{*******************************************************************************
  作者: juner11212436@163.com 2019-04-16
  描述: 销售量控制
*******************************************************************************}
unit UFormSCustomerControl;

{$I Link.Inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFormBase, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  cxTextEdit, dxLayoutControl, StdCtrls, cxCheckBox, cxSpinEdit, cxTimeEdit;

type
  TfFormSCustomerControl = class(TfFormNormal)
    CheckValid: TcxCheckBox;
    dxLayout1Item4: TdxLayoutItem;
    dxGroup2: TdxLayoutGroup;
    ChkUseControl: TcxCheckBox;
    dxLayout1Item3: TdxLayoutItem;
    EditCus: TcxComboBox;
    dxLayout1Item5: TdxLayoutItem;
    EditMemo: TcxTextEdit;
    dxLayout1Item8: TdxLayoutItem;
    EditStock: TcxComboBox;
    dxLayout1Item6: TdxLayoutItem;
    EditValue: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    procedure BtnOKClick(Sender: TObject);
    procedure EditCusPropertiesChange(Sender: TObject);
    procedure EditStockPropertiesChange(Sender: TObject);
  protected
    { Protected declarations }
    FTruckID: string;
    procedure LoadFormData(const nID: string);
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UMgrControl, UDataModule, UFormCtrl, USysDB, USysConst;

type
  TCusItem = record
    FID   : string;
    FName : string;
  end;

var
  gCusItems: array of TCusItem;
  gStockItems: array of TCusItem;
  //客户列表

class function TfFormSCustomerControl.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;
  
  with TfFormSCustomerControl.Create(Application) do
  try
    if nP.FCommand = cCmd_AddData then
    begin
      Caption := '销售量控制 - 添加';
      FTruckID := '';
    end;

    if nP.FCommand = cCmd_EditData then
    begin
      Caption := '销售量控制 - 修改';
      FTruckID := nP.FParamA;
    end;

    LoadFormData(FTruckID); 
    nP.FCommand := cCmd_ModalResult;
    nP.FParamA := ShowModal;
  finally
    Free;
  end;
end;

class function TfFormSCustomerControl.FormID: integer;
begin
  Result := cFI_FormSCustomerControl;
end;

procedure TfFormSCustomerControl.LoadFormData(const nID: string);
var nStr: string;
    nIdx: Integer;
begin
//  nStr := 'Select * From %s Where C_CusName=''%s''';
//  nStr := Format(nStr, [sTable_SCustomerControl, sFlag_SCustomerControl]);
//
//  with FDM.QueryTemp(nStr) do
//  begin
//    if RecordCount > 0 then
//    begin
//      if FieldByName('C_Valid').AsString = sFlag_Yes then
//        ChkUseControl.Checked := True;
//    end;
//  end;
  ChkUseControl.Checked := False;

  EditCus.Properties.Items.Clear;
  nStr := 'Select S_ID, S_Name From %s  ';
  nStr := Format(nStr, [sTable_Salesman]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount > 0 then
    begin
      SetLength(gCusItems, RecordCount);

      nIdx := 0;
      try
        EditCus.Properties.BeginUpdate;

        First;

        while not Eof do
        begin
          if (Fields[0].AsString = '') or (Fields[1].AsString = '') then
          begin
            Next;
            Continue;
          end;
          with gCusItems[nIdx] do
          begin
            FID := Fields[0].AsString;
            FName := Fields[1].AsString;
          end;

          Inc(nIdx);
          EditCus.Properties.Items.Add(Fields[1].AsString);
          Next;
        end;
      finally
        EditCus.Properties.EndUpdate;
      end;
    end;
  end;

  EditStock.Properties.Items.Clear;
  nStr := 'Select D_ParamB, D_Value From %s where D_Name=''%s'' ';
  nStr := Format(nStr, [sTable_SysDict, sFlag_StockItem]);

  with FDM.QueryTemp(nStr) do
  begin
    if RecordCount > 0 then
    begin
      SetLength(gStockItems, RecordCount);

      nIdx := 0;
      try
        EditStock.Properties.BeginUpdate;

        First;

        while not Eof do
        begin
          if (Fields[0].AsString = '') or (Fields[1].AsString = '') then
          begin
            Next;
            Continue;
          end;
          with gStockItems[nIdx] do
          begin
            FID := Fields[0].AsString;
            FName := Fields[1].AsString;
          end;

          Inc(nIdx);
          EditStock.Properties.Items.Add(Fields[1].AsString);
          Next;
        end;
      finally
        EditStock.Properties.EndUpdate;
      end;
    end;
  end;

  if nID <> '' then
  begin
    nStr := 'Select * From %s Where R_ID=%s';
    nStr := Format(nStr, [sTable_SCustomerControl, nID]);
    FDM.QueryTemp(nStr);
  end;

  with FDM.SqlTemp do
  begin
    if (nID = '') or (RecordCount < 1) then
    begin
      CheckValid.Checked := True;
      Exit;
    end;

    EditCus.Text := FieldByName('C_SaleName').AsString;
    EditCus.ItemIndex := EditCus.SelectedItem;
    EditStock.Text := FieldByName('C_StockName').AsString;
    EditStock.ItemIndex := EditStock.SelectedItem;
    EditMemo.Text := FieldByName('C_Memo').AsString;
    EditValue.Text := FieldByName('C_Value').AsString;
    CheckValid.Checked := FieldByName('C_Valid').AsString = sFlag_Yes;
  end;
end;

//Desc: 保存
procedure TfFormSCustomerControl.BtnOKClick(Sender: TObject);
var nStr,nCID,nV,nVTotal: string;
begin
  if Trim(EditCus.Text) = '' then
  begin
    ActiveControl := EditCus;
    ShowMsg('请选择业务员', sHint);
    Exit;
  end;

  if Trim(EditStock.Text) = '' then
  begin
    ActiveControl := EditStock;
    ShowMsg('请选择物料', sHint);
    Exit;
  end;

  if not IsNumber(EditValue.Text, True) then
  begin
    ActiveControl := EditValue;
    ShowMsg('日销售量非法,请重新输入', sHint);
    Exit;
  end;

  if ChkUseControl.Checked then
       nVTotal := sFlag_Yes
  else nVTotal := sFlag_No;

//  nStr := SF('C_CusName', sFlag_SCustomerControl);
//  nStr := MakeSQLByStr([
//          SF('C_CusName', sFlag_SCustomerControl),
//          SF('C_Valid', nVTotal)
//          ], sTable_SCustomerControl, nStr, False);
//
//  if FDM.ExecuteSQL(nStr) <= 0 then
//  begin
//    nStr := MakeSQLByStr([
//        SF('C_CusName', sFlag_SCustomerControl),
//        SF('C_Valid', nVTotal)
//        ], sTable_SCustomerControl, '', True);
//    FDM.ExecuteSQL(nStr);
//  end;

  if CheckValid.Checked then
       nV := sFlag_Yes
  else nV := sFlag_No;

  if FTruckID = '' then
       nStr := ''
  else nStr := SF('R_ID', FTruckID, sfVal);

  nStr := MakeSQLByStr([SF('C_SaleID', gCusItems[EditCus.ItemIndex].FID),
          SF('C_SaleName', gCusItems[EditCus.ItemIndex].FName),
          SF('C_Valid', nV),
          SF('C_StockNo', gStockItems[EditStock.ItemIndex].FID),
          SF('C_StockName', gStockItems[EditStock.ItemIndex].FName),
          SF('C_Value', EditValue.Text),
          SF('C_Memo', EditMemo.Text)
          ], sTable_SCustomerControl, nStr, FTruckID = '');
  FDM.ExecuteSQL(nStr);

  ModalResult := mrOk;
  ShowMsg('控制信息保存成功', sHint);
end;

procedure TfFormSCustomerControl.EditCusPropertiesChange(Sender: TObject);
var nIdx : Integer;
    nStr: string;
begin
  for nIdx := 0 to EditCus.Properties.Items.Count - 1 do
  begin;
    if Pos(EditCus.Text,EditCus.Properties.Items.Strings[nIdx]) > 0 then
    begin
      EditCus.SelectedItem := nIdx;
      Break;
    end;
  end;
end;

procedure TfFormSCustomerControl.EditStockPropertiesChange(
  Sender: TObject);
var nIdx : Integer;
    nStr: string;
begin
  for nIdx := 0 to EditStock.Properties.Items.Count - 1 do
  begin;
    if Pos(EditStock.Text,EditStock.Properties.Items.Strings[nIdx]) > 0 then
    begin
      EditStock.SelectedItem := nIdx;
      Break;
    end;
  end;
end;

initialization
  gControlManager.RegCtrl(TfFormSCustomerControl, TfFormSCustomerControl.FormID);
end.
