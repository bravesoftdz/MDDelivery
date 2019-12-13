{*******************************************************************************
  ����: dmzn@163.com 2013-11-23
  ����: ģ�鹤������,������Ӧ����¼�
*******************************************************************************}
unit UEventHardware;

{$I Link.Inc}
interface

uses
  Windows, Classes, UMgrPlug, UBusinessConst, ULibFun, UMITConst, UPlugConst;

type
  THardwareWorker = class(TPlugEventWorker)
  public
    class function ModuleInfo: TPlugModuleInfo; override;
    procedure RunSystemObject(const nParam: PPlugRunParameter); override;
    procedure InitSystemObject; override;
    //����������ʱ��ʼ��
    procedure BeforeStartServer; override;
    //��������֮ǰ����
    procedure AfterStopServer; override;
    //����ر�֮�����
  end;

var
  gPlugRunParam: TPlugRunParameter;
  //���в���

implementation

uses
  SysUtils, USysLoger, UHardBusiness, UMgrTruckProbe, UMgrParam,
  UMgrQueue, UMgrLEDCard, UMgrHardHelper, UMgrRemotePrint, U02NReader,
  {$IFDEF MultiReplay}UMultiJS_Reply, {$ELSE}UMultiJS, {$ENDIF}
  {$IFDEF UseModbusJS}UMultiModBus_JS, {$ENDIF}
  {$IFDEF UseLBCModbus}UMgrLBCModusTcp, {$ENDIF}
  UMgrERelay, UMgrRemoteVoice, UMgrCodePrinter, UMgrTTCEM100, UMgrBasisWeight,
  UMgrRFID102, UMgrVoiceNet, UBlueReader, UMgrSendCardNo, UMgrBXFontCard;

class function THardwareWorker.ModuleInfo: TPlugModuleInfo;
begin
  Result := inherited ModuleInfo;
  with Result do
  begin
    FModuleID := sPlug_ModuleHD;
    FModuleName := 'Ӳ���ػ�';
    FModuleVersion := '2014-09-30';
    FModuleDesc := '�ṩˮ��һ��ͨ������Ӳ����������';
    FModuleBuildTime:= Str2DateTime('2014-09-30 15:01:01');
  end;
end;

procedure THardwareWorker.RunSystemObject(const nParam: PPlugRunParameter);
var nStr,nCfg: string;
begin
  gPlugRunParam := nParam^;
  nCfg := gPlugRunParam.FAppPath + 'Hardware\';

  try
    nStr := 'LED';
    gCardManager.TempDir := nCfg + 'Temp\';
    gCardManager.FileName := nCfg + 'LED.xml';

    nStr := 'Զ���ͷ';
    gHardwareHelper.LoadConfig(nCfg + '900MK.xml');

    nStr := '����������';
    gBlueReader.LoadConfig(nCfg + 'BlueCardReader.XML');

    nStr := '�����ͷ';
    g02NReader.LoadConfig(nCfg + 'Readers.xml');

    nStr := '������';
    gMultiJSManager.LoadFile(nCfg + 'JSQ.xml');

    nStr := '�̵���';
    gERelayManager.LoadConfig(nCfg + 'ERelay.xml');

    nStr := 'Զ�̴�ӡ';
    gRemotePrinter.LoadConfig(nCfg + 'Printer.xml');

    nStr := '��������';
    gVoiceHelper.LoadConfig(nCfg + 'Voice.xml');

    nStr := '������������';
    if FileExists(nCfg + 'NetVoice.xml') then
    begin
      if not Assigned(gNetVoiceHelper) then
        gNetVoiceHelper := TNetVoiceManager.Create;
      gNetVoiceHelper.LoadConfig(nCfg + 'NetVoice.xml');
    end;

    nStr := '�����';
    gCodePrinterManager.LoadConfig(nCfg + 'CodePrinter.xml');

    {$IFDEF UseModbusJS}
    nStr := '����������';
    gModbusJSManager.LoadConfig(nCfg + 'ModBusTCPJS.xml');
    {$ENDIF}

    {$IFDEF HYRFID201}
    nStr := '����RFID102';
    if not Assigned(gHYReaderManager) then
    begin
      gHYReaderManager := THYReaderManager.Create;
      gHYReaderManager.LoadConfig(nCfg + 'RFID102.xml');
    end;
    {$ENDIF}

    {$IFDEF TTCEM100}
    nStr := '����һ������';
    if not Assigned(gM100ReaderManager) then
    begin
      gM100ReaderManager := TM100ReaderManager.Create;
      gM100ReaderManager.LoadConfig(nCfg + cTTCE_M100_Config);
    end;
    {$ENDIF}

    nStr := '���������';
    if FileExists(nCfg + 'TruckProber.xml') then
    begin
      gProberManager := TProberManager.Create;
      gProberManager.LoadConfig(nCfg + 'TruckProber.xml');
    end;

    {$IFDEF UseBXFontLED}
    nStr := 'װ��������С��';
    if FileExists(nCfg + 'BXFontLED.xml') then
    begin
      gBXFontCardManager := TBXFontCardManager.Create;
      gBXFontCardManager.LoadConfig(nCfg + 'BXFontLED.xml');
    end;
    {$ENDIF}

    {$IFDEF BasisWeight}
    nStr := '����װ��ҵ��';
    if FileExists(nCfg + 'Tunnels.xml') then
    begin
      gBasisWeightManager := TBasisWeightManager.Create;
      gBasisWeightManager.LoadConfig(nCfg + 'Tunnels.xml');
    end;
    {$ENDIF}

//    {$IFDEF FixLoad}
//    nStr := '����װ��';
//    gSendCardNo.LoadConfig(nCfg + 'PLCController.xml');
//    {$ENDIF}
  except
    on E:Exception do
    begin
      nStr := Format('����[ %s ]�����ļ�ʧ��: %s', [nStr, E.Message]);
      gSysLoger.AddLog(nStr);
    end;
  end;
end;

procedure THardwareWorker.InitSystemObject;
var
  nStr: string;
begin
  gHardwareHelper := THardwareHelper.Create;
  //Զ���ͷ

  if not Assigned(g02NReader) then
    g02NReader := T02NReader.Create;
  //�����ͷ

  if not Assigned(gMultiJSManager) then
    gMultiJSManager := TMultiJSManager.Create;
  //������

  gHardShareData := WhenBusinessMITSharedDataIn;
  //hard monitor share
  {$IFDEF UseModbusJS}
  if not Assigned(gModbusJSManager) then
    gModbusJSManager := TModbusJSManager.Create;
  {$ENDIF}

  {$IFDEF FixLoad}
  gSendCardNo := TReaderHelper.Create;
  {$ENDIF}

  {$IFDEF UseLBCModbus}
  gModBusClient := TReaderHelperEx.Create;
  {$ENDIF}
end;

procedure THardwareWorker.BeforeStartServer;
begin
  gTruckQueueManager.StartQueue(gParamManager.ActiveParam.FDB.FID);
  //truck queue

  gHardwareHelper.OnProce := WhenReaderCardArrived;
  gHardwareHelper.StartRead;
  //long reader

  gBlueReader.OnCardArrived := WhenBlueReaderCardArrived;
  if not gHardwareHelper.ConnHelper then gBlueReader.StartReader;
  //blue reader, �����ʹ��Ӳ���ػ�������������������Զ���

  {$IFDEF HYRFID201}
  if Assigned(gHYReaderManager) then
  begin
    gHYReaderManager.OnCardProc := WhenHYReaderCardArrived;
    gHYReaderManager.StartReader;
  end;
  {$ENDIF}

  g02NReader.OnCardIn := WhenReaderCardIn;
  g02NReader.OnCardOut := WhenReaderCardOut;
  g02NReader.StartReader;
  //near reader

  gMultiJSManager.SaveDataProc := WhenSaveJS;
  gMultiJSManager.GetTruckProc := GetJSTruck;
  gMultiJSManager.StartJS;
  //counter
  gERelayManager.ControlStart;
  //erelay

  gRemotePrinter.StartPrinter;
  //printer
  gVoiceHelper.StartVoice;
  //voice

  if Assigned(gNetVoiceHelper) then
    gNetVoiceHelper.StartVoice;
  //NetVoice

  gCardManager.StartSender;
  //led display

  {$IFDEF UseModbusJS}
//  gModbusJSManager.SaveDataProc := WhenSaveJSEx;
  gModbusJSManager.GetTruckProc := GetJSTruck;
  gModbusJSManager.StartReader;
  {$ENDIF}
  
  {$IFDEF MITTruckProber}
  gProberManager.StartProber;
  {$ENDIF} //truck

  {$IFDEF TTCEM100}
  if Assigned(gM100ReaderManager) then
  begin
    gM100ReaderManager.OnCardProc := WhenTTCE_M100_ReadCard;
    gM100ReaderManager.StartReader;
  end; //����һ������
  {$ENDIF}

  {$IFDEF FixLoad}
  if Assigned(gSendCardNo) then
  gSendCardNo.StartPrinter;
  //sendcard
  {$ENDIF}

  {$IFDEF UseBXFontLED}
  gBXFontCardManager.StartService;
  {$ENDIF}

  {$IFDEF BasisWeight}
  gBasisWeightManager.OnStatusChange := WhenBasisWeightStatusChange;
  gBasisWeightManager.StartService;
  {$ENDIF}
end;

procedure THardwareWorker.AfterStopServer;
begin
  gVoiceHelper.StopVoice;
  //voice
  gRemotePrinter.StopPrinter;
  //printer
  if Assigned(gNetVoiceHelper) then
    gNetVoiceHelper.StopVoice;
  //NetVoice

  gERelayManager.ControlStop;
  //erelay
  gMultiJSManager.StopJS;
  //counter

  g02NReader.StopReader;
  g02NReader.OnCardIn := nil;
  g02NReader.OnCardOut := nil;

  gHardwareHelper.StopRead;
  gHardwareHelper.OnProce := nil;
  //reader

  gBlueReader.StopReader;
  gBlueReader.OnCardArrived := nil;
  //blue reader

  {$IFDEF HYRFID201}
  if Assigned(gHYReaderManager) then
  begin
    gHYReaderManager.StopReader;
    gHYReaderManager.OnCardProc := nil;
  end;
  {$ENDIF}

  gCardManager.StopSender;
  //led

  {$IFDEF MITTruckProber}
  gProberManager.StopProber;
  {$ENDIF} //truck

  {$IFDEF TTCEM100}
  if Assigned(gM100ReaderManager) then
  begin
    gM100ReaderManager.StopReader;
    gM100ReaderManager.OnCardProc := nil;
  end; //����һ������
  {$ENDIF}

  gTruckQueueManager.StopQueue;

  {$IFDEF UseBXFontLED}
  gBXFontCardManager.StopService;
  {$ENDIF}
  //queue
  {$IFDEF BasisWeight}
  gBasisWeightManager.StopService;
  gBasisWeightManager.OnStatusChange := nil;
  {$ENDIF}

//  {$IFDEF FixLoad}
//  if Assigned(gSendCardNo) then
//  gSendCardNo.StopPrinter;
//  //sendcard
//  {$ENDIF}
//
//  {$IFDEF UseLBCModbus}
//  if Assigned(gModBusClient) then
//  gModBusClient.StopPrinter;
//  {$ENDIF}

end;

end.