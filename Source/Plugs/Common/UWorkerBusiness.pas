{*******************************************************************************
  ����: dmzn@163.com 2013-12-04
  ����: ģ��ҵ�����
*******************************************************************************}
unit UWorkerBusiness;

{$I Link.Inc}
interface

uses
  Windows, Classes, Controls, DB, SysUtils, UBusinessWorker, UBusinessPacker,
  UBusinessConst, UMgrDBConn, UMgrParam, ZnMD5, ULibFun, UFormCtrl, UBase64,
  USysLoger, USysDB, UMITConst;

type
  TBusWorkerQueryField = class(TBusinessWorkerBase)
  private
    FIn: TWorkerQueryFieldData;
    FOut: TWorkerQueryFieldData;
  public
    class function FunctionName: string; override;
    function GetFlagStr(const nFlag: Integer): string; override;
    function DoWork(var nData: string): Boolean; override;
    //ִ��ҵ��
  end;

  TMITDBWorker = class(TBusinessWorkerBase)
  protected
    FErrNum: Integer;
    //������
    FDBConn: PDBWorker;
    //����ͨ��
    FDataIn,FDataOut: PBWDataBase;
    //��γ���
    FDataOutNeedUnPack: Boolean;
    //��Ҫ���
    procedure GetInOutData(var nIn,nOut: PBWDataBase); virtual; abstract;
    //�������
    function VerifyParamIn(var nData: string): Boolean; virtual;
    //��֤���
    function DoDBWork(var nData: string): Boolean; virtual; abstract;
    function DoAfterDBWork(var nData: string; nResult: Boolean): Boolean; virtual;
    //����ҵ��
  public
    function DoWork(var nData: string): Boolean; override;
    //ִ��ҵ��
    procedure WriteLog(const nEvent: string);
    //��¼��־
  end;

  TK3SalePalnItem = record
    FInterID: string;       //������
    FEntryID: string;       //������
    FTruck: string;         //���ƺ�
  end;

  TK3StockCKItem = record
    FStockID: string;       //���ϱ��
    FCKID   : string;       //�ֿ�ID
  end;

  TWorkerBusinessCommander = class(TMITDBWorker)
  private
    FListA,FListB,FListC: TStrings;
    //list
    FIn: TWorkerBusinessCommand;
    FOut: TWorkerBusinessCommand;
    {$IFDEF UseK3SalePlan}
    FSalePlans: array of TK3SalePalnItem;
    //k3���ۼƻ�
    {$ENDIF}
    FStockCKs: array of TK3StockCKItem;
  protected
    procedure GetInOutData(var nIn,nOut: PBWDataBase); override;
    function DoDBWork(var nData: string): Boolean; override;
    //base funciton
    function GetCardUsed(var nData: string): Boolean;
    //��ȡ��Ƭ����
    function Login(var nData: string):Boolean;
    function LogOut(var nData: string): Boolean;
    //��¼ע���������ƶ��ն�
    function GetServerNow(var nData: string): Boolean;
    //��ȡ������ʱ��
    function GetSerailID(var nData: string): Boolean;
    //��ȡ����
    function IsSystemExpired(var nData: string): Boolean;
    //ϵͳ�Ƿ��ѹ���
    function GetCustomerValidMoney(var nData: string): Boolean;
    //��ȡ�ͻ����ý�
    function GetCusMoney(var nCusId: string;var nMoney:Double): Boolean;
    procedure CheckZhiKaXTMoney;
    function GetZhiKaValidMoney(var nData: string): Boolean;
    //��ȡֽ�����ý�
    function GetZhiKaValidMoneyEx(var nData: string): Boolean;
    //��ȡֽ��ʣ���
    function CustomerHasMoney(var nData: string): Boolean;
    //��֤�ͻ��Ƿ���Ǯ
    function SaveTruck(var nData: string): Boolean;
    function UpdateTruck(var nData: string): Boolean;
    //���泵����Truck��
    function VerifyTruckLicense(var nData: string): Boolean;
    //����ʶ��
    function SaveStockKuWei(var nData: string): Boolean;
    //���泵��ͨ��
    function SaveBusinessCard(var nData: string): Boolean;
    //����ˢ����Ϣ
    function SaveTruckLine(var nData: string): Boolean;
    //���泵��ͨ��
    function GetTruckPoundData(var nData: string): Boolean;
    function SaveTruckPoundData(var nData: string): Boolean;
    //��ȡ������������
    function GetStockBatcode(var nData: string): Boolean;
    //��ȡƷ�����κ�
    function GetStockBatcodeByCusType(var nData: string): Boolean;
    //��ȡƷ�����κ�(���տͻ�����)
    {$IFDEF SendBillToBakDB}
    function SyncRemoteStockBill(var nData: string): Boolean;
    //����  ͬ�������������ÿ�
    {$ENDIF}
    procedure SaveHyDanEvent(const nStockno,nEvent,
          nFrom,nSolution,nDepartment: string);
    //���ɻ��鵥�����¼�
    function SaveGrabCard(var nData: string): Boolean;
    //����ץ����ˢ����Ϣ
    function GetSalesCredit(nSalesID: string):Double;
    //��ȡҵ��Ա����
    function GetUnLoadingPlace(var nData: string): Boolean;
    //��ȡж���ص㼰ǿ������ж���ص�����
    function GetPOrderBase(var nData: string): Boolean;
    //��ȡ�ض�����
  public
    constructor Create; override;
    destructor destroy; override;
    //new free
    function GetFlagStr(const nFlag: Integer): string; override;
    class function FunctionName: string; override;
    //base function
    class function CallMe(const nCmd: Integer; const nData,nExt: string;
      const nOut: PWorkerBusinessCommand): Boolean;
    //local call
  end;

implementation

class function TBusWorkerQueryField.FunctionName: string;
begin
  Result := sBus_GetQueryField;
end;

function TBusWorkerQueryField.GetFlagStr(const nFlag: Integer): string;
begin
  inherited GetFlagStr(nFlag);

  case nFlag of
   cWorker_GetPackerName : Result := sBus_GetQueryField;
  end;
end;

function TBusWorkerQueryField.DoWork(var nData: string): Boolean;
begin
  FOut.FData := '*';
  FPacker.UnPackIn(nData, @FIn);

  case FIn.FType of
   cQF_Bill: 
    FOut.FData := '*';
  end;

  Result := True;
  FOut.FBase.FResult := True;
  nData := FPacker.PackOut(@FOut);
end;

//------------------------------------------------------------------------------
//Date: 2012-3-13
//Parm: ���������
//Desc: ��ȡ�������ݿ��������Դ
function TMITDBWorker.DoWork(var nData: string): Boolean;
begin
  Result := False;
  FDBConn := nil;

  with gParamManager.ActiveParam^ do
  try
    FDBConn := gDBConnManager.GetConnection(FDB.FID, FErrNum);
    if not Assigned(FDBConn) then
    begin
      nData := '�������ݿ�ʧ��(DBConn Is Null).';
      Exit;
    end;

    if not FDBConn.FConn.Connected then
      FDBConn.FConn.Connected := True;
    //conn db

    FDataOutNeedUnPack := True;
    GetInOutData(FDataIn, FDataOut);
    FPacker.UnPackIn(nData, FDataIn);

    with FDataIn.FVia do
    begin
      FUser   := gSysParam.FAppFlag;
      FIP     := gSysParam.FLocalIP;
      FMAC    := gSysParam.FLocalMAC;
      FTime   := FWorkTime;
      FKpLong := FWorkTimeInit;
    end;

    {$IFDEF DEBUG}
    WriteLog('Fun: '+FunctionName+' InData:'+ FPacker.PackIn(FDataIn, False));
    {$ENDIF}
    if not VerifyParamIn(nData) then Exit;
    //invalid input parameter

    FPacker.InitData(FDataOut, False, True, False);
    //init exclude base
    FDataOut^ := FDataIn^;

    Result := DoDBWork(nData);
    //execute worker

    if Result then
    begin
      if FDataOutNeedUnPack then
        FPacker.UnPackOut(nData, FDataOut);
      //xxxxx

      Result := DoAfterDBWork(nData, True);
      if not Result then Exit;

      with FDataOut.FVia do
        FKpLong := GetTickCount - FWorkTimeInit;
      nData := FPacker.PackOut(FDataOut);

      {$IFDEF DEBUG}
      WriteLog('Fun: '+FunctionName+' OutData:'+ FPacker.PackOut(FDataOut, False));
      {$ENDIF}
    end else DoAfterDBWork(nData, False);
  finally
    gDBConnManager.ReleaseConnection(FDBConn);
  end;
end;

//Date: 2012-3-22
//Parm: �������;���
//Desc: ����ҵ��ִ����Ϻ����β����
function TMITDBWorker.DoAfterDBWork(var nData: string; nResult: Boolean): Boolean;
begin
  Result := True;
end;

//Date: 2012-3-18
//Parm: �������
//Desc: ��֤��������Ƿ���Ч
function TMITDBWorker.VerifyParamIn(var nData: string): Boolean;
begin
  Result := True;
end;

//Desc: ��¼nEvent��־
procedure TMITDBWorker.WriteLog(const nEvent: string);
begin
  gSysLoger.AddLog(TMITDBWorker, FunctionName, nEvent);
end;

//------------------------------------------------------------------------------
class function TWorkerBusinessCommander.FunctionName: string;
begin
  Result := sBus_BusinessCommand;
end;

constructor TWorkerBusinessCommander.Create;
begin
  FListA := TStringList.Create;
  FListB := TStringList.Create;
  FListC := TStringList.Create;
  inherited;
end;

destructor TWorkerBusinessCommander.destroy;
begin
  FreeAndNil(FListA);
  FreeAndNil(FListB);
  FreeAndNil(FListC);
  inherited;
end;

function TWorkerBusinessCommander.GetFlagStr(const nFlag: Integer): string;
begin
  Result := inherited GetFlagStr(nFlag);

  case nFlag of
   cWorker_GetPackerName : Result := sBus_BusinessCommand;
  end;
end;

procedure TWorkerBusinessCommander.GetInOutData(var nIn,nOut: PBWDataBase);
begin
  nIn := @FIn;
  nOut := @FOut;
  FDataOutNeedUnPack := False;
end;

//Date: 2014-09-15
//Parm: ����;����;����;���
//Desc: ���ص���ҵ�����
class function TWorkerBusinessCommander.CallMe(const nCmd: Integer;
  const nData, nExt: string; const nOut: PWorkerBusinessCommand): Boolean;
var nStr: string;
    nIn: TWorkerBusinessCommand;
    nPacker: TBusinessPackerBase;
    nWorker: TBusinessWorkerBase;
begin
  nPacker := nil;
  nWorker := nil;
  try
    nIn.FCommand := nCmd;
    nIn.FData := nData;
    nIn.FExtParam := nExt;

    nPacker := gBusinessPackerManager.LockPacker(sBus_BusinessCommand);
    nPacker.InitData(@nIn, True, False);
    //init
    
    nStr := nPacker.PackIn(@nIn);
    nWorker := gBusinessWorkerManager.LockWorker(FunctionName);
    //get worker

    Result := nWorker.WorkActive(nStr);
    if Result then
         nPacker.UnPackOut(nStr, nOut)
    else nOut.FData := nStr;
  finally
    gBusinessPackerManager.RelasePacker(nPacker);
    gBusinessWorkerManager.RelaseWorker(nWorker);
  end;
end;

//Date: 2012-3-22
//Parm: ��������
//Desc: ִ��nDataҵ��ָ��
function TWorkerBusinessCommander.DoDBWork(var nData: string): Boolean;
begin
  with FOut.FBase do
  begin
    FResult := True;
    FErrCode := 'S.00';
    FErrDesc := 'ҵ��ִ�гɹ�.';
  end;

  case FIn.FCommand of
   cBC_GetCardUsed         : Result := GetCardUsed(nData);
   cBC_ServerNow           : Result := GetServerNow(nData);
   cBC_GetSerialNO         : Result := GetSerailID(nData);
   cBC_IsSystemExpired     : Result := IsSystemExpired(nData);
   cBC_GetCustomerMoney    : Result := GetCustomerValidMoney(nData);
   cBC_GetZhiKaMoney       : Result := GetZhiKaValidMoney(nData);
   cBC_GetZhiKaMoneyEx     : Result := GetZhiKaValidMoneyEx(nData);
   cBC_CustomerHasMoney    : Result := CustomerHasMoney(nData);
   cBC_SaveTruckInfo       : Result := SaveTruck(nData);
   cBC_UpdateTruckInfo     : Result := UpdateTruck(nData);
   cBC_GetTruckPoundData   : Result := GetTruckPoundData(nData);
   cBC_SaveTruckPoundData  : Result := SaveTruckPoundData(nData);
   cBC_UserLogin           : Result := Login(nData);
   cBC_UserLogOut          : Result := LogOut(nData);
   cBC_GetStockBatcode     : Result := GetStockBatcode(nData);
   cBC_GetStockBatcodeByCusType : Result := GetStockBatcodeByCusType(nData);

   cBC_SaveGrabCard        : Result := SaveGrabCard(nData);

   cBC_SaveStockKuWei      : Result := SaveStockKuWei(nData);
   cBC_VeryTruckLicense    : Result := VerifyTruckLicense(nData);

   cBC_SaveBusinessCard    : Result := SaveBusinessCard(nData);

   cBC_SaveTruckLine       : Result := SaveTruckLine(nData);

   {$IFDEF SendBillToBakDB}
   cBC_SyncStockBill       : Result := SyncRemoteStockBill(nData);
   {$ENDIF}

   cBC_GetUnLoadingPlace   : Result := GetUnLoadingPlace(nData);
   cBC_GetSendingPlace     : Result := GetUnLoadingPlace(nData);
   cBC_GetPOrderBase       : Result := GetPOrderBase(nData);
   else
    begin
      Result := False;
      nData := '��Ч��ҵ�����(Invalid Command).';
    end;
  end;
end;

//Date: 2014-09-05
//Desc: ��ȡ��Ƭ���ͣ�����S;�ɹ�P;����O
function TWorkerBusinessCommander.GetCardUsed(var nData: string): Boolean;
var nStr: string;
begin
  Result := False;

  nStr := 'Select C_Used From %s Where C_Card=''%s'' ' +
          'or C_Card3=''%s'' or C_Card2=''%s''';
  nStr := Format(nStr, [sTable_Card, FIn.FData, FIn.FData, FIn.FData]);
  //card status

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount<1 then
    begin
      nData := '�ſ�[ %s ]��Ϣ������.';
      nData := Format(nData, [FIn.FData]);
      Exit;
    end;

    FOut.FData := Fields[0].AsString;
    Result := True;
  end;

  FOut.FExtParam := sFlag_OrderCardL;

  if FOut.FData = sFlag_Provide then
  begin
    nStr := 'select O_CType from %s Where O_Card=''%s'' ';
    nStr := Format(nStr, [sTable_Order, FIn.FData]);

    with gDBConnManager.WorkerQuery(FDBConn, nStr) do
    if RecordCount > 0 then
    begin
      FOut.FExtParam := Fields[0].AsString;
    end;
  end;
end;

//------------------------------------------------------------------------------
//Date: 2015/9/9
//Parm: �û��������룻�����û�����
//Desc: �û���¼
function TWorkerBusinessCommander.Login(var nData: string): Boolean;
var
  nStr: string;
  nID, nWLBId, nHysID:string;
begin
  Result := False;

  FListA.Clear;
  FListA.Text := PackerDecodeStr(FIn.FData);
  if FListA.Values['User']='' then Exit;
  //δ�����û���

  nStr := 'Select U_Password,U_Group From %s Where U_Name=''%s''';
  nStr := Format(nStr, [sTable_User, FListA.Values['User']]);
  //card status

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount<1 then Exit;

    nStr := Fields[0].AsString;
    if nStr<>FListA.Values['Password'] then Exit;

    {$IFDEF DoubleCheck}
      nID := Fields[1].AsString;

      nStr := 'select * from %s where D_Name=''%s''';
      nStr := Format(nStr,[sTable_SysDict,sFlag_HYSGroup]);
      with gDBConnManager.WorkerQuery(FDBConn, nStr) do
      begin
        if RecordCount<1 then Exit;

        nHysID := FieldByName('D_Value').AsString;
      end;

      nStr := 'select * from %s where D_Name=''%s''';
      nStr := Format(nStr,[sTable_SysDict,sFlag_WLBGroup]);
      with gDBConnManager.WorkerQuery(FDBConn, nStr) do
      begin
        if RecordCount<1 then Exit;
      
        nWLBId := FieldByName('D_Value').AsString;
      end;
      if nID = nHysID then
        FOut.FData := sFlag_HYSGroup
      else
      if nID = nWLBId then
        FOut.FData := sFlag_WLBGroup
      else
      begin
        FOut.FData := 'û������Ȩ��.';
        Exit;
      end;
    {$ENDIF}

    Result := True;
  end;
end;
//------------------------------------------------------------------------------
//Date: 2015/9/9
//Parm: �û�������֤����
//Desc: �û�ע��
function TWorkerBusinessCommander.LogOut(var nData: string): Boolean;
//var nStr: string;
begin
  {nStr := 'delete From %s Where I_ItemID=''%s''';
  nStr := Format(nStr, [sTable_ExtInfo, PackerDecodeStr(FIn.FData)]);
  //card status

  
  if gDBConnManager.WorkerExec(FDBConn, nStr)<1 then
       Result := False
  else Result := True;     }

  Result := True;
end;

//Date: 2014-09-05
//Desc: ��ȡ��������ǰʱ��
function TWorkerBusinessCommander.GetServerNow(var nData: string): Boolean;
var nStr: string;
begin
  nStr := 'Select ' + sField_SQLServer_Now;
  //sql

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    FOut.FData := DateTime2Str(Fields[0].AsDateTime);
    Result := True;
  end;
end;

//Date: 2012-3-25
//Desc: �������������б��
function TWorkerBusinessCommander.GetSerailID(var nData: string): Boolean;
var nInt: Integer;
    nStr,nP,nB: string;
begin
  FDBConn.FConn.BeginTrans;
  try
    Result := False;
    FListA.Text := FIn.FData;
    //param list

    nStr := 'Update %s Set B_Base=B_Base+1 ' +
            'Where B_Group=''%s'' And B_Object=''%s''';
    nStr := Format(nStr, [sTable_SerialBase, FListA.Values['Group'],
            FListA.Values['Object']]);
    gDBConnManager.WorkerExec(FDBConn, nStr);

    nStr := 'Select B_Prefix,B_IDLen,B_Base,B_Date,%s as B_Now From %s ' +
            'Where B_Group=''%s'' And B_Object=''%s''';
    nStr := Format(nStr, [sField_SQLServer_Now, sTable_SerialBase,
            FListA.Values['Group'], FListA.Values['Object']]);
    //xxxxx

    with gDBConnManager.WorkerQuery(FDBConn, nStr) do
    begin
      if RecordCount < 1 then
      begin
        nData := 'û��[ %s.%s ]�ı�������.';
        nData := Format(nData, [FListA.Values['Group'], FListA.Values['Object']]);

        FDBConn.FConn.RollbackTrans;
        Exit;
      end;

      nP := FieldByName('B_Prefix').AsString;
      nB := FieldByName('B_Base').AsString;
      nInt := FieldByName('B_IDLen').AsInteger;

      if FIn.FExtParam = sFlag_Yes then //�����ڱ���
      begin
        nStr := Date2Str(FieldByName('B_Date').AsDateTime, False);
        //old date

        if (nStr <> Date2Str(FieldByName('B_Now').AsDateTime, False)) and
           (FieldByName('B_Now').AsDateTime > FieldByName('B_Date').AsDateTime) then
        begin
          nStr := 'Update %s Set B_Base=1,B_Date=%s ' +
                  'Where B_Group=''%s'' And B_Object=''%s''';
          nStr := Format(nStr, [sTable_SerialBase, sField_SQLServer_Now,
                  FListA.Values['Group'], FListA.Values['Object']]);
          gDBConnManager.WorkerExec(FDBConn, nStr);

          nB := '1';
          nStr := Date2Str(FieldByName('B_Now').AsDateTime, False);
          //now date
        end;

        System.Delete(nStr, 1, 2);
        //yymmdd
        nInt := nInt - Length(nP) - Length(nStr) - Length(nB);
        FOut.FData := nP + nStr + StringOfChar('0', nInt) + nB;
      end else
      begin
        nInt := nInt - Length(nP) - Length(nB);
        nStr := StringOfChar('0', nInt);
        FOut.FData := nP + nStr + nB;
      end;
    end;

    FDBConn.FConn.CommitTrans;
    Result := True;
  except
    FDBConn.FConn.RollbackTrans;
    raise;
  end;
end;

//Date: 2014-09-05
//Desc: ��֤ϵͳ�Ƿ��ѹ���
function TWorkerBusinessCommander.IsSystemExpired(var nData: string): Boolean;
var nStr: string;
    nDate: TDate;
    nInt: Integer;
begin
  nDate := Date();
  //server now

  nStr := 'Select D_Value,D_ParamB From %s ' +
          'Where D_Name=''%s'' and D_Memo=''%s''';
  nStr := Format(nStr, [sTable_SysDict, sFlag_SysParam, sFlag_ValidDate]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  if RecordCount > 0 then
  begin
    nStr := 'dmzn_stock_' + Fields[0].AsString;
    nStr := MD5Print(MD5String(nStr));

    if nStr = Fields[1].AsString then
      nDate := Str2Date(Fields[0].AsString);
    //xxxxx
  end;

  nInt := Trunc(nDate - Date());
  Result := nInt > 0;

  if nInt <= 0 then
  begin
    nStr := 'ϵͳ�ѹ��� %d ��,����ϵ����Ա!!';
    nData := Format(nStr, [-nInt]);
    Exit;
  end;

  FOut.FData := IntToStr(nInt);
  //last days

  if nInt <= 7 then
  begin
    nStr := Format('ϵͳ�� %d ������', [nInt]);
    FOut.FBase.FErrDesc := nStr;
    FOut.FBase.FErrCode := sFlag_ForceHint;
  end;
end;

function TWorkerBusinessCommander.GetSalesCredit(nSalesID: string): Double;
var
  nStr:string;
  nCredit, nUsed, nCusMoney:Double;
  nCusList:TStrings;
  nIdx:integer;
begin
  Result := 0;
  nStr := 'select * from %s where S_ID=''%s''';
  nStr := Format(nStr,[sTable_Salesman,nSalesID]);
  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount = 0 then Exit;
    if FieldByName('S_CreditLimit').AsFloat <= 0  then Exit;
    nCredit := FieldByName('S_CreditLimit').AsFloat;
  end;

  nStr := 'select C_ID from %s where C_SaleMan=''%s''';
  nStr := Format(nStr,[sTable_Customer,nSalesID]);
  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount = 0 then Exit;
    nCusList := TStringList.Create;
    First;
    while not Eof do
    begin
      nCusList.Add(FieldByName('C_ID').asstring);
      Next;
    end;

    for nIdx := 0 to nCusList.Count-1 do
    begin
      nStr := nCusList[nidx];
      if not GetCusMoney(nStr, nCusMoney) then Exit;
      if nCusMoney < 0 then
      nUsed := nUsed + nCusMoney;
      //���и�ҵ��Ա���¿ͻ��Ѿ�͸֧���
    end;
  end;

  nStr := 'update %s set S_CreditUsed=-(%s) where S_Id=''%s''';
  nStr := Format(nStr,[sTable_Salesman,FloatToStr(nUsed),nSalesID]);
  gDBConnManager.WorkerExec(FDBConn, nStr);

  if nCredit + nUsed >= 0 then
    Result := nCredit + nUsed;
end;

{$IFDEF COMMON}
//Date: 2014-09-05
//Desc: ��ȡָ���ͻ��Ŀ��ý��
function TWorkerBusinessCommander.GetCustomerValidMoney(var nData: string): Boolean;
var nStr: string;
    nUseCredit: Boolean;
    nVal,nCredit, nSalesCredit: Double;
begin
  nUseCredit := False;
  if FIn.FExtParam = sFlag_Yes then
  begin
    nStr := 'Select MAX(C_End) From %s ' +
            'Where C_CusID=''%s'' and C_Money>=0 and C_Verify=''%s''';
    nStr := Format(nStr, [sTable_CusCredit, FIn.FData, sFlag_Yes]);

    with gDBConnManager.WorkerQuery(FDBConn, nStr) do
      nUseCredit := (Fields[0].AsDateTime > Str2Date('2000-01-01')) and
                    (Fields[0].AsDateTime > Now());
    //����δ����
  end;

  nStr := 'Select * From %s Where A_CID=''%s''';
  nStr := Format(nStr, [sTable_CusAccount, FIn.FData]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount < 1 then
    begin
      nData := '���Ϊ[ %s ]�Ŀͻ��˻�������.';
      nData := Format(nData, [FIn.FData]);

      Result := False;
      Exit;
    end;

    nVal := FieldByName('A_InitMoney').AsFloat + FieldByName('A_InMoney').AsFloat -
            FieldByName('A_OutMoney').AsFloat -
            FieldByName('A_Compensation').AsFloat -
            FieldByName('A_FreezeMoney').AsFloat;
    //xxxxx

    nCredit := FieldByName('A_CreditLimit').AsFloat;
    nCredit := Float2PInt(nCredit, cPrecision, False) / cPrecision;

    if nUseCredit then
      nVal := nVal + nCredit;

    //ʹ��ҵ��Ա����
    {$IFDEF UseSalesCredit}
      nStr := 'select C_SaleMan from %s where C_Id=''%s''';
      nStr := Format(nstr,[sTable_Customer, FIn.FData]);
      with gDBConnManager.WorkerQuery(FDBConn, nStr) do
      begin
        if RecordCount =  1 then
        begin
          if Trim(FieldByName('C_SaleMan').AsString) <> '' then
          begin
            nStr := FieldByName('C_SaleMan').AsString;
            nSalesCredit := GetSalesCredit(nStr);
            WriteLog('ҵ��Ա['+ nStr +']����:'+floattostr(nSalesCredit));
          end;
        end;
      end;

      if nVal < 0 then
        nVal := nSalesCredit
      else
        nVal := nVal + nSalesCredit;
      WriteLog('�ͻ�['+fin.FData+']�ϼƿ���:'+floattostr(nVal));
    {$ENDIF}

    nVal := Float2PInt(nVal, cPrecision, False) / cPrecision;
    FOut.FData := FloatToStr(nVal);
    FOut.FExtParam := FloatToStr(nCredit);
    Result := True;
  end;
end;
{$ENDIF}

{$IFDEF COMMON}
//Date: 2014-09-05
//Desc: ��ȡָ��ֽ���Ŀ��ý��
function TWorkerBusinessCommander.GetZhiKaValidMoney(var nData: string): Boolean;
var nStr, nCusId: string;
    nVal,nMoney,nCredit, nSalesCredit: Double;
begin
  //У���ʽ�
  CheckZhiKaXTMoney;
  nStr := 'Select ca.*,Z_OnlyMoney,Z_FixedMoney From $ZK,$CA ca ' +
          'Where Z_ID=''$ZID'' and A_CID=Z_Customer';
  nStr := MacroValue(nStr, [MI('$ZK', sTable_ZhiKa), MI('$ZID', FIn.FData),
          MI('$CA', sTable_CusAccount)]);
  //xxxxx

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount < 1 then
    begin
      nData := '���Ϊ[ %s ]��ֽ��������,��ͻ��˻���Ч.';
      nData := Format(nData, [FIn.FData]);

      Result := False;
      Exit;
    end;

    FOut.FExtParam := FieldByName('Z_OnlyMoney').AsString;
    nMoney := FieldByName('Z_FixedMoney').AsFloat;

    nVal := FieldByName('A_InitMoney').AsFloat + FieldByName('A_InMoney').AsFloat -
            FieldByName('A_OutMoney').AsFloat -
            FieldByName('A_Compensation').AsFloat -
            FieldByName('A_FreezeMoney').AsFloat;
    //xxxxx

    nCredit := FieldByName('A_CreditLimit').AsFloat;
    nCredit := Float2PInt(nCredit, cPrecision, False) / cPrecision;
    nCusId := fieldbyname('A_CId').AsString;

    nStr := 'Select MAX(C_End) From %s ' +
            'Where C_CusID=''%s'' and C_Money>=0 and C_Verify=''%s''';
    nStr := Format(nStr, [sTable_CusCredit, FieldByName('A_CID').AsString,
            sFlag_Yes]);
    //xxxxx

    with gDBConnManager.WorkerQuery(FDBConn, nStr) do
    if (Fields[0].AsDateTime > Str2Date('2000-01-01')) and
       (Fields[0].AsDateTime > Now()) then
    begin
      nVal := nVal + nCredit;
      //����δ����
    end;

    nVal := Float2PInt(nVal, cPrecision, False) / cPrecision;
    //total money

    if FOut.FExtParam = sFlag_Yes then
    begin
      if nMoney > nVal then
        nMoney := nVal;
      //enough money
    end else nMoney := nVal;

    FOut.FData := FloatToStr(nMoney);
    Result := True;
  end;
end;

//Date: 2014-09-05
//Desc: ��ȡָ��ֽ���Ŀ��ý��
function TWorkerBusinessCommander.GetZhiKaValidMoneyEx(var nData: string): Boolean;
var nStr: string;
    nVal,nMoney,nCredit: Double;
begin
  nStr := 'Select ca.*,Z_OnlyMoney,Z_FixedMoney From $ZK,$CA ca ' +
          'Where Z_ID=''$ZID'' and A_CID=Z_Customer';
  nStr := MacroValue(nStr, [MI('$ZK', sTable_ZhiKa), MI('$ZID', FIn.FData),
          MI('$CA', sTable_CusAccount)]);
  //xxxxx

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount < 1 then
    begin
      nData := '���Ϊ[ %s ]��ֽ��������,��ͻ��˻���Ч.';
      nData := Format(nData, [FIn.FData]);

      Result := False;
      Exit;
    end;

    nVal := FieldByName('A_InitMoney').AsFloat + FieldByName('A_InMoney').AsFloat -
            FieldByName('A_OutMoney').AsFloat;
            
    nVal := Float2PInt(nVal, cPrecision, False) / cPrecision;
    //total money

    nMoney := nVal;
    FOut.FData := FloatToStr(nMoney);
    Result := True;
  end;
end;
{$ENDIF}

//Date: 2014-09-05
//Desc: ��֤�ͻ��Ƿ���Ǯ,�Լ������Ƿ����
function TWorkerBusinessCommander.CustomerHasMoney(var nData: string): Boolean;
var nStr,nName: string;
    nM,nC: Double;
begin
  FIn.FExtParam := sFlag_No;
  Result := GetCustomerValidMoney(nData);
  if not Result then Exit;

  nM := StrToFloat(FOut.FData);
  FOut.FData := sFlag_Yes;
  if nM > 0 then Exit;

  nStr := 'Select C_Name From %s Where C_ID=''%s''';
  nStr := Format(nStr, [sTable_Customer, FIn.FData]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount > 0 then
         nName := Fields[0].AsString
    else nName := '��ɾ��';
  end;

  nC := StrToFloat(FOut.FExtParam);
  if (nC <= 0) or (nC + nM <= 0) then
  begin
    nData := Format('�ͻ�[ %s ]���ʽ�����.', [nName]);
    Result := False;
    Exit;
  end;

  nStr := 'Select MAX(C_End) From %s ' +
          'Where C_CusID=''%s'' and C_Money>=0 and C_Verify=''%s''';
  nStr := Format(nStr, [sTable_CusCredit, FIn.FData, sFlag_Yes]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  if (Fields[0].AsDateTime > Str2Date('2000-01-01')) and
     (Fields[0].AsDateTime <= Now()) then
  begin
    nData := Format('�ͻ�[ %s ]�������ѹ���.', [nName]);
    Result := False;
  end;
end;

//Date: 2014-10-02
//Parm: ���ƺ�[FIn.FData];
//Desc: ���泵����sTable_Truck��
function TWorkerBusinessCommander.SaveTruck(var nData: string): Boolean;
var nStr: string;
begin
  Result := True;
  FIn.FData := UpperCase(FIn.FData);
  
  nStr := 'Select Count(*) From %s Where T_Truck=''%s''';
  nStr := Format(nStr, [sTable_Truck, FIn.FData]);
  //xxxxx

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  if Fields[0].AsInteger < 1 then
  begin
    nStr := 'Insert Into %s(T_Truck, T_PY) Values(''%s'', ''%s'')';
    nStr := Format(nStr, [sTable_Truck, FIn.FData, GetPinYinOfStr(FIn.FData)]);
    gDBConnManager.WorkerExec(FDBConn, nStr);
  end;
end;

function TWorkerBusinessCommander.VerifyTruckLicense(var nData: string): Boolean;
var nStr: string;
    nTruck, nBill, nPos, nEvent, nDept, nPicName: string;
    nUpdate, nNeedManu: Boolean;
    nLastTime: TDateTime;
begin
  Result := False;
  FListA.Text := FIn.FData;
  nPos := sFlag_DepBangFang;
  nDept:= sFlag_DepDaTing;
  nEvent:= '' ;
  nNeedManu := False;

  nTruck := FListA.Values['Truck'];
  nBill  := FListA.Values['Bill'];

  nStr := 'Select D_Value From %s Where D_Name=''%s'' and D_Memo=''%s''';
  nStr := Format(nStr, [sTable_SysDict, sFlag_TruckInNeedManu,nPos]);
  //xxxxx

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount > 0 then
    begin
      nNeedManu := FieldByName('D_Value').AsString = sFlag_Yes;
    end;
  end;

  if not nNeedManu then
  begin
    WriteLog('����ʶ��:'+'��λ:'+nPos+'�¼����ղ���:'+nDept+'�˹���Ԥ:��');
  end
  else
    WriteLog('����ʶ��:'+'��λ:'+nPos+'�¼����ղ���:'+nDept+'�˹���Ԥ:��');

  nStr := 'Select isnull(T_LastTime,''2000-12-12 09:00:00'') as T_LastTime From %s Where T_Truck=''%s''  ';
  nStr := Format(nStr, [sTable_Truck, nTruck]);
  //xxxxx

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount < 1 then
    begin
      Result:= False;
      nData := '����[ %s ]ʶ���쳣';
      nData := Format(nData, [nTruck]);
      FOut.FData := nData;
      Exit;
    end;
    
    nLastTime := FieldByName('T_LastTime').AsDateTime;
    if Now - nLastTime <= 0.1 then
    begin
      nData := '����[ %s ]����ʶ��ɹ�';
      nData:= Format(nData, [nTruck]);
      FOut.FData := nData;
      Result := True;
      Exit;
    end;
    //����ʶ��ɹ�
  end;

  if not nNeedManu then
  begin
   // Result := True;
    Exit;
  end;

  nStr := 'Select * From %s Where E_ID=''%s''';
  nStr := Format(nStr, [sTable_ManualEvent, nBill+sFlag_ManualE]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount > 0 then
    begin
      if FieldByName('E_Result').AsString = 'N' then
      begin
        nData := '����[ %s ]����ʶ��ʧ��,����Ա��ֹ����';
        nData := Format(nData, [nTruck]);
        FOut.FData := nData;
        Exit;
      end;
      if FieldByName('E_Result').AsString = 'Y' then
      begin
        Result := True;
        nData := '����[ %s ]����ʶ��ʧ��,����Ա����';
        nData := Format(nData, [nTruck]);
        FOut.FData := nData;
        Exit;
      end;
      nUpdate := True;
    end
    else
    begin
      nData := '����[ %s ]����ʶ��ʧ��';
      nData := Format(nData, [nTruck]);
      FOut.FData := nData;
      nUpdate := False;
      Result  := False;
    end;
  end;

  nEvent := '����[ %s ]����ʶ��ʧ��';
  nEvent := Format(nEvent, [nTruck]);

  nStr := SF('E_ID', nBill+sFlag_ManualE);
  nStr := MakeSQLByStr([
          SF('E_ID', nBill+sFlag_ManualE),
          SF('E_Key', nPicName),
          SF('E_From', nPos),
          SF('E_Result', 'Null', sfVal),

          SF('E_Event', nEvent),
          SF('E_Solution', sFlag_Solution_YN),
          SF('E_Departmen', nDept),
          SF('E_Date', sField_SQLServer_Now, sfVal)
          ], sTable_ManualEvent, nStr, (not nUpdate));
  //xxxxx
  gDBConnManager.WorkerExec(FDBConn, nStr);
end;

function TWorkerBusinessCommander.SaveStockKuWei(var nData: string): Boolean;
var
  nStr, nKuWei: string;
begin
  Result := True;

  if FIn.FData = '' then
    Exit;

  FListA.Clear;

  FListA.Text := FIn.FData;

  if FListA.Values['ID'] = '' then
    Exit;

  nStr := 'Select D_Value From %s Where D_Name=''%s'' And D_Memo=''%s'' And D_ParamB=''%s'' ';
  nStr := Format(nStr, [sTable_SysDict, sFlag_StockKuWei, FListA.Values['StockNo'],FListA.Values['LineID']]);
  
  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  if RecordCount > 0 then
  begin
    nKuWei := Fields[0].AsString;
  end
  else
    Exit;

  nStr := 'Update %s Set L_KuWei=''%s''  Where L_ID=''%s''';
  nStr := Format(nStr, [sTable_Bill, nKuWei,
                                     FListA.Values['ID']]);
  WriteLog('ˢ������������λSQL:' + nStr);
  gDBConnManager.WorkerExec(FDBConn, nStr);
end;

//Date: 2016-02-16
//Parm: ���ƺ�(Truck); ���ֶ���(Field);����ֵ(Value)
//Desc: ���³�����Ϣ��sTable_Truck��
function TWorkerBusinessCommander.UpdateTruck(var nData: string): Boolean;
var nStr: string;
    nValInt: Integer;
    nValFloat: Double;
begin
  Result := True;
  FListA.Text := FIn.FData;

  if FListA.Values['Field'] = 'T_PValue' then
  begin
    nStr := 'Select T_PValue, T_PTime From %s Where T_Truck=''%s''';
    nStr := Format(nStr, [sTable_Truck, FListA.Values['Truck']]);

    with gDBConnManager.WorkerQuery(FDBConn, nStr) do
    if RecordCount > 0 then
    begin
      nValInt := Fields[1].AsInteger;
      nValFloat := Fields[0].AsFloat;
    end else Exit;

//    nValFloat := nValFloat * nValInt + StrToFloatDef(FListA.Values['Value'], 0);
//    nValFloat := nValFloat / (nValInt + 1);
//    nValFloat := Float2Float(nValFloat, cPrecision);

    nValFloat := StrToFloatDef(FListA.Values['Value'], 0);
    nValFloat := Float2Float(nValFloat, cPrecision);

    nStr := 'Update %s Set T_PValue=%.2f, T_PTime=T_PTime+1 Where T_Truck=''%s''';
    nStr := Format(nStr, [sTable_Truck, nValFloat, FListA.Values['Truck']]);
    gDBConnManager.WorkerExec(FDBConn, nStr);
  end;
end;

//Date: 2014-09-25
//Parm: ���ƺ�[FIn.FData]
//Desc: ��ȡָ�����ƺŵĳ�Ƥ����(ʹ�����ģʽ,δ����)
function TWorkerBusinessCommander.GetTruckPoundData(var nData: string): Boolean;
var nStr: string;
    nPound: TLadingBillItems;
begin
  SetLength(nPound, 1);
  FillChar(nPound[0], SizeOf(TLadingBillItem), #0);

  nStr := 'Select * From %s Where P_Truck=''%s'' And ' +
          'P_MValue Is Null And P_PModel=''%s''';
  nStr := Format(nStr, [sTable_PoundLog, FIn.FData, sFlag_PoundPD]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr),nPound[0] do
  begin
    if RecordCount > 0 then
    begin
      FCusID      := FieldByName('P_CusID').AsString;
      FCusName    := FieldByName('P_CusName').AsString;
      FTruck      := FieldByName('P_Truck').AsString;

      FType       := FieldByName('P_MType').AsString;
      FStockNo    := FieldByName('P_MID').AsString;
      FStockName  := FieldByName('P_MName').AsString;

      with FPData do
      begin
        FStation  := FieldByName('P_PStation').AsString;
        FValue    := FieldByName('P_PValue').AsFloat;
        FDate     := FieldByName('P_PDate').AsDateTime;
        FOperator := FieldByName('P_PMan').AsString;
      end;  

      FFactory    := FieldByName('P_FactID').AsString;
      FPModel     := FieldByName('P_PModel').AsString;
      FPType      := FieldByName('P_Type').AsString;
      FPoundID    := FieldByName('P_ID').AsString;

      FStatus     := sFlag_TruckBFP;
      FNextStatus := sFlag_TruckBFM;
      FSelected   := True;
    end else
    begin
      FTruck      := FIn.FData;
      FPModel     := sFlag_PoundPD;

      FStatus     := '';
      FNextStatus := sFlag_TruckBFP;
      FSelected   := True;
    end;
  end;

  FOut.FData := CombineBillItmes(nPound);
  Result := True;
end;

//Date: 2014-09-25
//Parm: ��������[FIn.FData]
//Desc: ��ȡָ�����ƺŵĳ�Ƥ����(ʹ�����ģʽ,δ����)
function TWorkerBusinessCommander.SaveTruckPoundData(var nData: string): Boolean;
var nStr,nSQL: string;
    nPound: TLadingBillItems;
    nOut: TWorkerBusinessCommand;
begin
  AnalyseBillItems(FIn.FData, nPound);
  //��������

  with nPound[0] do
  begin
    if FPoundID = '' then
    begin
      TWorkerBusinessCommander.CallMe(cBC_SaveTruckInfo, FTruck, '', @nOut);
      //���泵�ƺ�

      FListC.Clear;
      FListC.Values['Group'] := sFlag_BusGroup;
      FListC.Values['Object'] := sFlag_PoundID;

      if not CallMe(cBC_GetSerialNO,
            FListC.Text, sFlag_Yes, @nOut) then
        raise Exception.Create(nOut.FData);
      //xxxxx

      FPoundID := nOut.FData;
      //new id

      if FPModel = sFlag_PoundLS then
           nStr := sFlag_Other
      else nStr := sFlag_Provide;

      nSQL := MakeSQLByStr([
              SF('P_ID', FPoundID),
              SF('P_Type', nStr),
              SF('P_Truck', FTruck),
              SF('P_CusID', FCusID),
              SF('P_CusName', FCusName),
              SF('P_MID', FStockNo),
              SF('P_MName', FStockName),
              SF('P_MType', sFlag_San),
              SF('P_PValue', FPData.FValue, sfVal),
              SF('P_PDate', sField_SQLServer_Now, sfVal),
              SF('P_PMan', FIn.FBase.FFrom.FUser),
              SF('P_FactID', FFactory),
              SF('P_PStation', FPData.FStation),
              SF('P_Direction', '����'),
              SF('P_PModel', FPModel),
              SF('P_Status', sFlag_TruckBFP),
              SF('P_Valid', sFlag_Yes),
              SF('P_PrintNum', 1, sfVal)
              ], sTable_PoundLog, '', True);
      gDBConnManager.WorkerExec(FDBConn, nSQL);
    end else
    begin
      nStr := SF('P_ID', FPoundID);
      //where

      if FNextStatus = sFlag_TruckBFP then
      begin
        nSQL := MakeSQLByStr([
                SF('P_PValue', FPData.FValue, sfVal),
                SF('P_PDate', sField_SQLServer_Now, sfVal),
                SF('P_PMan', FIn.FBase.FFrom.FUser),
                SF('P_PStation', FPData.FStation),
                SF('P_MValue', FMData.FValue, sfVal),
                SF('P_MDate', DateTime2Str(FMData.FDate)),
                SF('P_MMan', FMData.FOperator),
                SF('P_MStation', FMData.FStation)
                ], sTable_PoundLog, nStr, False);
        //����ʱ,����Ƥ�ش�,����Ƥë������
      end else
      begin
        nSQL := MakeSQLByStr([
                SF('P_MValue', FMData.FValue, sfVal),
                SF('P_MDate', sField_SQLServer_Now, sfVal),
                SF('P_MMan', FIn.FBase.FFrom.FUser),
                SF('P_MStation', FMData.FStation)
                ], sTable_PoundLog, nStr, False);
        //xxxxx
      end;

      gDBConnManager.WorkerExec(FDBConn, nSQL);
    end;

    FOut.FData := FPoundID;
    Result := True;
  end;
end;

//Date: 2016-02-24
//Parm: ���ϱ��[FIn.FData];Ԥ�ۼ���[FIn.ExtParam];
//Desc: ����������ָ��Ʒ�ֵ����α��
function TWorkerBusinessCommander.GetStockBatcode(var nData: string): Boolean;
var nStr,nP: string;
    nNew: Boolean;
    nInt,nInc: Integer;
    nVal,nPer: Double;

    //���������κ�
    function NewBatCode: string;
    begin
      nStr := 'Select * From %s Where B_Stock=''%s''';
      nStr := Format(nStr, [sTable_StockBatcode, FIn.FData]);

      with gDBConnManager.WorkerQuery(FDBConn, nStr) do
      begin
        nP := FieldByName('B_Prefix').AsString;
        nStr := FieldByName('B_UseYear').AsString;

        if nStr = sFlag_Yes then
        begin
          nStr := Copy(Date2Str(Now()), 3, 2);
          nP := nP + nStr;
          //ǰ׺����λ���
        end;

        nStr := FieldByName('B_Base').AsString;
        nInt := FieldByName('B_Length').AsInteger;
        nInt := nInt - Length(nP + nStr);

        if nInt > 0 then
             Result := nP + StringOfChar('0', nInt) + nStr
        else Result := nP + nStr;

        nStr := '����[ %s.%s ]������ʹ�����κ�[ %s ],��֪ͨ������ȷ���Ѳ���.';
        nStr := Format(nStr, [FieldByName('B_Stock').AsString,
                              FieldByName('B_Name').AsString, Result]);
        //xxxxx

        FOut.FBase.FErrCode := sFlag_ForceHint;
        FOut.FBase.FErrDesc := nStr;
      end;

      nStr := ' Update  %s set B_PreDate = B_FirstDate where B_Stock = ''%s'' ';
      nStr := Format(nStr, [sTable_StockBatcode,  FIn.FData]);
      gDBConnManager.WorkerExec(FDBConn, nStr);

      nStr := MakeSQLByStr([SF('B_Batcode', Result),
                SF('B_FirstDate', sField_SQLServer_Now, sfVal),
                SF('B_HasUse', 0, sfVal),
                SF('B_LastDate', sField_SQLServer_Now, sfVal)
                ], sTable_StockBatcode, SF('B_Stock', FIn.FData), False);
      gDBConnManager.WorkerExec(FDBConn, nStr);
    end;
begin
  Result := True;
  FOut.FData := '';
  
  nStr := 'Select D_Value From %s Where D_Name=''%s''';
  nStr := Format(nStr, [sTable_SysDict, sFlag_BatchAuto]);
  
  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  if RecordCount > 0 then
  begin
    nStr := Fields[0].AsString;
    if nStr <> sFlag_Yes then Exit;
  end  else Exit;
  //Ĭ�ϲ�ʹ�����κ�

  Result := False; //Init
  nStr := 'Select *,%s as ServerNow From %s Where B_Stock=''%s''';
  nStr := Format(nStr, [sField_SQLServer_Now, sTable_StockBatcode, FIn.FData]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount < 1 then
    begin
      nData := '����[ %s ]δ�������κŹ���.';
      nData := Format(nData, [FIn.FData]);
      {$IFDEF SaveHyDanEvent}
      SaveHyDanEvent(FIn.FData,nData,sFlag_DepDaTing,sFlag_Solution_OK,sFlag_DepHuaYan);
      {$ENDIF}
      Exit;
    end;

    FOut.FData := FieldByName('B_Batcode').AsString;
    nInc := FieldByName('B_Incement').AsInteger;
    nNew := False;

    if FieldByName('B_UseDate').AsString = sFlag_Yes then
    begin
      nP := FieldByName('B_Prefix').AsString;
      nStr := Date2Str(FieldByName('ServerNow').AsDateTime, False);

      nInt := FieldByName('B_Length').AsInteger;
      nInt := Length(nP + nStr) - nInt;

      if nInt > 0 then
      begin
        System.Delete(nStr, 1, nInt);
        FOut.FData := nP + nStr;
      end else
      begin
        nStr := StringOfChar('0', -nInt) + nStr;
        FOut.FData := nP + nStr;
      end;

      nNew := True;
    end;

    if (not nNew) and (FieldByName('B_AutoNew').AsString = sFlag_Yes) then      //Ԫ������
    begin
      nStr := Date2Str(FieldByName('ServerNow').AsDateTime);
      nStr := Copy(nStr, 1, 4);
      nP := Date2Str(FieldByName('B_LastDate').AsDateTime);
      nP := Copy(nP, 1, 4);

      if nStr <> nP then
      begin
        nStr := 'Update %s Set B_Base=1 Where B_Stock=''%s''';
        nStr := Format(nStr, [sTable_StockBatcode, FIn.FData]);
        
        gDBConnManager.WorkerExec(FDBConn, nStr);
        FOut.FData := NewBatCode;
        nNew := True;
      end;
    end;

    if not nNew then //��ų���
    begin
      nStr := Date2Str(FieldByName('ServerNow').AsDateTime);
      nP := Date2Str(FieldByName('B_FirstDate').AsDateTime);

      if (Str2Date(nP) > Str2Date('2000-01-01')) and
         (Str2Date(nStr) - Str2Date(nP) > FieldByName('B_Interval').AsInteger) then
      begin
        nStr := 'Update %s Set B_Base=B_Base+%d Where B_Stock=''%s''';
        nStr := Format(nStr, [sTable_StockBatcode, nInc, FIn.FData]);

        gDBConnManager.WorkerExec(FDBConn, nStr);
        FOut.FData := NewBatCode;
        nNew := True;
      end;
    end;

    if not nNew then //��ų���
    begin
      nVal := FieldByName('B_HasUse').AsFloat + StrToFloat(FIn.FExtParam);
      //��ʹ��+Ԥʹ��
      nPer := FieldByName('B_Value').AsFloat * FieldByName('B_High').AsFloat / 100;
      //��������

      if nVal >= nPer then //����
      begin
        nStr := 'Update %s Set B_Base=B_Base+%d Where B_Stock=''%s''';
        nStr := Format(nStr, [sTable_StockBatcode, nInc, FIn.FData]);

        gDBConnManager.WorkerExec(FDBConn, nStr);
        FOut.FData := NewBatCode;
      end else
      begin
        nPer := FieldByName('B_Value').AsFloat * FieldByName('B_Low').AsFloat / 100;
        //����
      
        if nVal >= nPer then //��������
        begin
          nStr := '����[ %s.%s ]�����������κ�,��֪ͨ������׼��ȡ��.';
          nStr := Format(nStr, [FieldByName('B_Stock').AsString,
                                FieldByName('B_Name').AsString]);
          //xxxxx

          FOut.FBase.FErrCode := sFlag_ForceHint;
          FOut.FBase.FErrDesc := nStr;
        end;
      end;
    end;
  end;

  if FOut.FData = '' then
    FOut.FData := NewBatCode;
  //xxxxx

  if FOut.FBase.FErrCode = sFlag_ForceHint then
  begin
    {$IFDEF SaveHyDanEvent}
    SaveHyDanEvent(FIn.FData,FOut.FBase.FErrDesc,
                   sFlag_DepDaTing,sFlag_Solution_OK,sFlag_DepHuaYan);
    {$ENDIF}
  end;
  Result := True;
  FOut.FBase.FResult := True;
end;

procedure TWorkerBusinessCommander.SaveHyDanEvent(const nStockno,nEvent,
          nFrom,nSolution,nDepartment: string);
var
  nStr:string;
  nEID:string;
begin
  try
    nEID := nStockno + FormatDateTime('YYYYMMDD',Now);
    nStr := 'Delete From %s Where E_ID=''%s''';
    nStr := Format(nStr, [sTable_ManualEvent, nEID]);

    gDBConnManager.WorkerExec(FDBConn, nStr);

    nStr := MakeSQLByStr([
        SF('E_ID', nEID),
        SF('E_Key', ''),
        SF('E_From', nFrom),
        SF('E_Event', nEvent),
        SF('E_Solution', nSolution),
        SF('E_Departmen', nDepartment),
        SF('E_Date', sField_SQLServer_Now, sfVal)
        ], sTable_ManualEvent, '', True);
    gDBConnManager.WorkerExec(FDBConn, nStr);
  except
    on E: Exception do
    begin
      WriteLog(e.message);
    end;
  end;
end;

function TWorkerBusinessCommander.SaveGrabCard(var nData: string): Boolean;
var nStr, nLs: string;
begin
  Result := False;
  FListA.Clear;
  FListA.Text := FIn.FData;

  nStr := 'Delete From $TB Where P_Tunnel=''$T''';
  nStr := MacroValue(nStr, [MI('$TB', sTable_CardGrab), MI('$T', FListA.Values['Tunnel'])]);

  gDBConnManager.WorkerExec(FDBConn, nStr);

  if FListA.Values['Delete'] = sFlag_Yes then
  begin
    Result := True;
    Exit;
  end;

  nLs := Date2Str(Now,False) + Time2Str(Now,False);
  //���ɴ˴�ˢ����ˮ��
  nStr := 'Insert Into %s(P_Ls, P_Card, P_Tunnel) Values(''%s'', ''%s'', ''%s'')';
  nStr := Format(nStr, [sTable_CardGrab, nLs, FListA.Values['Card'], FListA.Values['Tunnel']]);
  gDBConnManager.WorkerExec(FDBConn, nStr);

  Result := True;
end;

//Date: 2019-03-23
//Parm: ���ϱ��[FIn.FData];��������;
//Desc: ����������ָ��Ʒ�ֵ����α��
function TWorkerBusinessCommander.GetStockBatcodeByCusType(var nData: string): Boolean;
var nStr,nP,nType: string;
    nNew: Boolean;
    nInt,nInc: Integer;
    nVal,nPer,nKDValue: Double;

    //���������κ�
    function NewBatCode: string;
    begin
      nStr := 'Select * From %s Where B_Stock=''%s'' and B_Type=''%s''';
      nStr := Format(nStr, [sTable_StockBatcode, FIn.FData, nType]);

      with gDBConnManager.WorkerQuery(FDBConn, nStr) do
      begin
        nP := FieldByName('B_Prefix').AsString;
        nStr := FieldByName('B_UseYear').AsString;

        if nStr = sFlag_Yes then
        begin
          nStr := Copy(Date2Str(Now()), 3, 2);
          nP := nP + nStr;
          //ǰ׺����λ���
        end;

        nStr := FieldByName('B_Base').AsString;
        nInt := FieldByName('B_Length').AsInteger;
        nInt := nInt - Length(nP + nStr);

        if nInt > 0 then
             Result := nP + StringOfChar('0', nInt) + nStr
        else Result := nP + nStr;

        nStr := '����[ %s.%s.%s ]������ʹ�����κ�[ %s ],��֪ͨ������ȷ���Ѳ���.';
        nStr := Format(nStr, [FieldByName('B_Stock').AsString,
                              FieldByName('B_Name').AsString, nType, Result]);
        //xxxxx

        FOut.FBase.FErrCode := sFlag_ForceHint;
        FOut.FBase.FErrDesc := nStr;
      end;

      nStr := Format('B_Stock=''%s'' And B_Type=''%s''', [FIn.FData, nType]);
      nStr := MakeSQLByStr([SF('B_Batcode', Result),
                SF('B_FirstDate', sField_SQLServer_Now, sfVal),
                SF('B_HasUse', 0, sfVal),
                SF('B_LastDate', sField_SQLServer_Now, sfVal)
                ], sTable_StockBatcode, nStr, False);
      gDBConnManager.WorkerExec(FDBConn, nStr);
    end;
begin
  Result := True;
  FOut.FData := '';
  FListB.Clear;
  FListB.Text := FIn.FExtParam;
  nKDValue := StrToFloat(FListB.Values['Value']);
  nType := FListB.Values['CustomerType'];

  nStr := 'Select D_Value From %s Where D_Name=''%s''';
  nStr := Format(nStr, [sTable_SysDict, sFlag_BatchAuto]);
  
  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  if RecordCount > 0 then
  begin
    nStr := Fields[0].AsString;
    if nStr <> sFlag_Yes then Exit;
  end  else Exit;
  //Ĭ�ϲ�ʹ�����κ�

  Result := False; //Init
  nStr := 'Select *,%s as ServerNow From %s Where B_Stock=''%s'' and B_Type=''%s''';
  nStr := Format(nStr, [sField_SQLServer_Now, sTable_StockBatcode, FIn.FData, nType]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount < 1 then
    begin
      nData := '����[ %s ][ %s ]δ�������κŹ���.';
      nData := Format(nData, [FIn.FData, nType]);
      {$IFDEF SaveHyDanEvent}
      SaveHyDanEvent(FIn.FData,nData,sFlag_DepDaTing,sFlag_Solution_OK,sFlag_DepHuaYan);
      {$ENDIF}
      Exit;
    end;

    FOut.FData := FieldByName('B_Batcode').AsString;
    nInc := FieldByName('B_Incement').AsInteger;
    nNew := False;

    if FieldByName('B_UseDate').AsString = sFlag_Yes then
    begin
      nP := FieldByName('B_Prefix').AsString;
      nStr := Date2Str(FieldByName('ServerNow').AsDateTime, False);

      nInt := FieldByName('B_Length').AsInteger;
      nInt := Length(nP + nStr) - nInt;

      if nInt > 0 then
      begin
        System.Delete(nStr, 1, nInt);
        FOut.FData := nP + nStr;
      end else
      begin
        nStr := StringOfChar('0', -nInt) + nStr;
        FOut.FData := nP + nStr;
      end;

      nNew := True;
    end;

    if (not nNew) and (FieldByName('B_AutoNew').AsString = sFlag_Yes) then      //Ԫ������
    begin
      nStr := Date2Str(FieldByName('ServerNow').AsDateTime);
      nStr := Copy(nStr, 1, 4);
      nP := Date2Str(FieldByName('B_LastDate').AsDateTime);
      nP := Copy(nP, 1, 4);

      if nStr <> nP then
      begin
        nStr := 'Update %s Set B_Base=1 Where B_Stock=''%s'' and B_Type=''%s''';
        nStr := Format(nStr, [sTable_StockBatcode, FIn.FData, nType]);

        gDBConnManager.WorkerExec(FDBConn, nStr);
        FOut.FData := NewBatCode;
        nNew := True;
      end;
    end;

    if not nNew then //��ų���
    begin
      nStr := Date2Str(FieldByName('ServerNow').AsDateTime);
      nP := Date2Str(FieldByName('B_FirstDate').AsDateTime);

      if (Str2Date(nP) > Str2Date('2000-01-01')) and
         (Str2Date(nStr) - Str2Date(nP) > FieldByName('B_Interval').AsInteger) then
      begin
        nStr := 'Update %s Set B_Base=B_Base+%d Where B_Stock=''%s'' and B_Type=''%s''';
        nStr := Format(nStr, [sTable_StockBatcode, nInc, FIn.FData, nType]);

        gDBConnManager.WorkerExec(FDBConn, nStr);
        FOut.FData := NewBatCode;
        nNew := True;
      end;
    end;

    if not nNew then //��ų���
    begin
      nVal := FieldByName('B_HasUse').AsFloat + nKDValue;
      //��ʹ��+Ԥʹ��
      nPer := FieldByName('B_Value').AsFloat * FieldByName('B_High').AsFloat / 100;
      //��������

      if nVal >= nPer then //����
      begin
        nStr := 'Update %s Set B_Base=B_Base+%d Where B_Stock=''%s'' and B_Type=''%s''';
        nStr := Format(nStr, [sTable_StockBatcode, nInc, FIn.FData, nType]);

        gDBConnManager.WorkerExec(FDBConn, nStr);
        FOut.FData := NewBatCode;
      end else
      begin
        nPer := FieldByName('B_Value').AsFloat * FieldByName('B_Low').AsFloat / 100;
        //����
      
        if nVal >= nPer then //��������
        begin
          nStr := '����[ %s.%s.%s ]�����������κ�,��֪ͨ������׼��ȡ��.';
          nStr := Format(nStr, [FieldByName('B_Stock').AsString,
                                FieldByName('B_Name').AsString, nType]);
          //xxxxx

          FOut.FBase.FErrCode := sFlag_ForceHint;
          FOut.FBase.FErrDesc := nStr;
        end;
      end;
    end;
  end;

  if FOut.FData = '' then
    FOut.FData := NewBatCode;
  //xxxxx

  if FOut.FBase.FErrCode = sFlag_ForceHint then
  begin
    {$IFDEF SaveHyDanEvent}
    SaveHyDanEvent(FIn.FData,FOut.FBase.FErrDesc,
                   sFlag_DepDaTing,sFlag_Solution_OK,sFlag_DepHuaYan);
    {$ENDIF}
  end;
  Result := True;
  FOut.FBase.FResult := True;
end;

{$IFDEF SendBillToBakDB}
function TWorkerBusinessCommander.SyncRemoteStockBill(
  var nData: string): Boolean;
var
  nBakWork:PDBWorker;
  nStr, nSQL:string;
  nIdx: Integer;
begin
  Result := False;
  nBakWork := nil;
  nStr := AdjustListStrFormat(FIn.FData , '''' , True , ',' , True);

  FListA.Clear;
  try
    nBakWork := gDBConnManager.GetConnection(sFlag_BakDB, FErrNum);
    if not Assigned(nBakWork) then
    begin
      nData := '�������ݿ�ʧ��(DBConn Is Null).';
      Exit;
    end;

    if not nBakWork.FConn.Connected then
      nBakWork.FConn.Connected := True;
    //conn db

    nSQL := 'select * From $BL where L_ID In ($IN)';
    nSQL := MacroValue(nSQL, [MI('$BL', sTable_Bill) , MI('$IN', nStr)]);

    with gDBConnManager.WorkerQuery(FDBConn, nSQL)  do
    begin
      if RecordCount < 1 then
      begin
        nData := '���Ϊ[ %s ]�Ľ�����������.';
        nData := Format(nData, [FIn.FData]);
        Exit;
      end;

      First;
      while not Eof do
      begin
        nSQL := MakeSQLByStr([
                    SF('L_ID',              FieldByName('L_ID').AsString),
                    SF('L_ZhiKa',           FieldByName('L_ZhiKa').AsString),
                    SF('L_Project',         FieldByName('L_Project').AsString),
                    SF('L_Area',            FieldByName('L_Area').AsString),
                    SF('L_CusID',           FieldByName('L_CusID').AsString),
                    SF('L_CusName',         FieldByName('L_CusName').AsString),
                    SF('L_CusPY',           FieldByName('L_CusPY').AsString),
                    SF('L_SaleID',          FieldByName('L_SaleID').AsString),
                    SF('L_SaleMan',         FieldByName('L_SaleMan').AsString),
                    SF('L_Type',            FieldByName('L_Type').AsString),
                    SF('L_StockNo',         FieldByName('L_StockNo').AsString),
                    SF('L_StockName',       FieldByName('L_StockName').AsString),
                    SF('L_Value',           FieldByName('L_Value').AsFloat),
                    SF('L_Price',           FieldByName('L_Price').AsFloat),
                    //SF('L_ZKMoney',         FieldByName('L_ZKMoney').AsFloat),
                    SF('L_Truck',           FieldByName('L_Truck').AsString),
                    SF('L_Status',          sFlag_TruckOut),
                    //SF('L_NextStatus',      FieldByName('L_NextStatus').AsString),
                    SF('L_InTime',          FieldByName('L_InTime').AsDateTime),
                    SF('L_InMan',           FieldByName('L_InMan').AsString),
                    SF('L_PValue',          FieldByName('L_PValue').AsFloat),
                    SF('L_PDate',           FieldByName('L_PDate').AsDateTime),
                    SF('L_PMan',            FieldByName('L_PMan').AsString),
                    SF('L_MValue',          FieldByName('L_MValue').AsFloat),
                    SF('L_MDate',           FieldByName('L_MDate').AsDateTime),
                    SF('L_MMan',            FieldByName('L_MMan').AsString),
                    SF('L_LadeTime',        FieldByName('L_LadeTime').AsDateTime),
                    SF('L_LadeMan',         FieldByName('L_LadeMan').AsString),
                    SF('L_LadeLine',        FieldByName('L_LadeLine').AsString),
                    SF('L_LineName',        FieldByName('L_LineName').AsString),
                    SF('L_DaiTotal',        FieldByName('L_DaiTotal').AsFloat),
                    SF('L_DaiNormal',       FieldByName('L_DaiNormal').AsFloat),
                    SF('L_OutFact',         sField_SQLServer_Now, sfVal),
                    SF('L_OutMan',          FieldByName('L_OutMan').AsString),
                    SF('L_PrintGLF',        FieldByName('L_PrintGLF').AsString),
                    SF('L_Lading',          FieldByName('L_Lading').AsString),
                    SF('L_IsVIP',           FieldByName('L_IsVIP').AsString),
                    SF('L_Seal',            FieldByName('L_Seal').AsString),
                    SF('L_HYDan',           FieldByName('L_HYDan').AsString),
                    SF('L_PrintHY',         FieldByName('L_PrintHY').AsString),
                    SF('L_EmptyOut',        FieldByName('L_EmptyOut').AsString),
                    SF('L_Man',             FieldByName('L_Man').AsString),
                    SF('L_Date',            FieldByName('L_Date').AsDateTime),
                    SF('L_CusType',         FieldByName('L_CusType').AsString),
                    SF('L_DelMan',          FieldByName('L_DelMan').AsString),
                    SF('L_DelDate',         FieldByName('L_DelDate').AsString),
                    SF('L_Memo',            FieldByName('L_Memo').AsString)
                    ], sTable_Bill,         '',      True);
        FListA.Add(nSQL);

        Next;
      end;
    end;

    nSQL := 'select * From $PL where P_Bill In ($IN)';
    nSQL := MacroValue(nSQL, [MI('$PL', sTable_PoundLog) , MI('$IN', nStr)]);

    with gDBConnManager.WorkerQuery(FDBConn, nSQL)  do
    begin
      if RecordCount > 0 then
      begin
        First;
        while not Eof do
        begin
          nSQL := MakeSQLByStr([
                    SF('P_ID',              FieldByName('P_ID').AsString),
                    SF('P_Type',            FieldByName('P_Type').AsString),
                    SF('P_Order',           FieldByName('P_Order').AsString),
                    SF('P_Bill',            FieldByName('P_Bill').AsString),
                    SF('P_Truck',           FieldByName('P_Truck').AsString),
                    SF('P_CusID',           FieldByName('P_CusID').AsString),
                    SF('P_CusName',         FieldByName('P_CusName').AsString),
                    SF('P_MID',             FieldByName('P_MID').AsString),
                    SF('P_MName',           FieldByName('P_MName').AsString),
                    SF('P_MType',           FieldByName('P_MType').AsString),
                    SF('P_LimValue',        FieldByName('P_LimValue').AsString),
                    SF('P_PValue',          FieldByName('P_PValue').AsFloat),
                    SF('P_PDate',           FieldByName('P_PDate').AsDateTime),
                    SF('P_PMan',            FieldByName('P_PMan').AsString),
                    SF('P_MValue',          FieldByName('P_MValue').AsFloat),
                    SF('P_MDate',           FieldByName('P_MDate').AsDateTime),
                    SF('P_MMan',            FieldByName('P_MMan').AsString),
                    SF('P_FactID',          FieldByName('P_FactID').AsString),
                    SF('P_PStation',        FieldByName('P_PStation').AsString),
                    SF('P_MStation',        FieldByName('P_MStation').AsString),
                    SF('P_Direction',       FieldByName('P_Direction').AsString),
                    SF('P_PModel',          FieldByName('P_PModel').AsString),
                    SF('P_Status',          FieldByName('P_Status').AsString),
                    SF('P_Valid',           FieldByName('P_Valid').AsString),
                    SF('P_KZValue',         FieldByName('P_KZValue').AsFloat),
                    SF('P_DelMan',          FieldByName('P_DelMan').AsString),
                    SF('P_DelDate',         FieldByName('P_DelDate').AsDateTime),
                    SF('P_Memo',            FieldByName('P_Memo').AsString)
                    ], sTable_PoundLog,        '',      True);
                    
          FListA.Add(nSQL);
          Next;
        end;
      end;
    end;

    nBakWork.FConn.BeginTrans;
    try
      for nIdx:=0 to FListA.Count - 1 do
        gDBConnManager.WorkerExec(nBakWork, FListA[nIdx]);
      //xxxxx

      nBakWork.FConn.CommitTrans;
      Result := True;
    except
      nBakWork.FConn.RollbackTrans;
      nStr := 'ͬ�����������ݵ��������ݿ�ʧ��.';
      raise Exception.Create(nStr);
    end;
  finally
    gDBConnManager.ReleaseConnection(nBakWork);
  end;
end;
{$ENDIF}


function TWorkerBusinessCommander.GetCusMoney(var nCusId: string;var nMoney:Double): Boolean;
var nStr: string;
    nUseCredit: Boolean;
    nVal,nCredit, nSalesCredit: Double;
begin
  nUseCredit := False;
  //if FIn.FExtParam = sFlag_Yes then
  begin
    nStr := 'Select MAX(C_End) From %s ' +
            'Where C_CusID=''%s'' and C_Money>=0 and C_Verify=''%s''';
    nStr := Format(nStr, [sTable_CusCredit, nCusId, sFlag_Yes]);

    with gDBConnManager.WorkerQuery(FDBConn, nStr) do
      nUseCredit := (Fields[0].AsDateTime > Str2Date('2000-01-01')) and
                    (Fields[0].AsDateTime > Now());
    //����δ����
  end;

  nStr := 'Select * From %s Where A_CID=''%s''';
  nStr := Format(nStr, [sTable_CusAccount, nCusId]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount < 1 then
    begin
      nStr := '���Ϊ[ %s ]�Ŀͻ��˻�������.';
      nStr := Format(nStr, [nCusId]);
      WriteLog(nStr);
      Result := False;
      Exit;
    end;

    nVal := FieldByName('A_InitMoney').AsFloat + FieldByName('A_InMoney').AsFloat -
            FieldByName('A_OutMoney').AsFloat -
            FieldByName('A_Compensation').AsFloat -
            FieldByName('A_FreezeMoney').AsFloat;
    //xxxxx

    nCredit := FieldByName('A_CreditLimit').AsFloat;
    nCredit := Float2PInt(nCredit, cPrecision, False) / cPrecision;

    if nUseCredit then
      nVal := nVal + nCredit;

    nVal := Float2PInt(nVal, cPrecision, False) / cPrecision;
    nMoney := nVal;
    Result := True;
  end;
end;

function TWorkerBusinessCommander.GetUnLoadingPlace(var nData: string): Boolean;
var nStr: string;
begin
  Result := False;

  if FIn.FData = '' then Exit;

  nStr := 'Select D_Value From %s Where D_Name=''%s'' ';
  nStr := Format(nStr, [sTable_SysDict, FIn.FData]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount <= 0 then
      Exit;

    FListC.Clear;

    First;

    while not Eof do
    begin
      FListC.Add(Fields[0].AsString);
      Next;
    end;
  end;

  FOut.FData := FListC.Text;
  Result := True;
end;

function TWorkerBusinessCommander.GetPOrderBase(var nData: string): Boolean;
var nStr: string;
begin
  Result := False;

  nStr := 'Select B_ID,B_ProID,B_ProName,B_StockNo,B_StockName,B_OrderBz ' +
          ' From %s Where B_BStatus=''%s'' and ' +
          ' ((B_Value-B_SentValue>0) or (B_Value=0)) ';
  nStr := Format(nStr, [sTable_OrderBase, sFlag_Yes]);

  with gDBConnManager.WorkerQuery(FDBConn, nStr) do
  begin
    if RecordCount <= 0 then
      Exit;

    FListC.Clear;
    FListB.Clear;
    First;

    while not Eof do
    begin
      if FieldByName('B_OrderBz').AsString = '' then
      begin
        Next;
        Continue;
      end;
      FListB.Values['ID'] := FieldByName('B_ID').AsString;
      FListB.Values['ProID'] := FieldByName('B_ProID').AsString;
      FListB.Values['ProName'] := FieldByName('B_ProName').AsString;
      FListB.Values['StockNo'] := FieldByName('B_StockNo').AsString;
      FListB.Values['StockName'] := FieldByName('B_StockName').AsString;
      FListB.Values['OrderBz'] := FieldByName('B_OrderBz').AsString;
      FListC.Add(PackerEncodeStr(FListB.Text));
      Next;
    end;
  end;

  FOut.FData := FListC.Text;
  Result := True;
end;

function TWorkerBusinessCommander.SaveTruckLine(
  var nData: string): Boolean;
var nStr: string;
   // nItem: TDBASyncItem;
   // nOut: TWorkerBusinessCommand;
begin
  Result := False;

  if FIn.FData = '' then
    Exit;

  FListA.Clear;

  FListA.Text := FIn.FData;

  if FListA.Values['ID'] = '' then
    Exit;

  nStr := 'Update %s Set L_LadeLine=''%s'',L_LineName=''%s'' Where L_ID=''%s''';
  nStr := Format(nStr, [sTable_Bill, FListA.Values['LineID'],
                                     FListA.Values['LineName'],
                                     FListA.Values['ID']]);
  WriteLog('ˢ���������ͨ��SQL:' + nStr);
  gDBConnManager.WorkerExec(FDBConn, nStr);
//  gDBConnManager.ASyncAddItem(@nItem, nStr, nOut.FData);
  Result := True;
end;

function TWorkerBusinessCommander.SaveBusinessCard(
  var nData: string): Boolean;
var nStr: string;
begin
  Result := False;
  FListA.Text := FIn.FData;

  nStr := 'Delete From %s Where C_Line=''%s''';
  nStr := Format(nStr, [sTable_ZTCard, FListA.Values['Line']]);

  gDBConnManager.WorkerExec(FDBConn, nStr);

  nStr := MakeSQLByStr([
      SF('C_Truck', FListA.Values['Truck']),
      SF('C_Card', FListA.Values['Card']),
      SF('C_Bill', FListA.Values['Bill']),
      SF('C_Line', FListA.Values['Line']),
      SF('C_BusinessTime', sField_SQLServer_Now, sfVal)
      ], sTable_ZTCard, '', True);
  gDBConnManager.WorkerExec(FDBConn, nStr);

  nData := sFlag_Yes;
  FOut.FData := nData;
  Result := True;
end;

procedure TWorkerBusinessCommander.CheckZhiKaXTMoney;
var
  nStr: string;
begin
  FDBConn.FConn.BeginTrans;
  try
    //У��ֽ�����ʽ
    nStr := ' update S_ZhiKa set Z_PayType = (select D_Index from Sys_Dict ' +
            ' where D_Name= ''PaymentItem'' and D_Value=Z_Payment)';
    gDBConnManager.WorkerExec(FDBConn, nStr);
    //У������𸶿ʽ
    nStr := ' update Sys_CustomerInOutMoney set M_PayType = '+
            ' (select D_Index from Sys_Dict where D_Name= ''PaymentItem2'' and D_Value=M_Payment)';
     gDBConnManager.WorkerExec(FDBConn, nStr);

    //��ʼ��
    nStr := ' update S_ZhiKa set Z_FixedMoney = 0';
     gDBConnManager.WorkerExec(FDBConn, nStr);

    //У��ֽ������1
    nStr := ' update S_ZhiKa set Z_FixedMoney  = M_Money From( ' +
            ' Select Sum(isnull(M_Money,0)) M_Money, M_CusID,M_PayType from ( ' +
            ' select M_Money, M_CusID,M_PayType from Sys_CustomerInOutMoney ' +
            '  ) t Group by M_CusID,M_PayType) b where Z_Customer = b.M_CusID and Z_PayType= M_PayType ';
     gDBConnManager.WorkerExec(FDBConn, nStr);
    //У��ֽ������2
    nStr := ' update S_ZhiKa set Z_FixedMoney  = Z_FixedMoney-L_Money From( ' +
            ' Select isnull(Sum(L_Money),0) L_Money, L_CusID,L_ZhiKa from ( ' +
            ' select isnull(L_Value,0) * isnull(L_Price,0) as L_Money, L_CusID,L_ZhiKa from S_Bill ' +
            '  ) t Group by L_CusID,L_ZhiKa) b where Z_Customer = b.L_CusID and Z_ID= b.L_ZhiKa ';
     gDBConnManager.WorkerExec(FDBConn, nStr);
    //У��ֽ�������ʶ1
    nStr := ' update S_ZhiKa set Z_OnlyMoney= ''Y'' where Z_Customer ' +
            ' not in (select A_CID from Sys_CustomerAccount ' +
            ' where A_CreditLimit >0 Group by A_CID ) ';
     gDBConnManager.WorkerExec(FDBConn, nStr);
    //У��ֽ�������ʶ2
    nStr := ' update S_ZhiKa set Z_OnlyMoney= NULL where Z_Customer ' +
            ' in (select A_CID from Sys_CustomerAccount ' +
            ' where A_CreditLimit >0 Group by A_CID ) ';
     gDBConnManager.WorkerExec(FDBConn, nStr);

    FDBConn.FConn.CommitTrans;
  except
    FDBConn.FConn.RollbackTrans;
    raise;
  end;
end;

initialization
  gBusinessWorkerManager.RegisteWorker(TBusWorkerQueryField, sPlug_ModuleBus);
  gBusinessWorkerManager.RegisteWorker(TWorkerBusinessCommander, sPlug_ModuleBus);
end.
