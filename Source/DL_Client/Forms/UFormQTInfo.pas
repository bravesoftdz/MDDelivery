{*******************************************************************************
  ����: dmzn@163.com 2014-11-25
  ����: Ƿ����Ϣ�༭
*******************************************************************************}
unit UFormQTInfo;

{$I Link.Inc}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  UFormBase, UFormNormal, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit,
  cxTextEdit, dxLayoutControl, StdCtrls, cxCheckBox, cxMemo;

type
  TfFormQTInfo = class(TfFormNormal)
    EditMemo: TcxMemo;
    dxLayout1Item3: TdxLayoutItem;
    EditRuZhang: TcxComboBox;
    dxLayout1Item4: TdxLayoutItem;
    procedure BtnOKClick(Sender: TObject);
  protected
    { Protected declarations }
    FRID: integer;
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

class function TfFormQTInfo.CreateForm(const nPopedom: string;
  const nParam: Pointer): TWinControl;
var nP: PFormCommandParam;
begin
  Result := nil;
  if Assigned(nParam) then
       nP := nParam
  else Exit;

  if nP.FCommand = cCmd_EditData then
  begin
    with TfFormQTInfo.Create(Application) do
    try
      Caption       := 'Ƿ����Ϣ - �޸�';
      FRID          := nP.FParamA;
      EditMemo.Text := nP.FParamB;
      if nP.FParamC = 'Y' then
        EditRuZhang.ItemIndex := 2
      else if nP.FParamC = 'M' then
        EditRuZhang.ItemIndex := 1
      else if nP.FParamC = 'N' then
        EditRuZhang.ItemIndex := 0;
      
      nP.FCommand := cCmd_ModalResult;
      nP.FParamA := ShowModal;
    finally
      Free;
    end;
  end;
end;

class function TfFormQTInfo.FormID: integer;
begin
  Result := cFI_FormQTInfo;
end;

//Desc: ����
procedure TfFormQTInfo.BtnOKClick(Sender: TObject);
var nStr,nQTInfo,nU,nV,nP,nVip,nGps,nEvent: string;
    nRuzhang : string;
begin
  nQTInfo := UpperCase(Trim(EditMemo.Text));
  if nQTInfo = '' then
  begin
    ActiveControl := EditMemo;
    ShowMsg('�����뱸ע��Ϣ', sHint);
    Exit;
  end;

  if EditRuZhang.ItemIndex = 0 then
    nRuzhang := 'N'
  else if EditRuZhang.ItemIndex = 1 then
    nRuzhang := 'M'
  else if EditRuZhang.ItemIndex = 2 then
    nRuzhang := 'Y';
  

  nStr := SF('R_ID', FRID);

  nStr := MakeSQLByStr([SF('M_Memo', nQTInfo),
          SF('M_RuZhang', nRuzhang),
          SF('M_ModMan', gSysParam.FUserID),
          SF('M_ModDate', FDM.SQLServerNow, sfVal)
          ], sTable_InOutMoney, nStr, False);
  FDM.ExecuteSQL(nStr);


  nEvent := '�޸�[ %s ]Ƿ����Ϣ.';
  nEvent := Format(nEvent, [nQTInfo]);
  FDM.WriteSysLog(sFlag_CommonItem, nQTInfo, nEvent);


  ModalResult := mrOk;
  ShowMsg('�޸ı�ע��Ϣ����ɹ�', sHint);
end;

initialization
  gControlManager.RegCtrl(TfFormQTInfo, TfFormQTInfo.FormID);
end.
