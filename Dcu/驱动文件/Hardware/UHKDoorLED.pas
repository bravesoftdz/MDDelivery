{*******************************************************************************
  ����: dmzn@163.com 2017-10-18
  ����: �������Ÿ�LED������

  ��ע:
  *.֧���ͺ�: IS-TVL224
*******************************************************************************}
unit UHKDoorLED;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, NativeXml, UWaitItem, USysLoger;

type
  PHKCardParam = ^THKCardParam;
  THKCardParam = record
    FID        : string;            //��ʶ
    FName      : string;            //����
    FHost      : string;            //IP
    FPort      : Integer;           //�˿�
    
    FColor     : Integer;           //��ɫ:1,��ɫ;2,˫ɫ
    FWidth     : Integer;           //��
    FHeight    : Integer;           //��

    FTextKeep  : Integer;           //����ʱ��
    FTextSpeed : Integer;           //�����ٶ�
    FTextSend  : Int64;             //����ʱ��
    FDefaltTxt : string;            //Ĭ������
  end;

  THKDataDisplay = (ddNeiMa, ddLnTXT);
  //��ʾģʽ: ����,�����ı�

  PHKCardData = ^THKCardData;
  THKCardData = record
    FCard      : string;            //����ʶ
    FText      : string;            //����
    FColor     : Integer;           //��ɫ
    FDisplay   : THKDataDisplay;    //��ʾģʽ
    FEnabled   : Boolean;           //��Ч��ʶ
  end;

  THKCardManager = class;
  THKCardSender = class(TThread)
  private
    FOwner: THKCardManager;
    //ӵ����
    FWaiter: TWaitObject;
    //�ȴ�����
  protected
    procedure Execute; override;
    procedure Doexecute;
    //ִ���߳�
    procedure SendCardData(const nCard: PHKCardParam; const nData: PHKCardData);
    //��������
  public
    constructor Create(AOwner: THKCardManager);
    destructor Destroy; override;
    //�����ͷ�
    procedure WakupMe;
    //�����߳�
    procedure StopMe;
    //ֹͣ�߳�
  end;

  THKCardManager = class(TObject)
  private
    FEnabled: Boolean;
    //�Ƿ�����
    FCards: array of THKCardParam;
    //���б�
    FTextData: array of THKCardData;
    //��������
    FSender: THKCardSender;
    //�����߳�
    FSyncLock: TCriticalSection;
    //ͬ������
  protected
    procedure InitDataBuffer;
    //��ʼ����
  public
    constructor Create;
    destructor Destroy; override;
    //�����ͷ�
    procedure LoadConfig(const nFile: string);
    //��ȡ����
    procedure StartDiaplay;
    procedure StopDiaplay;
    //��ͣ����
    procedure GetCardList(const nList: TStrings);
    //��ȡ�б�
    procedure DisplayText(const nCard,nText: string; const nColor: Integer);
    //��ʾ�ı�
  end;

var
  gHKCardManager: THKCardManager = nil;
  //ȫ��ʹ��

implementation

const
  cDLLName = 'ListenPlayDll.DLL';

function StartSend(): Integer; stdcall; external cDLLName;
{
���ܣ�
  ����ͨѶ�Ự
����ֵ��
  �Ự���,��ֵ�������������
}
function EndSend(nHandle: Integer): Integer; stdcall; external cDLLName;
{
���ܣ�
  ����ͨѶ�Ự
����ֵ��
  1���ɹ�
  2�����ɹ�
}
function SetTransMode(nHandle,nTransMode,nMark,nType,
  nMarkID: Integer): Integer; stdcall; external cDLLName;
{
���ܣ�
  ����ͨѶģʽ
������
  Handle:�Ự���,StartSend����ֵ
  TransMode:����ģʽ   1 ���ڴ��� 2 ���ڴ���
  mark:Ĭ����Ϊ0.�����rfͨѶ������1
  controlType���ͺš�2��Tϵ�У�3��E��Qϵ�п�
  Markid����������ֵ��
����ֵ��
1���ɹ�
0�����ɹ�
}
function SetNetworkPara(nHandle,nPNum: Integer;
  nIP: PWideChar): Integer; stdcall; external cDLLName;
{
���ܣ�
  �����������
����:
 Handle:�Ự���,StartSend����ֵ
  pno:����
  ip:������IP��ַ
����ֵ��
  1���ɹ�
  2�����ɹ�
}
function SendScreenPara(nHandle,nColor,nWidth,
  nHeight: Integer): Integer; stdcall; external cDLLName;
{
���ܣ�
  ������Ļ����
����:
 Handle:�Ự���,StartSend����ֵ
 nColor:��ɫ 1,��ɫ;2,˫ɫ
 nWidth,nHeight:���
����ֵ��
  1���ɹ�
  2�����ɹ�
}
function AddControl(nHandle,nPNum,nDBColor: Integer): Integer;
  stdcall; external cDLLName;
{
���ܣ������ʾ��
������
  Handle:  �Ự���,StartSend����ֵ
  Pno:����
  DBColor����˫ɫ(��ɫΪ1 ��˫ɫΪ2,����ɫ3)
����ֵ��
  1���ɹ�
  2����������
}
function AddProgram (nHandle,nJNum,nPlayTime: Integer): Integer;
  stdcall; external cDLLName;
{
���ܣ���ӽ�Ŀ
������
  Handle:  �Ự���,StartSend����ֵ
  jno����Ŀ��
  playTime����Ŀ����ʱ��
����ֵ��
  1���ɹ�
  2����������
}
function AddNeiMaTxtArea1(const nHandle,nJNum,nQNum,nLeft,nTop,nWidth,
  nHeight: Integer; nText: PWideChar; nShowStyle,nFontName,nFontColor,
  nPlayStyle,nQuitStyle,nPlayspeed,nTimes: Integer): Integer;
  stdcall; external cDLLName;
{
���ܣ������������
������
  handle��	���
  Pno:       ����
  jno��		��Ŀ�� (>=1)
  qno��		����� (>=1)
  left��		�������ϽǶ���x���꣺8�ı�������λ������
  top��		�������ϽǶ���y����
  width��		�����ȣ�8�ı�������λ������
  height��		����߶�
  Showtext   ���͵����ݣ���"��ӭ����"��
  ShowStyle  �����С��ȡֵΪ16��32��16��ʾ16����32��ʾ32��������ȡֵ��Ч��
  Fontname   ����������ȡֵΪ0��ʾ���壬����Ϊ��Чֵ)
  Fontcolor   ������ɫ(ȡֵΪ1��2��3��1--��ɫ��2--��ɫ��3--��ɫ)
  PlayStyle   �����ؼ�
  QuitStyle   �˳��ؼ�---Ĭ��ֵ255
  PlaySpeed  �����ٶȣ�ȡֵ1--255����ʾ�ȼ�����ֵԽ�ߣ��ٶ�Խ����
  Times      ͣ��ʱ�䣨ȡֵ1-255��
����ֵ��
  5.�ɹ�
  6.ʧ��
}
function AddLnTxtString(nHandle,nJNum,nQNum,nLeft,nTop,nWidth,nHeight: Integer;
  nText,nFontName: PWideChar; nFontSize,nFontColor,nBold,nItalic,nUnderline,
  nPlayStyle,nPlaySpeed,nTimes: Integer): Integer; stdcall; external cDLLName;
{
���ܣ�
  ��ӵ����ı���ʹ���ַ�����
������
  jno��		��Ŀ�� (>=1)
  qno��		����� (>=1)

  left��		�������ϽǶ���x���꣺8�ı�������λ������
  top��		�������ϽǶ���y����
  width��		�����ȣ�8�ı�������λ������
  height��		����߶�

  Fontname    ��������
  Fontsize     �����С
  Fontcolor    ������ɫ��255������ɫ��65280������ɫ��65535������ɫ);
  Bold        �Ƿ����
  Italic        �Ƿ�б��
  Underline    �Ƿ��»���

  PlayStyle��  		��ʾ�ؼ���֧�����ơ����ơ����ơ����ƣ�
  Playspeed��		��ʾ�ٶ�
  Times           ������������δʹ�ã�
����ֵ��
  1���ɹ�
  2����������
}
function SendControl(nHandle,nSendType: Integer;nHWnd: THandle): Integer;
  stdcall; external cDLLName;
{
���ܣ���������
������
  SendType:����ģʽ1Ϊ��ͨ 2ΪSD������
  Hwnd:���ھ�� ,һ��ȡ0����
����ֵ��
  0��ԭ��1,û����ӽ�Ŀ2.��Ϊ���緢�ͣ���˿ڱ�ռ�� 3.��Ϊ���ڷ����򴮿ڱ�ռ�û򲻴���
  1�����ͳɹ�
  2��ͨѶʧ��
  3�����͹����г���
}

procedure WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(THKCardManager, '��������LED��', nEvent);
end;

//------------------------------------------------------------------------------
constructor THKCardManager.Create;
begin
  FEnabled := True;
  FSender := nil;

  InitDataBuffer;
  FSyncLock := TCriticalSection.Create;
end;

destructor THKCardManager.Destroy;
begin
  StopDiaplay;
  FSyncLock.Free;
  inherited;
end;

procedure THKCardManager.StartDiaplay;
begin
  if not FEnabled then Exit;
  //xxxxx
  
  if Length(FCards) < 1 then
    raise Exception.Create('Display Card List Is Null.');
  //xxxxx

  if not Assigned(FSender) then
    FSender := THKCardSender.Create(Self);
  FSender.WakupMe;
end;

procedure THKCardManager.StopDiaplay;
begin
  if Assigned(FSender) then
    FSender.StopMe;
  //xxxxx
  
  FSender := nil;
  InitDataBuffer;
end;

//Date: 2017-10-18
//Desc: ��ʼ�����ݻ���
procedure THKCardManager.InitDataBuffer;
var nIdx: Integer;
begin
  SetLength(FTextData, 10);
  for nIdx:=Low(FTextData) to High(FTextData) do
    FTextData[nIdx].FEnabled := False;
  //xxxx
end;

//Date: 2017-10-18
//Parm: ����ʶ;����;��ɫ
//Desc: ��nCard����ʾ��ɫΪnColor��nText����
procedure THKCardManager.DisplayText(const nCard, nText: string;
  const nColor: Integer);
var nIdx,nInt: Integer;
begin
  if not FEnabled then Exit;
  //xxxxx

  if not Assigned(FSender) then
    raise Exception.Create('Card Sender Should Start First.');
  //xxxxx

  FSyncLock.Enter;
  try
    for nIdx:=Low(FTextData) to High(FTextData) do
     with FTextData[nIdx] do
      if FEnabled and (FCard = nCard) then
      begin
        FText := nText;
        FColor := nColor;

        FSender.WakupMe;
        Exit;
      end; //ͬ�����ݺϲ�

    nInt := -1;
    for nIdx:=Low(FTextData) to High(FTextData) do
    if not FTextData[nIdx].FEnabled then
    begin
      nInt := nIdx;
      Break;
    end; //δʹ��

    if nInt < 0 then
    begin
      nInt := Length(FTextData);
      SetLength(FTextData, nInt + 1);
    end;

    with FTextData[nInt] do
    begin 
      FCard := nCard;
      FText := nText;
      FColor := nColor;

      FEnabled := True;
      FDisplay := ddNeiMa;
      FSender.WakupMe;
    end;
  finally
    FSyncLock.Leave;
  end;   
end;

//Date: 2017-10-18
//Parm: �б�
//Desc: ��ȡ���ÿ���ʶ�б�
procedure THKCardManager.GetCardList(const nList: TStrings);
var nIdx: Integer;
begin
  nList.Clear;
  for nIdx:=Low(FCards) to High(FCards) do
   with FCards[nIdx] do
    nList.Values[FID] := FName;
  //xxxxx
end;

procedure THKCardManager.LoadConfig(const nFile: string);
var nIdx,nInt: Integer;
    nXML: TNativeXml;
    nNode,nTmp: TXmlNode;
begin
  nXML := TNativeXml.Create;
  try
    SetLength(FCards, 0);
    nXML.LoadFromFile(nFile);
    nTmp := nXML.Root.FindNode('config');

    if Assigned(nTmp) then
    begin
      nIdx := nTmp.NodeByName('enable').ValueAsInteger;
      FEnabled := nIdx = 1;
    end;

    nTmp := nXML.Root.FindNode('cards');
    if Assigned(nTmp) then
    begin
      for nIdx:=0 to nTmp.NodeCount - 1 do
      begin
        nNode := nTmp.Nodes[nIdx];
        if nNode.NodeByName('enable').ValueAsInteger <> 1 then Continue;

        nInt := Length(FCards);
        SetLength(FCards, nInt + 1);

        with FCards[nInt] do
        begin
          FID := nNode.AttributeByName['id'];
          FName := nNode.AttributeByName['name'];

          FHost := nNode.NodeByName('ip').ValueAsString;
          FPort := nNode.NodeByName('port').ValueAsInteger;

          FColor := nNode.NodeByName('color').ValueAsInteger;
          FWidth := nNode.NodeByName('width').ValueAsInteger;
          FHeight := nNode.NodeByName('height').ValueAsInteger;

          FTextSend := 0;
          FTextKeep := nNode.NodeByName('textkeep').ValueAsInteger;
          FTextSpeed := nNode.NodeByName('textspeed').ValueAsInteger;
          FDefaltTxt := nNode.NodeByName('default').ValueAsString;
        end;
      end;
    end;
  finally
    nXML.Free;
  end;
end;

//------------------------------------------------------------------------------
constructor THKCardSender.Create(AOwner: THKCardManager);
begin
  inherited Create(False);
  FreeOnTerminate := False;

  FOwner := AOwner;
  FWaiter := TWaitObject.Create;
  FWaiter.Interval := 1000;
end;

destructor THKCardSender.Destroy;
begin
  FWaiter.Free;
  inherited;
end;

procedure THKCardSender.WakupMe;
begin
  FWaiter.Wakeup;
end;

procedure THKCardSender.StopMe;
begin
  Terminate;
  FWaiter.Wakeup;

  WaitFor;
  Free;
end;

procedure THKCardSender.Execute;
begin
  while not Terminated do
  try
    FWaiter.EnterWait;
    if Terminated then Exit;
    Doexecute;
  except
    on nErr: Exception do
    begin
      WriteLog(nErr.Message);
    end;
  end;
end;

procedure THKCardSender.Doexecute;
var nIdx: Integer;
    nData: THKCardData;
begin
  while not Terminated do
  with FOwner do
  begin
    FSyncLock.Enter;
    try
      nData.FEnabled := False;
      //default flag
      
      for nIdx:=Low(FTextData) to High(FTextData) do
      if FTextData[nIdx].FEnabled then
      begin
        nData := FTextData[nIdx];
        FTextData[nIdx].FEnabled := False;
        Break;
      end; //��ȡ����������
    finally
      FSyncLock.Leave;
    end;

    if not nData.FEnabled then
    begin
      for nIdx:=Low(FCards) to High(FCards) do
      with FCards[nIdx] do
      begin
        if (FTextSend = 0) or
           (GetTickCount - FTextSend < FTextKeep * 1000) then Continue;
        FTextSend := 0;

        with nData do
        begin
          FCard := FID;
          FText := FDefaltTxt;
          FColor := 2;
          
          FDisplay := ddLnTXT;
          FEnabled := True;
        end;

        Break;
      end;
    end; //����Ĭ������

    if not nData.FEnabled then Exit;
    //no data

    for nIdx:=Low(FCards) to High(FCards) do
    if CompareText(FCards[nIdx].FID, nData.FCard) = 0 then
    begin
      SendCardData(@FCards[nIdx], @nData);
      nData.FEnabled := False; //send flag
      
      nData.FText := '';
      Break;
    end;

    if nData.FEnabled then
    begin
      nData.FText := '����[ %s ]������,��ʾ�����Ѷ���.';
      WriteLog(Format(nData.FText, [nData.FCard]));
    end;
  end;
end;

//Date: 2017-10-18
//Parm: ��������;��ʾ����
//Desc: ��nCard����ʾnData����
procedure THKCardSender.SendCardData(const nCard: PHKCardParam;
  const nData: PHKCardData);
var nErr: string;
    nFont,nTxt: WideString;
    nInt,nHandle,nColor: Integer;
begin
  nErr := '��[ %s.%s ]��������ʧ��';
  nErr := Format(nErr, [nCard.FID, nCard.FName]);
  nErr := nErr + '(call %s return %d).';

  nHandle := -1;
  try
    nHandle := StartSend();
    if nHandle < 1 then
    begin
      WriteLog(Format(nErr, ['StartSend', nHandle]));
      Exit;
    end;

    nInt := SetTransMode(nHandle, 1, 0, 2, 1);
    if nInt <> 1 then
    begin
      WriteLog(Format(nErr, ['SetTransMode', nInt]));
      Exit;
    end;

    nTxt := nCard.FHost;
    nInt := SetNetworkPara(nHandle, 1, PWideChar(nTxt));
    if nInt <> 1 then
    begin
      WriteLog(Format(nErr, ['SetNetworkPara', nInt]));
      Exit;
    end;

    nInt := SendScreenPara(nHandle, nCard.FColor, nCard.FWidth, nCard.FHeight);
    if nInt <> 1 then
    begin
      WriteLog(Format(nErr, ['SendScreenPara', nInt]));
      Exit;
    end;

    nInt := AddControl(nHandle, 1, nCard.FColor);
    if nInt <> 1 then
    begin
      WriteLog(Format(nErr, ['AddControl', nInt]));
      Exit;
    end;

    nInt := AddProgram(nHandle, 1, 0);
    if nInt <> 1 then
    begin
      WriteLog(Format(nErr, ['AddProgram', nInt]));
      Exit;
    end;

    if nData.FDisplay = ddNeiMa then
    begin
      nTxt := nData.FText;
      nInt := AddNeiMaTxtArea1(nHandle, 1, 1, 0, 0, nCard.FWidth, nCard.FHeight,
              PWideChar(nTxt), 16, 0, nData.FColor, 1, 255, nCard.FTextSpeed, 255);
      //xxxxx

      if nInt <> 1 then
      begin
        WriteLog(Format(nErr, ['AddNeiMaTxtArea1', nInt]));
        Exit;
      end;

      nCard.FTextSend := GetTickCount;
      //���ͼ�ʱ
    end else

    if nData.FDisplay = ddLnTXT then
    begin
      nFont := '����';
      nTxt := nData.FText;

      case nData.FColor of
       1: nColor := 255;      //��ɫ
       2: nColor := 65535     //��ɫ
       else nColor := 65280;  //��ɫ
      end;

      nInt := AddLnTxtString(nHandle, 1, 1, 0, 0, nCard.FWidth, nCard.FHeight,
              PWideChar(nTxt), PWideChar(nFont), 12, nColor, 0, 0, 0, 32, 20, 0);
      //xxxxx

      if nInt <> 1 then
      begin
        WriteLog(Format(nErr, ['AddLnTxtString', nInt]));
        Exit;
      end;
    end;

    nInt := SendControl(nHandle, 1, 0);
    if nInt <> 1 then
    begin
      WriteLog(Format(nErr, ['SendControl', nInt]));
      Exit;
    end;
  finally
    if nHandle > 0 then
      EndSend(nHandle);
    //close handle
  end;
end;

initialization
  gHKCardManager := nil;
finalization
  FreeAndNil(gHKCardManager);
end.
