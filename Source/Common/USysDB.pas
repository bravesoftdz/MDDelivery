{*******************************************************************************
  作者: dmzn@163.com 2008-08-07
  描述: 系统数据库常量定义

  备注:
  *.自动创建SQL语句,支持变量:$Inc,自增;$Float,浮点;$Integer=sFlag_Integer;
    $Decimal=sFlag_Decimal;$Image,二进制流
*******************************************************************************}
unit USysDB;

{$I Link.inc}
interface

uses
  SysUtils, Classes;

const
  cSysDatabaseName: array[0..4] of String = (
     'Access', 'SQL', 'MySQL', 'Oracle', 'DB2');
  //db names

  cPrecision            = 100;
  {-----------------------------------------------------------------------------
   描述: 计算精度
   *.重量为吨的计算中,小数值比较或者相减运算时会有误差,所以会先放大,去掉
     小数位后按照整数计算.放大倍数由精度值确定.
  -----------------------------------------------------------------------------}

type
  TSysDatabaseType = (dtAccess, dtSQLServer, dtMySQL, dtOracle, dtDB2);
  //db types

  PSysTableItem = ^TSysTableItem;
  TSysTableItem = record
    FTable: string;
    FNewSQL: string;
  end;
  //系统表项

var
  gSysTableList: TList = nil;                        //系统表数组
  gSysDBType: TSysDatabaseType = dtSQLServer;        //系统数据类型

//------------------------------------------------------------------------------
const
  //自增字段
  sField_Access_AutoInc          = 'Counter';
  sField_SQLServer_AutoInc       = 'Integer IDENTITY (1,1) PRIMARY KEY';

  //小数字段
  sField_Access_Decimal          = 'Float';
  sField_SQLServer_Decimal       = 'Decimal(15, 5)';

  //图片字段
  sField_Access_Image            = 'OLEObject';
  sField_SQLServer_Image         = 'Image';

  //日期相关
  sField_SQLServer_Now           = 'getDate()';

  {*权限项*}
  sPopedom_Read       = 'A';                         //浏览
  sPopedom_Add        = 'B';                         //添加
  sPopedom_Edit       = 'C';                         //修改
  sPopedom_Delete     = 'D';                         //删除
  sPopedom_Preview    = 'E';                         //预览
  sPopedom_Print      = 'F';                         //打印
  sPopedom_Export     = 'G';                         //导出
  sPopedom_ViewPrice  = 'H';                         //查看单价

  {*数据库标识*}
  sFlag_DB_K3         = 'King_K3';                   //金蝶数据库
  sFlag_DB_NC         = 'YonYou_NC';                 //用友数据库
  sFlag_BakDB         = 'BakDB';                     //备用数据库

  {*相关标记*}
  sFlag_Yes           = 'Y';                         //是
  sFlag_No            = 'N';                         //否
  sFlag_Unknow        = 'U';                         //未知 
  sFlag_Enabled       = 'Y';                         //启用
  sFlag_Disabled      = 'N';                         //禁用

  sFlag_Integer       = 'I';                         //整数
  sFlag_Decimal       = 'D';                         //小数

  sFlag_ManualNo      = '%';                         //手动指定(非系统自动)
  sFlag_NotMatter     = '@';                         //无关编号(任意编号都可)
  sFlag_ForceDone     = '#';                         //强制完成(未完成前不换)
  sFlag_FixedNo       = '$';                         //指定编号(使用相同编号)

  sFlag_Provide       = 'P';                         //供应
  sFlag_Sale          = 'S';                         //销售
  sFlag_Returns       = 'R';                         //退货
  sFlag_Other         = 'O';                         //其它
  sFlag_Mul           = 'M';                         //多物料过磅
  sFlag_Tx            = 'T';                         //通行
  
  sFlag_TiHuo         = 'T';                         //自提
  sFlag_SongH         = 'S';                         //送货
  sFlag_XieH          = 'X';                         //运卸

  sFlag_Dai           = 'D';                         //袋装水泥
  sFlag_San           = 'S';                         //散装水泥

  sFlag_BillNew       = 'N';                         //新单
  sFlag_BillEdit      = 'E';                         //修改
  sFlag_BillDel       = 'D';                         //删除
  sFlag_BillLading    = 'L';                         //提货中
  sFlag_BillPick      = 'P';                         //拣配
  sFlag_BillPost      = 'G';                         //过账
  sFlag_BillDone      = 'O';                         //完成

  sFlag_OrderNew       = 'N';                        //新单
  sFlag_OrderEdit      = 'E';                        //修改
  sFlag_OrderDel       = 'D';                        //删除
  sFlag_OrderPuring    = 'L';                        //送货中
  sFlag_OrderDone      = 'O';                        //完成
  sFlag_OrderAbort     = 'A';                        //废弃
  sFlag_OrderStop      = 'S';                        //终止

  sFlag_OrderCardL     = 'L';                        //临时
  sFlag_OrderCardG     = 'G';                        //固定

  sFlag_TypeShip      = 'S';                         //船运
  sFlag_TypeZT        = 'Z';                         //栈台
  sFlag_TypeVIP       = 'V';                         //VIP
  sFlag_TypeCommon    = 'C';                         //普通,订单类型

  sFlag_CardIdle      = 'I';                         //空闲卡
  sFlag_CardUsed      = 'U';                         //使用中
  sFlag_CardLoss      = 'L';                         //挂失卡
  sFlag_CardInvalid   = 'N';                         //注销卡

  sFlag_TruckNone     = 'N';                         //无状态车辆
  sFlag_TruckIn       = 'I';                         //进厂车辆
  sFlag_TruckOut      = 'O';                         //出厂车辆
  sFlag_TruckBFP      = 'P';                         //磅房皮重车辆
  sFlag_TruckBFM      = 'M';                         //磅房毛重车辆
  sFlag_TruckSH       = 'S';                         //送货车辆
  sFlag_TruckFH       = 'F';                         //放灰车辆
  sFlag_TruckZT       = 'Z';                         //栈台车辆
  sFlag_TruckXH       = 'X';                         //验收车辆

  sFlag_TJNone        = 'N';                         //未调价
  sFlag_TJing         = 'T';                         //调价中
  sFlag_TJOver        = 'O';                         //调价完成

  sFlag_PoundBZ       = 'B';                         //标准
  sFlag_PoundPZ       = 'Z';                         //皮重
  sFlag_PoundPD       = 'P';                         //配对
  sFlag_PoundCC       = 'C';                         //出厂(过磅模式)
  sFlag_PoundLS       = 'L';                         //临时

  sFlag_MoneyHuiKuan  = 'R';                         //回款入金
  sFlag_MoneyJiaCha   = 'C';                         //补缴价差
  sFlag_MoneyZhiKa    = 'Z';                         //纸卡回款
  sFlag_MoneyFanHuan  = 'H';                         //返还用户

  sFlag_InvNormal     = 'N';                         //正常发票
  sFlag_InvHasUsed    = 'U';                         //已用发票
  sFlag_InvInvalid    = 'V';                         //作废发票
  sFlag_InvRequst     = 'R';                         //申请开出
  sFlag_InvDaily      = 'D';                         //日常开出

  sFlag_ManualA       = 'A';                         //皮重预警(错误事件类型)
  sFlag_ManualB       = 'B';                         //皮重超出范围
  sFlag_ManualC       = 'C';                         //净重超出误差范围
  sFlag_ManualD       = 'D';                         //空车出厂
  sFlag_ManualE       = 'E';                         //车牌识别
  sFlag_ManualF       = 'F';                         //毛重超出范围

  sFlag_FactoryID     = 'FactoryID';                 //工厂编号
  sFlag_SysParam      = 'SysParam';                  //系统参数
  sFlag_EnableBakdb   = 'Uses_BackDB';               //备用库
  sFlag_ValidDate     = 'SysValidDate';              //有效期
  sFlag_ZhiKaVerify   = 'ZhiKaVerify';               //纸卡审核
  sFlag_PrintZK       = 'PrintZK';                   //打印纸卡
  sFlag_PrintBill     = 'PrintStockBill';            //需打印订单
  sFlag_ViaBillCard   = 'ViaBillCard';               //直接制卡
  sFlag_PayCredit     = 'Pay_Credit';                //回款冲信用
  sFlag_CreditVerify  = 'CreditVerify';              //信用审核
  sFlag_SettleValid   = 'SettleValid';               //结算有效期
  sFlag_HYValue       = 'HYMaxValue';                //化验批次量
  sFlag_SaleManDept   = 'SaleManDepartment';         //业务员部门编号
  sFlag_VerifyFQValue = 'VerifyFQValue';             //禁止封签号超发
  sFlag_VerifyTruckP  = 'VerifyTruckP';              //校验预置皮重
  sFlag_AutoPurchaseID= 'AutoPurchaseID';            //是否自动生成原材料编号
  sFlag_AutoProviderID= 'AutoProviderID';            //是否自动生成供应商编号
  sFlag_BLMoney       = 'BLMoney';                   //客户保留资金

  sFlag_WXFactory     = 'WXFactoryID';               //微信标识
  sFlag_WXServiceMIT  = 'WXServiceMIT';              //微信工厂服务
  sFlag_WXSrvRemote   = 'WXServiceRemote';           //微信远程服务
  sFlag_Rq_WXUrl      = 'WXRqUrl';                   //请求微信网址
  sFlag_Rq_WXPicUrl   = 'WXRqPicUrl';                //请求微信图片地址

  sFlag_YY_OverTime   = 'YYOverTime';                //预约成功超时时间

  sFlag_VIPManyNum      = 'VIPManyNum';              //提单量到量进VIP道
  sFlag_EnableTruck     = 'EnableTruck';             //是否启用车牌识别
  sFlag_TruckInNeedManu = 'TruckInNeedManu';         //车牌识别需要人工干预
  sFlag_InAndBill       = 'InFactAndBill';           //进厂开单间隔

  sFlag_PDaiWuChaZ    = 'PoundDaiWuChaZ';            //袋装正误差
  sFlag_PDaiWuChaF    = 'PoundDaiWuChaF';            //袋装负误差
  sFlag_PDaiPercent   = 'PoundDaiPercent';           //按比例计算误差
  sFlag_PDaiWuChaStop = 'PoundDaiWuChaStop';         //误差时停止业务
  sFlag_PSanWuChaF    = 'PoundSanWuChaF';            //散装负误差
  sFlag_PoundWuCha    = 'PoundWuCha';                //过磅误差分组
  sFlag_PoundIfDai    = 'PoundIFDai';                //袋装是否过磅
  sFlag_NFStock       = 'NoFaHuoStock';              //现场无需发货
  sFlag_StrictSanVal  = 'StrictSanVal';              //严格控制散装超发
  sFlag_PEmpTWuCha    = 'EmpTruckWuCha';             //空车出厂误差

  sFlag_JsWc          = 'PoundJSWc';                 //采购拒收误差
  sFlag_HYPrintCount  = 'HYPrintMaxCount';           //化验单最大打印次数

  sFlag_CommonItem    = 'CommonItem';                //公共信息
  sFlag_CardItem      = 'CardItem';                  //磁卡信息项
  sFlag_AreaItem      = 'AreaItem';                  //区域信息项
  sFlag_TruckItem     = 'TruckItem';                 //车辆信息项
  sFlag_CustomerItem  = 'CustomerItem';              //客户信息项
  sFlag_BankItem      = 'BankItem';                  //银行信息项
  sFlag_UserLogItem   = 'UserLogItem';               //用户登录项

  sFlag_StockItem     = 'StockItem';                 //水泥信息项
  sFlag_ContractItem  = 'ContractItem';              //合同信息项
  sFlag_SalesmanItem  = 'SalesmanItem';              //业务员信息项
  sFlag_ZhiKaItem     = 'ZhiKaItem';                 //纸卡信息项
  sFlag_BillItem      = 'BillItem';                  //提单信息项
  sFlag_TruckQueue    = 'TruckQueue';                //车辆队列

  sFlag_PaymentItem   = 'PaymentItem';               //付款方式信息项
  sFlag_PaymentItem2  = 'PaymentItem2';              //销售回款信息项
  sFlag_LadingItem    = 'LadingItem';                //提货方式信息项
  sFlag_OrderItem     = 'OrderItem';                 //采购订单信息项

  sFlag_ProviderItem  = 'ProviderItem';              //供应商信息项
  sFlag_MaterailsItem = 'MaterailsItem';             //原材料信息项

  sFlag_ZDLineItem    = 'ZDLINEItem';                //指定通道信息项

  sFlag_HardSrvURL    = 'HardMonURL';
  sFlag_MITSrvURL     = 'MITServiceURL';             //服务地址

  sFlag_AutoIn        = 'Truck_AutoIn';              //自动进厂
  sFlag_AutoOut       = 'Truck_AutoOut';             //自动出厂
  sFlag_InTimeout     = 'InFactTimeOut';             //进厂超时(队列)
  sFlag_SanMultiBill  = 'SanMultiBill';              //散装预开多单
  sFlag_NoDaiQueue    = 'NoDaiQueue';                //袋装禁用队列
  sFlag_NoSanQueue    = 'NoSanQueue';                //散装禁用队列
  sFlag_DelayQueue    = 'DelayQueue';                //延迟排队(厂内)
  sFlag_PoundQueue    = 'PoundQueue';                //延迟排队(厂内依据过皮时间)
  sFlag_NetPlayVoice  = 'NetPlayVoice';              //使用网络语音播发
  sFlag_BatchAuto     = 'BatchAuto';                 //使用自动批次号
  sFlag_FobiddenInMul = 'FobiddenInMul';             //禁止多次进厂
  sFlag_StockKuWei    = 'StockKuWei';                //物料库位
  sFlag_CustomerType  = 'CustomerType';              //客户分类

  sFlag_HYReportName  = 'HYReportName';              //化验单报表名称

  sFlag_BusGroup      = 'BusFunction';               //业务编码组
  sFlag_BillNo        = 'Bus_Bill';                  //交货单号
  sFlag_PoundID       = 'Bus_Pound';                 //称重记录
  sFlag_Customer      = 'Bus_Customer';              //客户编号
  sFlag_SaleMan       = 'Bus_SaleMan';               //业务员编号
  sFlag_Contract      = 'Bus_Contract';              //合同编号
  sFlag_ZhiKa         = 'Bus_ZhiKa';                 //纸卡编号
  sFlag_Purchase      = 'Bus_Purchase';              //原材料编号
  sFlag_Provider      = 'Bus_Provider';              //供应商编号
  sFlag_InvWeek       = 'Bus_InvoiceWeek';           //结算周期
  sFlag_WeiXin        = 'Bus_WeiXin';                //微信映射编号
  sFlag_HYDan         = 'Bus_HYDan';                 //化验单号
  sFlag_ForceHint     = 'Bus_HintMsg';               //强制提示
  sFlag_Order         = 'Bus_Order';                 //采购单号
  sFlag_OrderDtl      = 'Bus_OrderDtl';              //采购单号
  sFlag_OrderBase     = 'Bus_OrderBase';             //采购申请单号
  sFlag_Grab          = 'Bus_Grab';                  //抓斗称单据号
  sFlag_VerifiyCard   = 'VerifiyCard';               //取卡校验

  sFlag_Departments   = 'Departments';               //部门列表
  sFlag_DepDaTing     = '大厅';                      //服务大厅
  sFlag_DepJianZhuang = '监装';                      //监装
  sFlag_DepBangFang   = '磅房';                      //磅房
  sFlag_DepHuaYan     = '化验室';                    //化验室
  sFlag_DepXiaoShou   = '销售';                      //销售部
  sFlag_DepKaiPiao    = '开票';                      //开票室
  sFlag_DepCaiWu      = '财务';                      //财务室
  sFlag_DepBangFang1  = '1号磅';                     //1号磅

  sFlag_Solution_YN   = 'Y=通过;N=禁止';
  sFlag_Solution_YNI  = 'Y=通过;N=禁止;I=忽略';
  sFlag_Solution_OK   = 'O=知道了';

  sFlag_LSStock       = 'ls-sn-00';                  //零售水泥编号(预开)
  sFlag_LSCustomer    = 'ls-kh-00';                  //零售客户编号(预开)

  sFlag_WxItem        = 'WxItem';                    //微信相关
  sFlag_InOutBegin    = 'BeginTime';                 //进出厂查询起始时间
  sFlag_InOutEnd      = 'EndTime';                   //进出厂查询结束时间
  sFlag_SealCount     = 'SealCount';                 //铅封录入个数
  sFlag_NoSealStock   = 'NoSealStock';               //无需录入铅封

  sFlag_DefaultPValue = 'DefaultPValue';             //默认皮重
  sFlag_PValueWuCha   = 'PValueWuCha';               //皮重误差范围

  sFlag_DuanDao       = 'D';                         //短倒(First=>Second)
  sFlag_Transfer      = 'Bus_Transfer';              //短倒单号
  sFlag_TransBase     = 'Bus_TransBase';             //短倒申请单号
  sFlag_TransferPound = 'TransferPound';             //短倒是否过磅
  sFlag_PMaterailControl= 'PMaterailControl';        //原材料进厂总控制
  sFlag_SCustomerControl= 'SCustomerControl';        //销售量总控制
  sFlag_Between2BillsTime = 30;                      //同一车开单间隔，单位：分钟
  sFlag_SCTime        = 'SaleControlTime';           //销售日发货量总控制时间段

  sFlag_HYSGroup      = 'HYSGroup';                  //化验室组
  sFlag_WLBGroup      = 'WLBGroup';                  //化验室组
  sFlag_PeerWeight    = 'PeerWeight';                //每袋重量
  sFlag_AutoAudit     = 'AutoAudit';                 //数据上传金蝶自动审核
  sFlag_DataView      = 'DataView';                  //数据处理区间
  sFlag_VefyWebOrder  = 'VefyWebOrder';              //申请单进行金额校验
  sFlag_WebOrderLoss  = 'WebOrderLoss';              //申请单自动失效

  {*数据表*}
  sTable_Group        = 'Sys_Group';                 //用户组
  sTable_User         = 'Sys_User';                  //用户表
  sTable_Menu         = 'Sys_Menu';                  //菜单表
  sTable_Popedom      = 'Sys_Popedom';               //权限表
  sTable_PopItem      = 'Sys_PopItem';               //权限项
  sTable_Entity       = 'Sys_Entity';                //字典实体
  sTable_DictItem     = 'Sys_DataDict';              //字典明细

  sTable_SysDict      = 'Sys_Dict';                  //系统字典
  sTable_ExtInfo      = 'Sys_ExtInfo';               //附加信息
  sTable_SysLog       = 'Sys_EventLog';              //系统日志
  sTable_BaseInfo     = 'Sys_BaseInfo';              //基础信息
  sTable_SerialBase   = 'Sys_SerialBase';            //编码种子
  sTable_SerialStatus = 'Sys_SerialStatus';          //编号状态
  sTable_WorkePC      = 'Sys_WorkePC';               //验证授权
  sTable_Factorys     = 'Sys_Factorys';              //工厂列表
  sTable_ManualEvent  = 'Sys_ManualEvent';           //人工干预
  
  sTable_Customer     = 'S_Customer';                //客户信息
  sTable_Salesman     = 'S_Salesman';                //业务人员
  sTable_SaleContract = 'S_Contract';                //销售合同
  sTable_SContractExt = 'S_ContractExt';             //合同扩展

  sTable_ZhiKa        = 'S_ZhiKa';                   //纸卡数据
  sTable_ZhiKaDtl     = 'S_ZhiKaDtl';                //纸卡明细
  sTable_PriceRule    = 'S_PriceRule';               //价格规则
  sTable_Card         = 'S_Card';                    //销售磁卡
  sTable_Bill         = 'S_Bill';                    //提货单
  sTable_BillBak      = 'S_BillBak';                 //已删交货单
  sTable_BillHK       = 'S_BillPreHK';               //开单预合卡
  sTable_XHSpot       = 'S_XHSpot';                  //卸货地点维护
  sTable_KDInfo       = 'S_KDInfo';                  //矿点维护
  sTable_DriverWh     = 'S_DriverWh';                //司机信息维护
  sTable_YYWebBill    = 'S_YYWebBill';                //网上预约订单

  sTable_StockMatch   = 'S_StockMatch';              //品种映射
  sTable_StockParam   = 'S_StockParam';              //品种参数
  sTable_YCLParam     = 'P_StockParam';              //原材料品种参数
  sTable_StockParamExt= 'S_StockParamExt';           //参数扩展
  sTable_YCLParamExt  = 'P_StockParamExt';           //原材料参数扩展
  sTable_StockRecord  = 'S_StockRecord';             //检验记录
  sTable_StockHuaYan  = 'S_StockHuaYan';             //开化验单
  sTable_StockBatcode = 'S_Batcode';                 //批次号

  sTable_SaleTotal1   = 'S_SaleTotal1';              //销售统计1
  sTable_YCLRecord    = 'P_StockRecord';             //原材料检验记录

  sTable_Truck        = 'S_Truck';                   //车辆表
  sTable_ZTLines      = 'S_ZTLines';                 //装车道
  sTable_ZTTrucks     = 'S_ZTTrucks';                //车辆队列
  sTable_AuditTruck   = 'S_AuditTruck';              //车辆审核

  sTable_PayingUnit   = 'S_PayingUnit';              //交货单位

  sTable_ZTCard       = 'S_ZTCard';                  //当前刷卡信息表
  sTable_YCLquality   = 'YCLquality_data';           //原材料检验表

  sTable_Provider     = 'P_Provider';                //客户表
  sTable_Materails    = 'P_Materails';               //物料表
  sTable_Order        = 'P_Order';                   //采购订单
  sTable_OrderBak     = 'P_OrderBak';                //已删除采购订单
  sTable_OrderBase    = 'P_OrderBase';               //采购申请订单
  sTable_OrderBaseBak = 'P_OrderBaseBak';            //已删除采购申请订单
  sTable_OrderDtl     = 'P_OrderDtl';                //采购订单明细
  sTable_OrderDtlBak  = 'P_OrderDtlBak';             //采购订单明细
  sTable_CardOther    = 'S_CardOther';               //临时称重

  sTable_CusAccount   = 'Sys_CustomerAccount';       //客户账户
  sTable_InOutMoney   = 'Sys_CustomerInOutMoney';    //资金明细
  sTable_CusCredit    = 'Sys_CustomerCredit';        //客户信用
  sTable_SysShouJu    = 'Sys_ShouJu';                //收据记录

  sTable_Invoice      = 'Sys_Invoice';               //发票列表
  sTable_InvoiceDtl   = 'Sys_InvoiceDetail';         //发票明细
  sTable_InvoiceWeek  = 'Sys_InvoiceWeek';           //结算周期
  sTable_InvoiceReq   = 'Sys_InvoiceRequst';         //结算申请
  sTable_InvReqtemp   = 'Sys_InvoiceReqtemp';        //临时申请
  sTable_InvSettle    = 'Sys_InvoiceSettle';         //销售结算
  sTable_DataTemp     = 'Sys_DataTemp';              //临时数据

  sTable_WeixinLog    = 'Sys_WeixinLog';             //微信日志
  sTable_WeixinMatch  = 'Sys_WeixinMatch';           //账号匹配
  sTable_WeixinTemp   = 'Sys_WeixinTemplate';        //信息模板
  sTable_WebOrderMatch   = 'S_WebOrderMatch';        //商城订单映射

  sTable_PoundLog     = 'Sys_PoundLog';              //过磅数据
  sTable_KSKD         = 'P_KSKD';                    //矿山扣吨表
  sTable_PoundBak     = 'Sys_PoundBak';              //过磅作废
  sTable_Picture      = 'Sys_Picture';               //存放图片
  sTable_PoundDaiWC   = 'Sys_PoundDaiWuCha';         //包装误差

  sTable_K3_SyncItem  = 'DL_SyncItem';               //数据同步项
  sTable_K3_Customer  = 'T_Organization';            //组织结构(客户)
  sTable_K3_SalePlan  = 'S_K3_SalePlan';             //销售计划

  sTable_CardGrab     = 'P_CardGrab';                //抓斗秤刷卡记录表
  sTable_Grab         = 'P_Grab';                    //抓斗秤称重记录表
  sTable_GrabBak      = 'P_GrabBak';                 //抓斗秤称重记录表

  sTable_TransBase    = 'P_TransBase';               //短倒单
  sTable_TransBaseBak = 'P_TransBaseBak';            //短倒单
  sTable_Transfer     = 'P_Transfer';                //短倒明细单
  sTable_TransferBak  = 'P_TransferBak';             //短倒明细单
  sTable_MonthSales   = 'S_MonthSales';              //月销售汇总
  sTable_MonthPrice   = 'S_MonthPrice';              //月销售汇总

  sTable_SalesCredit  = 'Sys_SalesCredit';           //业务员信用
  sTable_PMaterailControl = 'Sys_PMaterailControl';  //原材料进厂控制表

  sTable_SCustomerControl = 'Sys_SCustomerControl';  //销售量控制表
  
  {*新建表*}
  sSQL_NewSysDict = 'Create Table $Table(D_ID $Inc, D_Name varChar(15),' +
       'D_Desc varChar(30), D_Value varChar(50), D_Memo varChar(20),' +
       'D_ParamA $Float, D_ParamB varChar(50), D_ParamC varChar(50),' +
       'D_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   系统字典: SysDict
   *.D_ID: 编号
   *.D_Name: 名称
   *.D_Desc: 描述
   *.D_Value: 取值
   *.D_Memo: 相关信息
   *.D_ParamA: 浮点参数
   *.D_ParamB: 字符参数
   *.D_ParamC: 字符参数
   *.D_Index: 显示索引
  -----------------------------------------------------------------------------}
  
  sSQL_NewExtInfo = 'Create Table $Table(I_ID $Inc, I_Group varChar(20),' +
       'I_ItemID varChar(20), I_Item varChar(30), I_Info varChar(500),' +
       'I_ParamA $Float, I_ParamB varChar(50), I_Index Integer Default 0)';
  {-----------------------------------------------------------------------------
   扩展信息表: ExtInfo
   *.I_ID: 编号
   *.I_Group: 信息分组
   *.I_ItemID: 信息标识
   *.I_Item: 信息项
   *.I_Info: 信息内容
   *.I_ParamA: 浮点参数
   *.I_ParamB: 字符参数
   *.I_Memo: 备注信息
   *.I_Index: 显示索引
  -----------------------------------------------------------------------------}
  
  sSQL_NewSysLog = 'Create Table $Table(L_ID $Inc, L_Date DateTime,' +
       'L_Man varChar(32),L_Group varChar(20), L_ItemID varChar(20),' +
       'L_KeyID varChar(20), L_Event varChar(220))';
  {-----------------------------------------------------------------------------
   系统日志: SysLog
   *.L_ID: 编号
   *.L_Date: 操作日期
   *.L_Man: 操作人
   *.L_Group: 信息分组
   *.L_ItemID: 信息标识
   *.L_KeyID: 辅助标识
   *.L_Event: 事件
  -----------------------------------------------------------------------------}

  sSQL_NewBaseInfo = 'Create Table $Table(B_ID $Inc, B_Group varChar(15),' +
       'B_Text varChar(100), B_Py varChar(25), B_Memo varChar(50),' +
       'B_PID Integer, B_Index Float)';
  {-----------------------------------------------------------------------------
   基本信息表: BaseInfo
   *.B_ID: 编号
   *.B_Group: 分组
   *.B_Text: 内容
   *.B_Py: 拼音简写
   *.B_Memo: 备注信息
   *.B_PID: 上级节点
   *.B_Index: 创建顺序
  -----------------------------------------------------------------------------}

  sSQL_NewSerialBase = 'Create Table $Table(R_ID $Inc, B_Group varChar(15),' +
       'B_Object varChar(32), B_Prefix varChar(25), B_IDLen Integer,' +
       'B_Base Integer, B_Date DateTime)';
  {-----------------------------------------------------------------------------
   串行编号基数表: SerialBase
   *.R_ID: 编号
   *.B_Group: 分组
   *.B_Object: 对象
   *.B_Prefix: 前缀
   *.B_IDLen: 编号长
   *.B_Base: 基数
   *.B_Date: 参考日期
  -----------------------------------------------------------------------------}

  sSQL_NewSerialStatus = 'Create Table $Table(R_ID $Inc, S_Object varChar(32),' +
       'S_SerailID varChar(32), S_PairID varChar(32), S_Status Char(1),' +
       'S_Date DateTime)';
  {-----------------------------------------------------------------------------
   串行状态表: SerialStatus
   *.R_ID: 编号
   *.S_Object: 对象
   *.S_SerailID: 串行编号
   *.S_PairID: 配对编号
   *.S_Status: 状态(Y,N)
   *.S_Date: 创建时间
  -----------------------------------------------------------------------------}

  sSQL_NewWorkePC = 'Create Table $Table(R_ID $Inc, W_Name varChar(100),' +
       'W_MAC varChar(32), W_Factory varChar(32), W_Serial varChar(32),' +
       'W_Departmen varChar(32), W_ReqMan varChar(32), W_ReqTime DateTime,' +
       'W_RatifyMan varChar(32), W_RatifyTime DateTime,' +
       'W_PoundID varChar(50), W_MITUrl varChar(128), W_HardUrl varChar(128),' +
       'W_Valid Char(1))';
  {-----------------------------------------------------------------------------
   工作授权: WorkPC
   *.R_ID: 编号
   *.W_Name: 电脑名称
   *.W_MAC: MAC地址
   *.W_Factory: 工厂编号
   *.W_Departmen: 部门
   *.W_Serial: 编号
   *.W_ReqMan,W_ReqTime: 接入申请
   *.W_RatifyMan,W_RatifyTime: 批准
   *.W_PoundID:磅站编号
   *.W_MITUrl:业务服务
   *.W_HardUrl:硬件服务
   *.W_Valid: 有效(Y/N)
  -----------------------------------------------------------------------------}

  sSQL_NewFactorys = 'Create Table $Table(R_ID $Inc, F_ID varChar(32),' +
       'F_Name varChar(100), F_MITUrl varChar(128), F_HardUrl varChar(128),' +
       'F_WechatUrl varChar(128), F_DBConn varChar(500),' +
       'F_Valid Char(1), F_Index Integer)';
  {-----------------------------------------------------------------------------
   工厂列表: Factorys
   *.R_ID: 编号
   *.F_ID: 工厂编号
   *.F_Name: 工厂名称
   *.F_MITUrl: 中间件地址
   *.F_HardUrl: 硬件守护地址
   *.F_WechatUrl: 微信服务地址
   *.F_DBConn: 数据库连接配置
   *.F_Valid: 有效(Y/N)
   *.F_Index: 加载顺序
  -----------------------------------------------------------------------------}

  sSQL_NewManualEvent = 'Create Table $Table(R_ID $Inc, E_ID varChar(32),' +
       'E_From varChar(32), E_Key varChar(32), E_Event varChar(200), ' +
       'E_Solution varChar(100), E_Result varChar(12),E_Departmen varChar(32),' +
       'E_Date DateTime, E_ManDeal varChar(32), E_DateDeal DateTime, ' +
       'E_ParamA Integer, E_ParamB varChar(128), E_Memo varChar(512))';
  {-----------------------------------------------------------------------------
   人工干预事件: ManualEvent
   *.R_ID: 编号
   *.E_ID: 流水号
   *.E_From: 来源
   *.E_Key: 记录标识
   *.E_Event: 事件
   *.E_Solution: 处理方案(格式如: Y=通过;N=禁止) 
   *.E_Result: 处理结果(Y/N)
   *.E_Departmen: 处理部门
   *.E_Date: 发生时间
   *.E_ManDeal,E_DateDeal: 处理人
   *.E_ParamA: 附加参数, 整型
   *.E_ParamB: 附加参数, 字符串
   *.E_Memo: 备注信息
  -----------------------------------------------------------------------------}

  sSQL_NewSyncItem = 'Create Table $Table(R_ID $Inc, S_Table varChar(100),' +
       'S_Action Char(1), S_Record varChar(32), S_Param1 varChar(100),' +
       'S_Param2 $Float, S_Time DateTime)';
  {-----------------------------------------------------------------------------
   同步数据项: SyncItem
   *.R_ID: 编号
   *.S_Table: 表名称
   *.S_Action: 增删改(A,E,D)
   *.S_Record: 记录编号
   *.S_Param1,S_Param2: 参数
   *.S_Time: 时间
  -----------------------------------------------------------------------------}

  sSQL_NewStockMatch = 'Create Table $Table(R_ID $Inc, M_Group varChar(8),' +
       'M_ID varChar(20), M_Name varChar(80), M_Status Char(1))';
  {-----------------------------------------------------------------------------
   相似品种映射: StockMatch
   *.R_ID: 记录编号
   *.M_Group: 分组
   *.M_ID: 物料号
   *.M_Name: 物料名称
   *.M_Status: 状态
  -----------------------------------------------------------------------------}
  
  sSQL_NewSalesMan = 'Create Table $Table(R_ID $Inc, S_ID varChar(15),' +
       'S_Name varChar(30), S_PY varChar(30), S_Phone varChar(20),' +
       'S_Area varChar(50), S_InValid Char(1), S_Memo varChar(50),'+
       'S_CreditLimit Decimal(15,5) Default 0,S_CreditUsed Decimal(15,5) Default 0)';
  {-----------------------------------------------------------------------------
   业务员表: SalesMan
   *.R_ID: 记录号
   *.S_ID: 编号
   *.S_Name: 名称
   *.S_PY: 简拼
   *.S_Phone: 联系方式
   *.S_Area:所在区域
   *.S_InValid: 已无效
   *.S_Memo: 备注
   *.S_CreditLimit:授信额度
   *.S_CreditUsed：额度用量
  -----------------------------------------------------------------------------}

  sSQL_NewCustomer = 'Create Table $Table(R_ID $Inc, C_ID varChar(15), ' +
       'C_Name varChar(80), C_PY varChar(80), C_Addr varChar(100), ' +
       'C_FaRen varChar(50), C_LiXiRen varChar(50), C_WeiXin varChar(15),' +
       'C_Phone varChar(15), C_Fax varChar(15), C_Tax varChar(32),' +
       'C_Bank varChar(35), C_Account varChar(18), C_SaleMan varChar(15),' +
       'C_Param varChar(32), C_Memo varChar(50), C_Type char(1), C_XuNi Char(1))';
  {-----------------------------------------------------------------------------
   客户信息表: Customer
   *.R_ID: 记录号
   *.C_ID: 编号
   *.C_Name: 名称
   *.C_PY: 拼音简写
   *.C_Addr: 地址
   *.C_FaRen: 法人
   *.C_LiXiRen: 联系人
   *.C_Phone: 电话
   *.C_WeiXin: 微信
   *.C_Fax: 传真
   *.C_Tax: 税号
   *.C_Bank: 开户行
   *.C_Account: 帐号
   *.C_SaleMan: 业务员
   *.C_Param: 备用参数
   *.C_Memo: 备注信息
   *.C_Type: 客户分类
   *.C_XuNi: 虚拟(临时)客户
  -----------------------------------------------------------------------------}
  
  sSQL_NewCusAccount = 'Create Table $Table(R_ID $Inc, A_CID varChar(15),' +
       'A_Used Char(1), A_InMoney Decimal(15,5) Default 0,' +
       'A_OutMoney Decimal(15,5) Default 0, A_DebtMoney Decimal(15,5) Default 0,' +
       'A_Compensation Decimal(15,5) Default 0,' +
       'A_InitMoney Decimal(15,5) Default 0,' +
       'A_FreezeMoney Decimal(15,5) Default 0,' +
       'A_CreditLimit Decimal(15,5) Default 0, A_Date DateTime)';
  {-----------------------------------------------------------------------------
   客户账户:CustomerAccount
   *.R_ID:记录编号
   *.A_CID:客户号
   *.A_Used:用途(供应,销售)
   *.A_InitMoney:初始额度
   *.A_InMoney:入金
   *.A_OutMoney:出金
   *.A_DebtMoney:欠款
   *.A_Compensation:补偿金
   *.A_FreezeMoney:冻结资金
   *.A_CreditLimit:信用额度
   *.A_Date:创建日期

   *.水泥销售账中
     A_InitMoney:客户初始账户金额
     A_InMoney:客户存入账户的金额
     A_OutMoney:客户实际花费的金额
     A_DebtMoney:还未支付的金额
     A_Compensation:由于差价退还给客户的金额
     A_FreezeMoney:已办纸卡但未进厂提货的金额
     A_CreditLimit:授信给用户的最高可欠款金额

     可用余额 = 期初 + 入金 + 信用额 - 出金 - 补偿金 - 已冻结
     消费总额 = 出金 + 欠款 + 已冻结
  -----------------------------------------------------------------------------}

  sSQL_NewInOutMoney = 'Create Table $Table(R_ID $Inc, M_SaleMan varChar(15),' +
       'M_CusID varChar(15), M_CusName varChar(80), ' +
       'M_Type Char(1), M_Payment varChar(20),' +
       'M_Money Decimal(15,5), M_ZID varChar(15), M_Date DateTime,' +
       'M_Man varChar(32), M_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   出入金明细:CustomerInOutMoney
   *.M_ID:记录编号
   *.M_SaleMan:业务员
   *.M_CusID:客户号
   *.M_CusName:客户名
   *.M_Type:类型(补差,回款等)
   *.M_Payment:付款方式
   *.M_Money:缴纳金额
   *.M_ZID:纸卡号
   *.M_Date:操作日期
   *.M_Man:操作人
   *.M_Memo:描述

   *.水泥销售入金中
     金额 = 单价 x 数量 + 其它
  -----------------------------------------------------------------------------}

  sSQL_NewSysShouJu = 'Create Table $Table(R_ID $Inc ,S_Code varChar(15),' +
       'S_Sender varChar(100), S_Reason varChar(100), S_Money Decimal(15,5),' +
       'S_BigMoney varChar(50), S_Bank varChar(35), S_Man varChar(32),' +
       'S_Date DateTime, S_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   收据明细:ShouJu
   *.R_ID:编号
   *.S_Code:记账凭单号码
   *.S_Sender:兹由(来源)
   *.S_Reason:交来(事务)
   *.S_Money:金额
   *.S_Bank:银行
   *.S_Man:出纳员
   *.S_Date:日期
   *.S_Memo:备注
  -----------------------------------------------------------------------------}

  sSQL_NewCusCredit = 'Create Table $Table(R_ID $Inc ,C_CusID varChar(15),' +
       'C_Money Decimal(15,5), C_Man varChar(32), C_Date DateTime, ' +
       'C_End DateTime, C_Verify Char(1) Default ''N'', C_VerMan varChar(32),' +
       'C_VerDate DateTime, C_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   信用明细:CustomerCredit
   *.R_ID:编号
   *.C_CusID:客户编号
   *.C_Money:授信额
   *.C_Man:操作人
   *.C_Date:日期
   *.C_End: 有效期
   *.C_Verify: 已审核(Y/N)
   *.C_VerMan,C_VerDate: 审核
   *.C_Memo:备注
  -----------------------------------------------------------------------------}

  sSQL_NewSaleContract = 'Create Table $Table(R_ID $Inc, C_ID varChar(15),' +
       'C_Project varChar(100),C_SaleMan varChar(15), C_Customer varChar(15),' +
       'C_Date varChar(20), C_Area varChar(50), C_Addr varChar(50),' +
       'C_Delivery varChar(50), C_Payment varChar(20), C_Approval varChar(30),' +
       'C_ZKDays Integer, C_XuNi Char(1), C_Freeze Char(1), C_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   销售合同: SalesContract
   *.R_ID: 编号
   *.C_Project: 项目名称
   *.C_SaleMan: 销售人员
   *.C_Customer: 客户
   *.C_Date: 签订时间
   *.C_Area: 所属区域
   *.C_Addr: 签订地点
   *.C_Delivery: 交货地
   *.C_Payment: 付款方式
   *.C_Approval: 批准人
   *.C_ZKDays: 纸卡有效期
   *.C_XuNi: 虚拟合同
   *.C_Freeze: 是否冻结
   *.C_Memo: 备注信息
  -----------------------------------------------------------------------------}

  sSQL_NewSContractExt = 'Create Table $Table(R_ID $Inc,' +
       'E_CID varChar(15), E_Type Char(1), ' +
       'E_StockNo varChar(20), E_StockName varChar(80),' +
       'E_Value Decimal(15,5), E_Price Decimal(15,5), E_Money Decimal(15,5))';
  {-----------------------------------------------------------------------------
   销售合同: SalesContract
   *.R_ID: 记录编号
   *.E_CID: 销售合同
   *.E_Type: 类型(袋,散)
   *.E_StockNo,E_StockName: 水泥类型
   *.E_Value: 数量
   *.E_Price: 单价
   *.E_Money: 金额
  -----------------------------------------------------------------------------}

  sSQL_NewYYWeb = 'Create Table $Table(R_ID $Inc,W_WebOrderID varChar(32),' +
       'W_OrderNo varChar(50),W_CusID varChar(50), W_Customer varChar(80),' +
       'W_Truck varChar(32), W_MakeTime varChar(50), W_StockNo varChar(50),' +
       'W_StockName varChar(80), W_State char(1), ' +
       'W_SyncNum Integer default 0, W_Value $Float,' +
       'W_deleted char(1) default ''N'', W_SucessTime DateTime)';
  {-----------------------------------------------------------------------------
   网上预约: YYWebBill
   *.R_ID:记录编号
   *.W_WebOrderID:网上单号
   *.W_OrderNo:合同单号
   *.W_CusID:客户编号
   *.W_Customer:客户名称
   *.W_Truck:车牌号
   *.W_MakeTime:预约时间
   *.W_StockNo:品种编号
   *.W_StockName:品种名称
   *.W_State:状态 0 预约 1 预约成功  2 预约作废
   *.W_SyncNum:同步次数
   *.W_Value:预约量
   *.W_deleted:同步状态 N 失败 Y 成功
   *.W_SucessTime: 预约成功时间
  -----------------------------------------------------------------------------}

  sSQL_NewZhiKa = 'Create Table $Table(R_ID $Inc,Z_ID varChar(15),' +
       'Z_Name varChar(100),Z_Card varChar(16),' +
       'Z_CID varChar(15), Z_Project varChar(100), Z_Customer varChar(15),' +
       'Z_SaleMan varChar(15), Z_Payment varChar(20), Z_Lading Char(1),' +
       'Z_ValidDays DateTime, Z_Password varChar(16), Z_OnlyPwd Char(1),' +
       'Z_Verified Char(1), Z_InValid Char(1), Z_Freeze Char(1),' +
       'Z_YFMoney $Float, Z_FixedMoney $Float, Z_OnlyMoney Char(1),' +
       'Z_TJStatus Char(1), Z_Memo varChar(200), Z_Man varChar(32),' +
       'Z_Date DateTime, Z_VerifyMan varChar(32), Z_VerifyDate DateTime,'+
       'Z_Area varChar(30), Z_XHSpot varchar(30), Z_Freight $Float Default 0)';
  {-----------------------------------------------------------------------------
   纸卡办理: ZhiKa
   *.R_ID:记录编号
   *.Z_ID:纸卡号
   *.Z_Card:磁卡号
   *.Z_Name:纸卡名称
   *.Z_CID:销售合同
   *.Z_Project:项目名称
   *.Z_Customer:客户编号
   *.Z_SaleMan:业务员
   *.Z_Payment:付款方式
   *.Z_Lading:提货方式(自提,送货)
   *.Z_ValidDays:有效期
   *.Z_Password: 密码
   *.Z_OnlyPwd: 统一密码
   *.Z_Verified:已审核
   *.Z_VerifyMan: 审核人
   *.Z_VerifyDate: 审核时间
   *.Z_InValid:已无效
   *.Z_Freeze:已冻结
   *.Z_YFMoney:预付金额
   *.Z_FixedMoney:可用金
   *.Z_OnlyMoney:只使用可用金
   *.Z_TJStatus:调价状态
   *.Z_Man:操作人
   *.Z_Date:创建时间
   *.Z_Area:区域
   *.Z_XHSpot:卸货地点
   *.Z_Freight:运费
  -----------------------------------------------------------------------------}

  sSQL_NewZhiKaDtl = 'Create Table $Table(R_ID $Inc, D_ZID varChar(15),' +
       'D_Type Char(1), D_StockNo varChar(20), D_StockName varChar(80),' +
       'D_Price $Float, D_Value $Float, ' +
       'D_FLPrice $Float Default 0, D_YunFei $Float Default 0,' +
       'D_PPrice $Float, D_TPrice Char(1) Default ''Y'')';
  {-----------------------------------------------------------------------------
   纸卡明细:ZhiKaDtl
   *.R_ID:记录编号
   *.D_ZID:纸卡号
   *.D_Type:类型(袋,散)
   *.D_StockNo,D_StockName:水泥名称
   *.D_Price:单价
   *.D_Value:办理量
   *.D_FLPrice: 返利价
   *.D_YunFei: 运费单价
   *.D_PPrice:调价前单价
   *.D_TPrice:允许调价
  -----------------------------------------------------------------------------}

  sSQL_NewPriceRule = 'Create Table $Table(R_ID $Inc, R_StockNo varChar(20), ' +
       'R_StockName varChar(80), R_Low $Float,' +
       'R_High $Float, R_Valid Char(1), R_Man varChar(32), R_Date DateTime)';
  {-----------------------------------------------------------------------------
   价格规则:PriceRule
   *.R_ID:记录编号
   *.R_StockNo,R_StockName: 物料
   *.R_Low: 价格下限
   *.R_High: 价格上限
   *.R_Valid: 有效
   *.R_Man: 办理人
   *.R_Date: 办理时间
  -----------------------------------------------------------------------------}

  sSQL_NewBill = 'Create Table $Table(R_ID $Inc, L_ID varChar(20),' +
       'L_Card varChar(16), L_ZhiKa varChar(15), L_Order varChar(20),' +
       'L_Project varChar(100), L_Area varChar(50),' +
       'L_CusID varChar(15), L_CusName varChar(80), L_CusPY varChar(80),' +
       'L_SaleID varChar(15), L_SaleMan varChar(32),' +
       'L_Type Char(1), L_StockNo varChar(20), L_StockName varChar(80),' +
       'L_Value $Float, L_Price $Float, L_ZKMoney Char(1),' +
       'L_Truck varChar(15), L_Status Char(1), L_NextStatus Char(1),' +
       'L_InTime DateTime, L_InMan varChar(32),' +
       'L_PValue $Float, L_PDate DateTime, L_PMan varChar(32),' +
       'L_MValue $Float, L_MDate DateTime, L_MMan varChar(32),' +
       'L_LadeTime DateTime, L_LadeMan varChar(32), ' +
       'L_LadeLine varChar(15), L_LineName varChar(32), ' +
       'L_DaiTotal Integer , L_DaiNormal Integer, L_DaiBuCha Integer,' +
       'L_OutFact DateTime, L_OutMan varChar(32), L_PrintGLF Char(1),' +
       'L_Lading Char(1), L_IsVIP varChar(1), L_Seal varChar(100),' +
       'L_HYDan varChar(15), L_PrintHY Char(1),' +
       'L_Audit char(1) not null default(''N''),' +
       'L_EmptyOut char(1) not null default(''N''),' +
       'L_Man varChar(32), L_Date DateTime,' +
       'L_Seal1 varChar(32), L_Seal2 varChar(32), L_Seal3 varChar(32),' +
       'L_KuWei varChar(20), L_CusType char(1),' +
       'L_XHSpot varChar(30), L_Freight $Float, L_Ident varChar(30),' +
       'L_DelMan varChar(32), L_DelDate DateTime, L_Memo varChar(320))';
  {-----------------------------------------------------------------------------
   交货单表: Bill
   *.R_ID: 编号
   *.L_ID: 提单号
   *.L_Card: 磁卡号
   *.L_ZhiKa: 纸卡号
   *.L_Order: 订单号(备用)
   *.L_Area: 区域
   *.L_CusID,L_CusName,L_CusPY:客户
   *.L_SaleID,L_SaleMan:业务员
   *.L_Type: 类型(袋,散)
   *.L_StockNo: 物料编号
   *.L_StockName: 物料描述
   *.L_Value: 提货量
   *.L_Price: 提货单价
   *.L_ZKMoney: 占用纸卡限提(Y/N)
   *.L_Truck: 车船号
   *.L_Status,L_NextStatus:状态控制
   *.L_InTime,L_InMan: 进厂放行
   *.L_PValue,L_PDate,L_PMan: 称皮重
   *.L_MValue,L_MDate,L_MMan: 称毛重
   *.L_LadeTime,L_LadeMan: 发货时间,发货人
   *.L_LadeLine,L_LineName: 发货通道
   *.L_DaiTotal,L_DaiNormal,L_DaiBuCha:总装,正常,补差
   *.L_OutFact,L_OutMan: 出厂放行
   *.L_Lading: 提货方式(自提,送货)
   *.L_IsVIP:VIP单
   *.L_PrintGLF:是否自动打印过路费
   *.L_Seal: 封签号
   *.L_HYDan: 化验单
   *.L_PrintHY:自动打印化验单
   *.L_Audit: 补单审核状态Y待审核N已审核
   *.L_EmptyOut: 空车出厂标记
   *.L_Man:操作人
   *.L_Date:创建时间
   *.L_DelMan: 交货单删除人员
   *.L_DelDate: 交货单删除时间
   *.L_Memo: 动作备注
   *.L_Seal1: 铅封号1
   *.L_Seal2: 铅封号2
   *.L_Seal3: 铅封号3
   *.L_KuWei: 物料所属库位
   *.L_CusType: 提货单分类
   *.L_XHSpot:卸货点
   *.L_Freight:运费
   *.L_Ident:身份证号
  -----------------------------------------------------------------------------}

  sSQL_NewBillHK = 'Create Table $Table(R_ID $Inc, H_Bill varChar(20),' +
       'H_ZhiKa varChar(15), H_HKBill varChar(20),' +
       'H_Man varChar(32), H_Date DateTime)';
  {-----------------------------------------------------------------------------
   交货单预合卡: BillPreHK
   *.R_ID: 编号
   *.H_Bill: 提单号
   *.H_ZhiKa: 纸卡号
   *.H_HKBill: 合卡生成的单号
   *.H_Man:操作人
   *.H_Date:创建时间
  -----------------------------------------------------------------------------}

  sSQL_NewOrderBase = 'Create Table $Table(R_ID $Inc, B_ID varChar(20),' +
       'B_Value $Float, B_SentValue $Float,B_RestValue $Float,' +
       'B_LimValue $Float, B_WarnValue $Float,B_FreezeValue $Float,' +
       'B_BStatus Char(1),B_Area varChar(50), B_Project varChar(100),' +
       'B_ProID varChar(32), B_ProName varChar(80), B_ProPY varChar(80),' +
       'B_SaleID varChar(32), B_SaleMan varChar(80), B_SalePY varChar(80),' +
       'B_StockType Char(1), B_StockNo varChar(32), B_StockName varChar(80),' +
       'B_Man varChar(32), B_Date DateTime,' +
       'B_DelMan varChar(32), B_DelDate DateTime, B_Memo varChar(500))';
  {-----------------------------------------------------------------------------
   采购申请单表: Order
   *.R_ID: 编号
   *.B_ID: 提单号
   *.B_Value,B_SentValue,B_RestValue:订单量，已发量，剩余量
   *.B_LimValue,B_WarnValue,B_FreezeValue:订单超发上限;订单预警量,订单冻结量
   *.B_BStatus: 订单状态
   *.B_Area,B_Project: 区域,项目
   *.B_ProID,B_ProName,B_ProPY:供应商
   *.B_SaleID,B_SaleMan,B_SalePY:业务员
   *.B_StockType: 类型(袋,散)
   *.B_StockNo: 原材料编号
   *.B_StockName: 原材料名称
   *.B_Man:操作人
   *.B_Date:创建时间
   *.B_DelMan: 采购申请单删除人员
   *.B_DelDate: 采购申请单删除时间
   *.B_Memo: 动作备注
  -----------------------------------------------------------------------------}

  sSQL_NewOrder = 'Create Table $Table(R_ID $Inc, O_ID varChar(20),' +
       'O_BID varChar(20),O_Card varChar(16), O_CType varChar(1),' +
       'O_Value $Float,O_Area varChar(50), O_Project varChar(100),' +
       'O_ProID varChar(32), O_ProName varChar(80), O_ProPY varChar(80),' +
       'O_SaleID varChar(32), O_SaleMan varChar(80), O_SalePY varChar(80),' +
       'O_Type Char(1), O_StockNo varChar(32), O_StockName varChar(80),' +
       'O_Truck varChar(15), O_OStatus Char(1),' +
       'O_Man varChar(32), O_Date DateTime,' +
       'O_KFValue varChar(16), O_KFLS varChar(32),' +
       'O_DelMan varChar(32), O_DelDate DateTime, O_Memo varChar(500))';
  {-----------------------------------------------------------------------------
   采购订单表: Order
   *.R_ID: 编号
   *.O_ID: 提单号
   *.O_BID: 采购申请单据号
   *.O_Card,O_CType: 磁卡号,磁卡类型(L、临时卡;G、固定卡)
   *.O_Value:订单量，
   *.O_OStatus: 订单状态
   *.O_Area,O_Project: 区域,项目
   *.O_ProID,O_ProName,O_ProPY:供应商
   *.O_SaleID,O_SaleMan:业务员
   *.O_Type: 类型(袋,散)
   *.O_StockNo: 原材料编号
   *.O_StockName: 原材料名称
   *.O_Truck: 车船号
   *.O_Man:操作人
   *.O_Date:创建时间
   *.O_KFValue:矿发数量
   *.O_KFLS:矿发流水
   *.O_DelMan: 采购单删除人员
   *.O_DelDate: 采购单删除时间
   *.O_Memo: 动作备注
  -----------------------------------------------------------------------------}

  sSQL_NewOrderDtl = 'Create Table $Table(R_ID $Inc, D_ID varChar(20),' +
       'D_OID varChar(20), D_PID varChar(20), D_Card varChar(16), ' +
       'D_Area varChar(50), D_Project varChar(100),D_Truck varChar(15), ' +
       'D_ProID varChar(32), D_ProName varChar(80), D_ProPY varChar(80),' +
       'D_SaleID varChar(32), D_SaleMan varChar(80), D_SalePY varChar(80),' +
       'D_Type Char(1), D_StockNo varChar(32), D_StockName varChar(80),' +
       'D_DStatus Char(1), D_Status Char(1), D_NextStatus Char(1),' +
       'D_InTime DateTime, D_InMan varChar(32),' +
       'D_PValue $Float, D_PDate DateTime, D_PMan varChar(32),' +
       'D_MValue $Float, D_MDate DateTime, D_MMan varChar(32),' +
       'D_YTime DateTime, D_YMan varChar(32), ' +
       'D_Value $Float,D_KZValue $Float, D_AKValue $Float,' +
       'D_YLine varChar(15), D_YLineName varChar(32), D_Unload varChar(80),' +
       'D_DelMan varChar(32), D_DelDate DateTime, D_YSResult Char(1), ' +
       'D_OutFact DateTime, D_OutMan varChar(32), D_Memo varChar(500),'+
       'D_WlbYTime DateTime, D_WlbYMan varchar(32),D_WlbYS char(1) Default ''N'')';
  {-----------------------------------------------------------------------------
   采购订单明细表: OrderDetail
   *.R_ID: 编号
   *.D_ID: 采购明细号
   *.D_OID: 采购单号
   *.D_PID: 磅单号
   *.D_Card: 采购磁卡号
   *.D_DStatus: 订单状态
   *.D_Area,D_Project: 区域,项目
   *.D_ProID,D_ProName,D_ProPY:供应商
   *.D_SaleID,D_SaleMan:业务员
   *.D_Type: 类型(袋,散)
   *.D_StockNo: 原材料编号
   *.D_StockName: 原材料名称
   *.D_Truck: 车船号
   *.D_Status,D_NextStatus: 状态
   *.D_InTime,D_InMan: 进厂放行
   *.D_PValue,D_PDate,D_PMan: 称皮重
   *.D_MValue,D_MDate,D_MMan: 称毛重
   *.D_YTime,D_YMan: 收货时间,验收人,
   *.D_Value,D_KZValue,D_AKValue: 收货量,验收扣除(明扣),暗扣
   *.D_YLine,D_YLineName: 收货通道
   *.D_UnLoad: 卸货地点/库房
   *.D_YSResult: 验收结果
   *.D_OutFact,D_OutMan: 出厂放行
   *.D_WlbYTime,D_WlbYMan,D_WlbYS:物流部验收时间，人，结果
  -----------------------------------------------------------------------------}

  sSQL_NewCard = 'Create Table $Table(R_ID $Inc, C_Card varChar(16),' +
       'C_Card2 varChar(32), C_Card3 varChar(32),' +
       'C_Owner varChar(15), C_TruckNo varChar(15), C_Status Char(1),' +
       'C_Freeze Char(1), C_Used Char(1), C_UseTime Integer Default 0,' +
       'C_Man varChar(32), C_Date DateTime, C_Memo varChar(500))';
  {-----------------------------------------------------------------------------
   磁卡表:Card
   *.R_ID:记录编号
   *.C_Card:主卡号
   *.C_Card2,C_Card3:副卡号
   *.C_Owner:持有人标识
   *.C_TruckNo:提货车牌
   *.C_Used:用途(供应,销售,临时)
   *.C_UseTime:使用次数
   *.C_Status:状态(空闲,使用,注销,挂失)
   *.C_Freeze:是否冻结
   *.C_Man:办理人
   *.C_Date:办理时间
   *.C_Memo:备注信息
  -----------------------------------------------------------------------------}

    sSQL_NewTruck = 'Create Table $Table(R_ID $Inc, T_Truck varChar(15), ' +
       'T_PY varChar(15), T_Owner varChar(32), T_Phone varChar(15), T_Used Char(1), ' +
       'T_PrePValue $Float, T_PrePMan varChar(32), T_PrePTime DateTime, ' +
       'T_PrePUse Char(1), T_MinPVal $Float, T_MaxPVal $Float, ' +
       'T_PValue $Float Default 0, T_PTime Integer Default 0,' +
       'T_PlateColor varChar(12),T_Type varChar(12), T_LastTime DateTime, ' +
       'T_Card varChar(32), T_CardUse Char(1), T_Card2 varChar(32),' +
       'T_NoVerify Char(1), T_Valid Char(1), T_VIPTruck Char(1), T_HasGPS Char(1), T_GPSDate DateTime)';
  {-----------------------------------------------------------------------------
   车辆信息:Truck
   *.R_ID: 记录号
   *.T_Truck: 车牌号
   *.T_PY: 车牌拼音
   *.T_Owner: 车主
   *.T_Phone: 联系方式
   *.T_Used: 用途(供应,销售)
   *.T_PrePValue: 预置皮重
   *.T_PrePMan: 预置司磅
   *.T_PrePTime: 预置时间
   *.T_PrePUse: 使用预置
   *.T_MinPVal: 历史最小皮重
   *.T_MaxPVal: 历史最大皮重
   *.T_PValue: 有效皮重
   *.T_PTime: 过皮次数
   *.T_PlateColor: 车牌颜色
   *.T_Type: 车型
   *.T_LastTime: 上次活动
   *.T_Card: 电子标签
   *.T_CardUse: 使用电子签(Y/N)
   *.T_NoVerify: 不校验时间
   *.T_Valid: 是否有效
   *.T_VIPTruck:是否VIP
   *.T_HasGPS:安装GPS(Y/N)
   *.T_GPSDate:GPS有效日期

   有效平均皮重算法:
   T_PValue = (T_PValue * T_PTime + 新皮重) / (T_PTime + 1)
  -----------------------------------------------------------------------------}

  sSQL_NewPayingUnit = 'Create Table $Table(R_ID $Inc, P_PayingUnit varChar(60), ' +
     'P_PY varChar(30), P_CustID varChar(30), P_SaleID varchar(30))';


  sSQL_NewYCLQuality_data = 'Create Table $Table(R_ID $Inc, assay_time varChar(50), ' +
       'assay_value_group varChar(30), equipment_id varChar(32), equipment_name varChar(50),laboratory_types varChar(50), ' +
       'material_code varChar(32), material_name varChar(50), material_purpose varChar(50), ' +
       'property_data varChar(502), collector_num varChar(32) )';
  {-----------------------------------------------------------------------------
  
  -----------------------------------------------------------------------------}

  sSQL_NewPoundLog = 'Create Table $Table(R_ID $Inc, P_ID varChar(15),' +
       'P_Type varChar(1), P_Order varChar(20), P_Card varChar(16),' +
       'P_Bill varChar(20), P_Truck varChar(15), P_CusID varChar(32),' +
       'P_CusName varChar(80), P_MID varChar(32),P_MName varChar(80),' +
       'P_MType varChar(10), P_LimValue $Float,' +
       'P_PValue $Float, P_PDate DateTime, P_PMan varChar(32), ' +
       'P_MValue $Float, P_MDate DateTime, P_MMan varChar(32), ' +
       'P_FactID varChar(32), P_PStation varChar(10), P_MStation varChar(10),' +
       'P_Direction varChar(10), P_PModel varChar(10), P_Status Char(1),' +
       'P_Valid Char(1), P_PrintNum Integer Default 1, P_KZValue $Float,' +
       'P_DelMan varChar(32), P_DelDate DateTime, P_Memo varChar(320))';
  {-----------------------------------------------------------------------------
   过磅记录: Materails
   *.P_ID: 编号
   *.P_Type: 类型(销售,供应,临时)
   *.P_Order: 订单号(供应)
   *.P_Bill: 交货单
   *.P_Truck: 车牌
   *.P_CusID: 客户号
   *.P_CusName: 物料名
   *.P_MID: 物料号
   *.P_MName: 物料名
   *.P_MType: 包,散等
   *.P_LimValue: 票重
   *.P_PValue,P_PDate,P_PMan: 皮重
   *.P_MValue,P_MDate,P_MMan: 毛重
   *.P_FactID: 工厂编号
   *.P_PStation,P_MStation: 称重磅站
   *.P_Direction: 物料流向(进,出)
   *.P_PModel: 过磅模式(标准,配对等)
   *.P_Status: 记录状态
   *.P_Valid: 是否有效
   *.P_PrintNum: 打印次数
   *.P_KZValue: 供应扣杂
   *.P_DelMan,P_DelDate: 删除记录
   *.P_Memo: 动作备注
  -----------------------------------------------------------------------------}

  sSQL_NewPicture = 'Create Table $Table(R_ID $Inc, P_ID varChar(15),' +
       'P_Name varChar(32), P_Mate varChar(80), P_Date DateTime, P_Picture Image)';
  {-----------------------------------------------------------------------------
   图片: Picture
   *.P_ID: 编号
   *.P_Name: 名称
   *.P_Mate: 物料
   *.P_Date: 时间
   *.P_Picture: 图片
  -----------------------------------------------------------------------------}

  sSQL_NewKSKD = ' Create Table $Table(R_ID $Inc, P_Num1 $Float,' +
       ' P_Num2 $Float, P_Num3 $Float)';
  {-----------------------------------------------------------------------------
   矿山扣吨: P_KSKD
   *.R_ID: 编号
   *.P_Num1: 超过净重数
   *.P_Num2: 超过净重数默认值
   *.P_Num3: 扣吨数
  -----------------------------------------------------------------------------}

  sSQL_NewPoundDaiWC = 'Create Table $Table(R_ID $Inc,' +
       'P_DaiWuChaZ $Float, P_DaiWuChaF $Float, P_Start $Float, P_End $Float,' +
       'P_Percent Char(1), P_Station varChar(32))';
  {-----------------------------------------------------------------------------
   袋装误差范围: PoundDaiWuCha
   *.P_DaiWuChaZ: 正误差
   *.P_DaiWuChaF: 负误差
   *.P_Start: 起始范围
   *.P_End: 结束范围
   *.P_Percent: 按比例计算误差(Y、是;其它、否)
   *.P_Station: 磅站编号
  -----------------------------------------------------------------------------}

  sSQL_NewZTLines = 'Create Table $Table(R_ID $Inc, Z_ID varChar(15),' +
       'Z_Name varChar(32), Z_StockNo varChar(20), Z_Stock varChar(80),' +
       'Z_StockType Char(1), Z_PeerWeight Integer,' +
       'Z_QueueMax Integer, Z_VIPLine Char(1), Z_Valid Char(1), Z_Index Integer)';
  {-----------------------------------------------------------------------------
   装车线配置: ZTLines
   *.R_ID: 记录号
   *.Z_ID: 编号
   *.Z_Name: 名称
   *.Z_StockNo: 品种编号
   *.Z_Stock: 品名
   *.Z_StockType: 类型(袋,散)
   *.Z_PeerWeight: 袋重
   *.Z_QueueMax: 队列大小
   *.Z_VIPLine: VIP通道
   *.Z_Valid: 是否有效
   *.Z_Index: 顺序索引
  -----------------------------------------------------------------------------}

  sSQL_NewZTTrucks = 'Create Table $Table(R_ID $Inc, T_Truck varChar(15),' +
       'T_StockNo varChar(20), T_Stock varChar(80), T_Type Char(1),' +
       'T_Line varChar(15), T_Index Integer, ' +
       'T_InTime DateTime, T_InFact DateTime, T_InQueue DateTime,' +
       'T_InLade DateTime, T_VIP Char(1), T_Valid Char(1), T_Bill varChar(15),' +
       'T_Value $Float, T_PeerWeight Integer, T_Total Integer Default 0,' +
       'T_Normal Integer Default 0, T_BuCha Integer Default 0,' +
       'T_PDate DateTime, T_IsPound Char(1),T_HKBills varChar(200))';
  {-----------------------------------------------------------------------------
   待装车队列: ZTTrucks
   *.R_ID: 记录号
   *.T_Truck: 车牌号
   *.T_StockNo: 品种编号
   *.T_Stock: 品种名称
   *.T_Type: 品种类型(D,S)
   *.T_Line: 所在道
   *.T_Index: 顺序索引
   *.T_InTime: 入队时间
   *.T_InFact: 进厂时间
   *.T_InQueue: 上屏时间
   *.T_InLade: 提货时间
   *.T_VIP: 特权
   *.T_Bill: 提单号
   *.T_Valid: 是否有效
   *.T_Value: 提货量
   *.T_PeerWeight: 袋重
   *.T_Total: 总装袋数
   *.T_Normal: 正常袋数
   *.T_BuCha: 补差袋数
   *.T_PDate: 过磅时间
   *.T_IsPound: 需过磅(Y/N)
   *.T_HKBills: 合卡交货单列表
  -----------------------------------------------------------------------------}

  sSQL_NewAuditTruck = 'Create Table $Table(R_ID $Inc, A_ID varChar(50),' +
       'A_Serial varChar(50), A_Truck varChar(20), A_License Image,' +
       'A_WeiXin varChar(20), A_Phone varChar(20), A_LicensePath varChar(150), ' +
       'A_Date DateTime, A_Status Char(1), ' +
       'A_PValue $Float, A_Man varChar(20), A_Memo varChar(200))';
  {-----------------------------------------------------------------------------
   车辆审核: AuditTruck
   *.R_ID: 记录号
   *.A_ID: 车辆唯一识别码
   *.A_Serial: 车辆类型
   *.A_Truck: 车牌号
   *.A_License: 驾驶证图片
   *.A_WeiXin: 提交信息的商城账户
   *.A_Phone: 商城账户电话
   *.A_LicensePath: 照片路径
   *.A_Date: 审核时间
   *.A_Status: 审核结果(0:申请中.1:通过.2:驳回)
   *.A_PValue: 车辆皮重
   *.A_Man: 审核人
   *.A_Memo: 动作备注
  -----------------------------------------------------------------------------}

  sSQL_NewDataTemp = 'Create Table $Table(T_SysID varChar(15))';
  {-----------------------------------------------------------------------------
   临时数据表: DataTemp
   *.T_SysID: 系统编号
  -----------------------------------------------------------------------------}

  sSQL_NewInvoiceWeek = 'Create Table $Table(W_ID $Inc, W_NO varChar(15),' +
       'W_Name varChar(50), W_Begin DateTime, W_End DateTime,' +
       'W_Man varChar(32), W_Date DateTime, W_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   发票结算周期:InvoiceWeek
   *.W_ID:记录编号
   *.W_NO:周期编号
   *.W_Name:名称
   *.W_Begin:开始
   *.W_End:结束
   *.W_Man:创建人
   *.W_Date:创建时间
   *.W_Memo:备注信息
  -----------------------------------------------------------------------------}
  
  sSQL_NewInvoice = 'Create Table $Table(I_ID varChar(25) PRIMARY KEY,' +
       'I_Week varChar(15), I_CusID varChar(15), I_Customer varChar(80),' +
       'I_SaleID varChar(15), I_SaleMan varChar(50), I_Status Char(1),' +
       'I_Flag Char(1), I_InMan varChar(32), I_InDate DateTime,' +
       'I_OutMan varChar(32), I_OutDate DateTime, I_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   发票票据:Invoice
   *.I_ID:编号
   *.I_Week:结算周期
   *.I_CusID:客户编号
   *.I_Customer:客户名
   *.I_SaleID:业务员号
   *.I_SaleMan:业务员
   *.I_Status:状态
   *.I_Flag:标记
   *.I_InMan:录入人
   *.I_InDate:录入日期
   *.I_OutMan:领用人
   *.I_OutDate:领用日期
   *.I_Memo:备注
  -----------------------------------------------------------------------------}

  sSQL_NewInvoiceDtl = 'Create Table $Table(D_ID $Inc, D_Invoice varChar(25),' +
       'D_Type Char(1), D_Stock varChar(30), D_Price $Float Default 0,' +
       'D_Value $Float Default 0, D_KPrice $Float Default 0,' +
       'D_DisCount $Float Default 0, D_DisMoney $Float Default 0)';
  {-----------------------------------------------------------------------------
   发票明细:InvoiceDetail
   *.D_ID:编号
   *.D_Invoice:票号
   *.D_Type:类型(带,散)
   *.D_Stock:品种
   *.D_Price:单价
   *.D_Value:开票量
   *.D_KPrice:开票价
   *.D_DisCount:折扣比
   *.D_DisMoney:折扣钱数
  -----------------------------------------------------------------------------}

  sSQL_NewInvoiceReq = 'Create Table $Table(R_ID $Inc, R_Week varChar(15),' +
       'R_ZhiKa varChar(15), R_CusID varChar(15), R_Customer varChar(80),' +
       'R_CusPY varChar(80), R_SaleID varChar(15), R_SaleMan varChar(50), ' +
       'R_Type Char(1), R_Stock varChar(20), R_StockName varChar(80), ' +
       'R_Price $Float, R_Value $Float, R_YunFei $Float,' +
       'R_PreHasK $Float Default 0, R_ReqValue $Float, R_KPrice $Float,' +
       'R_KValue $Float Default 0, R_KOther $Float Default 0,' +
       'R_KMan varChar(32),R_KDate DateTime,R_Man varChar(32),R_Date DateTime)';
  {-----------------------------------------------------------------------------
   发票结算申请:InvoiceReq
   *.R_ID:记录编号
   *.R_Week:结算周期
   *.R_ZhiKa: 纸卡编号
   *.R_CusID:客户号
   *.R_Customer,R_CusPY:客户名
   *.R_SaleID:业务员号
   *.R_SaleMan:业务员名
   *.R_Type:水泥类型(D,S)
   *.R_Stock,R_StockName:水泥品种
   *.R_Price:单价
   *.R_Value:提货量
   *.R_YunFei:运费单价
   *.R_PreHasK:之前已开量
   *.R_ReqValue:申请量
   *.R_KPrice:开票单价
   *.R_KValue:申请已完成量
   *.R_KOther:本周申请量之外已开
   *.R_KMan,R_KDate: 结算人
   *.R_Man:申请人
   *.R_Date:申请时间
  -----------------------------------------------------------------------------}

  sSQL_NewInvoiceSettle = 'Create Table $Table(R_ID $Inc, S_Week varChar(15),' +
       'S_Bill varChar(15), S_CusID varChar(15), S_ZhiKa varChar(15),' +
       'S_Stock varChar(20), S_Value $Float, S_Price $Float, S_YunFei $Float,' +
       'S_OutFact DateTime, S_Man varChar(32), S_Date DateTime)';
  {-----------------------------------------------------------------------------
   结算结算:InvoiceSettle
   *.R_ID:记录编号
   *.S_Week: 结算周期
   *.S_Bill: 交货单号
   *.S_CusID: 客户编号
   *.S_ZhiKa: 纸卡编号
   *.S_Stock: 品种编号
   *.S_Value: 发货量
   *.S_Price: 返利单价
   *.S_YunFei: 运费单价
   *.S_OutFact: 出厂时间
   *.S_Man: 结算人
   *.S_Date: 结算时间
  -----------------------------------------------------------------------------}

  sSQL_NewXHSpot = 'Create Table $Table(R_ID $Inc, X_XHSpot varChar(100) )';
  {-----------------------------------------------------------------------------
   卸货地点维护: S_XHSpot
   *.R_ID: 编号
   *.X_XHSpot: 卸货地点
  -----------------------------------------------------------------------------}


  sSQL_NewKDInfo = 'Create Table $Table(R_ID $Inc, S_KDName varChar(100) )';
  {-----------------------------------------------------------------------------
   矿点信息维护: S_KDInfo
   *.R_ID     : 编号
   *.S_KDName: 矿点名称
  -----------------------------------------------------------------------------}

  sSQL_NewDriverWh = 'Create Table $Table(R_ID $Inc, D_Name varChar(100), '+
    ' D_PinYin varchar(80), D_PY varchar(80),D_IDCard varchar(20))';
  {-----------------------------------------------------------------------------
   司机信息维护: S_DriverWH
   *.R_ID: 编号
   *.D_Name: 司机姓名
   *.D_PinYin: 姓名全拼
   *.D_PY:拼音缩写
   *.D_IDCard:身份证号
  -----------------------------------------------------------------------------}

  sSQL_NewWXLog = 'Create Table $Table(R_ID $Inc, L_UserID varChar(50), ' +
       'L_Data varChar(2000), L_MsgID varChar(20), L_Result varChar(150),' +
       'L_Count Integer Default 0, L_Status Char(1), ' +
       'L_Comment varChar(100), L_Date DateTime)';
  {-----------------------------------------------------------------------------
   微信发送日志:WeixinLog
   *.R_ID:记录编号
   *.L_UserID: 接收者ID
   *.L_Data:微信数据
   *.L_Count:发送次数
   *.L_MsgID: 微信返回标识
   *.L_Result:发送返回信息
   *.L_Status:发送状态(N待发送,I发送中,Y已发送)
   *.L_Comment:备注
   *.L_Date: 发送时间
  -----------------------------------------------------------------------------}

  sSQL_NewWXMatch = 'Create Table $Table(R_ID $Inc, M_ID varChar(15), ' +
       'M_WXID varChar(50), M_WXName varChar(64), M_WXFactory varChar(15), ' +
       'M_IsValid Char(1), M_Comment varChar(100), ' +
       'M_AttentionID varChar(32), M_AttentionType Char(1))';
  {-----------------------------------------------------------------------------
   微信账户:WeixinMatch
   *.R_ID:记录编号
   *.M_ID: 微信编号
   *.M_WXID:开发ID
   *.M_WXName:微信名
   *.M_WXFactory:微信注册工厂编码
   *.M_IsValid: 是否有效
   *.M_Comment: 备注             
   *.M_AttentionID,M_AttentionType: 微信关注客户ID,类型(S、业务员;C、客户;G、管理员)
  -----------------------------------------------------------------------------}

  sSQL_NewWXTemplate = 'Create Table $Table(R_ID $Inc, W_Type varChar(15), ' +
       'W_TID varChar(50), W_TFields varChar(64), ' +
       'W_TComment Char(300), W_IsValid Char(1))';
  {-----------------------------------------------------------------------------
   微信账户:WeixinMatch
   *.R_ID:记录编号
   *.W_Type:类型
   *.W_TID:标识
   *.W_TFields:数据域段
   *.W_IsValid: 是否有效
   *.W_TComment: 备注
  -----------------------------------------------------------------------------}

  sSQL_NewProvider = 'Create Table $Table(R_ID $Inc, P_ID varChar(32),' +
       'P_Name varChar(80),P_PY varChar(80), P_Phone varChar(20),' +
       'P_Saler varChar(32),p_WechartAccount varchar(32),P_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   供应商: Provider
   *.P_ID: 编号
   *.P_Name: 名称
   *.P_PY: 拼音简写
   *.P_Phone: 联系方式
   *.p_WechartAccount：商城账号
   *.P_Saler: 业务员
   *.P_Memo: 备注
  -----------------------------------------------------------------------------}

  sSQL_NewMaterails = 'Create Table $Table(R_ID $Inc, M_ID varChar(32),' +
       'M_Name varChar(80),M_PY varChar(80),M_Unit varChar(20),M_Price $Float,' +
       'M_PrePValue Char(1), M_PrePTime Integer, M_Memo varChar(50), ' +
       'M_YS2Times char(1), M_HYSYS char(1))';
  {-----------------------------------------------------------------------------
   物料表: Materails
   *.M_ID: 编号
   *.M_Name: 名称
   *.M_PY: 拼音简写
   *.M_Unit: 单位
   *.M_PrePValue: 预置皮重
   *.M_PrePTime: 皮重时长(天)
   *.M_Memo: 备注
   *.M_IsSale: 销售品种
   *.M_HasLs: 是否生成矿发流水
   *.M_YS2Times 是否两次验收 Y:两次验收 N:一次验收
   *.M_HYSYS    Y:化验室验收  N:物流部验收
  -----------------------------------------------------------------------------}

  sSQL_NewStockParam = 'Create Table $Table(P_ID varChar(15), P_Stock varChar(30),' +
       'P_Type Char(1), P_Name varChar(50), P_QLevel varChar(20), P_Memo varChar(50),' +
       'P_MgO varChar(20), P_SO3 varChar(20), P_ShaoShi varChar(20),' +
       'P_CL varChar(20), P_BiBiao varChar(20), P_ChuNing varChar(20),' +
       'P_ZhongNing varChar(20), P_AnDing varChar(20), P_XiDu varChar(20),' +
       'P_Jian varChar(20), P_ChouDu varChar(20), P_BuRong varChar(20),' +
       'P_YLiGai varChar(20), P_Water varChar(20), P_KuangWu varChar(20),' +
       'P_GaiGui varChar(20), P_3DZhe varChar(20), P_28Zhe varChar(20),' +
       'P_3DYa varChar(20), P_28Ya varChar(20))';
  {-----------------------------------------------------------------------------
   品种参数:StockParam
   *.P_ID:记录编号
   *.P_Stock:品名
   *.P_Type:类型(袋,散)
   *.P_Name:等级名
   *.P_QLevel:强度等级
   *.P_Memo:备注
   *.P_MgO:氧化镁
   *.P_SO3:三氧化硫
   *.P_ShaoShi:烧失量
   *.P_CL:氯离子
   *.P_BiBiao:比表面积
   *.P_ChuNing:初凝时间
   *.P_ZhongNing:终凝时间
   *.P_AnDing:安定性
   *.P_XiDu:细度
   *.P_Jian:碱含量
   *.P_ChouDu:稠度
   *.P_BuRong:不溶物
   *.P_YLiGai:游离钙
   *.P_Water:保水率
   *.P_KuangWu:硅酸盐矿物
   *.P_GaiGui:钙硅比
   *.P_3DZhe:3天抗折强度
   *.P_28DZhe:28抗折强度
   *.P_3DYa:3天抗压强度
   *.P_28DYa:28抗压强度
  -----------------------------------------------------------------------------}

  sSQL_NewYCLParam = 'Create Table $Table(P_ID varChar(15), P_Stock varChar(30),' +
       'P_Memo varChar(50),  P_Fe2O3 varChar(20), P_Water varChar(20),' +
       'P_Jian varChar(20),  P_Al2O3 varChar(20),' +
       'P_SiO2 varChar(20),  P_YMWater varChar(20),' +
       'P_Hui varChar(20),   P_HuiFa varChar(20), ' +
       'P_SO3 varChar(20),   P_JJH2O varChar(20),' +
       'P_CL varChar(20),    P_CaO varChar(20), P_BiBiao varChar(20),' +
       'P_ShaoShi varChar(20),  P_AnDing varChar(20),' +
       'P_MgO varChar(20))';
  {-----------------------------------------------------------------------------
   品种参数:StockParam
   *.P_ID:记录编号
   *.P_Stock:品名
   *.P_Memo:备注
   *.P_Fe2O3:三氧化二铁
   *.P_Water:水分
   *.P_Jian:碱含量
   *.P_Al2O3:三氧化二铝
   *.P_SiO2:二氧化硅
   *.P_YMWater:进厂原煤水分
   *.P_Hui:灰份
   *.P_HuiFa:挥发份
   *.P_SO3:三氧化硫
   *.P_JJH2O:结晶水
   *.P_CL:氯离子
   *.P_CaO:氧化钙
   *.P_BiBiao:比表面积
   *.P_ShaoShi:烧失量
   *.P_AnDing:安定性
   *.P_MgO:氧化镁
  -----------------------------------------------------------------------------}

  sSQL_NewStockRecord = 'Create Table $Table(R_ID $Inc, R_SerialNo varChar(15),' +
       'R_PID varChar(15),' +
       'R_SGType varChar(20), R_SGValue varChar(20),' +
       'R_HHCType varChar(20), R_HHCValue varChar(20),' +
       'R_MgO varChar(20), R_SO3 varChar(20), R_ShaoShi varChar(20),' +
       'R_CL varChar(20), R_BiBiao varChar(20), R_ChuNing varChar(20),' +
       'R_ZhongNing varChar(20), R_AnDing varChar(20), R_XiDu varChar(20),' +
       'R_Jian varChar(20), R_ChouDu varChar(20), R_BuRong varChar(20),' +
       'R_YLiGai varChar(20), R_Water varChar(20), R_KuangWu varChar(20),' +
       'R_GaiGui varChar(20),' +
       'R_3DZhe1 varChar(20), R_3DZhe2 varChar(20), R_3DZhe3 varChar(20),' +
       'R_28Zhe1 varChar(20), R_28Zhe2 varChar(20), R_28Zhe3 varChar(20),' +
       'R_3DYa1 varChar(20), R_3DYa2 varChar(20), R_3DYa3 varChar(20),' +
       'R_3DYa4 varChar(20), R_3DYa5 varChar(20), R_3DYa6 varChar(20),' +
       'R_28Ya1 varChar(20), R_28Ya2 varChar(20), R_28Ya3 varChar(20),' +
       'R_28Ya4 varChar(20), R_28Ya5 varChar(20), R_28Ya6 varChar(20),' +
       'R_FMH varChar(20), R_ZMJ varChar(20), R_RMLZ varChar(20), R_KF varChar(20),' +
       'R_FMHXSLB varChar(32),R_FMHMD varChar(32),R_FMHZLFS varChar(32),R_FMHHXZS varChar(32),' +
       'R_JZSYSZB varChar(32),R_JZSBGMD varChar(32),R_JZSSSDJMD varChar(32),R_JZSKXL varChar(32),' +
       'R_JZSFKS475 varChar(32),R_JZSFKS236 varChar(32),R_JZSFKS118 varChar(32),R_JZSMBZ varChar(20),'+
       ' R_JZSSFHL varChar(20), R_JZSNKHL varChar(20), R_JZSJGXZB varChar(20), ' +
       'R_JZSFKS060 varChar(32),R_JZSFKS030 varChar(32),R_JZSFKS015 varChar(32),R_JZSXDMS varChar(32),' +
       'R_Date DateTime, R_Man varChar(32),R_assay_time varChar(50),R_cao varChar(50),R_create_time varChar(50), ' +
       'R_f_cao varChar(50), R_fineness_045 varChar(50),R_fineness_08 varChar(50),R_material_id varChar(50), ' +
       'R_record_user_id varChar(50),R_thick varChar(50),R_material_name varChar(100),R_mortar_flow varChar(100),'+
       'R_packaging_method varChar(50), R_1DZhe1 varChar(50),R_1DYa1 varChar(50) )';
  {-----------------------------------------------------------------------------
   检验记录:StockRecord
   *.R_ID:记录编号
   *.R_SerialNo:水泥编号
   *.R_PID:品种参数
   *.R_SGType: 石膏种类
   *.R_SGValue: 石膏掺入量
   *.R_HHCType: 混合材料类
   *.R_HHCValue: 混合材掺入量
   *.R_MgO:氧化镁 (有)
   *.R_SO3:三氧化硫 (有)
   *.R_ShaoShi:烧失量 (有)
   *.R_CL:氯离子 (有)
   *.R_BiBiao:比表面积 (有)
   *.R_ChuNing:初凝时间 (有)
   *.R_ZhongNing:终凝时间 (有)
   *.R_AnDing:安定性
   *.R_XiDu:细度
   *.R_Jian:碱含量
   *.R_ChouDu:稠度
   *.R_BuRong:不溶物
   *.R_YLiGai:游离钙
   *.R_Water:保水率 (有)
   *.R_KuangWu:硅酸盐矿物
   *.R_GaiGui:钙硅比
   *.R_3DZhe1:3天抗折强度1
   *.R_3DZhe2:3天抗折强度2
   *.R_3DZhe3:3天抗折强度3
   *.R_28Zhe1:28抗折强度1
   *.R_28Zhe2:28抗折强度2
   *.R_28Zhe3:28抗折强度3
   *.R_3DYa1:3天抗压强度1
   *.R_3DYa2:3天抗压强度2
   *.R_3DYa3:3天抗压强度3
   *.R_3DYa4:3天抗压强度4
   *.R_3DYa5:3天抗压强度5
   *.R_3DYa6:3天抗压强度6
   *.R_28Ya1:28抗压强度1
   *.R_28Ya2:28抗压强度2
   *.R_28Ya3:28抗压强度3
   *.R_28Ya4:28抗压强度4
   *.R_28Ya5:28抗压强度5
   *.R_28Ya6:28抗压强度6
   *.R_Date:取样日期
   *.R_Man:录入人
   *.R_FMH:粉煤灰
   *.R_ZMJ:助磨剂
   *.R_RMLZ:燃煤炉渣
   *.R_KF:矿粉
   *.R_FMHXSLB:需水量比
   *.R_FMHMD:密度
   *.R_FMHZLFS:质量分数
   *.R_FMHHXZS:活性指数
   *.R_JZSMBZ:MB值
   *.R_JZSSFHL:石粉含量
   *.R_JZSNKHL:泥块含量
   *.R_JZSJGXZB:坚固性指标
   *.R_JZSYSZB:压碎指标
   *.R_JZSBGMD:表观密度
   *.R_JZSSSDJMD:松散堆积密度
   *.R_JZSKXL:孔隙率
   *.R_JZSFKS475:方孔筛4.75
   *.R_JZSFKS236:方孔筛2.36
   *.R_JZSFKS118:方孔筛1.18
   *.R_JZSFKS060:方孔筛0.6
   *.R_JZSFKS030:方孔筛0.3
   *.R_JZSFKS015:方孔筛0.15
   *.R_JZSXDMS:细度模数
   *.R_assay_time:采集时间
   *.R_cao: 氧化钙
   *.R_create_time: 创建时间
   *.R_f_cao: fCao
   *.R_fineness_045:0.045细度
   *.R_fineness_08:0.08细度
   *.R_material_id: 材料ID
   *.R_record_user_id : 创建人
   *.R_thick: 标稠
   *.R_material_name: 水泥型号
   *.R_mortar_flow: 胶砂流动度采集值
   *.R_packaging_method: 包装方式
   *.R_1DZhe1:1天抗折强度1
   *.R_1DYa1:1天抗压
  -----------------------------------------------------------------------------}

  sSQL_NewYCLStockRecord = 'Create Table $Table(R_ID $Inc, R_SerialNo varChar(15),' +
       'R_PID varChar(15), R_Fe2O3 varChar(20), R_Water varChar(20),' +
       'R_Jian varChar(20),  R_Al2O3 varChar(20),' +
       'R_SiO2 varChar(20), R_ShaiLi varChar(20), R_YMWater varChar(20),' +
       'R_Hui varChar(20), R_HuiFa varChar(20), R_St_ad varChar(20),' +
       'R_Qnet_ar varChar(20), R_SO3 varChar(20), R_JJH2O varChar(20),' +
       'R_CL varChar(20), R_FSX varChar(100),' +
       'R_CaO varChar(20), R_Loss varChar(20), R_BiBiao varChar(20),' +
       'R_FMHHXZS varChar(20), ' +
       'R_ShaoShi varChar(20), R_f_Cao varChar(20), R_AnDing varChar(20),' +
       'R_MgO varChar(20), R_LiDu varChar(20))';
  {-----------------------------------------------------------------------------
   原材料检验记录:YCLStockRecord
   *.R_ID:记录编号
   *.R_SerialNo:品种编号
   *.R_PID:品种参数
   *.R_Fe2O3: 三氧化二铁
   *.R_Water: 水分
   *.R_Jian: 碱含量
   *.R_Al2O3: 三氧化二铝
   *.R_SiO2:二氧化硅
   *.R_ShaiLi:26.5mm标准筛粒度
   *.R_YMWater:进厂原煤水分
   *.R_Hui:灰份
   *.R_HuiFa:挥发份
   *.R_St_ad:St.ad
   *.R_Qnet_ar:Qnet.ar
   *.R_SO3:三氧化硫
   *.R_JJH2O:结晶水
   *.R_CL:氯离子
   *.R_FSX:放射性
   *.R_CaO:氧化钙
   *.R_Loss:Loss
   *.R_BiBiao:比表面积
   *.R_FMHHXZS:强度活性指数
   *.R_ShaoShi:烧矢量
   *.R_f_Cao: f-Cao
   *.R_AnDing:安定性
   *.R_MgO:氧化镁
   *.R_LiDu:粒度
  -----------------------------------------------------------------------------}

  sSQL_NewStockHuaYan = 'Create Table $Table(H_ID $Inc, H_No varChar(15),' +
       'H_Custom varChar(15), H_CusName varChar(80), H_SerialNo varChar(15),' +
       'H_Truck varChar(15), H_Value $Float, H_BillDate DateTime,' +
       'H_EachTruck Char(1), H_ReportDate DateTime, H_Reporter varChar(32),H_KindType char(1))';
  {-----------------------------------------------------------------------------
   开化验单:StockHuaYan
   *.H_ID:记录编号
   *.H_No:化验单号
   *.H_Custom:客户编号
   *.H_CusName:客户名称
   *.H_SerialNo:水泥编号
   *.H_Truck:提货车辆
   *.H_Value:提货量
   *.H_BillDate:提货日期
   *.H_EachTruck: 随车开单
   *.H_ReportDate:报告日期
   *.H_Reporter:报告人
   *.H_KindType:是否补单：Y：是
  -----------------------------------------------------------------------------}

  sSQL_NewSaleTotal1 = ' Create Table $Table(R_ID $Inc, R_Group varChar(100),' +
       'R_Stock1 $Float, R_Stock2 $Float, R_Stock3 $Float,R_Stock4 $Float, R_Stock5 $Float,' +
       'R_Stock6 $Float, R_Stock7 $Float, R_Stock8 $Float,R_Stock9 $Float, R_Stock10 $Float,' +
       'R_Sum1 $Float)';
  {-----------------------------------------------------------------------------
   销售统计1:S_SaleTotal1
   *.R_ID:记录编号
   *.R_Group:分组名称
   *.R_Stock1:品种1数量
   *.R_Stock2:品种2数量
   *.R_Stock3:品种3数量
   *.R_Stock4:品种4数量
   *.R_Stock5:品种5数量
   *.R_Stock6:品种6数量
   *.R_Stock7:品种37数量
   *.R_Stock8:品种8数量
   *.R_Stock9:品种9数量
   *.R_Stock10:品种10数量
   *.R_Sum1:品种合计数量
  -----------------------------------------------------------------------------}

  sSQL_NewStockBatcode = 'Create Table $Table(R_ID $Inc, B_Stock varChar(32),' +
       'B_Name varChar(80), B_Prefix varChar(5), B_UseYear Char(1),' +
       'B_Base Integer, B_Incement Integer, B_Length Integer, B_Type char(1), ' +
       'B_Value $Float, B_Low $Float, B_High $Float, B_Interval Integer,' +
       'B_AutoNew Char(1), B_UseDate Char(1), B_FirstDate DateTime,' +
       'B_LastDate DateTime, B_HasUse $Float Default 0, B_Batcode varChar(32))';
  {-----------------------------------------------------------------------------
   批次编码表: Batcode
   *.R_ID: 编号
   *.B_Stock: 物料号
   *.B_Name: 物料名
   *.B_Prefix: 前缀
   *.B_UseYear: 前缀后加两位年
   *.B_Base: 起始编码(基数)
   *.B_Incement: 编号增量
   *.B_Length: 编号长度
   *.B_Value:检测量
   *.B_Low,B_High:上下限(%)
   *.B_Interval: 编号周期(天)
   *.B_AutoNew: 元旦重置(Y/N)
   *.B_UseDate: 使用日期编码
   *.B_FirstDate: 首次使用时间
   *.B_LastDate: 上次基数更新时间
   *.B_HasUse: 已使用
   *.B_Batcode: 当前批次号
   *.B_Type: 批次分类
  -----------------------------------------------------------------------------}

  sSQL_NewK3SalePlan = 'Create Table $Table(R_ID $Inc, S_InterID Integer,' +
       'S_EntryID Integer, S_Truck varChar(15), S_Date DateTime)';
  {-----------------------------------------------------------------------------
   销售计划:SalePlan
   *.R_ID:记录编号
   *.S_InterID:主表号
   *.S_EntryID:附表号
   *.S_Truck:车牌号
   *.S_Date: 使用时间
  -----------------------------------------------------------------------------}

  sSQL_CardGrab = 'Create Table $Table(R_ID $Inc,P_Ls varChar(32), P_Card varChar(32),' +
       'P_Tunnel varChar(50))';
  {-----------------------------------------------------------------------------
   抓斗秤刷卡记录:
   *.P_Card: 磁卡编号
   *.P_Ls: 刷卡流水号
   *.P_Tunnel: 抓斗秤通道
  -----------------------------------------------------------------------------}

  sSQL_Grab = 'Create Table $Table(R_ID $Inc, ' +
       'G_ID varChar(32),G_Order varChar(32), G_Card varChar(32), G_Num Integer, ' +
       'G_Truck varChar(20),G_CusID varChar(32), G_CusName varChar(128), ' +
       'G_StockNo varChar(32),G_StockName varChar(128), G_EachWeight $Float,'+
       'G_TunnelID varChar(20),G_TunnelName varChar(32),'+
       'G_WeightTime DateTime, G_DelMan varChar(32), G_DelDate DateTime)';
  {-----------------------------------------------------------------------------
   商城发送模板消息表: WebSendMsgInfo
   *.R_ID: 编号
   *.G_ID: 每条船流水号
   *.G_Order: 采购单号
   *.G_Card: 卡号
   *.G_Num: 第Num次称重
   *.G_Truck: 车船号
   *.G_CusID: 客户编号
   *.G_CusName: 客户名称
   *.G_StockNo: 物料编号
   *.G_StockName: 物料名称
   *.G_TunnelID,G_TunnelName: 通道
   *.G_EachWeight: 第Num次称重重量
   *.G_WeightTime: 第Num次称重时间
   *.G_DelMan,G_DelDate: 删除记录
  -----------------------------------------------------------------------------}

//------------------------------------------------------------------------------
// 数据查询
//------------------------------------------------------------------------------
  sQuery_SysDict = 'Select D_ID, D_Value, D_Memo, D_ParamA, ' +
         'D_ParamB From $Table Where D_Name=''$Name'' Order By D_Index ASC';
  {-----------------------------------------------------------------------------
   从数据字典读取数据
   *.$Table:数据字典表
   *.$Name:字典项名称
  -----------------------------------------------------------------------------}

  sQuery_ExtInfo = 'Select I_ID, I_Item, I_Info From $Table Where ' +
         'I_Group=''$Group'' and I_ItemID=''$ID'' Order By I_Index Desc';
  {-----------------------------------------------------------------------------
   从扩展信息表读取数据
   *.$Table:扩展信息表
   *.$Group:分组名称
   *.$ID:信息标识
  -----------------------------------------------------------------------------}

  sSQL_NewWebOrderMatch = 'Create Table $Table(R_ID $Inc,'
      +'WOM_WebOrderID varchar(32) null,'
      +'WOM_LID varchar(20) null,'
      +'WOM_StatusType Integer,'
      +'WOM_MsgType Integer,'
      +'WOM_BillType char(1),'
      +'WOM_SyncNum Integer default 0,'
      +'WOM_deleted char(1) default ''N'')';
  {-----------------------------------------------------------------------------
   商城订单与提货单对照表: WebOrderMatch
   *.R_ID: 记录编号
   *.WOM_WebOrderID: 商城订单
   *.WOM_LID: 提货单
   *.WOM_StatusType: 订单状态 0.开卡  1.完成
   *.WOM_MsgType: 消息类型 开单  出厂  报表 删单
   *.WOM_SyncNum: 发送次数
   *.WOM_BillType: 业务类型  采购 销售
  -----------------------------------------------------------------------------}
  sSQL_NewTransBase = 'Create Table $Table(R_ID $Inc, B_ID varChar(20),' +
       'B_CType Char(1), B_Card varChar(32), B_Truck varChar(15), ' +
       'B_TID varChar(15), B_SrcAddr varChar(160), B_DestAddr varChar(160),' +
       'B_Type Char(1), B_StockNo varChar(32), B_StockName varChar(160),' +
       'B_PValue $Float, B_PDate DateTime, B_PMan varChar(32),' +
       'B_MValue $Float, B_MDate DateTime, B_MMan varChar(32),' +
       'B_Status Char(1), B_NextStatus Char(1), B_IsUsed Char(1),' +
       'B_Value $Float, B_Man varChar(32), B_Date DateTime,' +
       'B_DelMan varChar(32), B_DelDate DateTime, B_Memo varChar(500),'+
       'B_IsNei char(1) Default ''N'')';
  {-----------------------------------------------------------------------------
   短倒基础表: TransBase
   *.R_ID: 编号
   *.B_ID: 短倒基础编号
   *.B_Card: 磁卡号
   *.B_Truck: 车牌号
   *.B_SrcAddr:倒出地点
   *.B_DestAddr:倒入地点
   *.B_Type: 类型(袋,散)
   *.B_StockNo: 物料编号
   *.B_StockName: 物料描述
   *.B_PValue,B_PDate,B_PMan: 称皮重
   *.B_MValue,B_MDate,B_MMan: 称毛重
   *.B_Status: 当前车辆状态
   *.B_NextStus: 下一状态
   *.B_IsUsed: 订单是否占用(Y、正在使用;N、未占用)
   *.B_Value: 收货量
   *.B_Man,B_Date: 单据信息
   *.B_DelMan,B_DelDate: 删除信息
   *.B_IsNei : 厂内倒料车辆   Y、N
  -----------------------------------------------------------------------------}

  sSQL_NewZTCard = 'Create Table $Table(R_ID $Inc, C_Truck varChar(15), ' +
         'C_Card varChar(20), C_Bill varChar(20), C_Line varChar(20), ' +
         'C_BusinessTime DateTime)';
    {-----------------------------------------------------------------------------
     客户信息表: Customer
     *.R_ID: 记录号
     *.C_Truck: 车牌号
     *.C_Card: 磁卡号
     *.C_Bill: 单据号
     *.C_Line: 装车道
     *.C_BusinessTime: 刷卡时间
    -----------------------------------------------------------------------------}

  sSQL_NewTransfer = 'Create Table $Table(R_ID $Inc, T_ID varChar(20),' +
       'T_Card varChar(32), T_Truck varChar(15), T_PID varChar(15),' +
       'T_SrcAddr varChar(160), T_DestAddr varChar(160),' +
       'T_Type Char(1), T_StockNo varChar(32), T_StockName varChar(160),' +
       'T_PValue $Float, T_PDate DateTime, T_PMan varChar(32),' +
       'T_MValue $Float, T_MDate DateTime, T_MMan varChar(32),' +
       'T_Status Char(1), T_NextStatus Char(1), ' +
       'T_Value $Float, T_Man varChar(32), T_Date DateTime,' +
       'T_InTime DateTime, T_InMan varChar(32),' +
       'T_OutFact DateTime, T_OutMan varChar(32),' +
       'T_DelMan varChar(32), T_DelDate DateTime, T_Memo varChar(500))';
  {-----------------------------------------------------------------------------
   入厂表: Transfer
   *.R_ID: 编号
   *.T_ID: 短倒业务号
   *.T_PID: 磅单编号
   *.T_Card: 磁卡号
   *.T_Truck: 车牌号
   *.T_SrcAddr:倒出地点
   *.T_DestAddr:倒入地点
   *.T_Type: 类型(袋,散)
   *.T_StockNo: 物料编号
   *.T_StockName: 物料描述
   *.T_PValue,T_PDate,T_PMan: 称皮重
   *.T_MValue,T_MDate,T_MMan: 称毛重
   *.T_Value: 收货量
   *.T_Man,T_Date: 单据信息
   *.T_InMan,T_InTime:进场信息
   *.T_OutMan,T_OutFact:出厂信息
   *.T_DelMan,T_DelDate: 删除信息
  -----------------------------------------------------------------------------}

  sSQL_NewMonthSales = 'Create Table $Table(R_ID $Inc, M_Area varChar(30),' +
      'M_1M $Float, M_1P $Float, M_2M $Float, M_2P $Float,'+
      'M_3M $Float, M_3P $Float, M_4M $Float, M_4P $Float,'+
      'M_5M $Float, M_5P $Float, M_6M $Float, M_6P $Float,'+
      'M_7M $Float, M_7P $Float, M_8M $Float, M_8P $Float,'+
      'M_9M $Float, M_9P $Float, M_10M $Float, M_10P $Float,'+
      'M_11M $Float, M_11P $Float, M_12M $Float, M_12P $Float,'+
      'M_YearM $Float, M_YearP $Float,'+
      'M_Valid varchar(1) Default ''Y'',M_Man varchar(20),M_Date DateTime)';
  {-----------------------------------------------------------------------------
  *.R_ID: 编号

  -----------------------------------------------------------------------------}

  sSQL_NewMonthPrice = 'Create Table $Table(R_ID $Inc, M_Area varChar(30),' +
      'M_1M $Float, M_2M $Float,'+
      'M_3M $Float, M_4M $Float,'+
      'M_5M $Float, M_6M $Float,'+
      'M_7M $Float, M_8M $Float,'+
      'M_9M $Float, M_10M $Float,'+
      'M_11M $Float, M_12M $Float,'+
      'M_YearM $Float,'+
      'M_Valid varchar(1) Default ''Y'',M_Man varchar(20),M_Date DateTime)';
  {-----------------------------------------------------------------------------
  *.R_ID: 编号

  -----------------------------------------------------------------------------}

  sSQL_NewSalesCredit = 'Create Table $Table(R_ID $Inc ,C_SalesID varChar(15),' +
       'C_SalesName varChar(50), C_Money Decimal(15,5), C_Man varChar(32), C_Date DateTime, ' +
       'C_End DateTime, C_Verify Char(1) Default ''N'', C_VerMan varChar(32),' +
       'C_VerDate DateTime, C_Memo varChar(50))';
  {-----------------------------------------------------------------------------
   信用明细:CustomerCredit
   *.R_ID:编号
   *.C_SalesID:客户编号
   *.C_SalesName:客户名称
   *.C_Money:授信额
   *.C_Man:操作人
   *.C_Date:日期
   *.C_End: 有效期
   *.C_Verify: 已审核(Y/N)
   *.C_VerMan,C_VerDate: 审核
   *.C_Memo:备注
  -----------------------------------------------------------------------------}

  sSQL_NewSCControlInfo = 'Create Table $Table(R_ID $Inc, C_SaleID varChar(32),' +
       'C_SaleName varChar(150), C_StockNo varChar(32), C_StockName varChar(150),' +
       'C_Valid char(1) default ''Y'', C_Value Decimal(15,5) Default 0, C_Memo varchar(200))';
  {-----------------------------------------------------------------------------
   业务员限量控制表:
   *.R_ID: 编号
   *.C_SaleID: 业务员编号
   *.C_SaleName: 业务员名称
   *.C_StockNo: 物料编号
   *.C_StockName: 物料名称
   *.C_Valid: 是否有效
   *.C_Value: 控制量
   *.C_Memo: 备注
  -----------------------------------------------------------------------------}

  sSQL_NewPMControlInfo = 'Create Table $Table(R_ID $Inc, C_CusID varChar(32),' +
       'C_CusName varChar(150), C_StockNo varChar(32), C_StockName varChar(150),' +
       'C_Type char(1) default ''0'' , C_Value $Float default 0,' +
       'C_Valid char(1) default ''Y'', C_Memo varchar(200))';
  {-----------------------------------------------------------------------------
   原材料进厂控制表:
   *.R_ID: 编号
   *.C_Type: 控制类型  0 即时控制  1按日进厂量控制  2按月进厂量控制
   *.C_CusID: 客户编号
   *.C_CusName: 客户名称
   *.C_StockNo: 物料编号
   *.C_StockName: 物料名称
   *.C_Value: 进厂上限
   *.C_Valid: 是否有效
   *.C_Memo: 备注
  -----------------------------------------------------------------------------}


function CardStatusToStr(const nStatus: string): string;
//磁卡状态
function TruckStatusToStr(const nStatus: string): string;
//车辆状态
function BillTypeToStr(const nType: string): string;
//订单类型
function PostTypeToStr(const nPost: string): string;
//岗位类型
function BusinessToStr(const nBus: string): string;
//业务类型

implementation

//Desc: 将nStatus转为可读内容
function CardStatusToStr(const nStatus: string): string;
begin
  if nStatus = sFlag_CardIdle then Result := '空闲' else
  if nStatus = sFlag_CardUsed then Result := '正常' else
  if nStatus = sFlag_CardLoss then Result := '挂失' else
  if nStatus = sFlag_CardInvalid then Result := '注销' else Result := '未知';
end;

//Desc: 将nStatus转为可识别的内容
function TruckStatusToStr(const nStatus: string): string;
begin
  if nStatus = sFlag_TruckIn then Result := '进厂' else
  if nStatus = sFlag_TruckOut then Result := '出厂' else
  if nStatus = sFlag_TruckBFP then Result := '称皮重' else
  if nStatus = sFlag_TruckBFM then Result := '称毛重' else
  if nStatus = sFlag_TruckSH then Result := '送货中' else
  if nStatus = sFlag_TruckXH then Result := '验收处' else
  if nStatus = sFlag_TruckFH then Result := '放灰处' else
  if nStatus = sFlag_TruckZT then Result := '栈台' else Result := '未进厂';
end;

//Desc: 交货单类型转为可识别内容
function BillTypeToStr(const nType: string): string;
begin
  if nType = sFlag_TypeShip then Result := '船运' else
  if nType = sFlag_TypeZT   then Result := '栈台' else
  if nType = sFlag_TypeVIP  then Result := 'VIP' else Result := '普通';
end;

//Desc: 将岗位转为可识别内容
function PostTypeToStr(const nPost: string): string;
begin
  if nPost = sFlag_TruckIn   then Result := '门卫进厂' else
  if nPost = sFlag_TruckOut  then Result := '门卫出厂' else
  if nPost = sFlag_TruckBFP  then Result := '磅房称皮' else
  if nPost = sFlag_TruckBFM  then Result := '磅房称重' else
  if nPost = sFlag_TruckFH   then Result := '散装放灰' else
  if nPost = sFlag_TruckZT   then Result := '袋装栈台' else Result := '厂外';
end;

//------------------------------------------------------------------------------
//Desc: 添加系统表项
procedure AddSysTableItem(const nTable,nNewSQL: string);
var nP: PSysTableItem;
begin
  New(nP);
  gSysTableList.Add(nP);

  nP.FTable := nTable;
  nP.FNewSQL := nNewSQL;
end;

//Desc: 系统表
procedure InitSysTableList;
begin
  gSysTableList := TList.Create;

  AddSysTableItem(sTable_SysDict, sSQL_NewSysDict);
  AddSysTableItem(sTable_ExtInfo, sSQL_NewExtInfo);
  AddSysTableItem(sTable_SysLog, sSQL_NewSysLog);

  AddSysTableItem(sTable_BaseInfo, sSQL_NewBaseInfo);
  AddSysTableItem(sTable_SerialBase, sSQL_NewSerialBase);
  AddSysTableItem(sTable_SerialStatus, sSQL_NewSerialStatus);
  AddSysTableItem(sTable_StockMatch, sSQL_NewStockMatch);
  AddSysTableItem(sTable_WorkePC, sSQL_NewWorkePC);
  AddSysTableItem(sTable_Factorys, sSQL_NewFactorys);
  AddSysTableItem(sTable_ManualEvent, sSQL_NewManualEvent);

  AddSysTableItem(sTable_Customer, sSQL_NewCustomer);
  AddSysTableItem(sTable_Salesman, sSQL_NewSalesMan);
  AddSysTableItem(sTable_SaleContract, sSQL_NewSaleContract);
  AddSysTableItem(sTable_SContractExt, sSQL_NewSContractExt);

  AddSysTableItem(sTable_CusAccount, sSQL_NewCusAccount);
  AddSysTableItem(sTable_InOutMoney, sSQL_NewInOutMoney);
  AddSysTableItem(sTable_CusCredit, sSQL_NewCusCredit);
  AddSysTableItem(sTable_SysShouJu, sSQL_NewSysShouJu);

  AddSysTableItem(sTable_InvoiceWeek, sSQL_NewInvoiceWeek);
  AddSysTableItem(sTable_Invoice, sSQL_NewInvoice);
  AddSysTableItem(sTable_InvoiceDtl, sSQL_NewInvoiceDtl);
  AddSysTableItem(sTable_InvoiceReq, sSQL_NewInvoiceReq);
  AddSysTableItem(sTable_InvReqtemp, sSQL_NewInvoiceReq);
  AddSysTableItem(sTable_InvSettle, sSQL_NewInvoiceSettle);
  AddSysTableItem(sTable_DataTemp, sSQL_NewDataTemp);

  AddSysTableItem(sTable_WeixinLog, sSQL_NewWXLog);
  AddSysTableItem(sTable_WeixinMatch, sSQL_NewWXMatch);
  AddSysTableItem(sTable_WeixinTemp, sSQL_NewWXTemplate);

  AddSysTableItem(sTable_ZhiKa, sSQL_NewZhiKa);
  AddSysTableItem(sTable_ZhiKaDtl, sSQL_NewZhiKaDtl);
  AddSysTableItem(sTable_PriceRule, sSQL_NewPriceRule);
  AddSysTableItem(sTable_Card, sSQL_NewCard);
  AddSysTableItem(sTable_Bill, sSQL_NewBill);
  AddSysTableItem(sTable_YYWebBill,sSQL_NewYYWeb);
  AddSysTableItem(sTable_BillBak, sSQL_NewBill);
  AddSysTableItem(sTable_BillHK, sSQL_NewBillHK);

  AddSysTableItem(sTable_Truck, sSQL_NewTruck);
  AddSysTableItem(sTable_PayingUnit, sSQL_NewPayingUnit);
  AddSysTableItem(sTable_YCLquality, sSQL_NewYCLQuality_data);
  AddSysTableItem(sTable_ZTLines, sSQL_NewZTLines);
  AddSysTableItem(sTable_ZTTrucks, sSQL_NewZTTrucks);
  AddSysTableItem(sTable_PoundLog, sSQL_NewPoundLog);
  AddSysTableItem(sTable_PoundBak, sSQL_NewPoundLog);
  AddSysTableItem(sTable_Picture, sSQL_NewPicture);
  AddSysTableItem(sTable_PoundDaiWC, sSQL_NewPoundDaiWC);
  AddSysTableItem(sTable_Provider, ssql_NewProvider);
  AddSysTableItem(sTable_Materails, sSQL_NewMaterails);

  AddSysTableItem(sTable_KSKD, sSQL_NewKSKD);

  AddSysTableItem(sTable_StockParam, sSQL_NewStockParam);
  AddSysTableItem(sTable_YCLParam,   sSQL_NewYCLParam);
  AddSysTableItem(sTable_StockParamExt, sSQL_NewStockRecord);
  AddSysTableItem(sTable_YCLParamExt, sSQL_NewYCLStockRecord);
  AddSysTableItem(sTable_StockRecord, sSQL_NewStockRecord);
  AddSysTableItem(sTable_YCLRecord, sSQL_NewYCLStockRecord);
  AddSysTableItem(sTable_StockHuaYan, sSQL_NewStockHuaYan);
  AddSysTableItem(sTable_StockBatcode, sSQL_NewStockBatcode);
  AddSysTableItem(sTable_SaleTotal1, sSQL_NewSaleTotal1);

  AddSysTableItem(sTable_Order, sSQL_NewOrder);
  AddSysTableItem(sTable_OrderBak, sSQL_NewOrder);
  AddSysTableItem(sTable_OrderDtl, sSQL_NewOrderDtl);
  AddSysTableItem(sTable_OrderDtlBak, sSQL_NewOrderDtl);
  AddSysTableItem(sTable_OrderBase, sSQL_NewOrderBase);
  AddSysTableItem(sTable_OrderBaseBak, sSQL_NewOrderBase);

  AddSysTableItem(sTable_K3_SalePlan, sSQL_NewK3SalePlan);
  AddSysTableItem(sTable_WebOrderMatch,sSQL_NewWebOrderMatch);
  AddSysTableItem(sTable_AuditTruck, sSQL_NewAuditTruck);

  AddSysTableItem(sTable_CardGrab, sSQL_CardGrab);
  AddSysTableItem(sTable_Grab, sSQL_Grab);
  AddSysTableItem(sTable_GrabBak, sSQL_Grab);

  //内倒业务表
  AddSysTableItem(sTable_TransBase, sSQL_NewTransBase);
  AddSysTableItem(sTable_TransBaseBak, sSQL_NewTransBase);
  AddSysTableItem(sTable_Transfer, sSQL_NewTransfer);
  AddSysTableItem(sTable_TransferBak, sSQL_NewTransfer);

  //卸货地点维护
  AddSysTableItem(sTable_XHSpot, sSQL_NewXHSpot);
  //矿点信息维护
  AddSysTableItem(sTable_KDInfo, sSQL_NewKDInfo);
  //司机信息维护
  AddSysTableItem(sTable_DriverWh,sSQL_NewDriverWh);

  AddSysTableItem(sTable_MonthSales, sSQL_NewMonthSales);
  AddSysTableItem(sTable_MonthPrice, sSQL_NewMonthPrice);

  AddSysTableItem(sTable_ZTCard,sSQL_NewZTCard);

  AddSysTableItem(sTable_SalesCredit, sSQL_NewSalesCredit);
  AddSysTableItem(sTable_PMaterailControl,sSQL_NewPMControlInfo);

  AddSysTableItem(sTable_SCustomerControl,sSQL_NewSCControlInfo);
end;

//Desc: 清理系统表
procedure ClearSysTableList;
var nIdx: integer;
begin
  for nIdx:= gSysTableList.Count - 1 downto 0 do
  begin
    Dispose(PSysTableItem(gSysTableList[nIdx]));
    gSysTableList.Delete(nIdx);
  end;

  FreeAndNil(gSysTableList);
end;

//Desc: 业务类型转为可识别内容
function BusinessToStr(const nBus: string): string;
begin
  if nBus = sFlag_Sale       then Result := '销售' else
  if nBus = sFlag_Provide    then Result := '供应' else
  if nBus = sFlag_Returns    then Result := '退货' else
  if nBus = sFlag_DuanDao    then Result := '短倒' else
  //if nBus = sFlag_WaiXie     then Result := '外协' else
  if nBus = sFlag_Other      then Result := '其它';
end;

initialization
  InitSysTableList;
finalization
  ClearSysTableList;
end.


