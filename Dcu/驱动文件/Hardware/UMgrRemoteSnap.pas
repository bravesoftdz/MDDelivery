{*******************************************************************************
  ����: dmzn@163.com 2017-10-20
  ����: Զ��ץ�ļ�LED��ʾ����
*******************************************************************************}
unit UMgrRemoteSnap;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, NativeXml, IdComponent, IdTCPConnection,
  IdTCPClient, IdUDPServer, IdGlobal, IdSocketHandle, USysLoger, UWaitItem,
  ULibFun, UBase64;

type
  PHKDataBase = ^THKDataBase;
  THKDataBase = record
    FCommand   : Byte;     //������
    FDataLen   : Word;     //���ݳ�
  end;

  PHKPlaySnap = ^THKPlaySnap;
  THKPlaySnap = record
    FBase      : THKDataBase;
    FContent   : string;
  end;

  PHKDisplay = ^THKDisplay;
  THKDisplay = record
    FBase      : THKDataBase;
    FCard      : string;
    FText      : string;
    FColor     : Integer;
  end;

const
  cHKCmd_Display  = $17;  //��ʾ����
  cHKCmd_Snap     = $25;  //ץ��
  cSizeHKBase     = SizeOf(THKDataBase);
  
type
  THKSnapItem = record
    FID        : string;
    FName      : string;
    FHost      : string;
    FPort      : Integer;
    FEnable    : Boolean;
  end;

  THKSnapItems = array of THKSnapItem;

  THKSnapHelper = class;
  THKSnapConnector = class(TThread)
  private
    FOwner: THKSnapHelper;
    //ӵ����
    FListA: TStrings;
    //�ַ��б�
    FBuffer: TList;
    //���ͻ���
    FWaiter: TWaitObject;
    //�ȴ�����
    FClient: TIdTCPClient;
    //�������
  protected
    procedure DoExuecte(const nHost: THKSnapItem);
    procedure Execute; override;
    //ִ���߳�
  public
    constructor Create(AOwner: THKSnapHelper);
    destructor Destroy; override;
    //�����ͷ�
    procedure WakupMe;
    //�����߳�
    procedure StopMe;
    //ֹͣ�߳�
  end;

  THKSnapHelper = class(TObject)
  private
    FHosts: THKSnapItems;
    FSnaper: THKSnapConnector;
    //��·����
    FBuffData: TList;
    //��ʱ����
    FSyncLock: TCriticalSection;
    //ͬ����
  protected
    procedure ClearBuffer(const nList: TList);
    //������
  public
    constructor Create;
    destructor Destroy; override;
    //�����ͷ�
    procedure LoadConfig(const nFile: string);
    //��ȡ����
    procedure StartSnap;
    procedure StopSnap;
    //��ͣ��ȡ
    procedure Display(const nCard,nText: string; const nColor: Integer = 2);
    //LED��ʾ
  end;

var
  gHKSnapHelper: THKSnapHelper = nil;
  //ȫ��ʹ��

implementation

procedure WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(THKSnapHelper, 'Զ��ץ�ķ���', nEvent);
end;

constructor THKSnapHelper.Create;
begin
  FBuffData := TList.Create;
  FSyncLock := TCriticalSection.Create;
end;

destructor THKSnapHelper.Destroy;
begin
  StopSnap;
  ClearBuffer(FBuffData);
  FBuffData.Free;

  FSyncLock.Free;
  inherited;
end;

procedure THKSnapHelper.ClearBuffer(const nList: TList);
var nIdx: Integer;
    nBase: PHKDataBase;
begin
  for nIdx:=nList.Count - 1 downto 0 do
  begin
    nBase := nList[nIdx];

    case nBase.FCommand of
     cHKCmd_Display : Dispose(PHKDisplay(nBase));
    end;

    nList.Delete(nIdx);
  end;
end;

procedure THKSnapHelper.StartSnap;
begin
  if not Assigned(FSnaper) then
    FSnaper := THKSnapConnector.Create(Self);
  FSnaper.WakupMe;
end;

procedure THKSnapHelper.StopSnap;
begin
  if Assigned(FSnaper) then
    FSnaper.StopMe;
  FSnaper := nil;
end;

//Date: 2017-10-19
//Parm: ����ʶ;����;��ɫ
//Desc: ��nCard����ʾ��ɫΪnColor��nText����
procedure THKSnapHelper.Display(const nCard,nText: string;
 const nColor: Integer);
var nPtr: PHKDisplay;
begin
  FSyncLock.Enter;
  try
    ClearBuffer(FBuffData);
    //clear

    New(nPtr);
    FBuffData.Add(nPtr);

    nPtr.FBase.FCommand := cHKCmd_Display;
    nPtr.FCard := nCard;
    nPtr.FText := nText;
    nPtr.FColor := nColor;

    if Assigned(FSnaper) then
      FSnaper.WakupMe;
    //xxxxx
  finally
    FSyncLock.Leave;
  end;
end;

//Desc: ����nFile�����ļ�
procedure THKSnapHelper.LoadConfig(const nFile: string);
var nXML: TNativeXml;
    nNode: TXmlNode;
    nIdx,nNum: Integer;
begin
  SetLength(FHosts, 0);
  nXML := TNativeXml.Create;
  try
    nXML.LoadFromFile(nFile);
    //load config

    for nIdx:=0 to nXML.Root.NodeCount - 1 do
    begin
      nNode := nXML.Root.Nodes[nIdx];
      if CompareText(nNode.Name, 'item') <> 0 then Continue;
      //not valid item

      nNum := Length(FHosts);
      SetLength(FHosts, nNum + 1);

      with FHosts[nNum] do
      begin
        FID    := nNode.NodeByName('id').ValueAsString;
        FName  := nNode.NodeByName('name').ValueAsString;
        FHost  := nNode.NodeByName('ip').ValueAsString;
        FPort  := nNode.NodeByName('port').ValueAsInteger;
        FEnable := nNode.NodeByName('enable').ValueAsInteger = 1;
      end;
    end;
  finally
    nXML.Free;
  end;
end;

//------------------------------------------------------------------------------
constructor THKSnapConnector.Create(AOwner: THKSnapHelper);
begin
  inherited Create(False);
  FreeOnTerminate := False;

  FOwner := AOwner;
  FListA := TStringList.Create;
  
  FBuffer := TList.Create;
  FWaiter := TWaitObject.Create;
  FWaiter.Interval := 2000;

  FClient := TIdTCPClient.Create;
  FClient.ReadTimeout := 5 * 1000;
  FClient.ConnectTimeout := 5 * 1000;
end;

destructor THKSnapConnector.Destroy;
begin
  FClient.Disconnect;
  FClient.Free;

  FOwner.ClearBuffer(FBuffer);
  FBuffer.Free;

  FWaiter.Free;
  FListA.Free;
  inherited;
end;

procedure THKSnapConnector.StopMe;
begin
  Terminate;
  FWaiter.Wakeup;

  WaitFor;
  Free;
end;

procedure THKSnapConnector.WakupMe;
begin
  FWaiter.Wakeup;
end;

procedure THKSnapConnector.Execute;
var nIdx: Integer;
begin
  while not Terminated do
  try
    FWaiter.EnterWait;
    if Terminated then Exit;

    FOwner.FSyncLock.Enter;
    try
      for nIdx:=0 to FOwner.FBuffData.Count - 1 do
        FBuffer.Add(FOwner.FBuffData[nIdx]);
      FOwner.FBuffData.Clear;
    finally
      FOwner.FSyncLock.Leave;
    end;

    if FBuffer.Count > 0 then
    try
      for nIdx:=Low(FOwner.FHosts) to High(FOwner.FHosts) do
       if FOwner.FHosts[nIdx].FEnable then
        DoExuecte(FOwner.FHosts[nIdx]);
      //send voice command
    finally
      FOwner.ClearBuffer(FBuffer);
    end;
  except
    on E:Exception do
    begin
      WriteLog(E.Message);
    end;
  end;
end;

procedure THKSnapConnector.DoExuecte(const nHost: THKSnapItem);
var nIdx: Integer;
    nBuf,nTmp: TIdBytes;
    nPBase: PHKDataBase;
begin
  try
    if FClient.Connected and ((FClient.Host <> nHost.FHost) or (
       FClient.Port <> nHost.FPort)) then
    begin
      FClient.Disconnect;
      if Assigned(FClient.IOHandler) then
        FClient.IOHandler.InputBuffer.Clear;
      //try to swtich connection
    end;

    if not FClient.Connected then
    begin
      FClient.Host := nHost.FHost;
      FClient.Port := nHost.FPort;
      FClient.Connect;
    end;

    for nIdx:=FBuffer.Count - 1 downto 0 do
    begin
      nPBase := FBuffer[nIdx];

      if nPBase.FCommand = cHKCmd_Display then
      begin
        with FListA,PHKDisplay(nPBase)^ do
        begin
          Clear;
          Values['Card'] := FCard;
          Values['Text'] := FText;
          Values['Color'] := IntToStr(FColor);
        end;

        SetLength(nTmp, 0);
        nTmp := ToBytes(EncodeBase64(FListA.Text));
        nPBase.FDataLen := Length(nTmp);

        nBuf := RawToBytes(nPBase^, cSizeHKBase);
        AppendBytes(nBuf, nTmp);
        FClient.Socket.Write(nBuf);
      end;
    end;
  except
    WriteLog(Format('������[ %s ]����ץ��ָ��ʧ��.', [nHost.FHost]));
    //loged

    FClient.Disconnect;
    if Assigned(FClient.IOHandler) then
      FClient.IOHandler.InputBuffer.Clear;
    //close connection
  end;
end;

initialization
  gHKSnapHelper := THKSnapHelper.Create;
finalization
  FreeAndNil(gHKSnapHelper);
end.
