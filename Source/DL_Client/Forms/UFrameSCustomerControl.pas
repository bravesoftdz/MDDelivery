{*******************************************************************************
  ����: juner11212436@163.com 2019-04-16
  ����: ����������
*******************************************************************************}
unit UFrameSCustomerControl;

{$I Link.Inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFrameNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, Menus, dxLayoutControl,
  cxTextEdit, cxMaskEdit, cxButtonEdit, ADODB, cxLabel, UBitmapPanel,
  cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, ToolWin;

type
  TfFrameSCustomerControl = class(TfFrameNormal)
    EditID: TcxButtonEdit;
    dxLayout1Item1: TdxLayoutItem;
    EditName: TcxButtonEdit;
    dxLayout1Item2: TdxLayoutItem;
    cxTextEdit1: TcxTextEdit;
    dxLayout1Item3: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    dxLayout1Item4: TdxLayoutItem;
    procedure EditIDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure BtnDelClick(Sender: TObject);
  private
    { Private declarations }
  protected
    function InitFormDataSQL(const nWhere: string): string; override;
    {*��ѯSQL*}
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    //�����ͷ�
  public
    { Public declarations }
    class function FrameID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UMgrControl, UDataModule, UFormBase, UFormWait, USysBusiness,
  UBusinessPacker, USysConst, USysDB, USysLoger;

class function TfFrameSCustomerControl.FrameID: integer;
begin
  Result := cFI_FrameSCustomerControl;
end;

procedure TfFrameSCustomerControl.OnCreateFrame;
begin
  inherited;
end;

procedure TfFrameSCustomerControl.OnDestroyFrame;
begin
  inherited;
end;

//Desc: ���ݲ�ѯSQL
function TfFrameSCustomerControl.InitFormDataSQL(const nWhere: string): string;
begin
  Result := 'Select * From $Xz ';
  //xxxxx

  if nWhere <> '' then
    Result := Result + ' Where (' + nWhere + ')';

  Result := MacroValue(Result, [MI('$Xz', sTable_SCustomerControl)]);
  //xxxxx
end;

//------------------------------------------------------------------------------
//Desc: ���
procedure TfFrameSCustomerControl.BtnAddClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  nParam.FCommand := cCmd_AddData;
  CreateBaseFormItem(cFI_FormSCustomerControl, PopedomItem, @nParam);

  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    InitFormData('');
  end;
end;

//Desc: �޸�
procedure TfFrameSCustomerControl.BtnEditClick(Sender: TObject);
var nParam: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('��ѡ��Ҫ�༭�ļ�¼', sHint); Exit;
  end;

  nParam.FCommand := cCmd_EditData;
  nParam.FParamA := SQLQuery.FieldByName('R_ID').AsString;
  CreateBaseFormItem(cFI_FormSCustomerControl, PopedomItem, @nParam);

  if (nParam.FCommand = cCmd_ModalResult) and (nParam.FParamA = mrOK) then
  begin
    InitFormData(FWhere);
  end;
end;

//Desc: ɾ��
procedure TfFrameSCustomerControl.BtnDelClick(Sender: TObject);
var nStr,nSQL: string;
begin
  if cxView1.DataController.GetSelectedCount < 1 then
  begin
    ShowMsg('��ѡ��Ҫɾ���ļ�¼', sHint); Exit;
  end;

  if not QueryDlg('ȷ��Ҫɾ����', sAsk) then Exit;

  FDM.ADOConn.BeginTrans;
  try
    nSQL := 'Delete From %s Where R_ID=%d';
    nSQL := Format(nSQL, [sTable_SCustomerControl, SQLQuery.FieldByName('R_ID').AsInteger]);
    FDM.ExecuteSQL(nSQL);

    FDM.ADOConn.CommitTrans;
    InitFormData(FWhere);
    ShowMsg('�ѳɹ�ɾ����¼', sHint);
  except
    FDM.ADOConn.RollbackTrans;
    ShowMsg('ɾ����¼ʧ��', 'δ֪����');
  end;
end;

//Desc: ִ�в�ѯ
procedure TfFrameSCustomerControl.EditIDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditID then
  begin
    EditID.Text := Trim(EditID.Text);
    if EditID.Text = '' then Exit;

    FWhere := ' C_SaleID like ''%' + EditID.Text + '%''';
    InitFormData(FWhere);
  end else

  if Sender = EditName then
  begin
    EditName.Text := Trim(EditName.Text);
    if EditName.Text = '' then Exit;

    FWhere := ' C_SaleName like ''%%%s%%''';
    FWhere := Format(FWhere, [EditName.Text, EditName.Text]);
    InitFormData(FWhere);
  end;
end;

initialization
  gControlManager.RegCtrl(TfFrameSCustomerControl, TfFrameSCustomerControl.FrameID);
end.
