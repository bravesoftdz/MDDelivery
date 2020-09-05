{*******************************************************************************
  ����: dmzn@163.com 2009-7-15
  ����: ���ۻؿ�
*******************************************************************************}
unit UFramePaymentQT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFrameNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, cxContainer, dxLayoutControl,
  cxMaskEdit, cxButtonEdit, cxTextEdit, ADODB, cxLabel, UBitmapPanel,
  cxSplitter, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  ComCtrls, ToolWin, Menus;

type
  TfFramePaymentQT = class(TfFrameNormal)
    cxTextEdit1: TcxTextEdit;
    dxLayout1Item1: TdxLayoutItem;
    EditID: TcxButtonEdit;
    dxLayout1Item2: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    dxLayout1Item4: TdxLayoutItem;
    EditDate: TcxButtonEdit;
    dxLayout1Item6: TdxLayoutItem;
    cxTextEdit4: TcxTextEdit;
    dxLayout1Item7: TdxLayoutItem;
    PMenu1: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure EditDatePropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure EditTruckPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnEditClick(Sender: TObject);
    procedure cxView1DblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    { Private declarations }
  protected
    FStart,FEnd: TDate;
    //ʱ������
    procedure OnCreateFrame; override;
    procedure OnDestroyFrame; override;
    function InitFormDataSQL(const nWhere: string): string; override;
    {*��ѯSQL*}
  public
    { Public declarations }
    class function FrameID: integer; override;
  end;

implementation

{$R *.dfm}
uses
  ULibFun, UMgrControl, USysConst, USysDB, UFormBase, UFormDateFilter,
  UDataModule;

//------------------------------------------------------------------------------
class function TfFramePaymentQT.FrameID: integer;
begin
  Result := cFI_FramePaymentQT;
end;

procedure TfFramePaymentQT.OnCreateFrame;
begin
  inherited;
  InitDateRange(Name, FStart, FEnd);
end;

procedure TfFramePaymentQT.OnDestroyFrame;
begin
  SaveDateRange(Name, FStart, FEnd);
  inherited;
end;

function TfFramePaymentQT.InitFormDataSQL(const nWhere: string): string;
begin
  EditDate.Text := Format('%s �� %s', [Date2Str(FStart), Date2Str(FEnd)]);
  
  Result := 'Select iom.*,sm.S_Name From $IOM iom ' +
            ' Left Join $SM sm On sm.S_ID=iom.M_SaleMan ' +
            'Where M_Type=''$HK'' And M_Payment like ''%%Ƿ��%%'' ';
            
  if nWhere = '' then
       Result := Result + 'And (M_Date>=''$Start'' And M_Date <''$End'')'
  else Result := Result + 'And (' + nWhere + ')';

  Result := MacroValue(Result, [MI('$SM', sTable_Salesman),
            MI('$IOM', sTable_InOutMoney), MI('$HK', sFlag_MoneyHuiKuan),
            MI('$Start', Date2Str(FStart)), MI('$End', Date2Str(FEnd + 1))]);
  //xxxxx
end;

//------------------------------------------------------------------------------
//Desc: �ؿ�
procedure TfFramePaymentQT.BtnAddClick(Sender: TObject);
var nP: TFormCommandParam;
begin
  nP.FParamA := '';
  CreateBaseFormItem(cFI_FormPaymentQT, '', @nP);

  if (nP.FCommand = cCmd_ModalResult) and (nP.FParamA = mrOK) then
  begin
    InitFormData;
  end;
end;

//Desc: �ض��ͻ��ؿ�
procedure TfFramePaymentQT.cxView1DblClick(Sender: TObject);
var nP: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount < 1 then Exit;
  nP.FParamA := SQLQuery.FieldByName('M_CusID').AsString;
  CreateBaseFormItem(cFI_FormPaymentQT, '', @nP);

  if (nP.FCommand = cCmd_ModalResult) and (nP.FParamA = mrOK) then
  begin
    InitFormData;
  end;
end;

//Desc: ֽ���ؿ�
procedure TfFramePaymentQT.BtnEditClick(Sender: TObject);
var nP: TFormCommandParam;
begin
  CreateBaseFormItem(cFI_FormPaymentZK, '', @nP);
  if (nP.FCommand = cCmd_ModalResult) and (nP.FParamA = mrOK) then
  begin
    InitFormData;
  end;
end;

//Desc: ����ɸѡ
procedure TfFramePaymentQT.EditDatePropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if ShowDateFilterForm(FStart, FEnd) then InitFormData(FWhere);
end;

//Desc: ִ�в�ѯ
procedure TfFramePaymentQT.EditTruckPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if Sender = EditID then
  begin
    EditID.Text := Trim(EditID.Text);
    if EditID.Text = '' then Exit;
    
    FWhere := '(M_CusID like ''%%%s%%'' Or M_CusName like ''%%%s%%'')';
    FWhere := Format(FWhere, [EditID.Text, EditID.Text]);
    InitFormData(FWhere);
  end else
end;

procedure TfFramePaymentQT.N1Click(Sender: TObject);
var
  nStr, nRID, nRuZhang : string;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nRID     := SQLQuery.FieldByName('R_ID').AsString;
    nRuZhang := SQLQuery.FieldByName('M_RuZhang').AsString;

    nStr := 'ȷ��Ҫ����ʱ�ؿ��¼[ %s ]��������ȷ����?';
    nStr := Format(nStr, [nRID]);
    if not QueryDlg(nStr, sAsk) then Exit;

    FDM.ADOConn.BeginTrans;
    try
      nStr := ' update %s set M_RuZhang= ''%s'' where R_ID = %s ';
      nStr := Format(nStr, [sTable_InOutMoney, sFlag_Yes, nRID]);
      FDM.ExecuteSQL(nStr);

      FDM.ADOConn.CommitTrans;
    except
      FDM.ADOConn.RollbackTrans;
      ShowMsg('����ȷ��ʧ��.', sHint);
      Exit;
    end;

    InitFormData(FWhere);
    ShowMsg('����ȷ�ϳɹ�', sHint);
  end;
end;

procedure TfFramePaymentQT.N3Click(Sender: TObject);
var
  nStr, nRID, nSql,nPayingUnit,nMoney : string;
  nPayingMan,nDesc,nPriceStock,nType,nAcceptNum : string;
  nP: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nRID        := SQLQuery.FieldByName('R_ID').AsString;
    nPayingUnit := SQLQuery.FieldByName('M_PayingUnit').AsString;
    nMoney      := SQLQuery.FieldByName('M_Money').AsString;
    nPayingMan  := SQLQuery.FieldByName('M_PayingMan').AsString;
    nDesc       := SQLQuery.FieldByName('M_Memo').AsString;
    nPriceStock := SQLQuery.FieldByName('M_PriceStock').AsString;
    nType       := SQLQuery.FieldByName('M_Payment').AsString;
    nAcceptNum  := SQLQuery.FieldByName('M_AcceptNum').AsString;
    
    //�ж��Ƿ��������վ�
    nSql := ' Select Count(*) From %s Where S_InOutID = ''%s'' ';
    nSql := Format(nSql, [sTable_SysShouJu, nRID]);

    with FDM.QueryTemp(nSql) do
    if Fields[0].AsInteger > 0 then
    begin
      ShowMsg('�Ѵ��ڶ�Ӧ���վ���Ϣ', sHint); Exit;
    end;

    //�����վ�
    nP.FCommand := cCmd_AddData;
    nP.FParamA  := nPayingUnit;
    if nAcceptNum <> '' then
      nP.FParamB  := nType +'('+nAcceptNum+')'
    else
      nP.FParamB  := nType;
    nP.FParamC  := nMoney;
    nP.FParamD  := nPayingMan;
    nP.FParamE  := nDesc;
    nP.FParamF  := nPriceStock;
    nP.FParamG  := nRID;
    CreateBaseFormItem(cFI_FormShouJu, '', @nP);
  end;
end;

procedure TfFramePaymentQT.N4Click(Sender: TObject);
var
  nP: TFormCommandParam;
begin
  if cxView1.DataController.GetSelectedCount > 0 then
  begin
    nP.FCommand := cCmd_EditData;
    nP.FParamA  := SQLQuery.FieldByName('R_ID').AsString;
    nP.FParamB  := SQLQuery.FieldByName('M_Memo').AsString;
    nP.FParamC  := SQLQuery.FieldByName('M_RuZhang').AsString;
    CreateBaseFormItem(cFI_FormQTInfo, '', @nP);

    InitFormData(FWhere);
  end;
end;

initialization
  gControlManager.RegCtrl(TfFramePaymentQT, TfFramePaymentQT.FrameID);
end.
