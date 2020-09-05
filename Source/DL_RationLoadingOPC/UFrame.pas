unit UFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, StdCtrls, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, ULEDFont, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, cxLabel, cxMaskEdit, cxDropDownEdit, UMgrdOPCTunnels,
  ExtCtrls, IdContext, IdGlobal, UBusinessConst, ULibFun,
  Menus, cxButtons, UMgrSendCardNo, USysLoger, cxCurrencyEdit, dxSkinsCore,
  dxSkinsDefaultPainters, cxSpinEdit, DateUtils,Activex, StrUtils, USysConst;

type
  TFrame1 = class(TFrame)
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    btnPause: TToolButton;
    ToolButton6: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton1: TToolButton;
    GroupBox1: TGroupBox;
    StateTimer: TTimer;
    DelayTimer: TTimer;
    cxLabel6: TcxLabel;
    EditMaxValue: TcxTextEdit;
    cxLabel1: TcxLabel;
    editPValue: TcxTextEdit;
    cxLabel2: TcxLabel;
    editZValue: TcxTextEdit;
    cxLabel4: TcxLabel;
    EditBill: TcxComboBox;
    cxLabel5: TcxLabel;
    EditTruck: TcxComboBox;
    cxLabel7: TcxLabel;
    EditMValue: TcxComboBox;
    cxLabel8: TcxLabel;
    EditValue: TcxComboBox;
    procedure BtnStopClick(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure StateTimerTimer(Sender: TObject);
    procedure DelayTimerTimer(Sender: TObject);
  private
    { Private declarations }
    FCardUsed: string;            //��Ƭ����
    FUIData: TLadingBillItem;     //��������
    FOPCTunnel: PPTOPCItem;       //OPCͨ��
    FHasDone, FSetValue, FUseTime: Double;
    FDataLarge: Double;//�Ŵ���
    procedure SetUIData(const nReset: Boolean; const nOnlyData: Boolean = False);
    //���ý�������
    procedure SetTunnel(const Value: PPTOPCItem);
    procedure WriteLog(const nEvent: string);
    procedure SyncReadValues(const FromCache: boolean);
    procedure Get_Card_Message(var Message: TMessage); message WM_HAVE_CARD ;
  public
    FrameId:Integer;              //PLCͨ��
    FIsBusy: Boolean;             //ռ�ñ�ʶ
    FSysLoger : TSysLoger;
    FCard: string;
    FLastValue,FControl : Double;
    property OPCTunnel: PPTOPCItem read FOPCTunnel write SetTunnel;
    procedure LoadBillItems(const nCard: string);
    //��ȡ������
    procedure StopPound;
  end;

implementation

{$R *.dfm}

uses
   USysBusiness, USysDB, UDataModule, UFormInputbox, UFormCtrl, main;

procedure TFrame1.Get_Card_Message(var Message: TMessage);
Begin
  EditBill.Text := FCard;
  LoadBillItems(EditBill.Text);
End ;

//Parm: �ſ��򽻻�����
//Desc: ��ȡnCard��Ӧ�Ľ�����
procedure TFrame1.LoadBillItems(const nCard: string);
var
  nStr,nTruck: string;
  nBills: TLadingBillItems;
  nRet,nHisMValueControl: Boolean;
  nIdx,nSendValue: Integer;
  nVal, nPreKD: Double;
  nEvent,nEID:string;
begin
  if Assigned(FOPCTunnel.FOptions) And
       (UpperCase(FOPCTunnel.FOptions.Values['SendToPlc']) = sFlag_Yes) then
  begin
    WriteLog('��OPC����,�˳�����');
    Exit;
  end;
  if DelayTimer.Enabled then
  begin
    nStr := '����Ƶ��ˢ��';
    WriteLog(nStr);
    LineClose(FOPCTunnel.FID, sFlag_Yes);
    ShowLedText(FOPCTunnel.FID, nStr);
    SetUIData(True);
    Exit;
  end;
  FDataLarge := 1;

  if Assigned(FOPCTunnel.FOptions) And
       (IsNumber(FOPCTunnel.FOptions.Values['DataLarge'], True)) then
  begin
    FDataLarge := StrToFloat(FOPCTunnel.FOptions.Values['DataLarge']);
  end;

  if Assigned(FOPCTunnel.FOptions) And
       (UpperCase(FOPCTunnel.FOptions.Values['ClearLj']) = sFlag_Yes) then
  begin
    if StrToFloatDef(EditValue.Text, 0) > 0.1 then
    begin
      nStr := '������ۼ���';
      WriteLog(nStr);
      LineClose(FOPCTunnel.FID, sFlag_Yes);
      ShowLedText(FOPCTunnel.FID, nStr);
      SetUIData(True);
      Exit;
    end;
  end;

  WriteLog('���յ�����:' + nCard);
  FCard := nCard;

  nRet := GetLadingBills(nCard, sFlag_TruckBFP, nBills);

  if (not nRet) or (Length(nBills) < 1) then
  begin
    nStr := '��ȡ�ſ���Ϣʧ��,����ϵ����Ա';
    WriteLog(nStr);
    SetUIData(True);
    Exit;
  end;

  //��ȡ�������ֵ
  //nBills[0].FMData.FValue := StrToFloatDef(GetLimitValue(nBills[0].FTruck),0);

  FUIData := nBills[0];

  if Assigned(FOPCTunnel.FOptions) And
       (UpperCase(FOPCTunnel.FOptions.Values['NoHasDone']) = sFlag_Yes) then
    FHasDone := 0
  else
    FHasDone := ReadDoneValue(FUIData.FID, FUseTime);

  FSetValue := FUIData.FValue;

  nHisMValueControl := False;
  if Assigned(FOPCTunnel.FOptions) And
       (UpperCase(FOPCTunnel.FOptions.Values['TruckHzValueControl']) = sFlag_Yes) then
    nHisMValueControl := True;

  if nHisMValueControl then
  begin
    nVal := GetTruckSanMaxLadeValue(FUIData.FTruck);
    if (nVal > 0) and (FUIData.FValue > nVal) then//����������ϵͳ�趨�����
    begin
      EditMaxValue.Text := Format('%.2f', [nVal]);
      FSetValue := nVal;
      nEvent := '����[ %s ]������[ %s ],' +
                '������[ %.2f ]���ں�����[ %.2f ],�����󿪵���[ %.2f ].';
      nEvent := Format(nEvent, [FUIData.FTruck, FUIData.FID,
                                FUIData.FValue, nVal, nVal]);
      WriteLog(nEvent);
    end;
  end;

  nVal := GetSanMaxLadeValue;
  if (nVal > 0) and (FUIData.FValue > nVal) then//����������ϵͳ�趨�����
  begin
    EditMaxValue.Text := Format('%.2f', [nVal]);
    FSetValue := nVal;
    nEvent := '����[ %s ]������[ %s ],' +
              '������[ %.2f ]����ϵͳ�趨�����[ %.2f ],�����󿪵���[ %.2f ].';
    nEvent := Format(nEvent, [FUIData.FTruck, FUIData.FID,
                              FUIData.FValue, nVal, nVal]);
    WriteLog(nEvent);
  end;

  nVal := ReadTruckHisMValueMax(FUIData.FTruck);
  nPreKD := GetSanPreKD;

  nHisMValueControl := False;
  if Assigned(FOPCTunnel.FOptions) And
       (UpperCase(FOPCTunnel.FOptions.Values['HisMValueControl']) = sFlag_Yes) then
    nHisMValueControl := True;

  if nHisMValueControl and (nVal > 0) and
  ((FUIData.FPData.FValue + FUIData.FValue) > nVal) then
  begin
    FSetValue := nVal - FUIData.FPData.FValue - nPreKD;

    //�����¼�
    if Assigned(FOPCTunnel.FOptions) And
       (UpperCase(FOPCTunnel.FOptions.Values['SendMsg']) = sFlag_Yes) then
    begin
      try
        nEID := FUIData.FID + 'H';
        nStr := 'Delete From %s Where E_ID=''%s''';
        nStr := Format(nStr, [sTable_ManualEvent, nEID]);

        FDM.ExecuteSQL(nStr);

        nEvent := '����[ %s ]������[ %s ]װ�����ѵ���,��ʷ���ë��[ %.2f ],' +
                  '��ǰƤ��[ %.2f ],������[ %.2f ],Ԥ����[ %.2f ],������װ����[ %.2f ].';
        nEvent := Format(nEvent, [FUIData.FTruck, FUIData.FID, nVal,
                                  FUIData.FPData.FValue, FUIData.FValue,
                                  nPreKD, FSetValue]);
        WriteLog(nEvent);
        nStr := MakeSQLByStr([
            SF('E_ID', nEID),
            SF('E_Key', ''),
            SF('E_From', sFlag_DepJianZhuang),
            SF('E_Event', nEvent),
            SF('E_Solution', sFlag_Solution_OK),
            SF('E_Departmen', sFlag_DepDaTing),
            SF('E_Date', sField_SQLServer_Now, sfVal)
            ], sTable_ManualEvent, '', True);
        FDM.ExecuteSQL(nStr);
      except
        on E: Exception do
        begin
          WriteLog('�����¼�ʧ��:' + e.message);
        end;
      end;
    end;
  end
  else
  begin
    if (FUIData.FValue - nPreKD) > 0 then
    begin
      FSetValue := FSetValue - nPreKD;

      nEvent := '����[ %s ]������[ %s ],' +
                '������[ %.2f ],Ԥ����[ %.2f ],������װ����[ %.2f ].';
      nEvent := Format(nEvent, [FUIData.FTruck, FUIData.FID,
                                FUIData.FValue, nPreKD, FSetValue]);
      WriteLog(nEvent);
    end;
  end;

  if FHasDone >= FSetValue then
  begin
    nStr := '������[ %s ]������[ %.2f ],��װ��[ %.2f ],�޷�����װ��';
    nStr := Format(nStr, [FUIData.FID, FSetValue, FHasDone]);
    WriteLog(nStr);
    LineClose(FOPCTunnel.FID, sFlag_Yes);
    ShowLedText(FOPCTunnel.FID, 'װ�����Ѵﵽ������');
    SetUIData(True);
    Exit;
  end;

  EditValue.Text := Format('%.2f', [FHasDone]);
  SetUIData(False);

  try
    if Trim(FOPCTunnel.FStartTag) <> '' then
    begin
      for nIdx := 1 to 30 do
      begin
        Sleep(100);
        Application.ProcessMessages;
      end;


      for nIdx := 1 to 30 do
      begin
        Sleep(100);
        Application.ProcessMessages;
      end;
    end;

    LineClose(FOPCTunnel.FID, sFlag_No);
    WriteLog(FOPCTunnel.FID +'������������ɹ�');
    StateTimer.Tag := 0;
  except
    on E: Exception do
    begin
      StopPound;
      WriteLog(FOPCTunnel.FID +'����ʧ��,ԭ��Ϊ:' + e.Message);
      ShowLedText(FOPCTunnel.FID, '����ʧ��,������ˢ��');
    end;
  end;
end;

procedure TFrame1.SetUIData(const nReset: Boolean; const nOnlyData: Boolean = False);
var
  nItem: TLadingBillItem;
begin
  if nReset then
  begin
    FillChar(nItem, SizeOf(nItem), #0);
    nItem.FFactory := gSysParam.FFactNum;

    FUIData := nItem;
    if nOnlyData then Exit;

    EditValue.Text := '0.00';
    EditMValue.Text := '0.00';
    EditBill.Properties.Items.Clear;
  end;

  with FUIData do
  begin
    EditBill.Text  := FID;
    EditTruck.Text := FTruck;

    //EditMaxValue.Text := Format('%.2f', [FMData.FValue]);
    EditPValue.Text := Format('%.2f', [FPData.FValue]);
    EditZValue.Text := Format('%.2f', [FValue]);
  end;
end;

procedure TFrame1.WriteLog(const nEvent: string);
begin
  FSysLoger.AddLog(TFrame, '����װ������Ԫ', nEvent);
end;

procedure TFrame1.SetTunnel(const Value: PPTOPCItem);
begin
  FOPCTunnel := Value;
  SetUIData(true);
end;

procedure TFrame1.StopPound;
begin

end;

procedure TFrame1.BtnStopClick(Sender: TObject);
begin
  try
    StopPound;
  except
    on E: Exception do
    begin
      WriteLog('ͨ��' + FOPCTunnel.FID + 'ֹͣ����ʧ��,ԭ��:' + e.Message);
    end;
  end;
end;

procedure TFrame1.BtnStartClick(Sender: TObject);
var nStr: string;
begin
  nStr := FCard;
  if not ShowInputBox('������ſ���:', '��ʾ', nStr) then Exit;
  try
    LoadBillItems(nStr);
  except
    on E: Exception do
    begin
      WriteLog('ͨ��' + FOPCTunnel.FID + '��������ʧ��,ԭ��:' + e.Message);
    end;
  end;
end;

procedure TFrame1.SyncReadValues(const FromCache: boolean);
begin

end;

procedure TFrame1.StateTimerTimer(Sender: TObject);
var nInfo: string;
    nList: TStrings;
begin
  StateTimer.Enabled := False;
  StateTimer.Tag := StateTimer.Tag + 1;
  try
    WriteLog('��ȡ��׼���');
    if not ReadBaseWeight(FOPCTunnel.FID, nInfo) then
    begin
      StateTimer.Enabled := True;
      Exit;
    end;
    WriteLog('��׼���:' + nInfo);
    nList := TStringList.Create;
    try
      nList.Text        := nInfo;
      EditMaxValue.Text := nList.Values['ValueMax'];
      EditBill.Text     := nList.Values['Bill'];
      editPValue.Text   := nList.Values['PValue'];
      EditMValue.Text   := nList.Values['MValue'];
      EditValue.Text    := nList.Values['NetValue'];
      editZValue.Text   := nList.Values['Value'];
      EditTruck.Text    := GetTruckInfo(nList.Values['Bill']);
    finally
      nList.Free;
    end;
  except
    on E: Exception do
    begin
      WriteLog(e.Message);
    end;
  end;
  StateTimer.Enabled := True;
end;

procedure TFrame1.DelayTimerTimer(Sender: TObject);
begin
  DelayTimer.Tag := DelayTimer.Tag + 1;
  if DelayTimer.Tag >= 10 then
  begin
    DelayTimer.Enabled := False;
  end;
end;

end.
