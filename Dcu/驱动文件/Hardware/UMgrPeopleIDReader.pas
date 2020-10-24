{*******************************************************************************
  ����: dmzn@163.com 2019-03-18
  ����: ���������֤����������
*******************************************************************************}
unit UMgrPeopleIDReader;

interface

uses
  Windows, Classes, SysUtils, SyncObjs, USysLoger;

type
  TCardOpenMode = (omManual=0, omAuto=1);
  //�򿪷�ʽ: �ֶ�;�Զ�

  TCardPhotoPath = (ppCRoot=0, ppCurrent=1, ppFix=2);
  //��Ƭ·��: C��;��ǰ·��;ָ��·��

  TCardPhotoType = (ptBMP=0, ptJPG=1, ptBase64=2, ptWLT=3, ptNone=4);
  //��Ƭ����

  TCardPhotoName = (pnTMP=0, pnName=1, pnID=2, pnNameID=3);
  //��Ƭ����
  
  PCardData = ^TCardData;
  TCardData = packed record
    FName            : array[0..31] of Char;  //����
    FSex             : array[0..5] of Char;   //�Ա�
    FNation          : array[0..63] of Char;  //����
    FBorn            : array[0..17] of Char;  //��������
    FAddress         : array[0..71] of Char;  //סַ
    FIDCardNo        : array[0..37] of Char;  //���֤��
    FGrantDept       : array[0..31] of Char;  //��֤����
    FUserLifeBegin   : array[0..17] of Char;  //��Ч�ڿ�ʼ
    FUserLifeEnd     : array[0..17] of Char;  //��Ч�ڽ���
    FPassID          : array[0..19] of Char;  //ͨ��֤��
    FIssuesTimes     : array[0..5] of Char;   //ǩ������
    FReserved        : array[0..11] of Char;  //����
    FPhotoFileName   : array[0..254] of Char; //��Ƭ·��
    FCardType        : array[0..3] of Char;   //֤������
    FEngName         : array[0..121] of Char; //Ӣ����
    FCertVol         : array[0..5] of Char;   //֤���汾
  end;
  
  TPeopleIDReader = class
  private
    FPort: Integer;
    //�������˿�
    FLastCode: Integer;
    FLastError: string;
    //�ϴ��쳣
    FSyncLock: TCriticalSection;
    //ͬ������
  protected
    procedure InitData(var nData: TCardData);
    //��ʼ����
  public
    constructor Create;
    destructor Destroy; override;
    //�����ͷ�
    function ReadData(const nPath: string=''; const nName: TCardPhotoName = pnID;
      const nType: TCardPhotoType = ptBMP): TCardData;
    //��ȡ����
    property LastCode: Integer read FLastCode;
    property LastError: string read FLastError;
    //�������
  end;

var
  gPeopleIDReader: TPeopleIDReader = nil;

implementation

const
  cLibDLL = 'SynIDCard.dll';

function Syn_FindReader(): Integer;
 stdcall; external cLibDLL;
//Ѱ������
function Syn_OpenPort(nPort: Integer): Integer;
 stdcall; external cLibDLL;
//�򿪶˿�
function Syn_ClosePort(nPort: Integer): Integer;
 stdcall; external cLibDLL;
//�رն˿�
function Syn_StartFindIDCard(nPort: Integer; nIn: PChar;
 nIFOpen: Integer): Integer; stdcall; external cLibDLL;
//��ʼѰ��
function Syn_SelectIDCard(nPort: Integer; nIN: PChar;
 nIfOpen: Integer): Integer; stdcall; external cLibDLL;
//ѡ�п�Ƭ
function Syn_SetPhotoPath(nPath: Integer; nPhotoPath: PChar): Integer;
 stdcall; external cLibDLL;
//������Ƭ�ļ��洢��·��
function Syn_SetPhotoType(nType: Integer): Integer;
 stdcall; external cLibDLL;
//������Ƭ����
function Syn_SetPhotoName(nName: Integer): Integer;
 stdcall; external cLibDLL;
//������Ƭ����
function Syn_ReadMsg(nPort: Integer; nIfOpen: Integer;
 nCardData: PCardData): Integer; stdcall; external cLibDLL;
//��ȡ���֤��Ϣ
function Syn_ReadBaseMsg(nPort: Integer; nCHMsg: PChar; nCHMsgLen: PInteger;
 nPHMsg: PChar; nPHMsgLen: PInteger; nIfOpen: Integer): Integer;
 stdcall; external cLibDLL;
//��ȡ���֤�ڻ�����Ϣ������Ϣ

procedure WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(TPeopleIDReader, '���֤����', nEvent);
end;

//Date: 2019-03-18
//Parm: ������
//Desc: ����nCode������
function Code2Desc(const nCode: Integer): string;
begin
  case nCode of
    $90	: Result := '�����ɹ�';
    $91	: Result := '�������֤���޴�������';
    $9F	: Result := 'Ѱ�Ҿ������֤�ɹ�';
    $01	: Result := '�˿ڴ�ʧ��/�˿���δ��/�˿ںŲ��Ϸ�';
    $02	: Result := 'PC���ճ�ʱ���ڹ涨��ʱ����δ���յ��涨���ȵ�����';
    $03	: Result := '���ݴ������';
    $05	: Result := 'SAM_A���ڲ����ã�ֻ��Syn_GetCOMBaud��������';
    $09	: Result := '���ļ�ʧ��';
    $10	: Result := '����ҵ���ն����ݵ�У��ʹ�';
    $11	: Result := '����ҵ���ն����ݵĳ��ȴ�';
    $21	: Result := '����ҵ���ն˵��������,���������еĸ�����ֵ���߼��������';
    $23	: Result := 'ԽȨ����';
    $24	: Result := '�޷�ʶ��Ĵ���';
    $80	: Result := 'Ѱ�Ҿ������֤ʧ��';
    $81	: Result := 'ѡȡ�������֤ʧ��';
    $31	: Result := '�������֤��֤SAM_Aʧ��';
    $32	: Result := 'SAM_A��֤�������֤ʧ��';
    $33	: Result := '��Ϣ��֤ʧ��';
    $37	: Result := 'ָ����Ϣ��֤����';
    $3F	: Result := '��Ϣ���ȴ���';
    $40	: Result := '�޷�ʶ��ľ������֤����';
    $41	: Result := '���������֤����ʧ��';
    $47	: Result := 'ȡ�����ʧ��';
    $60	: Result := 'SAM_A�Լ�ʧ�ܣ����ܽ�������';
    $66	: Result := 'SAM_Aû������Ȩ,�޷�ʹ��';
  end;
end;

//------------------------------------------------------------------------------
constructor TPeopleIDReader.Create;
begin
  FLastCode := -1;
  FLastError := '';

  FPort := 0;
  FSyncLock := TCriticalSection.Create;
end;

destructor TPeopleIDReader.Destroy;
begin
  if FPort > 0 then
    Syn_ClosePort(FPort);
  //xxxxx

  FSyncLock.Free;
  inherited;
end;

//Date: 2019-03-28
//Parm: ����
//Desc: ��ʼ��nData����
procedure TPeopleIDReader.InitData(var nData: TCardData);
var nDef: TCardData;
begin
  FillChar(nDef, SizeOf(nDef), #0);
  nData := nDef;
end;

//Date: 2019-03-28
//Parm: ��Ƭ·��;��Ƭ�ļ���;��Ƭ����
//Desc: ��ȡ���֤��Ϣ
function TPeopleIDReader.ReadData(const nPath: string;
  const nName: TCardPhotoName; const nType: TCardPhotoType): TCardData;
var nHasOpen: Boolean;
    nBuf: array[0..254] of Char;
begin
  InitData(Result);
  //init
  nHasOpen := False;

  FSyncLock.Enter;
  try
    if FPort = 0 then
    begin
      FLastCode := Syn_FindReader();
      if FLastCode <= 0 then
      begin
        FLastError := 'û���ҵ�������';
        WriteLog(FLastError);

        FPort := 0;
        Exit;
      end;

      FPort := FLastCode;
      //find port
    end;

    if DirectoryExists(nPath) then
    begin
      StrPCopy(@nBuf[0], nPath);
      FLastCode := Syn_SetPhotoPath(Ord(ppFix), @nBuf[0]);
    end else FLastCode := Syn_SetPhotoPath(Ord(ppCurrent), @nBuf[0]);

    if FLastCode <> 0 then
    begin
      FLastError := '������Ƭ·������,����: %d,%s';
      FLastError := Format(FLastError, [FLastCode, Code2Desc(FLastCode)]);
      WriteLog(FLastError);
      Exit;
    end;

    FLastCode := Syn_SetPhotoType(Ord(nType));
    if FLastCode <> 0 then
    begin
      FLastError := '������Ƭ���ʹ���,����: %d,%s';
      FLastError := Format(FLastError, [FLastCode, Code2Desc(FLastCode)]);
      WriteLog(FLastError);
      Exit;
    end;

    FLastCode := Syn_SetPhotoName(Ord(nName));
    if FLastCode <> 0 then
    begin
      FLastError := '������Ƭ���ƴ���,����: %d,%s';
      FLastError := Format(FLastError, [FLastCode, Code2Desc(FLastCode)]);
      WriteLog(FLastError);
      Exit;
    end;

    FLastCode := Syn_OpenPort(FPort);
    if FLastCode <> 0 then
    begin
      Syn_ClosePort(FPort); //���쳣��ر�
      FPort := 0;

      FLastError := '�򿪶˿ڴ���,����: %d,%s';
      FLastError := Format(FLastError, [FLastCode, Code2Desc(FLastCode)]);
      WriteLog(FLastError);
      Exit;
    end;

    nHasOpen := True;
    FLastCode := Syn_StartFindIDCard(FPort, @nBuf[0], Ord(omManual)); //Ѱ��    
    if FLastCode = 0 then
    begin
      Sleep(20);
      FLastCode := Syn_SelectIDCard(FPort, @nBuf[0], Ord(omManual)); //ѡ��

      if FLastCode <> 0 then
      begin
        FLastError := 'ѡ��ʧ��,����: %d,%s';
        FLastError := Format(FLastError, [FLastCode, Code2Desc(FLastCode)]);
        WriteLog(FLastError);
        Exit;
      end;
    end;

    Sleep(20);
    FLastCode := Syn_ReadMsg(FPort, Ord(omManual), @Result); //����    
    if (FLastCode <> 0) and (FLastCode <> 1) then
    begin
      FLastError := '��ȡ���֤��Ϣʧ��,����: %d,%s';
      FLastError := Format(FLastError, [FLastCode, Code2Desc(FLastCode)]);
      WriteLog(FLastError);
      Exit;
    end;

    FLastCode := -1;
    FLastError := '';
    //no error
  finally
    if nHasOpen then
      Syn_ClosePort(FPort);
    FSyncLock.Leave;
  end;
end;

initialization
  gPeopleIDReader := nil;
finalization
  FreeAndNil(gPeopleIDReader);
end.
