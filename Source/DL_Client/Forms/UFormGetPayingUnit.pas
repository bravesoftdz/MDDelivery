{*******************************************************************************
  ����: fendou116688@163.com 2015/9/8
  ����: ѡ�񽻻���λ
*******************************************************************************}
unit UFormGetPayingUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, ComCtrls, cxCheckBox, Menus,
  cxLabel, cxListView, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxLayoutControl, StdCtrls;

type
  TfFormGetPayingUnit = class(TfFormNormal)
    EditProvider: TcxButtonEdit;
    dxLayout1Item5: TdxLayoutItem;
    ListProvider: TcxListView;
    dxLayout1Item6: TdxLayoutItem;
    cxLabel1: TcxLabel;
    dxLayout1Item7: TdxLayoutItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnOKClick(Sender: TObject);
    procedure ListProviderKeyPress(Sender: TObject; var Key: Char);
    procedure EditCIDPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure ListProviderDblClick(Sender: TObject);
  private
    { Private declarations }
    function QueryProvider(const nProvider: string): Boolean;
    //��ѯ��Ӧ��
  public
    { Public declarations }
    class function CreateForm(const nPopedom: string = '';
      const nParam: Pointer = nil): TWinControl; override;
    class function FormID: integer; override;
  end;

implementation

{$R *.dfm}

uses
  IniFiles, ULibFun, UMgrControl, UFormBase, USysGrid, USysDB, USysConst,
  USysBusiness, UDataModule, UFormInputbox;

class function TfFormGetPayingUnit.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  with TfFormGetPayingUnit.Create(Application) do
  begin
    Caption := 'ѡ�񽻿λ';

    EditProvider.Text := nP.FParamA;
    QueryProvider(EditProvider.Text);

    nP.FCommand := cCmd_ModalResult;
    nP.FParamA := ShowModal;

    if nP.FParamA = mrOK then
    with ListProvider.Items[ListProvider.ItemIndex] do
    begin
      nP.FParamB := SubItems[0];;
    end;
    Free;
  end;
end;

class function TfFormGetPayingUnit.FormID: integer;
begin
  Result := cFI_FormGetPayingUnit;
end;

procedure TfFormGetPayingUnit.FormCreate(Sender: TObject);
var nIni: TIniFile;
begin
  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    LoadFormConfig(Self, nIni);
    LoadcxListViewConfig(Name, ListProvider, nIni);
  finally
    nIni.Free;
  end;
end;

procedure TfFormGetPayingUnit.FormClose(Sender: TObject;
  var Action: TCloseAction);
var nIni: TIniFile;
begin
  nIni := TIniFile.Create(gPath + sFormConfig);
  try
    SaveFormConfig(Self, nIni);
    SavecxListViewConfig(Name, ListProvider, nIni);
  finally
    nIni.Free;
  end;
end;

//------------------------------------------------------------------------------
//Desc: ��ѯ���λ
function TfFormGetPayingUnit.QueryProvider(const nProvider: string): Boolean;
var nStr: string;
begin
  Result := False;
  if Trim(nProvider) = '' then Exit;
  ListProvider.Items.Clear;

  nStr := 'Select * From %s Where (P_PY Like ''%%%s%%'' or ' +
          'P_PayingUnit Like ''%%%s%%'' )  Order By P_PY';
  nStr := Format(nStr, [sTable_PayingUnit, Trim(nProvider), Trim(nProvider)]);
  //xxxxxx

  with FDM.QueryTemp(nStr) do
  if RecordCount > 0 then
  begin
    First;

    while not Eof do
    begin
      with ListProvider.Items.Add do
      begin
        Caption := FieldByName('P_PY').AsString;
        SubItems.Add(FieldByName('P_PayingUnit').AsString);

        ImageIndex := 11;
        StateIndex := ImageIndex;
      end;

      Next;
    end;
  end;

  Result := ListProvider.Items.Count > 0;
  if Result then
  begin
    ActiveControl := ListProvider;
    ListProvider.ItemIndex := 0;
    ListProvider.ItemFocused := ListProvider.TopItem;
  end;
end;

//------------------------------------------------------------------------------
procedure TfFormGetPayingUnit.EditCIDPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  QueryProvider(EditProvider.Text);
end;

procedure TfFormGetPayingUnit.ListProviderKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;

    if ListProvider.ItemIndex > -1 then
      ModalResult := mrOk;
    //xxxxx
  end;
end;

procedure TfFormGetPayingUnit.ListProviderDblClick(Sender: TObject);
begin
  if ListProvider.ItemIndex > -1 then
    ModalResult := mrOk;
  //xxxxx
end;

procedure TfFormGetPayingUnit.BtnOKClick(Sender: TObject);
begin
  if ListProvider.ItemIndex > -1 then
       ModalResult := mrOk
  else ShowMsg('���ڲ�ѯ�����ѡ��', sHint);
end;

initialization
  gControlManager.RegCtrl(TfFormGetPayingUnit, TfFormGetPayingUnit.FormID);
end.
