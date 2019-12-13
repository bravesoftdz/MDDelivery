{*******************************************************************************
  ����: dmzn@163.com 2012-02-03
  ����: ҵ��������

  ��ע:
  *.����In/Out����,��ô���TBWDataBase������,��λ�ڵ�һ��Ԫ��.
*******************************************************************************}
unit UBusinessConst;

{$I LibFun.Inc}
interface

uses
  Classes, SysUtils, UBusinessPacker, ULibFun, USysDB;

const
  {*channel type*}
  cBus_Channel_Connection     = $0002;
  cBus_Channel_Business       = $0005;

  {*query field define*}
  cQF_Bill                    = $0001;

  {*business command*}
  cBC_GetSerialNO             = $0001;   //��ȡ���б��
  cBC_ServerNow               = $0002;   //��������ǰʱ��
  cBC_IsSystemExpired         = $0003;   //ϵͳ�Ƿ��ѹ���
  cBC_GetCardUsed             = $0004;   //��ȡ��Ƭ����
  cBC_UserLogin               = $0005;   //�û���¼
  cBC_UserLogOut              = $0006;   //�û�ע��
  cBC_VeryTruckLicense        = $1006;   //����ʶ��

  cBC_GetCustomerMoney        = $0010;   //��ȡ�ͻ����ý�
  cBC_GetZhiKaMoney           = $0011;   //��ȡֽ�����ý�
  cBC_GetZhiKaMoneyEx         = $0014;   //��ȡֽ��ʣ�����
  cBC_CustomerHasMoney        = $0012;   //�ͻ��Ƿ������
  cBC_GetCustomerMoneyEx      = $0018;   //�ͻ��Ƿ������

  cBC_SaveTruckInfo           = $0013;   //���泵����Ϣ
  cBC_UpdateTruckInfo         = $0017;   //���泵����Ϣ
  cBC_GetTruckPoundData       = $0015;   //��ȡ������������
  cBC_SaveTruckPoundData      = $0016;   //���泵����������

  cBC_SaveBills               = $0020;   //���潻�����б�
  cBC_DeleteBill              = $0021;   //ɾ��������
  cBC_ModifyBillTruck         = $0022;   //�޸ĳ��ƺ�
  cBC_SaleAdjust              = $0023;   //���۵���
  cBC_SaveBillCard            = $0024;   //�󶨽������ſ�
  cBC_LogoffCard              = $0025;   //ע���ſ�
  cBC_SaveBillLSCard          = $0026;   //�󶨳������۴ſ�
  cBC_LoadSalePlan            = $0027;   //��ȡ���ۼƻ�

  cBC_SaveOrder               = $0040;
  cBC_DeleteOrder             = $0041;
  cBC_SaveOrderCard           = $0042;
  cBC_LogOffOrderCard         = $0043;
  cBC_GetPostOrders           = $0044;   //��ȡ��λ�ɹ���
  cBC_SavePostOrders          = $0045;   //�����λ�ɹ���
  cBC_SaveOrderBase           = $0046;   //����ɹ����뵥
  cBC_DeleteOrderBase         = $0047;   //ɾ���ɹ����뵥
  cBC_GetGYOrderValue         = $0048;   //��ȡ���ջ���

  cBC_GetPostBills            = $0030;   //��ȡ��λ������
  cBC_SavePostBills           = $0031;   //�����λ������
  cBC_MakeSanPreHK            = $0032;   //ִ��ɢװԤ�Ͽ�

  cBC_GetStockBatcodeByCusType= $0052;   //��ȡ���α��
  cBC_ChangeDispatchMode      = $0053;   //�л�����ģʽ
  cBC_GetPoundCard            = $0054;   //��ȡ��վ����
  cBC_GetQueueData            = $0055;   //��ȡ��������
  cBC_PrintCode               = $0056;
  cBC_PrintFixCode            = $0057;   //����
  cBC_PrinterEnable           = $0058;   //�������ͣ
  cBC_GetStockBatcode         = $0059;   //��ȡ���α��

  cBC_JSStart                 = $0060;
  cBC_JSStop                  = $0061;
  cBC_JSPause                 = $0062;
  cBC_JSGetStatus             = $0063;
  cBC_SaveCountData           = $0064;   //����������
  cBC_RemoteExecSQL           = $0065;

  cBC_ShowLedTxt              = $0066;   //��led��Ļ��������
  cBC_GetLimitValue           = $0067;   //��ȡ�����������ֵ
  cBC_LineClose               = $0068;   //�رշŻ�

  cBC_IsTunnelOK              = $0075;
  cBC_TunnelOC                = $0076;
  cBC_PlayVoice               = $0077;
  cBC_OpenDoorByReader        = $0078;
  cBC_ShowTxt                 = $0079;   //����:����С��

  cBC_SyncCustomer            = $0080;   //Զ��ͬ���ͻ�
  cBC_SyncSaleMan             = $0081;   //Զ��ͬ��ҵ��Ա
  cBC_SyncStockBill           = $0082;   //ͬ�����ݵ�Զ��
  cBC_CheckStockValid         = $0083;   //��֤�Ƿ���������
  cBC_SyncStockOrder          = $0084;   //ͬ���ɹ����ݵ�Զ��
  cBC_SyncProvider            = $0085;   //Զ��ͬ����Ӧ��
  cBC_SyncMaterails           = $0086;   //Զ��ͬ��ԭ����

  cBC_SaveGrabCard            = $0090;   //����ץ����ˢ����Ϣ
  cBC_SaveStockKuWei          = $0091;   //��������������λ��Ϣ

  cBC_GetWebOrderByCard       = $0112;   //ͨ������ȡ΢�Ŷ���

  cBC_SaveBusinessCard        = $0136;   //���浱ǰˢ����Ϣ

  cBC_GetUnLoadingPlace       = $0139;   //��ȡж���ص�
  cBC_GetSendingPlace         = $0140;   //��ȡ�����ص�
  cBC_GetPOrderBase           = $0141;   //��ȡ�ɹ����뵥

  cBC_GetLoginToken          =  $0601;   //���ŵ�¼�ӿ�
  cBC_GetDepotInfo           =  $0602;   //��ȡ���Ų��ŵ���
  cBC_GetUserInfo            =  $0603;   //��ȡ������Ա����
  cBC_GetCusProInfo          =  $0604;   //��ȡ���ſ��̵���
  cBC_GetStockType           =  $0605;   //��ȡ���Ŵ������
  cBC_GetStockInfo           =  $0606;   //��ȡ���Ŵ������
  cBC_GetOrderInfo           =  $0607;   //��ȡ���Ųɹ�������Ϣ
  cBC_GetOrderPound          =  $0608;   //��ȡ���Ųɹ������ӿ�
  cBC_GetSaleInfo            =  $0609;   //��ȡ�������۶�����Ϣ
  cBC_GetSalePound           =  $0610;   //��ȡ�������۰����ӿ�
  cBC_GetHYInfo              =  $0611;   //��ȡ�����ʼ���Ϣ

  //cBC_GetYSRules              = $0612;   //��ȡԭ�������չ���
  //cBC_SaveWlbYs               = $0613;   //������������������
  //cBC_GetWlbYsStatus          = $0614;   //��ȡ���������ս��
  cBC_GetYSRules              = $1001;   //��ȡԭ�������չ���
  cBC_SaveWlbYs               = $1002;   //������������������
  cBC_GetWlbYsStatus          = $1003;   //��ȡ���������ս��
  cBC_GetReaderCard           = $0615;   //��������Ч��

  cBC_SaveTruckLine           = $9090;   //����װ������Ϣ


  cBC_WX_VerifPrintCode       = $0501;   //΢�ţ���֤������Ϣ
  cBC_WX_WaitingForloading    = $0502;   //΢�ţ�������װ��ѯ
  cBC_WX_BillSurplusTonnage   = $0503;   //΢�ţ����϶������µ�������ѯ
  cBC_WX_GetOrderInfo         = $0504;   //΢�ţ���ȡ������Ϣ
  cBC_WX_GetOrderList         = $0505;   //΢�ţ���ȡ�����б�
  cBC_WX_GetPurchaseContract  = $0506;   //΢�ţ���ȡ�ɹ���ͬ�б�

  cBC_WX_getCustomerInfo      = $0507;   //΢�ţ���ȡ�ͻ�ע����Ϣ
  cBC_WX_get_Bindfunc         = $0508;   //΢�ţ��ͻ���΢���˺Ű�
  cBC_WX_send_event_msg       = $0509;   //΢�ţ�������Ϣ
  cBC_WX_edit_shopclients     = $0510;   //΢�ţ������̳��û�
  cBC_WX_edit_shopgoods       = $0511;   //΢�ţ�������Ʒ
  cBC_WX_get_shoporders       = $0512;   //΢�ţ���ȡ������Ϣ
  cBC_WX_complete_shoporders  = $0513;   //΢�ţ��޸Ķ���״̬
  cBC_WX_get_shoporderbyNO    = $0514;   //΢�ţ����ݶ����Ż�ȡ������Ϣ
  cBC_WX_get_shopPurchasebyNO = $0515;   //΢�ţ����ݶ����Ż�ȡ������Ϣ
  cBC_WX_ModifyWebOrderStatus = $0516;   //΢�ţ��޸����϶���״̬
  cBC_WX_CreatLadingOrder     = $0517;   //΢�ţ�����������
  cBC_WX_GetCusMoney          = $0518;   //΢�ţ���ȡ�ͻ��ʽ�
  cBC_WX_GetInOutFactoryTotal = $0519;   //΢�ţ���ȡ������ͳ��
  cBC_WX_GetAuditTruck        = $0520;   //΢�ţ���ȡ��˳���
  cBC_WX_UpLoadAuditTruck     = $0521;   //΢�ţ���˳�������ϴ�
  cBC_WX_DownLoadPic          = $0522;   //΢�ţ�����ͼƬ
  cBC_WX_get_shoporderbyTruck = $0523;   //΢�ţ����ݳ��ƺŻ�ȡ������Ϣ
  cBC_WX_get_shoporderbyTruckClt = $0524;   //΢�ţ����ݳ��ƺŻ�ȡ������Ϣ  �ͻ�����
  cBC_WX_get_shoporderStatus  = $0525;   //΢�ţ����ݶ����Ż�ȡ����״̬
  cBC_WX_get_shopYYWebBill    = $0526;   //΢�ţ�����ʱ��λ�ȡԤԼ����
  cBC_WX_get_syncYYWebState   = $0527;   //΢�ţ�����ԤԼ������Ϣ״̬
  cBC_WX_SaveCustomerWxOrders = $0529;   //΢�ţ������ͻ�Ԥ����
  cBC_WX_QueryByCar           = $0534;   //΢�ţ���ѯ����״̬
  cBC_WX_IsCanCreateWXOrder   = $0531;   //΢�ţ��µ�У��
type
  PWorkerQueryFieldData = ^TWorkerQueryFieldData;
  TWorkerQueryFieldData = record
    FBase     : TBWDataBase;
    FType     : Integer;           //����
    FData     : string;            //����
  end;

  PWorkerBusinessCommand = ^TWorkerBusinessCommand;
  TWorkerBusinessCommand = record
    FBase     : TBWDataBase;
    FCommand  : Integer;           //����
    FData     : string;            //����
    FExtParam : string;            //����
  end;

  TPoundStationData = record
    FStation  : string;            //��վ��ʶ
    FValue    : Double;           //Ƥ��
    FDate     : TDateTime;        //��������
    FOperator : string;           //����Ա
  end;

  PLadingBillItem = ^TLadingBillItem;
  TLadingBillItem = record
    FID         : string;          //��������
    FZhiKa      : string;          //ֽ�����
    FCusID      : string;          //�ͻ����
    FCusName    : string;          //�ͻ�����
    FTruck      : string;          //���ƺ���

    FType       : string;          //Ʒ������
    FStockNo    : string;          //Ʒ�ֱ��
    FStockName  : string;          //Ʒ������
    FValue      : Double;          //�����
    FPrice      : Double;          //�������

    FCard       : string;          //�ſ���
    FIsVIP      : string;          //ͨ������
    FStatus     : string;          //��ǰ״̬
    FNextStatus : string;          //��һ״̬

    FPData      : TPoundStationData; //��Ƥ
    FMData      : TPoundStationData; //��ë
    FFactory    : string;          //�������
    FPModel     : string;          //����ģʽ
    FPType      : string;          //ҵ������
    FPoundID    : string;          //���ؼ�¼
    FSelected   : Boolean;         //ѡ��״̬

    FHKRecord   : string;          //�ϵ���¼(����)ж���ص�(�ɹ�)
    FYSValid    : string;          //���ս����Y���ճɹ���N���գ�
    FKZValue    : Double;          //��Ӧ�۳�
    FPrintHY    : Boolean;         //��ӡ���鵥
    FHYDan      : string;          //���鵥��
    FMemo       : string;          //������ע
    FLadeTime   : string;          //���ʱ��

    FPrePData   : string;          //Ԥ��Ƥ��
    FIsNei      : string;          //���ڵ���
    FCusType    : string;          //�ͻ�����
    FUPlace     : string;          //ж���ص�
    FSPlace     : string;          //�����ص�
    FNewOrder   : string;          //�����뵥
    FSerialNo   : string;          //��¼���
    FKD         : string;          //ж���ص�
  end;

  TLadingBillItems = array of TLadingBillItem;
  //�������б�

  PWorkerWebChatData = ^TWorkerWebChatData;
  TWorkerWebChatData = record
    FBase     : TBWDataBase;
    FCommand  : Integer;           //����
    FData     : string;            //����
    FExtParam : string;            //����
    FRemoteUL : string;            //����������UL
  end;

procedure AnalyseBillItems(const nData: string; var nItems: TLadingBillItems);
//������ҵ����󷵻صĽ���������
function CombineBillItmes(const nItems: TLadingBillItems): string;
//�ϲ�����������Ϊҵ������ܴ������ַ���

resourcestring
  {*PBWDataBase.FParam*}
  sParam_NoHintOnError        = 'NHE';                  //����ʾ����

  {*plug module id*}
  sPlug_ModuleBus             = '{DF261765-48DC-411D-B6F2-0B37B14E014E}';
                                                        //ҵ��ģ��
  sPlug_ModuleHD              = '{B584DCD6-40E5-413C-B9F3-6DD75AEF1C62}';
                                                        //Ӳ���ػ�
  sPlug_ModuleRemote          = '{B584DCD7-40E5-413C-B9F3-6DD75AEF1C63}';
                                                        //MIT�������                                                                                                   
  {*common function*}  
  sSys_BasePacker             = 'Sys_BasePacker';       //���������

  {*business mit function name*}
  sBus_ServiceStatus          = 'Bus_ServiceStatus';    //����״̬
  sBus_GetQueryField          = 'Bus_GetQueryField';    //��ѯ���ֶ�

  sBus_BusinessSaleBill       = 'Bus_BusinessSaleBill'; //���������
  sBus_BusinessCommand        = 'Bus_BusinessCommand';  //ҵ��ָ��
  sBus_HardwareCommand        = 'Bus_HardwareCommand';  //Ӳ��ָ��
  sBus_BusinessWebchat        = 'Bus_BusinessWebchat';  //Webƽ̨����
  sBus_BusinessPurchaseOrder  = 'Bus_BusinessPurchaseOrder'; //�ɹ������

  {*client function name*}
  sCLI_ServiceStatus          = 'CLI_ServiceStatus';    //����״̬
  sCLI_GetQueryField          = 'CLI_GetQueryField';    //��ѯ���ֶ�

  sCLI_BusinessSaleBill       = 'CLI_BusinessSaleBill'; //������ҵ��
  sCLI_BusinessCommand        = 'CLI_BusinessCommand';  //ҵ��ָ��
  sCLI_HardwareCommand        = 'CLI_HardwareCommand';  //Ӳ��ָ��
  sCLI_BusinessWebchat        = 'CLI_BusinessWebchat';  //Webƽ̨����
  sCLI_BusinessPurchaseOrder  = 'CLI_BusinessPurchaseOrder'; //�ɹ������

  sCLI_BusinessDuanDao        = 'CLI_BusinessDuanDao';  //�̵�ҵ�����
  sBus_BusinessDuanDao        = 'Bus_BusinessDuanDao';  //�̵�ҵ�����

implementation

//Date: 2014-09-17
//Parm: ����������;�������
//Desc: ����nDataΪ�ṹ���б�����
procedure AnalyseBillItems(const nData: string; var nItems: TLadingBillItems);
var nStr: string;
    nIdx,nInt: Integer;
    nListA,nListB: TStrings;
begin
  nListA := TStringList.Create;
  nListB := TStringList.Create;
  try
    nListA.Text := PackerDecodeStr(nData);
    //bill list
    nInt := 0;
    SetLength(nItems, nListA.Count);

    for nIdx:=0 to nListA.Count - 1 do
    begin
      nListB.Text := PackerDecodeStr(nListA[nIdx]);
      //bill item

      with nListB,nItems[nInt]
      {$IFDEF XE.LibFun},TDateTimeHelper,TStringHelper{$ENDIF} do
      begin
        FID         := Values['ID'];
        FZhiKa      := Values['ZhiKa'];
        FCusID      := Values['CusID'];
        FCusName    := Values['CusName'];
        FTruck      := Values['Truck'];

        FType       := Values['Type'];
        FStockNo    := Values['StockNo'];
        FStockName  := Values['StockName'];
        FKD         := Values['KD'];

        FCard       := Values['Card'];
        FIsVIP      := Values['IsVIP'];
        FStatus     := Values['Status'];
        FNextStatus := Values['NextStatus'];

        FFactory    := Values['Factory'];
        FPModel     := Values['PModel'];
        FPType      := Values['PType'];
        FPoundID    := Values['PoundID'];
        FSelected   := Values['Selected'] = sFlag_Yes;

        with FPData do
        begin
          FStation  := Values['PStation'];
          FDate     := Str2DateTime(Values['PDate']);
          FOperator := Values['PMan'];

          nStr := Trim(Values['PValue']);
          if (nStr <> '') and IsNumber(nStr, True) then
               FPData.FValue := StrToFloat(nStr)
          else FPData.FValue := 0;
        end;

        with FMData do
        begin
          FStation  := Values['MStation'];
          FDate     := Str2DateTime(Values['MDate']);
          FOperator := Values['MMan'];

          nStr := Trim(Values['MValue']);
          if (nStr <> '') and IsNumber(nStr, True) then
               FMData.FValue := StrToFloat(nStr)
          else FMData.FValue := 0;
        end;

        nStr := Trim(Values['Value']);
        if (nStr <> '') and IsNumber(nStr, True) then
             FValue := StrToFloat(nStr)
        else FValue := 0;

        nStr := Trim(Values['Price']);
        if (nStr <> '') and IsNumber(nStr, True) then
             FPrice := StrToFloat(nStr)
        else FPrice := 0;

        nStr := Trim(Values['KZValue']);
        if (nStr <> '') and IsNumber(nStr, True) then
             FKZValue := StrToFloat(nStr)
        else FKZValue := 0;

        FYSValid := Values['YSValid'];
        FHKRecord:= Values['HKRecord'];
        FPrintHY := Values['PrintHY'] = sFlag_Yes;
        FHYDan   := Values['HYDan'];
        FMemo    := Values['Memo'];
        FSerialNo:= Values['SerialNo'];
        FLadeTime:= Values['LadeTime'];
        FCusType := Values['CusType'];
        FUPlace  := Values['UPlace'];
        FSPlace  := Values['SPlace'];
        FNewOrder:= Values['NewOrder'];
      end;

      Inc(nInt);
    end;
  finally
    nListB.Free;
    nListA.Free;
  end;
end;

//Date: 2014-09-18
//Parm: �������б�
//Desc: ��nItems�ϲ�Ϊҵ������ܴ�����
function CombineBillItmes(const nItems: TLadingBillItems): string;
var nIdx: Integer;
    nListA,nListB: TStrings;
begin
  nListA := TStringList.Create;
  nListB := TStringList.Create;
  try
    Result := '';
    nListA.Clear;
    nListB.Clear;

    for nIdx:=Low(nItems) to High(nItems) do
    with nItems[nIdx]
    {$IFDEF XE.LibFun},TDateTimeHelper,TStringHelper{$ENDIF} do
    begin
      if not FSelected then Continue;
      //ignored

      with nListB do
      begin
        Values['ID']         := FID;
        Values['ZhiKa']      := FZhiKa;
        Values['CusID']      := FCusID;
        Values['CusName']    := FCusName;
        Values['Truck']      := FTruck;

        Values['Type']       := FType;
        Values['StockNo']    := FStockNo;
        Values['StockName']  := FStockName;
        Values['KD']         := FKD;
        Values['Value']      := FloatToStr(FValue);
        Values['Price']      := FloatToStr(FPrice);

        Values['Card']       := FCard;
        Values['IsVIP']      := FIsVIP;
        Values['Status']     := FStatus;
        Values['NextStatus'] := FNextStatus;

        Values['Factory']    := FFactory;
        Values['PModel']     := FPModel;
        Values['PType']      := FPType;
        Values['PoundID']    := FPoundID;
        Values['CusType']    := FCusType;

        with FPData do
        begin
          Values['PStation'] := FStation;
          Values['PValue']   := FloatToStr(FPData.FValue);
          Values['PDate']    := DateTime2Str(FDate);
          Values['PMan']     := FOperator;
        end;

        with FMData do
        begin
          Values['MStation'] := FStation;
          Values['MValue']   := FloatToStr(FMData.FValue);
          Values['MDate']    := DateTime2Str(FDate);
          Values['MMan']     := FOperator;
        end;

        if FSelected then
             Values['Selected'] := sFlag_Yes
        else Values['Selected'] := sFlag_No;

        Values['KZValue']    := FloatToStr(FKZValue);
        Values['YSValid']    := FYSValid;
        Values['Memo']       := FMemo;
        Values['HKRecord']   := FHKRecord;
        Values['SerialNo']   := FSerialNo;

        if FPrintHY then
             Values['PrintHY'] := sFlag_Yes
        else Values['PrintHY'] := sFlag_No;
        Values['HYDan']    := FHYDan;
        Values['LadeTime'] := FLadeTime;
        Values['UPlace'] := FUPlace;
        Values['SPlace'] := FSPlace;
        Values['NewOrder']   := FNewOrder;
      end;

      nListA.Add(PackerEncodeStr(nListB.Text));
      //add bill
    end;

    Result := PackerEncodeStr(nListA.Text);
    //pack all
  finally
    nListB.Free;
    nListA.Free;
  end;
end;

end.

