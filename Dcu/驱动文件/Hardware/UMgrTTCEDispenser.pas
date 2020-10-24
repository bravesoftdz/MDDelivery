{*******************************************************************************
  ����: dmzn@163.com 2018-11-22
  ����:  ��������ʵҵ(TTCE)������/�̿���������Ԫ

  ��ע:
  *.������֧��K720��K730��K750,��������K7x0Э�鿪��.
*******************************************************************************}
unit UMgrTTCEDispenser;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, NativeXml, IdTCPClient, IdGlobal,
  CPort, CPortTypes, UWaitItem, USysLoger, ULibFun;

const
  cDispenser_MaxThread      = 10;                  //���ɨ���߳���
  cDispenser_Wait_Short     = 1500;
  cDispenser_Wait_Long      = 3 * 1000;            //�ȴ�ʱ��
  cDispenser_Wait_Timeout   = 12 * 1000;           //�ȴ�Ӧ��ʱ

  cTTCE_Frame_MaxSize       = 300;                 //���������ֽ���
  cTTCE_Frame_DataMax       = cTTCE_Frame_MaxSize - 7; //����������
  cTTCE_Frame_SendInterval  = 300;                 //���ݰ����ͼ��
  
type
  PDispenserK7Send = ^TDispenserK7Send;
  TDispenserK7Send = packed record
    FSTX   : Byte;                                 //����ʼ��
    FADDH  : Byte;                                 //��ַH
    FADDL  : Byte;                                 //��ַL
    FLen   : Word;                                 //���͵����ݰ���
    FData  : array [0..cTTCE_Frame_DataMax-1] of Char;//���͵����ݰ�
    FETX   : Byte;                                 //�������
    FBCC   : Byte;                                 //���У��
  end;

  PDispenserK7Recv = ^TDispenserK7Recv;
  TDispenserK7Recv = packed record
    FSTX   : Byte;                                 //����ʼ��
    FADDH  : Byte;                                 //��ַH
    FADDL  : Byte;                                 //��ַL
    FLen   : Word;                                 //�������ݰ���
    FRes   : Char;                                 //ִ�н��: P/N
    FData  : array [0..cTTCE_Frame_DataMax-1] of Char;//���ص����ݰ�
    FETX   : Byte;                                 //�������
    FBCC   : Byte;                                 //���У��
  end;

  TDispenserType = (dtSender, dtReceiver);
  //�豸����: ������,�̿���
  TDispenserConnType = (ctTCP, ctCOM);
  //��·����: ����,����

  PDispenserItem = ^TDispenserItem;
  TDispenserItem = record
    FEnable       : Boolean;                       //�Ƿ�����
    FID           : string;                        //�豸��ʶ
    FType         : TDispenserType;                //�豸����
    FAddH         : Byte;
    FAddL         : Byte;                          //���ͨѶ��ַ:�ߵ�λ
    FTimeout      : Integer;                       //��ʱ�տ�

    FConn         : TDispenserConnType;            //��·
    FHost         : string;                        //��ַ
    FPort         : Integer;                       //�˿�
    FClient       : TIdTCPClient;                  //ͨ����·

    FCOMPort      : TComPort;                      //��д����
    FCOMBuff      : string;                        //ͨѶ����
    FCOMData      : string;                        //ͨѶ����
                                                   
    FLastSend     : Int64;                         //�ϴη���
    FLastStatus   : string;                        //�������״̬
    FStatusKeep   : Int64;                         //���״̬ʱ��
    FNowCard      : string;                        //��ǰ����λ����
    FLastCMD      : string;                        //��Ҫִ�е�ָ��
                                                             
    FLastActive   : Int64;                         //�ϴλ
    FLocked       : Boolean;                       //�Ƿ�����
    FOptions      : TStrings;                      //��ѡ��
  end;

  TDispenserThreadType = (ttAll, ttActive);
  //�߳�ģʽ: ȫ��;ֻ���

  TDispenserManager = class;
  TDispenserThread = class(TThread)
  private
    FOwner: TDispenserManager;
    //ӵ����
    FWaiter: TWaitObject;
    //�ȴ�����
    FActiveDispenser: PDispenserItem;
    //��ǰ��ͷ
    FThreadType: TDispenserThreadType;
    //�߳�ģʽ
  protected
    procedure DoExecute;
    procedure Execute; override;
    //ִ���߳�
    procedure ScanActiveDispenser(const nActive: Boolean);
    //ɨ�����
    procedure InitSendData(const nData: PDispenserK7Send; const nCMD: string = '');
    //��ʼ������
    function SendData2Bytes(const nData: PDispenserK7Send): TIdBytes;
    //תΪ���ͻ���
    function SendWithResponse(const nSend: PDispenserK7Send;
      const nRecv: PDispenserK7Recv): Boolean;
    //Ӧ��ģʽ��������
    function SendToDispenser(const nSend: PDispenserK7Send): Boolean;
    //�����ݷ��͵��豸
    function ReadCOMData(nLen: Integer): Boolean;
    //�Ӵ��ڶ�ȡ����
    function PrepareCard(const nDispenser: PDispenserItem): Boolean;
    //׼����Ƭ: ����Ƭ��������λ��
    function QueryStatuse: string;
    function HasStatus(const nALL: string; const nStatus: Integer): Boolean;
    //��ѯ�豸״̬
    function SendCardToReadPosition: Boolean;
    //����Ƭ��������λ
    function GetCardSerial: string;
    function ParseCardNO(const nCard: string; const nHex: Boolean): string;
    //��ȡ����
    function SendCardOut: Boolean;
    //����Ƭ����ȡ��λ
    function RecoveryCard: Boolean;
    //����Ƭ�յ�������
    function ResetDispenser: Boolean;
    //��������
    procedure WriteRecvError(const nRecv: PDispenserK7Recv);
    //��¼������־
  public
    constructor Create(AOwner: TDispenserManager; AType: TDispenserThreadType);
    destructor Destroy; override;
    //�����ͷ�
    procedure StopMe;
    //ֹͣ�߳�
  end;

  TDispenserProc = procedure (const nDispenser: PDispenserItem);
  TDispenserEvent = procedure (const nDispenser: PDispenserItem) of object;

  TDispenserManager = class(TObject)
  private
    FEnable: Boolean;
    //�Ƿ�����
    FMonitorCount: Integer;
    FThreadCount: Integer;
    //ɨ���߳�
    FDispenserIndex: Integer;
    FDispenserActive: Integer;
    //�豸����
    FDispensers: TList;
    //�豸�б�
    FSyncLock: TCriticalSection;
    //ͬ������
    FThreads: array[0..cDispenser_MaxThread-1] of TDispenserThread;
    //��������
    FOnProc: TDispenserProc;
    FOnEvent: TDispenserEvent;
    //�¼�����
  protected
    procedure ClearDispensers(const nFree: Boolean);
    //������Դ
    procedure CloseDispenser(const nDispenser: PDispenserItem);
    //�ر��豸
    function SyncCardNo(const nDispenser: PDispenserItem; const nSet: Boolean;
      const nCard: string = ''): string;
    //ͬ����д����
    function SyncCommand(const nDispenser: PDispenserItem; const nSet: Boolean;
      const nCMD: string = ''): string;
    //ͬ����дָ��
  public
    constructor Create;
    destructor Destroy; override;
    //�����ͷ�
    procedure LoadConfig(const nFile: string);
    //��������
    procedure StartDispensers;
    procedure StopDispensers;
    //��ͣ�豸
    function FindDispenser(const nID: string): PDispenserItem;
    //�����豸
    function GetCardNo(const nID:string; var nHint: string;
      const nWaitFor: Boolean = True;
      const nTimeout: Integer = cDispenser_Wait_Timeout): string;
    //��ÿ���
    function SendCardOut(const nID: string; var nHint: string):Boolean;
    //����
    function RecoveryCard(const nID: string; var nHint: string):Boolean;
    //���տ�
    property OnCardProc: TDispenserProc read FOnProc write FOnProc;
    property OnCardEvent: TDispenserEvent read FOnEvent write FOnEvent;
    //�������
  end;

var
  gDispenserManager: TDispenserManager = nil;
  //ȫ��ʹ��

implementation

const
  cFrameSize_Send     = SizeOf(TDispenserK7Send);
  cFrameSize_Recv     = SizeOf(TDispenserK7Recv);   //֡��С

  cTTCE_K7_STX        = $02;                        //����ʼ��
  cTTCE_K7_ETX        = $03;                        //�������
  cTTCE_K7_EOT        = $04;                        //ȡ������
  cTTCE_K7_ENQ        = $05;                        //ִ����������
  cTTCE_K7_ACK        = $06;                        //�϶�Ӧ��
  cTTCE_K7_NAK        = $15;                        //��Ӧ��

  cTTCE_K7_Success    = 'P';                        //����ִ�гɹ�
  cTTCE_K7_Failure    = 'N';                        //����ִ��ʧ��

  cTTCE_K7_PosNew     = $01;                        //�¿���׼����
  cTTCE_K7_PosRead    = $02;                        //��Ƭ�ڶ���λ
  cTTCE_K7_PosOut     = $03;                        //��Ƭ�ڳ�����
  cTTCE_K7_NewError   = $11;                        //׼����ʧ��
  cTTCE_K7_KXNoCard   = $12;                        //���俨ƬΪ��
  cTTCE_K7_TDNoCard   = $13;                        //ͨ����ƬΪ��
  cTTCE_K7_CardJam    = $14;                        //��Ƭ����(������)

  cCMD_RecoveryCard   = 'RC';                       //���տ�Ƭ
  cCMD_CardOut        = 'CO';                       //������������

procedure WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(TDispenserManager, '��������������', nEvent);
end;

procedure LogHex(const nData: TIdBytes; const nPrefix: string = '');
var nStr: string;
    nIdx: Integer;
begin
  nStr := '';
  for nIdx:=Low(nData) to High(nData) do
    nStr := nStr + IntToHex(nData[nIdx], 2) + ' ';
  WriteLog(nPrefix + nStr);
end;

//------------------------------------------------------------------------------
constructor TDispenserManager.Create;
var nIdx: Integer;
begin
  FEnable := False;
  for nIdx:=Low(FThreads) to High(FThreads) do
    FThreads[nIdx] := nil;
  //xxxxx

  FDispensers := TList.Create;
  FSyncLock := TCriticalSection.Create;
end;

destructor TDispenserManager.Destroy;
begin
  StopDispensers;
  ClearDispensers(True);

  FSyncLock.Free;
  inherited;
end;

//Date: 2018-11-23
//Parm: �ͷ��б�
//Desc: �����豸�б�
procedure TDispenserManager.ClearDispensers(const nFree: Boolean);
var nIdx: Integer;
    nItem: PDispenserItem;
begin
  for nIdx:=FDispensers.Count - 1 downto 0 do
  begin
    nItem := FDispensers[nIdx];
    if Assigned(nItem.FCOMPort) then
    begin
      nItem.FCOMPort.Close;
      FreeAndNil(nItem.FCOMPort);
    end;

    if Assigned(nItem.FClient) then
    begin
      nItem.FClient.Disconnect;
      FreeAndNil(nItem.FClient);
    end;

    FreeAndNil(nItem.FOptions);
    Dispose(nItem);
    FDispensers.Delete(nIdx);
  end;

  if nFree then
    FDispensers.Free;
  //xxxxx
end;

//Date: 2018-11-23
//Parm: �豸
//Desc: �ر�nDispenser������
procedure TDispenserManager.CloseDispenser(const nDispenser: PDispenserItem);
begin
  if Assigned(nDispenser) then
  begin
    if Assigned(nDispenser.FClient) then
    begin
      nDispenser.FClient.Disconnect;
      if Assigned(nDispenser.FClient.IOHandler) then
        nDispenser.FClient.IOHandler.InputBuffer.Clear;
      //xxxxx
    end;

    if Assigned(nDispenser.FCOMPort) then
    begin
      nDispenser.FCOMPort.Connected := False;
      //disconn comport
    end;
  end;
end;

//Date: 2018-11-23
//Desc: �����豸
procedure TDispenserManager.StartDispensers;
var nIdx,nInt,nNum: Integer;
    nType: TDispenserThreadType;
begin
  if not FEnable then Exit;
  FDispenserIndex := 0;
  FDispenserActive := 0;
  
  nInt := 0;
  for nIdx:=FDispensers.Count-1 downto 0 do
   if PDispenserItem(FDispensers[nIdx]).FEnable then
    Inc(nInt);
  //ͳ����Ч�豸����

  nNum := 0;
  for nIdx:=Low(FThreads) to High(FThreads) do
  begin
    if (nNum >= FThreadCount) or (nNum >= nInt) then Exit;
    //�̲߳��ܳ���Ԥ��ֵ,�򲻶����豸����

    if nNum < FMonitorCount then
         nType := ttAll
    else nType := ttActive;

    if not Assigned(FThreads[nIdx]) then
      FThreads[nIdx] := TDispenserThread.Create(Self, nType);
    Inc(nNum);
  end;
end;

//Date: 2018-11-23
//Desc: ֹͣ�豸
procedure TDispenserManager.StopDispensers;
var nIdx: Integer;
begin
  for nIdx:=Low(FThreads) to High(FThreads) do
   if Assigned(FThreads[nIdx]) then
    FThreads[nIdx].Terminate;
  //�����˳����

  for nIdx:=Low(FThreads) to High(FThreads) do
  begin
    if Assigned(FThreads[nIdx]) then
      FThreads[nIdx].StopMe;
    FThreads[nIdx] := nil;
  end;

  FSyncLock.Enter;
  try
    for nIdx:=FDispensers.Count - 1 downto 0 do
      CloseDispenser(FDispensers[nIdx]);
    //�ر��豸
  finally
    FSyncLock.Leave;
  end;
end;

//Date: 2018-11-26
//Parm: �豸;���� or ��ȡ;����
//Desc: ͬ��������ǰ�豸�Ŀ���
function TDispenserManager.SyncCardNo(const nDispenser: PDispenserItem;
  const nSet: Boolean; const nCard: string): string;
begin
  FSyncLock.Enter;
  try
    if nSet then
         nDispenser.FNowCard := nCard
    else Result := nDispenser.FNowCard;
  finally
    FSyncLock.Leave;
  end;
end;

//Date: 2018-11-27
//Parm: �豸;���� or ��ȡ;ָ��
//Desc: ͬ��������ǰ�豸��ָ��
function TDispenserManager.SyncCommand(const nDispenser: PDispenserItem;
  const nSet: Boolean; const nCMD: string): string;
begin
  FSyncLock.Enter;
  try
    if nSet then
         nDispenser.FLastCMD := nCMD
    else Result := nDispenser.FLastCMD;
  finally
    FSyncLock.Leave;
  end;
end;

//Date: 2018-11-27
//Parm: �豸��
//Desc: �����豸��ΪnID���豸
function TDispenserManager.FindDispenser(const nID: string): PDispenserItem;
var nIdx: Integer;
begin
  Result := nil;
  //init
  
  for nIdx:=FDispensers.Count-1 downto 0 do
  if CompareText(PDispenserItem(FDispensers[nIdx]).FID, nID) = 0 then
  begin
    Result := FDispensers[nIdx];
    Break;
  end;
end;

//Date: 2018-11-26
//Parm: �豸��;��ʾ;�Ƿ�ȴ�;��ʱʱ��
//Desc: ��ȡnID��ǰ�Ŀ���
function TDispenserManager.GetCardNo(const nID: string; var nHint: string;
  const nWaitFor: Boolean; const nTimeout: Integer): string;
var nInit: Int64;
    nDispenser: PDispenserItem;
begin
  Result := '';
  nHint := '';
  nDispenser := FindDispenser(nID);

  if not Assigned(nDispenser) then
  begin
    nHint := Format('��ʶΪ[ %s ]���豸������.', [nID]);
    WriteLog(nHint);
    Exit;
  end;

  if not nWaitFor then
  begin
    Result := SyncCardNo(nDispenser, False);
    Exit;
  end;

  nInit := GetTickCount();
  while GetTickCountDiff(nInit) <= nTimeout do
  begin
    Result := SyncCardNo(nDispenser, False);
    if Result = '' then
         Sleep(1)
    else Break;
  end;

  if Result = '' then
  begin
    nHint := Format('��ȡ�豸[ %s ]�Ŀ��ų�ʱ.', [nID]);
    WriteLog(nHint);
  end;
end;

//Date: 2018-11-27
//Parm: �豸��;��ʾ;��ʱ
//Desc: ���ձ�ʾΪnID�Ŀ�Ƭ
function TDispenserManager.RecoveryCard(const nID: string; var nHint: string): Boolean;
var nDispenser: PDispenserItem;
begin
  Result := False;
  nHint := '';
  nDispenser := FindDispenser(nID);

  if not Assigned(nDispenser) then
  begin
    nHint := Format('��ʶΪ[ %s ]���豸������.', [nID]);
    WriteLog(nHint);
    Exit;
  end;

  SyncCommand(nDispenser, True, cCMD_RecoveryCard);
  //����ָ��
  Result := True;
end;

function TDispenserManager.SendCardOut(const nID: string; var nHint: string): Boolean;
var nDispenser: PDispenserItem;
begin
  Result := False;
  nHint := '';
  nDispenser := FindDispenser(nID);

  if not Assigned(nDispenser) then
  begin
    nHint := Format('��ʶΪ[ %s ]���豸������.', [nID]);
    WriteLog(nHint);
    Exit;
  end;

  SyncCommand(nDispenser, True, cCMD_CardOut);
  //����ָ��
  Result := True;
end;

//Date: 2018-11-23
//Parm: �����ļ�
//Desc: ����nFile����
procedure TDispenserManager.LoadConfig(const nFile: string);
var nIdx: Integer;
    nXML: TNativeXml;
    nDispenser: PDispenserItem;
    nRoot,nNode,nTmp: TXmlNode;
begin
  FEnable := False;
  if not FileExists(nFile) then Exit;

  nXML := nil;
  try
    nXML := TNativeXml.Create;
    nXML.LoadFromFile(nFile);

    nRoot := nXML.Root.NodeByName('config');
    if Assigned(nRoot) then
    begin
      nNode := nRoot.NodeByName('enable');
      if Assigned(nNode) then
        Self.FEnable := nNode.ValueAsString <> 'N';
      //xxxxx

      nNode := nRoot.NodeByName('thread');
      if Assigned(nNode) then
           FThreadCount := nNode.ValueAsInteger
      else FThreadCount := 1;

      if (FThreadCount < 1) or (FThreadCount > cDispenser_MaxThread) then
        raise Exception.Create(Format(
          'TTCE_Driver Thread-Num Need Between 1-%d.', [cDispenser_MaxThread]));
      //xxxxx

      nNode := nRoot.NodeByName('monitor');
      if Assigned(nNode) then
           FMonitorCount := nNode.ValueAsInteger
      else FMonitorCount := 1;

      if (FMonitorCount < 1) or (FMonitorCount > FThreadCount) then
        raise Exception.Create(Format(
          'TTCE_Driver Monitor-Num Need Between 1-%d.', [FThreadCount]));
      //xxxxx
    end;

    //--------------------------------------------------------------------------
    nRoot := nXML.Root.NodeByName('dispensers');
    if not Assigned(nRoot) then Exit;
    ClearDispensers(False);

    for nIdx:=0 to nRoot.NodeCount - 1 do
    begin
      nNode := nRoot.Nodes[nIdx];
      if CompareText(nNode.Name, 'dispenser') <> 0 then Continue;

      New(nDispenser);
      FDispensers.Add(nDispenser);

      with nNode,nDispenser^ do
      begin
        FLocked := False;
        FLastActive := GetTickCount;
        FNowCard := '';
        
        FLastSend := 0;
        FStatusKeep := 0;
        FLastStatus := DateTimeSerial;

        FID := AttributeByName['id']; 
        FEnable := NodeByNameR('enable').ValueAsString <> 'N';
        FHost := NodeByNameR('hostip').ValueAsString;
        FPort := NodeByNameR('hostport').ValueAsInteger;
        FTimeout := NodeByNameR('timeout').ValueAsInteger;

        nTmp := NodeByNameR('param');
        FAddH := StrToInt('$' + nTmp.AttributeByName['H']);
        FAddL := StrToInt('$' + nTmp.AttributeByName['L']);

        if CompareText(nTmp.AttributeByName['type'], 'receiver') = 0 then
             FType := dtReceiver
        else FType := dtSender;

        nTmp := NodeByName('options');
        if Assigned(nTmp) then
        begin
          FOptions := TStringList.Create;
          SplitStr(nTmp.ValueAsString, FOptions, 0, ';');
        end else FOptions := nil;

        //----------------------------------------------------------------------
        if CompareText('com', NodeByNameR('conn').ValueAsString) = 0 then
             FConn := ctCOM
        else FConn := ctTCP;
        
        if FConn = ctTCP then
        begin
          FCOMPort := nil;
          FClient := TIdTCPClient.Create;
          
          with FClient do
          begin
            Host := FHost;
            Port := FPort;
            ReadTimeout := 3 * 1000;
            ConnectTimeout := 3 * 1000;
          end;
        end else
        begin
          FClient := nil;
          FCOMPort := TComPort.Create(nil);
          FCOMPort.SyncMethod := smDisableEvents; //��ʹ���¼�,˳���д
          
          with FCOMPort do
          begin
            with Timeouts do
            begin
              ReadTotalConstant := 100;
              ReadTotalMultiplier := 10;
            end;

            with Parity do
            begin
              Bits := StrToParity(NodeByNameR('paritybit').ValueAsString);
              Check := NodeByNameR('paritycheck').ValueAsString = 'Y';
            end;

            Port := NodeByNameR('comport').ValueAsString;
            BaudRate := StrToBaudRate(NodeByNameR('rate').ValueAsString);
            DataBits := StrToDataBits(NodeByNameR('databit').ValueAsString);
            StopBits := StrToStopBits(NodeByNameR('stopbit').ValueAsString);
          end;
        end;
      end;
    end;
  finally
    nXML.Free;
  end;
end;

//------------------------------------------------------------------------------
constructor TDispenserThread.Create(AOwner: TDispenserManager;
  AType: TDispenserThreadType);
begin
  inherited Create(False);
  FreeOnTerminate := False;

  FOwner := AOwner;
  FThreadType := AType;

  FWaiter := TWaitObject.Create;
  FWaiter.Interval := cDispenser_Wait_Short;
end;

destructor TDispenserThread.Destroy;
begin
  FWaiter.Free;
  inherited;
end;

procedure TDispenserThread.StopMe;
begin
  Terminate;
  FWaiter.Wakeup;

  WaitFor;
  Free;
end;

procedure TDispenserThread.Execute;
begin
  while not Terminated do
  try
    FWaiter.EnterWait;
    if Terminated then Exit;

    FActiveDispenser := nil;
    try
      DoExecute;
    finally
      if Assigned(FActiveDispenser) then
      begin
        FOwner.FSyncLock.Enter;
        FActiveDispenser.FLocked := False;
        FOwner.FSyncLock.Leave;
      end;
    end;
  except
    on E: Exception do
    begin
      WriteLog(E.Message);
      Sleep(500);
    end;
  end;
end;

procedure TDispenserThread.DoExecute;
begin
  FOwner.FSyncLock.Enter;
  try
    if FThreadType = ttAll then
    begin
      ScanActiveDispenser(False);
      //����ɨ�費��豸

      if not Assigned(FActiveDispenser) then
        ScanActiveDispenser(True);
      //����ɨ���豸
    end else

    if FThreadType = ttActive then //ֻɨ��߳�
    begin
      ScanActiveDispenser(True);
      //����ɨ���豸

      if Assigned(FActiveDispenser) then
      begin
        FWaiter.Interval := cDispenser_Wait_Short;
        //�л�豸,����
      end else
      begin
        FWaiter.Interval := cDispenser_Wait_Long;
        //�޻�豸,����
        ScanActiveDispenser(False);
        //����ɨ�費��豸
      end;
    end;
  finally
    FOwner.FSyncLock.Leave;
  end;

  if Assigned(FActiveDispenser) and (not Terminated) then
  try
    if PrepareCard(FActiveDispenser) then
    begin
      if FThreadType = ttActive then
        FWaiter.Interval := cDispenser_Wait_Short;
      FActiveDispenser.FLastActive := GetTickCount;
    end else
    begin
      if (FActiveDispenser.FLastActive > 0) and
         (GetTickCountDiff(FActiveDispenser.FLastActive) >= 5 * 1000) then
        FActiveDispenser.FLastActive := 0;
      //����׼����Ƭʱ,�Զ�תΪ���
    end;
  except
    on E:Exception do
    begin
      FActiveDispenser.FLastActive := 0;
      //��Ϊ���

      if FActiveDispenser.FConn = ctCOM then
       WriteLog(Format('Dispenser:[ %s:%s ] Msg: %s', [FActiveDispenser.FID,
        FActiveDispenser.FCOMPort.Port, E.Message]))
      else
       WriteLog(Format('Dispenser:[ %s:%d ] Msg: %s', [FActiveDispenser.FHost,
        FActiveDispenser.FPort, E.Message]));
      //xxxxx

      FOwner.CloseDispenser(FActiveDispenser);
      //focus reconnect
    end;
  end;
end;

//Date: 2018-11-23
//Parm: �&�����
//Desc: ɨ��nActive��,�����ô���FActiveDispenser.
procedure TDispenserThread.ScanActiveDispenser(const nActive: Boolean);
var nIdx: Integer;
    nDispenser: PDispenserItem;
begin
  if nActive then //ɨ����
  with FOwner do
  begin
    if FDispenserActive = 0 then
         nIdx := 1
    else nIdx := 0; //��0��ʼΪ����һ��

    while True do
    begin
      if FDispenserActive >= FDispensers.Count then
      begin
        FDispenserActive := 0;
        Inc(nIdx);

        if nIdx >= 2 then Break;
        //ɨ��һ��,��Ч�˳�
      end;

      nDispenser := FDispensers[FDispenserActive];
      Inc(FDispenserActive);
      if nDispenser.FLocked or (not nDispenser.FEnable) then Continue;

      if nDispenser.FLastActive > 0 then 
      begin
        FActiveDispenser := nDispenser;
        FActiveDispenser.FLocked := True;
        Break;
      end;
    end;
  end else

  with FOwner do //ɨ�費���
  begin
    if FDispenserIndex = 0 then
         nIdx := 1
    else nIdx := 0; //��0��ʼΪ����һ��

    while True do
    begin
      if FDispenserIndex >= FDispensers.Count then
      begin
        FDispenserIndex := 0;
        Inc(nIdx);

        if nIdx >= 2 then Break;
        //ɨ��һ��,��Ч�˳�
      end;

      nDispenser := FDispensers[FDispenserIndex];
      Inc(FDispenserIndex);
      if nDispenser.FLocked or (not nDispenser.FEnable) then Continue;

      if nDispenser.FLastActive = 0 then 
      begin
        FActiveDispenser := nDispenser;
        FActiveDispenser.FLocked := True;
        Break;
      end;
    end;
  end;
end;

//------------------------------------------------------------------------------
//Date: 2018-11-23
//Parm: ������
//Desc: ��nDispenser�еĿ�Ƭ��������λ,Ϊ������׼��
function TDispenserThread.PrepareCard(const nDispenser: PDispenserItem): Boolean;
var nStr,nStatus: string;
begin
  Result := True;
  nStatus := QueryStatuse();

  if (not HasStatus(nStatus, cTTCE_K7_PosRead)) and
     (FActiveDispenser.FNowCard <> '') then
    FOwner.SyncCardNo(nDispenser, True, '');
  //�����ڶ���λ,��տ���

  if HasStatus(nStatus, cTTCE_K7_PosNew) then
  begin
    if SendCardToReadPosition() then //��������λ
     if GetCardSerial() = '' then    //��ȡ����
      RecoveryCard();                //���ɹ����տ�
    //xxxxx
  end; //���ڴ�����3λ��,�¿���λ

  if (HasStatus(nStatus, cTTCE_K7_PosRead)) and
     (FActiveDispenser.FNowCard = '') then
  begin
    if GetCardSerial() = '' then    //��ȡ����
      RecoveryCard();               //���ɹ����տ�
    //xxxxx
  end; //���ڶ���λ�ҿ���Ϊ��,���¶���
  
  if (nDispenser.FStatusKeep > 0) and //ĳ��״̬����ʱ�����
     (GetTickCountDiff(nDispenser.FStatusKeep) >= nDispenser.FTimeout * 1000) then
  begin
    if nDispenser.FLastStatus = '' then
    begin
      nDispenser.FStatusKeep := 0;
      nDispenser.FLastStatus := DateTimeSerial;
      ResetDispenser();           

      WriteLog(Format('����[ %s ]�޷���ȡ״̬,������.', [nDispenser.FID]));
      Exit;
    end;

    if HasStatus(nDispenser.FLastStatus, cTTCE_K7_NewError) then
    begin
      nDispenser.FStatusKeep := 0;
      nDispenser.FLastStatus := DateTimeSerial;
      ResetDispenser();

      WriteLog(Format('����[ %s ]׼����ʧ��,������.', [nDispenser.FID]));
      Exit;
    end; //׼����ʧ��

    if HasStatus(nDispenser.FLastStatus, cTTCE_K7_PosOut) then
    begin
      RecoveryCard();
      WriteLog(Format('����[ %s ]��ʱδȡ,���ջ�.', [nDispenser.FID]));
    end; //�������п�

    if HasStatus(nDispenser.FLastStatus, cTTCE_K7_CardJam) then
    begin
      ResetDispenser();
      WriteLog(Format('����[ %s ]��Ƭӵ�»�����,��������.', [nDispenser.FID]));
    end; //������,����ӵ��
  end;

  if nStatus <> nDispenser.FLastStatus then Exit;
  //״̬�ѱ��
  nStr := FOwner.SyncCommand(FActiveDispenser, False);

  if nStr = cCMD_RecoveryCard then
  begin
    if HasStatus(nStatus, cTTCE_K7_PosRead) or
       HasStatus(nStatus, cTTCE_K7_PosOut) then
      RecoveryCard();
    //ִ���տ�

    if not (HasStatus(nDispenser.FLastStatus, cTTCE_K7_PosRead) or
            HasStatus(nDispenser.FLastStatus, cTTCE_K7_PosOut)) then
      FOwner.SyncCommand(FActiveDispenser, True, '');
    //xxxxx
  end else

  if nStr = cCMD_CardOut then
  begin
    if HasStatus(nStatus, cTTCE_K7_PosRead) then
      SendCardOut();
    //ִ�з���

    if not HasStatus(nDispenser.FLastStatus, cTTCE_K7_PosRead) then
      FOwner.SyncCommand(FActiveDispenser, True, '');
    //xxxxx
  end else

  if nStr <> '' then
  begin
    FOwner.SyncCommand(FActiveDispenser, True, '');
    //����ʶ���ָ��,ֱ�����
  end;
end;

//Date: 2018-11-23
//Parm: ����֡;����
//Desc: ����FActiveDispenser��ʼ��nData����
procedure TDispenserThread.InitSendData(const nData: PDispenserK7Send;
  const nCMD: string);
var nIdx,nBase: Integer;
begin
  FillChar(nData^, cFrameSize_Send, #0);
  nData.FSTX := cTTCE_K7_STX;
  nData.FETX := cTTCE_K7_ETX;

  nData.FADDH := FActiveDispenser.FAddH;
  nData.FADDL := FActiveDispenser.FAddL;
  nData.FLen := Length(nCMD);

  if nData.FLen > cTTCE_Frame_DataMax then
   raise Exception.Create(Format(
    'Data Is Too Big Than %d.', [cTTCE_Frame_DataMax]));
  //xxxxx

  if nData.FLen > 0 then
  begin
    nBase := 1;
    for nIdx:=Low(nData.FData) to High(nData.FData) do
    begin
      nData.FData[nIdx] := nCMD[nBase];
      Inc(nBase);
      if nBase > nData.FLen then Break;
    end;
  end;
end;

//Date: 2018-11-23
//Parm: ����;��ʼ,����λ��
//Desc: ����nBuf��BCC���У��ֵ
function CalBBC(const nBuf: TIdBytes; const nStart,nEnd: Integer): Byte;
var nIdx: Integer;
begin
  Result := 0;
  for nIdx:=nStart to nEnd do
    Result := Result xor nBuf[nIdx];
  //xxxxx
end;

//Date: 2018-11-23
//Parm: ����֡
//Desc: ��nDataתΪ���ͻ���,������У��ֵ
function TDispenserThread.SendData2Bytes(const nData: PDispenserK7Send): TIdBytes;
var nLen: Integer;
begin
  nLen := cFrameSize_Send - (cTTCE_Frame_DataMax - nData.FLen);
  //��Ч���� = ���� - ��Ч

  Result := RawToBytes(nData^, nLen);
  Result[3] := nData.FLen div 256;
  Result[4] := nData.FLen mod 256; //���ݳ���: �ߵ�λ����

  Result[nLen - 2] := nData.FETX;
  Result[nLen - 1] := CalBBC(Result, 0, nLen - 2);
end;

//Date: 2018-11-28
//Parm: ����ȡ�ĳ���
//Desc: �Ӵ��ڶ�ȡ��ȡnLen���ȵ�����
function TDispenserThread.ReadCOMData(nLen: Integer): Boolean;
var nInit: Int64;
    nInt: Integer;
begin
  nInit := GetTickCount;
  while (nLen > 0) and (GetTickCountDiff(nInit) < cDispenser_Wait_Timeout) do
  begin
    FActiveDispenser.FCOMBuff := '';
    FActiveDispenser.FCOMPort.ReadStr(FActiveDispenser.FCOMBuff, nLen);
    nInt := Length(FActiveDispenser.FCOMBuff);

    if nInt > 0 then
    begin
      nLen := nLen - nInt;
      FActiveDispenser.FCOMData := FActiveDispenser.FCOMData +
                                   FActiveDispenser.FCOMBuff;
      //�ϲ�����
    end;
  end;

  Result := nLen <= 0;
  if not Result then
   WriteLog(Format('����[ %s,%s ]��ȡ����ʧ��.', [FActiveDispenser.FID,
    FActiveDispenser.FCOMPort.Port]));
  //xxxxx
end;

//Date: 2018-11-29
//Parm: ��������
//Desc: ��¼nRecv�����Ĵ�����־
procedure TDispenserThread.WriteRecvError(const nRecv: PDispenserK7Recv);
var nStr,nCode: string;
    nIdx,nInt: Integer;
begin
  if nRecv.FRes = cTTCE_K7_Failure then
  begin
    nCode := '';
    nInt := nRecv.FLen - 3; //ERR_CD����

    for nIdx:=2 to cTTCE_Frame_DataMax - 1 do
    begin
      if (nInt <= 0) or
         (nRecv.FData[nIdx] = Char(cTTCE_K7_ETX)) then Break;
      nCode := nCode + IntToHex(Ord(nRecv.FData[nIdx]), 2);

      Dec(nInt);
      if nInt > 0 then nCode := nCode + '-';
    end;

    nStr := '����[ %s ]ִ��ʧ��,����: CM:%s PM:%s CODE:%s.';
    nStr := Format(nStr, [FActiveDispenser.FID,
            IntToHex(Ord(nRecv.FData[0]), 2),
            IntToHex(Ord(nRecv.FData[1]), 2), nCode]);
    WriteLog(nStr);
  end;
end;

//Date: 2018-11-23
//Parm: ����֡;����֡
//Desc: ����nSend����,���պ����nRecv,Ӧ��ģʽ
function TDispenserThread.SendWithResponse(const nSend: PDispenserK7Send;
  const nRecv: PDispenserK7Recv): Boolean;
var nStr: string;
    nBuf: TIdBytes;
    nItv: Int64;
    nIdx,nLen: Integer;
begin
  with FActiveDispenser.FClient,FActiveDispenser.FCOMPort do
  begin
    if FActiveDispenser.FConn = ctCOM then
    begin
      if not FActiveDispenser.FCOMPort.Connected then
        FActiveDispenser.FCOMPort.Connected := True;
      Result := False;
    end else
    begin
      if not FActiveDispenser.FClient.Connected then
        FActiveDispenser.FClient.Connect;
      Result := False;
    end;
    
    nItv := GetTickCountDiff(FActiveDispenser.FLastSend);
    nItv := cTTCE_Frame_SendInterval - nItv;
    if nItv > 0 then Sleep(nItv); //���Ʒ����ٶ�
    FActiveDispenser.FLastSend := GetTickCount();

    if FActiveDispenser.FConn = ctCOM then
    begin
      nBuf := SendData2Bytes(nSend);
      Write(@nBuf[0], Length(nBuf));

      FActiveDispenser.FCOMData := '';
      if not ReadCOMData(3) then Exit;
      nBuf := ToBytes(FActiveDispenser.FCOMData);
    end else
    begin
      Socket.Write(SendData2Bytes(nSend));
      SetLength(nBuf, 0);
      Socket.ReadBytes(nBuf, 3, False);
    end;

    if (nBuf[1] <> FActiveDispenser.FAddH) or
       (nBuf[2] <> FActiveDispenser.FAddL) then
    begin
      nStr := Format('����[ %s ]Ӧ���ַ����.', [FActiveDispenser.FID]);
      WriteLog(nStr);
      Exit;
    end;

    case nBuf[0] of
     cTTCE_K7_EOT:
      nStr := Format('����[ %s ]ȡ������.', [FActiveDispenser.FID]);
     cTTCE_K7_NAK:
      nStr := Format('����[ %s ]��Ӧ��.', [FActiveDispenser.FID]);
     cTTCE_K7_ACK:
      nStr := ''
     else
      begin
        nStr := '����[ %s ]Ӧ�𲻿�ʶ��,Ӧ����:[ %d ].';
        nStr := Format(nStr, [FActiveDispenser.FID, nBuf[0]]);
      end;
    end;

    if nStr <> '' then
    begin
      WriteLog(nStr);
      Exit;
    end;

    nBuf[0] := cTTCE_K7_ENQ;
    if FActiveDispenser.FConn = ctCOM then
    begin
      Write(@nBuf[0], 3);
      FActiveDispenser.FCOMData := '';
      
      if not ReadCOMData(5) then Exit;
      nBuf := ToBytes(FActiveDispenser.FCOMData, Indy8BitEncoding);
    end else
    begin
      Socket.Write(nBuf); //ȷ��ִ��
      SetLength(nBuf, 0);
      Socket.ReadBytes(nBuf, 5, False);
    end; 

    if (nBuf[0] <> cTTCE_K7_STX) or (nBuf[1] <> FActiveDispenser.FAddH) or
       (nBuf[2] <> FActiveDispenser.FAddL) then
    begin
      nStr := '����[ %s ]Ӧ�𲻿�ʶ��,Ӧ����:[ %d,%d,%d ].';
      nStr := Format(nStr, [FActiveDispenser.FID, nBuf[0], nBuf[1], nBuf[2]]);
      
      WriteLog(nStr);
      Exit;
    end;

    nLen := nBuf[3] * 265 + nBuf[4]; //���ݸ��س���
    if FActiveDispenser.FConn = ctCOM then
    begin
      if not ReadCOMData(nLen + 2) then Exit;
      nBuf := ToBytes(FActiveDispenser.FCOMData, Indy8BitEncoding);
    end else
    begin
      Socket.ReadBytes(nBuf, nLen + 2, True);
    end;
    
    nIdx := Length(nBuf);
    Result := nBuf[nIdx-1] = CalBBC(nBuf, 0, nIdx-2);
    //ͨ����֤
    
    if not Result then
    begin
      nStr := Format('����[ %s ]Ӧ��У��ʧ��.', [FActiveDispenser.FID]);
      WriteLog(nStr);
      Exit;
    end;

    if Assigned(nRecv) then
    begin
      BytesToRaw(nBuf, nRecv^, nIdx);
      nRecv.FLen := nLen;
      nRecv.FETX := nBuf[nIdx-2];
      nRecv.FBCC := nBuf[nIdx-1];

      WriteRecvError(nRecv);
      //��¼������־
    end;

    FActiveDispenser.FLastSend := GetTickCount();
    //���¼����´η��ͼ��
  end;
end;

//Date: 2018-11-24
//Parm: ����֡;����֡
//Desc: ����nSend����,����Ӧ��
function TDispenserThread.SendToDispenser(const nSend: PDispenserK7Send): Boolean;
var nStr: string;
    nBuf: TIdBytes;
    nItv: Int64;
begin
  with FActiveDispenser.FClient,FActiveDispenser.FCOMPort do
  begin
    if FActiveDispenser.FConn = ctCOM then
    begin
      if not FActiveDispenser.FCOMPort.Connected then
        FActiveDispenser.FCOMPort.Connected := True;
      Result := False;
    end else
    begin
      if not FActiveDispenser.FClient.Connected then
        FActiveDispenser.FClient.Connect;
      Result := False;
    end;

    nItv := GetTickCountDiff(FActiveDispenser.FLastSend);
    nItv := cTTCE_Frame_SendInterval - nItv;
    if nItv > 0 then Sleep(nItv); //���Ʒ����ٶ�
    FActiveDispenser.FLastSend := GetTickCount();

    if FActiveDispenser.FConn = ctCOM then
    begin
      nBuf := SendData2Bytes(nSend);
      Write(@nBuf[0], Length(nBuf));

      FActiveDispenser.FCOMData := '';
      if not ReadCOMData(3) then Exit;
      nBuf := ToBytes(FActiveDispenser.FCOMData, Indy8BitEncoding);
    end else
    begin
      Socket.Write(SendData2Bytes(nSend));
      SetLength(nBuf, 0);
      Socket.ReadBytes(nBuf, 3, False);
    end;

    if (nBuf[1] <> FActiveDispenser.FAddH) or
       (nBuf[2] <> FActiveDispenser.FAddL) then
    begin
      nStr := Format('����[ %s ]Ӧ���ַ����.', [FActiveDispenser.FID]);
      WriteLog(nStr);
      Exit;
    end;

    case nBuf[0] of
     cTTCE_K7_EOT:
      nStr := Format('����[ %s ]ȡ������.', [FActiveDispenser.FID]);
     cTTCE_K7_NAK:
      nStr := Format('����[ %s ]��Ӧ��.', [FActiveDispenser.FID]);
     cTTCE_K7_ACK:
      nStr := ''
     else
      begin
        nStr := '����[ %s ]Ӧ�𲻿�ʶ��,Ӧ����:[ %d ].';
        nStr := Format(nStr, [FActiveDispenser.FID, nBuf[0]]);
      end;
    end;

    if nStr <> '' then
    begin
      WriteLog(nStr);
      Exit;
    end;

    nBuf[0] := cTTCE_K7_ENQ;
    if FActiveDispenser.FConn = ctCOM then
         Write(@nBuf[0], 3)
    else Socket.Write(nBuf); //ȷ��ִ��

    FActiveDispenser.FLastSend := GetTickCount();
    //���¼����´η��ͼ��
    Result := True;
  end;
end;

//Date: 2018-11-23
//Desc: ��ѯnDispenser���豸״̬
function TDispenserThread.QueryStatuse: string;
var nSend: TDispenserK7Send;
    nRecv: TDispenserK7Recv;
begin
  Result := '';
  InitSendData(@nSend, Char($41) + Char($50));
  if not (SendWithResponse(@nSend, @nRecv) and (nRecv.FLen = 6)) then Exit;

  Result := Copy(nRecv.FData, 2, 4);
  //����4λ״̬��

  if Length(Result) <> 4 then
    Result := '';
  //xxxxx

  if Result <> FActiveDispenser.FLastStatus then
  begin
    FActiveDispenser.FLastStatus := Result;
    FActiveDispenser.FStatusKeep := GetTickCount;
  end;
end;

//Date: 2018-11-27
//Parm: ȫ��״̬;״̬��
//Desc: ��ѯnAll���Ƿ����nStatus״̬
function TDispenserThread.HasStatus(const nALL: string;
  const nStatus: Integer): Boolean;
begin
  Result := False;
  if nALL = '' then Exit;

  case nStatus of
   cTTCE_K7_PosNew    : Result :=(StrToInt(nALL[4]) and $04 = $04) or
                                 (StrToInt(nALL[4]) and $0F = $02);
   cTTCE_K7_PosRead   : Result := StrToInt(nALL[4]) and $03 = $03;
   cTTCE_K7_PosOut    : Result :=(StrToInt(nALL[4]) and $01 = $01) and
                                 (StrToInt(nALL[4]) and $02 <> $02);
   cTTCE_K7_NewError  : Result := StrToInt(nALL[1]) and $02 = $02;
   cTTCE_K7_KXNoCard  : Result := StrToInt(nALL[3]) and $01 = $01;
   cTTCE_K7_TDNoCard  : Result := StrToInt(nALL[4]) and $08 = $08;
   cTTCE_K7_CardJam   : Result :=(StrToInt(nALL[2]) and $01 = $01) and
                                 (StrToInt(nALL[3]) and $02 = $02);
  end;
end;

//Date: 2018-11-24
//Desc: ����Ƭ��������λ��
function TDispenserThread.SendCardToReadPosition: Boolean;
var nStr: string;
    nInit: Int64;
    nSend: TDispenserK7Send;
begin
  Result := False;
  InitSendData(@nSend, Char($46) + Char($43) + Char($37));
  if not SendToDispenser(@nSend) then Exit;

  nStr := '';
  nInit := GetTickCount();
  
  while GetTickCountDiff(nInit) < cDispenser_Wait_Timeout do
  begin
    nStr := QueryStatuse();
    if HasStatus(nStr, cTTCE_K7_PosRead) then //���ѷ�������λ
    begin
      Result := True;
      Exit;
    end;
  end;

  if nStr <> '' then
  begin
    WriteLog(Format('����[ %s ]�޷�������������λ,������: %s.',
      [FActiveDispenser.FID, nStr]));
    //xxxxx
  end;
end;

//Date: 2018-11-26
//Parm: 16λ��������
//Desc: ��ʽ��nCardΪ��׼����
function TDispenserThread.ParseCardNO(const nCard: string;
  const nHex: Boolean): string;
var nInt: Int64;
    nIdx: Integer;
begin
  if nHex then
  begin
    Result := '';
    for nIdx:=Length(nCard) downto 1 do
      Result := Result + IntToHex(Ord(nCard[nIdx]), 2);
    //xxxxx
  end else Result := nCard;

  try
    nInt := StrToInt64('$' + Result);
    Result := IntToStr(nInt);
    Result := StringOfChar('0', 12 - Length(Result)) + Result;
  except
    on nErr: Exception do
    begin
      Result := '';
      WriteLog(Format('����[ %s ]�޷���������,����: %s.',
        [FActiveDispenser.FID, nErr.Message]));
      //xxxxx
    end;
  end;
end;

//Date: 2018-11-26
//Desc: ��ȡ����
function TDispenserThread.GetCardSerial: string;
var nIdx: Integer;
    nBool: Boolean;
    nSend: TDispenserK7Send;
    nRecv: TDispenserK7Recv;
begin
  Result := '';
  InitSendData(@nSend, Char($3C) + Char($30));

  for nIdx:=1 to 2 do
  begin
    nBool := SendWithResponse(@nSend, @nRecv) and
             (nRecv.FRes = cTTCE_K7_Success);
    //Ѱ��

    if nBool then
         Break
    else Sleep(cTTCE_Frame_SendInterval);
  end;

  if not nBool then Exit;
  InitSendData(@nSend, Char($3C) + Char($31));
  
  for nIdx:=1 to 2 do
  begin
    nBool := SendWithResponse(@nSend, @nRecv) and
             (nRecv.FRes = cTTCE_K7_Success);
    //����

    if nBool then
         Break
    else Sleep(cTTCE_Frame_SendInterval);
  end;

  if not nBool then Exit;
  Result:= Copy(nRecv.FData, 3, 4);
  //����4λ����
  Result := ParseCardNO(Result, True);
  //��ʽ������

  FOwner.SyncCardNo(FActiveDispenser, True, Result);
  if Assigned(FOwner.FOnProc) then FOwner.FOnProc(FActiveDispenser);
  if Assigned(FOwner.FOnEvent) then FOwner.FOnEvent(FActiveDispenser);
end;

//Date: 2018-11-24
//Desc: ����Ƭ����ȡ��λ��
function TDispenserThread.SendCardOut: Boolean;
var nStr: string;
    nInit: Int64;
    nSend: TDispenserK7Send;
begin
  Result := False;
  FOwner.SyncCardNo(FActiveDispenser, True, '');
  //�ÿտ���
  
  InitSendData(@nSend, Char($46) + Char($43) + Char($34));
  if not SendToDispenser(@nSend) then Exit;

  nStr := '';
  nInit := GetTickCount();
  
  while GetTickCountDiff(nInit) < cDispenser_Wait_Timeout do
  begin
    nStr := QueryStatuse();
    if HasStatus(nStr, cTTCE_K7_PosOut) then //���ѷ���ȡ��λ
    begin
      Result := True;
      Exit;
    end;
  end;

  if nStr <> '' then
  begin
    WriteLog(Format('����[ %s ]�޷���������ȡ��λ,������: %s.',
      [FActiveDispenser.FID, nStr]));
    //xxxxx
  end;
end;

//Date: 2018-11-24
//Desc: ����Ƭ�յ�������
function TDispenserThread.RecoveryCard: Boolean;
var nStr: string;
    nInit: Int64;
    nSend: TDispenserK7Send;
begin
  Result := False;
  FOwner.SyncCardNo(FActiveDispenser, True, '');
  //�ÿտ���

  InitSendData(@nSend, Char($43) + Char($50));
  if not SendToDispenser(@nSend) then Exit;

  nStr := '';
  nInit := GetTickCount();

  while GetTickCountDiff(nInit) < cDispenser_Wait_Timeout do
  begin
    nStr := QueryStatuse();
    if HasStatus(nStr, cTTCE_K7_TDNoCard) or
       HasStatus(nStr, cTTCE_K7_PosNew) then //�¿���׼����,��ͨ���޿�
    begin
      Result := True;
      Exit;
    end;
  end;

  if nStr <> '' then
  begin
    WriteLog(Format('����[ %s ]�޷������յ�������,������: %s.',
      [FActiveDispenser.FID, nStr]));
    //xxxxx
  end;
end;

//Date: 2018-11-24
//Desc: �����豸
function TDispenserThread.ResetDispenser: Boolean;
var nStr: string;
    nInit: Int64;
    nSend: TDispenserK7Send;
begin
  Result := False;
  InitSendData(@nSend, Char($52) + Char($53));
  if not SendToDispenser(@nSend) then Exit;

  nStr := '';
  nInit := GetTickCount();
  
  while GetTickCountDiff(nInit) < cDispenser_Wait_Timeout do
  begin
    nStr := QueryStatuse();
    if HasStatus(nStr, cTTCE_K7_PosNew) or
       HasStatus(nStr, cTTCE_K7_KXNoCard) then //�¿���׼����,�����޿�
    begin
      Result := True;
      if HasStatus(nStr, cTTCE_K7_KXNoCard) then
        WriteLog(Format('����[ %s ]����Ϊ��,������: %s.',
          [FActiveDispenser.FID, nStr]));
      Exit;
    end;
  end;

  if nStr <> '' then
  begin
    WriteLog(Format('����[ %s ]�޷�����,������: %s.',
      [FActiveDispenser.FID, nStr]));
    //xxxxx
  end;
end;

initialization
  gDispenserManager := nil;
finalization
  FreeAndNil(gDispenserManager);
end.
