{*******************************************************************************
  作者: fendou116688@163.com 2015/8/10
  描述: 采购验收明细
*******************************************************************************}
unit UFrameQueryOrderDetail;

{$I Link.inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFrameNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, Menus, dxLayoutControl,
  cxMaskEdit, cxButtonEdit, cxTextEdit, ADODB, cxLabel, UBitmapPanel,
  cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, ToolWin;

type
  TfFrameOrderDetailQuery = class(TfFrameNormal)
    cxtxtdt1: TcxTextEdit;
    dxLayout1Item5: TdxLayoutItem;
    EditDate: TcxButtonEdit;
    dxLayout1Item6: TdxLayoutItem;
    EditCustomer: TcxButtonEdit;
    dxLayout1Item8: TdxLayoutItem;
    cxtxtdt2: TcxTextEdit;
    dxLayout1Item1: TdxLayoutItem;
    pmPMenu1: TPopupMenu;
    mniN1: TMenuItem;
    cxtxtdt3: TcxTextEdit;
    dxLayout1Item2: TdxLayoutItem;
    cxtxtdt4: TcxTextEdit;
    dxLayout1Item3: TdxLayoutItem;
    EditTruck: TcxButtonEdit;
    dxLayout1Item4: TdxLayoutItem;
    EditBill: TcxButtonEdit;
    dxLayout1Item7: TdxLayoutItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure EditTruckPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure mniN1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
  private
    FNum1,Fnum2,FNum3: Double;
    { Private declarations }
  protected
    FStart,FEnd: TDate;
    FTimeS,FTimeE: TDate;
    //时间区间
    FJBWhere: string;
    //交班条件
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    function InitFormDataSQL(const nWhere: string): string; override;
    //查询SQL
    function GetVal(const nRow: Integer; const nField: string): string;
    //获取指定字段
  public
    { Public declarations }
    class function FrameID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  IniFiles, ULibFun, UMgrControl, UFormDateFilter, USysPopedom, USysBusiness,
  UBusinessConst, USysConst, USysDB, UDataModule, UFormInputbox;

class function TfFrameOrderDetailQuery.FrameID: integer;
begin
  Result := cFI_FrameOrderDetailQuery;
end;

procedure TfFrameOrderDetailQuery.OnCreateFrame;
var
  nStr: string;
begin
  inherited;
  nStr := 'Select * From %s ';
  nStr := Format(nStr, [sTable_KSKD]);
  FDM.QueryTemp(nStr);
  with FDM.SqlTemp do
  begin
    if (RecordCount < 1) then
    begin
      FNum1 := 0;
      FNum2 := 0;
      FNum3 := 0;
    end
    else
    begin
      FNum1 := FieldByName('P_Num1').AsFloat;
      FNum2 := FieldByName('P_Num2').AsFloat;
      FNum3 := FieldByName('P_Num3').AsFloat;
    end;
  end;

  FTimeS := Str2DateTime(Date2Str(Now) + ' 00:00:00');
  FTimeE := Str2DateTime(Date2Str(Now) + ' 00:00:00');

  FJBWhere := '';
  InitDateRange(Name, FStart, FEnd);
  N7.Visible := True;
  N8.Visible := False;
  {$IFDEF SendUnLoadPlace}
  if gSysParam.FIsAdmin then
  begin
    N7.Visible := True;
    N8.Visible := True;
  end;
  {$ENDIF}
  N10.Visible := False;
  N11.Visible := False;
end;

procedure TfFrameOrderDetailQuery.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFrameOrderDetailQuery.InitFormDataSQL(const nWhere: string): string;
begin
  {$IFDEF SpecialControl}
  MakeOrderViewData;
  {$ENDIF}

  EditDate.Text := Format('%s 至 %s', [Date2Str(FStart), Date2Str(FEnd)]);

  if FNum1 > 0 then
  begin
    Result := ' Select *,' +
              ' (D_MValue-D_PValue) as D_NetWeight,'+
              ' case When ((Select isnull(M_AutoKZ,''N'') from P_Materails where M_ID = od.D_StockNo) = ''Y'') and ((isnull(P_IsKS,''N'') = ''Y'')) then ' +
              ' (case When (D_MValue-D_PValue) >= '+Floattostr(FNum1)+' then D_PValue+'+Floattostr(FNum2)+
              ' else (D_MValue-'+Floattostr(FNum3)+') end) '+
              ' else (D_MValue-isnull(D_KZValue,0)) end D_MValueEx,  '+
              ' case When ((Select isnull(M_AutoKZ,''N'') from P_Materails where M_ID = od.D_StockNo) = ''Y'') and ((isnull(P_IsKS,''N'') = ''Y''))  then ' +
              ' (case When (D_MValue-D_PValue) >= '+Floattostr(FNum1)+' then '+Floattostr(FNum2)+
              ' else (D_MValue-D_PValue-'+Floattostr(FNum3)+') end) '+
              ' else (D_MValue-D_PValue-isnull(D_KZValue,0)) end D_NetWeightEx,  '+
              '( select Top 1 T_Owner from S_Truck where T_Truck = D_Truck ) as T_Owner,' +
              ' '''+EditDate.Text+''' as P_BetweenTime From $OD od Inner Join $OO oo on od.D_OID=oo.O_ID ' +
              ' Inner Join Sys_PoundLog pl on od.D_ID=pl.P_Order ';
  end
  else
  begin
    Result := 'Select *,(D_MValue-D_PValue) as D_NetWeight, ' +
              '(D_MValue-D_PValue-isnull(D_KZValue,0)) as D_NetWeightEx,'+
              '(D_MValue-isnull(D_KZValue,0)) as D_MValueEx,'+
              '( select Top 1 T_Owner from S_Truck where T_Truck = D_Truck ) as T_Owner,' +
              ' '''+EditDate.Text+''' as P_BetweenTime From $OD od Inner Join $OO oo on od.D_OID=oo.O_ID ';
    //xxxxxx
  end;

  if FJBWhere = '' then
  begin
    Result := Result + 'Where (D_PDate>=''$S'' and D_PDate <''$End'') and D_OutFact is not null ';

    if nWhere <> '' then
      Result := Result + ' And (' + nWhere + ')';
    //xxxxx
  end else
  begin
    Result := Result + ' Where (' + FJBWhere + ')';
  end;

  Result := MacroValue(Result, [MI('$OD', sTable_OrderDtl),MI('$OO', sTable_Order),
            MI('$S', Date2Str(FStart)), MI('$End', Date2Str(FEnd + 1))]);
  //xxxxx
end;


//Desc: 日期筛选
procedure TfFrameOrderDetailQuery.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then InitFormData(FWhere);
end;

//Desc: 执行查询
procedure TfFrameOrderDetailQuery.EditTruckPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditCustomer then
  begin
    EditCustomer.Text := Trim(EditCustomer.Text);
    if EditCustomer.Text = '' then Exit;

    FWhere := 'D_ProPY like ''%%%s%%'' Or D_ProName like ''%%%s%%''';
    FWhere := Format(FWhere, [EditCustomer.Text, EditCustomer.Text]);
    InitFormData(FWhere);
  end else

  if Sender = EditTruck then
  begin
    EditTruck.Text := Trim(EditTruck.Text);
    if EditTruck.Text = '' then Exit;

    FWhere := 'oo.O_Truck like ''%%%s%%''';
    FWhere := Format(FWhere, [EditTruck.Text]);
    InitFormData(FWhere);
  end;

  if Sender = EditBill then
  begin
    EditBill.Text := Trim(EditBill.Text);
    if EditBill.Text = '' then Exit;

    FWhere := 'od.D_ID like ''%%%s%%''';
    FWhere := Format(FWhere, [EditBill.Text]);
    InitFormData(FWhere);
  end;
end;

//Desc: 交接班查询
procedure TfFrameOrderDetailQuery.mniN1Click(Sender: TObject);
begin
  if ShowDateFilterForm(FTimeS, FTimeE, True) then
  try
    FJBWhere := '(D_PDate>=''%s'' and D_PDate <''%s'')';
    FJBWhere := Format(FJBWhere, [DateTime2Str(FTimeS), DateTime2Str(FTimeE)]);
    InitFormData('');
  finally
    FJBWhere := '';
  end;
end;
//------------------------------------------------------------------------------
//Date: 2015/8/13
//Parm: 
//Desc: 查询未完成
procedure TfFrameOrderDetailQuery.N2Click(Sender: TObject);
begin
  inherited;
  try
    FJBWhere := '(D_OutFact Is Null And D_DStatus<>''%s'')';
    FJBWhere := Format(FJBWhere, [sFlag_OrderDel]);
    InitFormData('');
  finally
    FJBWhere := '';
  end;
end;
//------------------------------------------------------------------------------
//Date: 2015/8/13
//Parm: 
//Desc: 删除未完成记录
procedure TfFrameOrderDetailQuery.N3Click(Sender: TObject);
var nStr: string;
begin
  inherited;
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nStr := SQLQuery.FieldByName('D_ID').AsString;
    if not QueryDlg('确认删除该订单么?', sWarn) then Exit;

    //nSQL := MacroValue()
  end;

  N2.Click;
end;

procedure TfFrameOrderDetailQuery.N5Click(Sender: TObject);
var nStr: string;
    nIdx: Integer;
    nList: TStrings;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要编辑的记录', sHint); Exit;
  end;

  nList := TStringList.Create;
  try
    for nIdx := 0 to cxView1.DataController.RowCount - 1  do
    begin

      nStr := GetVal(nIdx,'D_ID');
      if nStr = '' then
        Continue;

      nList.Add(nStr);
    end;

    nStr := AdjustListStrFormat2(nList, '''', True, ',', False);
    PrintOrderReport(nStr, False, True);
  finally
    nList.Free;
  end;
end;

//Desc: 获取nRow行nField字段的内容
function TfFrameOrderDetailQuery.GetVal(const nRow: Integer;
 const nField: string): string;
var nVal: Variant;
begin
  nVal := cxView1.ViewData.Rows[nRow].Values[
            cxView1.GetColumnByFieldName(nField).Index];
  //xxxxx

  if VarIsNull(nVal) then
       Result := ''
  else Result := nVal;
end;

procedure TfFrameOrderDetailQuery.N7Click(Sender: TObject);
var nStr,nID,nTruck: string;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nStr := SQLQuery.FieldByName('D_Truck').AsString;
    nTruck := nStr;
    if not ShowInputBox('请输入新的车牌号:', '修改', nTruck, 100) then Exit;

    if (nTruck = '') or (nStr = nTruck) then Exit;
    //无效或一致
    nID := SQLQuery.FieldByName('D_ID').AsString;

    nStr := 'Update %s Set D_Truck=''%s'' Where D_ID=''%s''';
    nStr := Format(nStr, [sTable_OrderDtl, nTruck, nID]);
    FDM.ExecuteSQL(nStr);

    nStr := 'Update %s Set P_Truck=''%s'' Where P_Order=''%s''';
    nStr := Format(nStr, [sTable_PoundLog, nTruck, nID]);
    FDM.ExecuteSQL(nStr);

    nStr := '采购单[ %s ]修改车牌号[ %s -> %s ].';
    nStr := Format(nStr, [nID, SQLQuery.FieldByName('D_Truck').AsString, nTruck]);
    FDM.WriteSysLog(sFlag_BillItem, nID, nStr, False);

    InitFormData(FWhere);
    ShowMsg('车牌号修改成功', sHint);
  end;
end;

procedure TfFrameOrderDetailQuery.N8Click(Sender: TObject);
var nStr,nID,nPlace: string;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nStr := SQLQuery.FieldByName('D_UPlace').AsString;
    nPlace := nStr;
    if not ShowInputBox('请输入新的收货地点:', '修改', nPlace, 100) then Exit;

    if (nPlace = '') or (nStr = nPlace) then Exit;
    //无效或一致
    nID := SQLQuery.FieldByName('D_ID').AsString;

    nStr := 'Update %s Set D_UPlace=''%s'' Where D_ID=''%s''';
    nStr := Format(nStr, [sTable_OrderDtl, nPlace, nID]);
    FDM.ExecuteSQL(nStr);

    nStr := '采购单[ %s ]修改收货地点[ %s -> %s ].';
    nStr := Format(nStr, [nID, SQLQuery.FieldByName('D_UPlace').AsString, nPlace]);
    FDM.WriteSysLog(sFlag_BillItem, nID, nStr, False);

    InitFormData(FWhere);
    ShowMsg('收货地点修改成功', sHint);
  end;
end;

procedure TfFrameOrderDetailQuery.N10Click(Sender: TObject);
var nStr, nSql, nDIDs, nPrice : string;
    nIdx: Integer;
    nList: TStrings;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要设置的记录', sHint); Exit;
  end;

  nList := TStringList.Create;
  try
    with cxView1.Controller do
    begin
      for nIdx:=0 to SelectedRowCount-1   do
      begin
        SelectedRows[nIdx].Focused:=True;
        nStr := SQLQuery.FieldByName('D_ID').AsString;
        if nStr = '' then
          Continue;

        nList.Add(nStr);
      end;
    end;

    nDIDs := AdjustListStrFormat2(nList, '''', True, ',', False);

    nSql := ' Select * From %s od Where D_ID In (%s) and isnull(D_YNPrice,''N'') = ''Y'' ';
    nSql := Format(nSql, [sTable_OrderDtl, nDIDs]);
    with FDM.QueryTemp(nSql) do
    if RecordCount > 0 then
    begin
      ShowMsg('存在已设置单价的记录,请过滤后再设置', sHint);
      Exit;
    end;

    nPrice := '0';
    if not ShowInputBox('请输入单价:', '修改', nPrice, 100) then Exit;

    if StrToCurrDef(nPrice,0) <= 0 then Exit;

    nStr := 'Update %s Set D_Price=''%s'', D_YNPrice=''Y'' Where D_ID In (%s) ';
    nStr := Format(nStr, [sTable_OrderDtl, nPrice, nDIDs]);
    FDM.ExecuteSQL(nStr);
    
    nStr := '采购单设置价格[%s].';
    nStr := Format(nStr, [nPrice]);
    FDM.WriteSysLog(sFlag_BillItem, gSysParam.FUserName, nStr, False);

    InitFormData(FWhere);
    ShowMsg('设置单价成功！', sHint);
  finally
    nList.Free;
  end;
end;

procedure TfFrameOrderDetailQuery.N11Click(Sender: TObject);
var nStr, nSql, nDIDs, nPrice : string;
    nIdx: Integer;
    nList: TStrings;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('请选择要修改的记录', sHint); Exit;
  end;

  nList := TStringList.Create;
  try
    with cxView1.Controller do
    begin
      for nIdx:=0 to SelectedRowCount-1   do
      begin
        SelectedRows[nIdx].Focused:=True;
        nStr := SQLQuery.FieldByName('D_ID').AsString;
        if nStr = '' then
          Continue;

        nList.Add(nStr);
      end;
    end;
    nDIDs := AdjustListStrFormat2(nList, '''', True, ',', False);

    nPrice :=  SQLQuery.FieldByName('D_Price').AsString;
    if not ShowInputBox('请输入单价:', '修改', nPrice, 100) then Exit;

    if StrToCurrDef(nPrice,0) <= 0 then Exit;

    nStr := 'Update %s Set D_Price=''%s'', D_YNPrice=''Y'' Where D_ID In (%s) ';
    nStr := Format(nStr, [sTable_OrderDtl, nPrice, nDIDs]);
    FDM.ExecuteSQL(nStr);
    
    nStr := '采购单设置价格[%s].';
    nStr := Format(nStr, [nPrice]);
    FDM.WriteSysLog(sFlag_BillItem, gSysParam.FUserName, nStr, False);

    InitFormData(FWhere);
    ShowMsg('修改单价成功！', sHint);
  finally
    nList.Free;
  end;
end;

initialization
  gControlManager.RegCtrl(TfFrameOrderDetailQuery, TfFrameOrderDetailQuery.FrameID);
end.
