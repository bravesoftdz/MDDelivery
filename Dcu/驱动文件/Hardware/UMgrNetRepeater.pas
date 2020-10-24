{*******************************************************************************
  ����: dmzn@163.com 2016-06-25
  ����: RJ45 - COM232 ת����ͨѶ��Ԫ
*******************************************************************************}
unit UMgrNetRepeater;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, CPortTypes, IdGlobal, IdTCPClient,
  UWaitItem;

const
  cNR_Port_Num      = 4;
  cNR_Port_1        = $01;    //232 - 1
  cNR_Port_2        = $02;    //232 - 2
  cNR_Port_3        = $04;    //232 - 3
  cNR_Port_4        = $08;    //232 - 4

  cNR_CMD_SetParam  = $01;    //����232
  cNR_CMD_GetParam  = $02;    //��ȡ����
  cNR_CMD_SetIP     = $03;    //���õ�ַ
  cNR_CMD_SendData  = $10;    //��������
  cNR_CMD_RecvData  = $11;    //��������
                   
  cNR_Pack_Head     = $FF;    //Э��ͷ
  cNR_Pack_MaxData  = 200;    //��������

type
  PNRDataItem = ^TNRDataItem;
  TNRDataItem = record
    FHead: Byte;
    FLen: Byte;
    FPort: Byte;
    FCmd: Byte;
    FData: array[0..cNR_Pack_MaxData - 1] of Byte;
    FVerify: Byte;
  end;

  TNRRepeaterPort = record
    FEnable: Boolean;        //���ñ�ʶ
    FPortID: Byte;           //�˿ڱ��
    FPortName: string;       //�˿�����
    FGroup: string;          //�˿ڷ���

    FBaudRate: TBaudRate;    //������
    FDataBits: TDataBits;    //����λ
    FStopBits: TStopBits;    //ֹͣλ
    FParity: TParityBits;    //У��λ
  end;

  PNRRepeaterHost = ^TNRRepeaterHost;
  TNRRepeaterHost = record
    FEnable: Boolean;        //���ñ�ʶ
    FID: string;             //������ʶ
    FHost: string;           //������ַ
    FPort: Integer;          //ͨѶ�˿�
    FCOMPorts: array[0..cNR_Port_Num-1] of TNRRepeaterPort;

    FClient: TIdTCPClient;   //ͨѶ��·
    FSendBuf: TList;         //������
    FSending: TList;         //���ͻ���
    FRecvBuf: TNRDataItem;   //���ջ���
  end;

type
  TNRThreadType = (ttAll, ttActive);
  //�߳�ģʽ: ȫ��;ֻ���

  TNetRepeaterManager = class;
  TNetRepeaterThread = class(TThread)
  private
    FOwner: TNetRepeaterManager;
    //ӵ����
    FWaiter: TWaitObject;
    //�ȴ�����
    FThreadType: TNRThreadType;
    //�߳�ģʽ
    FActiveHost: PNRRepeaterHost;
    //��ǰ��ͷ
  protected
    procedure Execute; override;
    procedure DoExecute;
    //ִ���߳�
    procedure ScanActiveHost(const nActive: Boolean);
    //ɨ�����
    procedure SendHostCommand(const nHost: PNRRepeaterHost);
    function SendData(const nHost: PNRRepeaterHost; var nData: TIdBytes;
      const nRecvLen: Integer): string;
    //��������
  public
    constructor Create(AOwner: TNetRepeaterManager; AType: TNRThreadType);
    destructor Destroy; override;
    //�����ͷ�
    procedure Wakeup;
    procedure StopMe;
    //��ͣͨ��
  end;

  TNetRepeaterManager = class(TObject)
  private
    FRetry: Byte;
    //���Դ���
    FHosts: TList;
    //ת����
    FHostIndex: Integer;
    FHostActive: Integer;
    //��ͷ����
    FDataItem: Integer;
    //���ݱ�ʶ
    FReaders: array[0..1] of TNetRepeaterThread;
    //���Ӷ���
    FSyncLock: TCriticalSection;
    //ͬ������
  protected
    procedure ClearCommandList(nList: TList; nFree: Boolean);
    procedure ClearHost(const nFree: Boolean);
    //��������
    procedure CloseHostConn(const nHost: PNRRepeaterHost);
    //�ر�����
    procedure RegisterDataType;
    //ע������
    procedure WakeupReaders;
    //�����߳�
  public
    constructor Create;
    destructor Destroy; override;
    //�����ͷ�
    procedure StartRepeater;
    procedure StopRepeater;
    //��ͣ�����
    procedure LoadConfig(const nFile: string);
    //��ȡ����
    procedure SendData(const nHost: string; const nPort,nCmd: Byte;
      const nData: string = '');
    //��������
  end;

var
  gNetRepeaterManager: TNetRepeaterManager = nil;
  //ȫ��ʹ��

implementation

uses
  ULibFun, UMemDataPool, USysLoger;

procedure WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(TNetRepeaterManager, '����ת����', nEvent);
end;

//Desc: ��nData�����У��
function RepeaterVerify(var nData: TIdBytes; const nDataLen: Integer; 
  const nLast: Boolean): Byte;
var nIdx,nLen: Integer;
begin
  Result := 0;
  if nDataLen < 1 then Exit;

  nLen := nDataLen - 2;
  //ĩλ���������
  Result := nData[0];

  for nIdx:=1 to nLen do
    Result := Result xor nData[nIdx];
  //xxxxx

  if nLast then
    nData[nDataLen - 1] := Result;
  //���ӵ�ĩβ
end;

procedure OnNew(const nFlag: string; const nType: Word; var nData: Pointer);
var nP: PNRDataItem;
begin
  New(nP);
  nData := nP;
end;

procedure OnFree(const nFlag: string; const nType: Word; const nData: Pointer);
begin
  Dispose(PNRDataItem(nData));
end;

//Desc: ע����������
procedure TNetRepeaterManager.RegisterDataType;
begin
  if not Assigned(gMemDataManager) then
    raise Exception.Create('NetRepeater Needs MemDataManager Support.');
  //xxxxx

  with gMemDataManager do
  begin
    FDataItem := RegDataType('NRDataItem', 'NetRepeater', OnNew, OnFree, 1);
  end;
end;

//------------------------------------------------------------------------------
constructor TNetRepeaterManager.Create;
begin
  FRetry := 2;
  FHosts := TList.Create;
  FSyncLock := TCriticalSection.Create;

  RegisterDataType;
  //���ڴ��������
end;

destructor TNetRepeaterManager.Destroy;
begin
  StopRepeater;
  ClearHost(True);
  FSyncLock.Free;
  
  gMemDataManager.UnregType(FDataItem);
  inherited;
end;

//Desc: ��������
procedure TNetRepeaterManager.ClearCommandList(nList: TList; nFree: Boolean);
var nIdx: Integer;
begin
  for nIdx:=nList.Count - 1 downto 0 do
  begin
    gMemDataManager.UnLockData(nList[nIdx]);
    nList.Delete(nIdx);
  end;

  if nFree then
    nList.Free;
  //xxxxx
end;

//Desc: ��������
procedure TNetRepeaterManager.ClearHost(const nFree: Boolean);
var nIdx: Integer;
    nItem: PNRRepeaterHost;
begin
  for nIdx:=FHosts.Count - 1 downto 0 do
  begin
    nItem := FHosts[nIdx];
    nItem.FClient.Free;
    nItem.FClient := nil;
    
    Dispose(nItem);
    FHosts.Delete(nIdx);
  end;

  if nFree then
    FHosts.Free;
  //xxxxx
end;

//Desc: ����
procedure TNetRepeaterManager.StartRepeater;
var nIdx,nInt: Integer;
    nType: TNRThreadType;
begin
  nInt := 0;
  for nIdx:=FHosts.Count - 1 downto 0 do
   if PNRRepeaterHost(FHosts[nIdx]).FEnable then
    Inc(nInt);
  //count enable host
                            
  if nInt < 1 then Exit;
  FHostIndex := 0;
  FHostActive := 0;

  for nIdx:=Low(FReaders) to High(FReaders) do
  begin
    if nIdx >= nInt then Exit;
    //�̲߳���������������

    if nIdx = 0 then
         nType := ttAll
    else nType := ttActive;

    if not Assigned(FReaders[nIdx]) then
      FReaders[nIdx] := TNetRepeaterThread.Create(Self, nType);
    //xxxxx
  end;
end;

//Desc: ֹͣ
procedure TNetRepeaterManager.StopRepeater;
var nIdx: Integer;
begin
  for nIdx:=Low(FReaders) to High(FReaders) do
   if Assigned(FReaders[nIdx]) then
    FReaders[nIdx].Terminate;
  //�����˳����

  for nIdx:=Low(FReaders) to High(FReaders) do
  begin
    if Assigned(FReaders[nIdx]) then
      FReaders[nIdx].StopMe;
    FReaders[nIdx] := nil;
  end;

  FSyncLock.Enter;
  try
    for nIdx:=FHosts.Count - 1 downto 0 do
      CloseHostConn(FHosts[nIdx]);
    //�ر���·
  finally
    FSyncLock.Leave;
  end;
end;

//Desc: �ر�������·
procedure TNetRepeaterManager.CloseHostConn(const nHost: PNRRepeaterHost);
begin
  if Assigned(nHost) and Assigned(nHost.FClient) then
  begin
    nHost.FClient.Disconnect;
    if Assigned(nHost.FClient.IOHandler) then
      nHost.FClient.IOHandler.InputBuffer.Clear;
    //xxxxx
  end;
end;

//Desc: ����ȫ���߳�
procedure TNetRepeaterManager.WakeupReaders;
var nIdx: Integer;
begin
  for nIdx:=Low(FReaders) to High(FReaders) do
   if Assigned(FReaders[nIdx]) then
    FReaders[nIdx].Wakeup;
  //xxxxx
end;

//Date: 2016-06-25
//Parm: ����;�˿�;����;����
//Desc: ��nCmd.nData������nHost.nPort
procedure TNetRepeaterManager.SendData(const nHost: string; const nPort,
  nCmd: Byte; const nData: string);
var nIdx: Integer;
    nPData: PNRDataItem;
    nPHost: PNRRepeaterHost;
begin
  nIdx := Length(nData);
  if nIdx > cNR_Pack_MaxData then
    raise Exception.Create(Format('Data is too long(%d>%d).', [nIdx, cNR_Pack_MaxData]));
  //xxxxx

  nPHost := nil;
  for nIdx:=FHosts.Count - 1 downto 0 do
  begin
    nPHost := FHosts[nIdx];
    if CompareText(nHost, nPHost.FID) = 0 then
         Break
    else nPHost := nil;
  end;

  if not Assigned(nPHost) then
    raise Exception.Create(Format('Host "%s" is invalid.', [nHost]));
  //xxxxx

  FSyncLock.Enter;
  try
    nPData := gMemDataManager.LockData(FDataItem);
    nPHost.FSendBuf.Add(nPData);

    nPData.FHead := cNR_Pack_Head;
    nPData.FPort := nPort;
    nPData.FCmd := nCmd;

    nIdx := Length(nData);
    //BytesToRaw(nData, nPData.FData, nIdx);
    nPData.FLen := nPData.FLen + 3;

    WakeupReaders;
    //wake up thread
  finally
    FSyncLock.Leave;
  end;   
end;

procedure TNetRepeaterManager.LoadConfig(const nFile: string);
begin

end;

//------------------------------------------------------------------------------
constructor TNetRepeaterThread.Create(AOwner: TNetRepeaterManager;
  AType: TNRThreadType);
begin

end;

destructor TNetRepeaterThread.Destroy;
begin

  inherited;
end;

procedure TNetRepeaterThread.DoExecute;
begin

end;

procedure TNetRepeaterThread.Execute;
begin
  inherited;

end;

procedure TNetRepeaterThread.ScanActiveHost(const nActive: Boolean);
begin

end;

function TNetRepeaterThread.SendData(const nHost: PNRRepeaterHost;
  var nData: TIdBytes; const nRecvLen: Integer): string;
begin

end;

procedure TNetRepeaterThread.SendHostCommand(const nHost: PNRRepeaterHost);
begin

end;

procedure TNetRepeaterThread.StopMe;
begin

end;

procedure TNetRepeaterThread.Wakeup;
begin

end;

initialization
  gNetRepeaterManager := nil;
finalization
  FreeAndNil(gNetRepeaterManager);
end.
