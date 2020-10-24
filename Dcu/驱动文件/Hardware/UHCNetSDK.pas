{*******************************************************************************
  ����: dmzn@163.com 2017-10-17
  ����: ��������SDK��������������
*******************************************************************************}
unit UHCNetSDK;

interface

const
  /// <summary>
  /// CHCNetSDK ��ժҪ˵����
  /// </summary>
  //
  // TODO: �ڴ˴���ӹ��캯���߼�
  //

  //SDK����
  SDK_PLAYMPEG4 = 1;//���ſ�
  SDK_HCNETSDK = 2;//�����

  NAME_LEN = 32;//�û�������
  PASSWD_LEN = 16;//���볤��
  GUID_LEN = 16;      //GUID����
  DEV_TYPE_NAME_LEN = 24;      //�豸�������Ƴ���
  MAX_NAMELEN = 16;//DVR���ص�½��
  MAX_RIGHT = 32;//�豸֧�ֵ�Ȩ�ޣ�1-12��ʾ����Ȩ�ޣ�13-32��ʾԶ��Ȩ�ޣ�
  SERIALNO_LEN = 48;//���кų���
  MACADDR_LEN = 6;//mac��ַ����
  MAX_ETHERNET = 2;//�豸������̫����
  MAX_NETWORK_CARD = 4; //�豸�������������Ŀ
  PATHNAME_LEN = 128;//·������

  MAX_NUMBER_LEN = 32;	//������󳤶�
  MAX_NAME_LEN = 128; //�豸������󳤶�

  MAX_TIMESEGMENT_V30 = 8;//9000�豸���ʱ�����
  MAX_TIMESEGMENT = 4;//8000�豸���ʱ�����
  MAX_ICR_NUM = 8;   //ץ�Ļ������˹�ƬԤ�õ���

  MAX_SHELTERNUM = 4;//8000�豸����ڵ�������
  PHONENUMBER_LEN = 32;//pppoe���ź�����󳤶�

  MAX_DISKNUM = 16;//8000�豸���Ӳ����
  MAX_DISKNUM_V10 = 8;//1.2�汾֮ǰ�汾

  MAX_WINDOW_V30 = 32;//9000�豸������ʾ��󲥷Ŵ�����
  MAX_WINDOW = 16;//8000�豸���Ӳ����
  MAX_VGA_V30 = 4;//9000�豸���ɽ�VGA��
  MAX_VGA = 1;//8000�豸���ɽ�VGA��

  MAX_USERNUM_V30 = 32;//9000�豸����û���
  MAX_USERNUM = 16;//8000�豸����û���
  MAX_EXCEPTIONNUM_V30 = 32;//9000�豸����쳣������
  MAX_EXCEPTIONNUM = 16;//8000�豸����쳣������
  MAX_LINK = 6;//8000�豸��ͨ�������Ƶ��������
  MAX_ITC_EXCEPTIONOUT = 32;//ץ�Ļ���󱨾����

  MAX_DECPOOLNUM = 4;//��·������ÿ������ͨ������ѭ��������
  MAX_DECNUM = 4;//��·��������������ͨ������ʵ��ֻ��һ������������������
  MAX_TRANSPARENTNUM = 2;//��·���������������͸��ͨ����
  MAX_CYCLE_CHAN = 16; //��·�����������ѭͨ����
  MAX_CYCLE_CHAN_V30 = 64;//�����ѯͨ��������չ��
  MAX_DIRNAME_LENGTH = 80;//���Ŀ¼����

  MAX_STRINGNUM_V30 = 8;//9000�豸���OSD�ַ�������
  MAX_STRINGNUM = 4;//8000�豸���OSD�ַ�������
  MAX_STRINGNUM_EX = 8;//8000������չ
  MAX_AUXOUT_V30 = 16;//9000�豸����������
  MAX_AUXOUT = 4;//8000�豸����������
  MAX_HD_GROUP = 16;//9000�豸���Ӳ������
  MAX_NFS_DISK = 8; //8000�豸���NFSӲ����

  IW_ESSID_MAX_SIZE = 32;//WIFI��SSID�ų���
  IW_ENCODING_TOKEN_MAX = 32;//WIFI��������ֽ���
  WIFI_WEP_MAX_KEY_COUNT = 4;
  WIFI_WEP_MAX_KEY_LENGTH = 33;
  WIFI_WPA_PSK_MAX_KEY_LENGTH = 63;
  WIFI_WPA_PSK_MIN_KEY_LENGTH = 8;
  WIFI_MAX_AP_COUNT = 20;
  MAX_SERIAL_NUM = 64;//���֧�ֵ�͸��ͨ��·��
  MAX_DDNS_NUMS = 10;//9000�豸������ddns��
  MAX_EMAIL_ADDR_LEN = 48;//���email��ַ����
  MAX_EMAIL_PWD_LEN = 32;//���email���볤��

  MAXPROGRESS = 100;//�ط�ʱ�����ٷ���
  MAX_SERIALNUM = 2;//8000�豸֧�ֵĴ����� 1-232�� 2-485
  CARDNUM_LEN = 20;//���ų���
  CARDNUM_LEN_OUT = 32; //�ⲿ�ṹ�忨�ų���
  MAX_VIDEOOUT_V30 = 4;//9000�豸����Ƶ�����
  MAX_VIDEOOUT = 2;//8000�豸����Ƶ�����

  MAX_PRESET_V30 = 256;// 9000�豸֧�ֵ���̨Ԥ�õ���
  MAX_TRACK_V30 = 256;// 9000�豸֧�ֵ���̨�켣��
  MAX_CRUISE_V30 = 256;// 9000�豸֧�ֵ���̨Ѳ����
  MAX_PRESET = 128;// 8000�豸֧�ֵ���̨Ԥ�õ���
  MAX_TRACK = 128;// 8000�豸֧�ֵ���̨�켣��
  MAX_CRUISE = 128;// 8000�豸֧�ֵ���̨Ѳ����

  CRUISE_MAX_PRESET_NUMS = 32;// һ��Ѳ������Ѳ����

  MAX_SERIAL_PORT = 8;//9000�豸֧��232������
  MAX_PREVIEW_MODE = 8;// �豸֧�����Ԥ��ģʽ��Ŀ 1����,4����,9����,16����....
  MAX_MATRIXOUT = 16;// ���ģ������������
  LOG_INFO_LEN = 11840; // ��־������Ϣ
  DESC_LEN = 16;// ��̨�����ַ�������
  PTZ_PROTOCOL_NUM = 200;// 9000���֧�ֵ���̨Э����

  MAX_AUDIO = 1;//8000�����Խ�ͨ����
  MAX_AUDIO_V30 = 2;//9000�����Խ�ͨ����
  MAX_CHANNUM = 16;//8000�豸���ͨ����
  MAX_ALARMIN = 16;//8000�豸��󱨾�������
  MAX_ALARMOUT = 4;//8000�豸��󱨾������
  //9000 IPC����
  MAX_ANALOG_CHANNUM = 32;//���32��ģ��ͨ��
  MAX_ANALOG_ALARMOUT = 32; //���32·ģ�ⱨ�����
  MAX_ANALOG_ALARMIN = 32;//���32·ģ�ⱨ������

  MAX_IP_DEVICE = 32;//�����������IP�豸��
  MAX_IP_DEVICE_V40 = 64;//�����������IP�豸��
  MAX_IP_CHANNEL = 32;//�����������IPͨ����
  MAX_IP_ALARMIN = 128;//����������౨��������
  MAX_IP_ALARMOUT = 64;//����������౨�������
  MAX_IP_ALARMIN_V40 = 4096;    //����������౨��������
  MAX_IP_ALARMOUT_V40 = 4096;    //����������౨�������

  MAX_RECORD_FILE_NUM = 20;      // ÿ��ɾ�����߿�¼������ļ���

  //SDK_V31 ATM
  MAX_ATM_NUM = 1;
  MAX_ACTION_TYPE = 12;
  ATM_FRAMETYPE_NUM = 4;
  MAX_ATM_PROTOCOL_NUM = 1025;
  ATM_PROTOCOL_SORT = 4;
  ATM_DESC_LEN = 32;
  // SDK_V31 ATM

  //* ���֧�ֵ�ͨ���� ���ģ��������IP֧�� */
  MAX_CHANNUM_V30 = MAX_ANALOG_CHANNUM + MAX_IP_CHANNEL;//64
  MAX_ALARMOUT_V30 = MAX_ANALOG_ALARMOUT + MAX_IP_ALARMOUT;//96
  MAX_ALARMIN_V30 = MAX_ANALOG_ALARMIN + MAX_IP_ALARMIN;//160

  MAX_CHANNUM_V40 = 512;
  MAX_ALARMOUT_V40 = MAX_IP_ALARMOUT_V40 + MAX_ANALOG_ALARMOUT;//4128
  MAX_ALARMIN_V40 = MAX_IP_ALARMIN_V40 + MAX_ANALOG_ALARMOUT;//4128

  MAX_HUMAN_PICTURE_NUM = 10;   //�����Ƭ��
  MAX_HUMAN_BIRTHDATE_LEN = 10;

  MAX_LAYERNUMS = 32;

  MAX_ROIDETECT_NUM = 8;    //֧�ֵ�ROI������
  MAX_LANERECT_NUM   =     5;    //�����ʶ��������
  MAX_FORTIFY_NUM   =      10;   //��󲼷�����
  MAX_INTERVAL_NUM  =      4;    //���ʱ��������
  MAX_CHJC_NUM     =       3;    //�����ʡ�ݼ���ַ�����
  MAX_VL_NUM        =      5;    //���������Ȧ����
  MAX_DRIVECHAN_NUM =      16;   //��󳵵���
  MAX_COIL_NUM      =      3;    //�����Ȧ����
  MAX_SIGNALLIGHT_NUM =    6;   //����źŵƸ���
  LEN_32				=	32;
  LEN_31				=	31;
  MAX_CABINET_COUNT  =     8;    //���֧�ֻ�������
  MAX_ID_LEN         =     48;
  MAX_PARKNO_LEN    =      16;
  MAX_ALARMREASON_LEN =    32;
  MAX_UPGRADE_INFO_LEN=    48; //��ȡ�����ļ�ƥ����Ϣ(ģ������)
  MAX_CUSTOMDIR_LEN  =     32; //�Զ���Ŀ¼����

  MAX_TRANSPARENT_CHAN_NUM  =    4;   //ÿ�����������������͸��ͨ����
  MAX_TRANSPARENT_ACCESS_NUM =   4;   //ÿ�������˿������������������

  //ITS
  MAX_PARKING_STATUS  =     8;    //��λ״̬ 0�����޳���1�����г���2����ѹ��(���ȼ����), 3���⳵λ
  MAX_PARKING_NUM	   =      4;    //һ��ͨ�����4����λ (�����ҳ�λ ����0��3)

  MAX_ITS_SCENE_NUM    =    16;   //��󳡾�����
  MAX_SCENE_TIMESEG_NUM =   16;   //��󳡾�ʱ�������
  MAX_IVMS_IP_CHANNEL  =    128;  //���IPͨ����
  DEVICE_ID_LEN      =      48;   //�豸��ų���
  MONITORSITE_ID_LEN  =     48;   //�����ų���
  MAX_AUXAREA_NUM       =   16;   //�������������Ŀ
  MAX_SLAVE_CHANNEL_NUM =   16;   //����ͨ������

  MAX_SCH_TASKS_NUM = 10;

  MAX_SERVERID_LEN   =         64; //��������ID�ĳ���
  MAX_SERVERDOMAIN_LEN =       128; //������������󳤶�
  MAX_AUTHENTICATEID_LEN =     64; //��֤ID��󳤶�
  MAX_AUTHENTICATEPASSWD_LEN = 32; //��֤������󳤶�
  MAX_SERVERNAME_LEN =         64; //���������û���
  MAX_COMPRESSIONID_LEN =      64; //����ID����󳤶�
  MAX_SIPSERVER_ADDRESS_LEN =  128; //SIP��������ַ֧��������IP��ַ
  //ѹ�߱���
  MAX_PlATE_NO_LEN =        32;   //���ƺ�����󳤶� 2013-09-27
  UPNP_PORT_NUM	=		12;	  //upnp�˿�ӳ��˿���Ŀ


  MAX_LOCAL_ADDR_LEN	= 96;		//SOCKS��󱾵����θ���
  MAX_COUNTRY_NAME_LEN = 4;		//���Ҽ�д���Ƴ���

  //�������ӷ�ʽ
  NORMALCONNECT = 1;
  MEDIACONNECT = 2;

  //�豸�ͺ�(����)
  HCDVR = 1;
  MEDVR = 2;
  PCDVR = 3;
  HC_9000 = 4;
  HF_I = 5;
  PCNVR = 6;
  HC_76NVR = 8;

  //NVR����
  DS8000HC_NVR = 0;
  DS9000HC_NVR = 1;
  DS8000ME_NVR = 2;

  //*******************ȫ�ִ����� begin**********************/
  NET_DVR_NOERROR = 0;//û�д���
  NET_DVR_PASSWORD_ERROR = 1;//�û����������
  NET_DVR_NOENOUGHPRI = 2;//Ȩ�޲���
  NET_DVR_NOINIT = 3;//û�г�ʼ��
  NET_DVR_CHANNEL_ERROR = 4;//ͨ���Ŵ���
  NET_DVR_OVER_MAXLINK = 5;//���ӵ�DVR�Ŀͻ��˸����������
  NET_DVR_VERSIONNOMATCH = 6;//�汾��ƥ��
  NET_DVR_NETWORK_FAIL_CONNECT = 7;//���ӷ�����ʧ��
  NET_DVR_NETWORK_SEND_ERROR = 8;//�����������ʧ��
  NET_DVR_NETWORK_RECV_ERROR = 9;//�ӷ�������������ʧ��
  NET_DVR_NETWORK_RECV_TIMEOUT = 10;//�ӷ������������ݳ�ʱ
  NET_DVR_NETWORK_ERRORDATA = 11;//���͵���������
  NET_DVR_ORDER_ERROR = 12;//���ô������
  NET_DVR_OPERNOPERMIT = 13;//�޴�Ȩ��
  NET_DVR_COMMANDTIMEOUT = 14;//DVR����ִ�г�ʱ
  NET_DVR_ERRORSERIALPORT = 15;//���ںŴ���
  NET_DVR_ERRORALARMPORT = 16;//�����˿ڴ���
  NET_DVR_PARAMETER_ERROR = 17;//��������
  NET_DVR_CHAN_EXCEPTION = 18;//������ͨ�����ڴ���״̬
  NET_DVR_NODISK = 19;//û��Ӳ��
  NET_DVR_ERRORDISKNUM = 20;//Ӳ�̺Ŵ���
  NET_DVR_DISK_FULL = 21;//������Ӳ����
  NET_DVR_DISK_ERROR = 22;//������Ӳ�̳���
  NET_DVR_NOSUPPORT = 23;//��������֧��
  NET_DVR_BUSY = 24;//������æ
  NET_DVR_MODIFY_FAIL = 25;//�������޸Ĳ��ɹ�
  NET_DVR_PASSWORD_FORMAT_ERROR = 26;//���������ʽ����ȷ
  NET_DVR_DISK_FORMATING = 27;//Ӳ�����ڸ�ʽ����������������
  NET_DVR_DVRNORESOURCE = 28;//DVR��Դ����
  NET_DVR_DVROPRATEFAILED = 29;//DVR����ʧ��
  NET_DVR_OPENHOSTSOUND_FAIL = 30;//��PC����ʧ��
  NET_DVR_DVRVOICEOPENED = 31;//�����������Խ���ռ��
  NET_DVR_TIMEINPUTERROR = 32;//ʱ�����벻��ȷ
  NET_DVR_NOSPECFILE = 33;//�ط�ʱ������û��ָ�����ļ�
  NET_DVR_CREATEFILE_ERROR = 34;//�����ļ�����
  NET_DVR_FILEOPENFAIL = 35;//���ļ�����
  NET_DVR_OPERNOTFINISH = 36; //�ϴεĲ�����û�����
  NET_DVR_GETPLAYTIMEFAIL = 37;//��ȡ��ǰ���ŵ�ʱ�����
  NET_DVR_PLAYFAIL = 38;//���ų���
  NET_DVR_FILEFORMAT_ERROR = 39;//�ļ���ʽ����ȷ
  NET_DVR_DIR_ERROR = 40;//·������
  NET_DVR_ALLOC_RESOURCE_ERROR = 41;//��Դ�������
  NET_DVR_AUDIO_MODE_ERROR = 42;//����ģʽ����
  NET_DVR_NOENOUGH_BUF = 43;//������̫С
  NET_DVR_CREATESOCKET_ERROR = 44;//����SOCKET����
  NET_DVR_SETSOCKET_ERROR = 45;//����SOCKET����
  NET_DVR_MAX_NUM = 46;//�����ﵽ���
  NET_DVR_USERNOTEXIST = 47;//�û�������
  NET_DVR_WRITEFLASHERROR = 48;//дFLASH����
  NET_DVR_UPGRADEFAIL = 49;//DVR����ʧ��
  NET_DVR_CARDHAVEINIT = 50;//���뿨�Ѿ���ʼ����
  NET_DVR_PLAYERFAILED = 51;//���ò��ſ���ĳ������ʧ��
  NET_DVR_MAX_USERNUM = 52;//�豸���û����ﵽ���
  NET_DVR_GETLOCALIPANDMACFAIL = 53;//��ÿͻ��˵�IP��ַ�������ַʧ��
  NET_DVR_NOENCODEING = 54;//��ͨ��û�б���
  NET_DVR_IPMISMATCH = 55;//IP��ַ��ƥ��
  NET_DVR_MACMISMATCH = 56;//MAC��ַ��ƥ��
  NET_DVR_UPGRADELANGMISMATCH = 57;//�����ļ����Բ�ƥ��
  NET_DVR_MAX_PLAYERPORT = 58;//������·���ﵽ���
  NET_DVR_NOSPACEBACKUP = 59;//�����豸��û���㹻�ռ���б���
  NET_DVR_NODEVICEBACKUP = 60;//û���ҵ�ָ���ı����豸
  NET_DVR_PICTURE_BITS_ERROR = 61;//ͼ����λ����������24ɫ
  NET_DVR_PICTURE_DIMENSION_ERROR = 62;//ͼƬ��*���ޣ� ��128*256
  NET_DVR_PICTURE_SIZ_ERROR = 63;//ͼƬ��С���ޣ���100K
  NET_DVR_LOADPLAYERSDKFAILED = 64;//���뵱ǰĿ¼��Player Sdk����
  NET_DVR_LOADPLAYERSDKPROC_ERROR = 65;//�Ҳ���Player Sdk��ĳ���������
  NET_DVR_LOADDSSDKFAILED = 66;//���뵱ǰĿ¼��DSsdk����
  NET_DVR_LOADDSSDKPROC_ERROR = 67;//�Ҳ���DsSdk��ĳ���������
  NET_DVR_DSSDK_ERROR = 68;//����Ӳ�����DsSdk��ĳ������ʧ��
  NET_DVR_VOICEMONOPOLIZE = 69;//��������ռ
  NET_DVR_JOINMULTICASTFAILED = 70;//����ಥ��ʧ��
  NET_DVR_CREATEDIR_ERROR = 71;//������־�ļ�Ŀ¼ʧ��
  NET_DVR_BINDSOCKET_ERROR = 72;//���׽���ʧ��
  NET_DVR_SOCKETCLOSE_ERROR = 73;//socket�����жϣ��˴���ͨ�������������жϻ�Ŀ�ĵز��ɴ�
  NET_DVR_USERID_ISUSING = 74;//ע��ʱ�û�ID���ڽ���ĳ����
  NET_DVR_SOCKETLISTEN_ERROR = 75;//����ʧ��
  NET_DVR_PROGRAM_EXCEPTION = 76;//�����쳣
  NET_DVR_WRITEFILE_FAILED = 77;//д�ļ�ʧ��
  NET_DVR_FORMAT_READONLY = 78;//��ֹ��ʽ��ֻ��Ӳ��
  NET_DVR_WITHSAMEUSERNAME = 79;//�û����ýṹ�д�����ͬ���û���
  NET_DVR_DEVICETYPE_ERROR = 80;//�������ʱ�豸�ͺŲ�ƥ��
  NET_DVR_LANGUAGE_ERROR = 81;//�������ʱ���Բ�ƥ��
  NET_DVR_PARAVERSION_ERROR = 82;//�������ʱ����汾��ƥ��
  NET_DVR_IPCHAN_NOTALIVE = 83; //Ԥ��ʱ���IPͨ��������
  NET_DVR_RTSP_SDK_ERROR = 84;//���ظ���IPCͨѶ��StreamTransClient.dllʧ��
  NET_DVR_CONVERT_SDK_ERROR = 85;//����ת���ʧ��
  NET_DVR_IPC_COUNT_OVERFLOW = 86;//��������ip����ͨ����

  NET_PLAYM4_NOERROR = 500;//no error
  NET_PLAYM4_PARA_OVER = 501;//input parameter is invalid
  NET_PLAYM4_ORDER_ERROR = 502;//The order of the function to be called is error
  NET_PLAYM4_TIMER_ERROR = 503;//Create multimedia clock failed
  NET_PLAYM4_DEC_VIDEO_ERROR = 504;//Decode video data failed
  NET_PLAYM4_DEC_AUDIO_ERROR = 505;//Decode audio data failed
  NET_PLAYM4_ALLOC_MEMORY_ERROR = 506;//Allocate memory failed
  NET_PLAYM4_OPEN_FILE_ERROR = 507;//Open the file failed
  NET_PLAYM4_CREATE_OBJ_ERROR = 508;//Create thread or event failed
  NET_PLAYM4_CREATE_DDRAW_ERROR = 509;//Create DirectDraw object failed
  NET_PLAYM4_CREATE_OFFSCREEN_ERROR = 510;//failed when creating off-screen surface
  NET_PLAYM4_BUF_OVER = 511;//buffer is overflow
  NET_PLAYM4_CREATE_SOUND_ERROR = 512;//failed when creating audio device
  NET_PLAYM4_SET_VOLUME_ERROR = 513;//Set volume failed
  NET_PLAYM4_SUPPORT_FILE_ONLY = 514;//The function only support play file
  NET_PLAYM4_SUPPORT_STREAM_ONLY = 515;//The function only support play stream
  NET_PLAYM4_SYS_NOT_SUPPORT = 516;//System not support
  NET_PLAYM4_FILEHEADER_UNKNOWN = 517;//No file header
  NET_PLAYM4_VERSION_INCORRECT = 518;//The version of decoder and encoder is not adapted
  NET_PALYM4_INIT_DECODER_ERROR = 519;//Initialize decoder failed
  NET_PLAYM4_CHECK_FILE_ERROR = 520;//The file data is unknown
  NET_PLAYM4_INIT_TIMER_ERROR = 521;//Initialize multimedia clock failed
  NET_PLAYM4_BLT_ERROR = 522;//Blt failed
  NET_PLAYM4_UPDATE_ERROR = 523;//Update failed
  NET_PLAYM4_OPEN_FILE_ERROR_MULTI = 524;//openfile error, streamtype is multi
  NET_PLAYM4_OPEN_FILE_ERROR_VIDEO = 525;//openfile error, streamtype is video
  NET_PLAYM4_JPEG_COMPRESS_ERROR = 526;//JPEG compress error
  NET_PLAYM4_EXTRACT_NOT_SUPPORT = 527;//Don't support the version of this file
  NET_PLAYM4_EXTRACT_DATA_ERROR = 528;//extract video data failed
  //*******************ȫ�ִ����� end**********************/

  {*************************************************
  NET_DVR_IsSupport()����ֵ
  1��9λ�ֱ��ʾ������Ϣ��λ����TRUE)��ʾ֧�֣�
  **************************************************}
  NET_DVR_SUPPORT_DDRAW = 1;//֧��DIRECTDRAW�������֧�֣��򲥷������ܹ���
  NET_DVR_SUPPORT_BLT = 2;//�Կ�֧��BLT�����������֧�֣��򲥷������ܹ���
  NET_DVR_SUPPORT_BLTFOURCC = 4;//�Կ�BLT֧����ɫת���������֧�֣��������������������RGBת��
  NET_DVR_SUPPORT_BLTSHRINKX = 8;//�Կ�BLT֧��X����С�������֧�֣�ϵͳ�����������ת��
  NET_DVR_SUPPORT_BLTSHRINKY = 16;//�Կ�BLT֧��Y����С�������֧�֣�ϵͳ�����������ת��
  NET_DVR_SUPPORT_BLTSTRETCHX = 32;//�Կ�BLT֧��X��Ŵ������֧�֣�ϵͳ�����������ת��
  NET_DVR_SUPPORT_BLTSTRETCHY = 64;//�Կ�BLT֧��Y��Ŵ������֧�֣�ϵͳ�����������ת��
  NET_DVR_SUPPORT_SSE = 128;//CPU֧��SSEָ�Intel Pentium3����֧��SSEָ��
  NET_DVR_SUPPORT_MMX = 256;//CPU֧��MMXָ���Intel Pentium3����֧��SSEָ��

  //**********************��̨�������� begin*************************/
  LIGHT_PWRON = 2;// ��ͨ�ƹ��Դ
  WIPER_PWRON = 3;// ��ͨ��ˢ����
  FAN_PWRON = 4;// ��ͨ���ȿ���
  HEATER_PWRON = 5;// ��ͨ����������
  AUX_PWRON1 = 6;// ��ͨ�����豸����
  AUX_PWRON2 = 7;// ��ͨ�����豸����
  SET_PRESET = 8;// ����Ԥ�õ�
  CLE_PRESET = 9;// ���Ԥ�õ�

  ZOOM_IN = 11;// �������ٶ�SS���(���ʱ��)
  ZOOM_OUT = 12;// �������ٶ�SS��С(���ʱ�С)
  FOCUS_NEAR = 13;// �������ٶ�SSǰ��
  FOCUS_FAR = 14;// �������ٶ�SS���
  IRIS_OPEN = 15;// ��Ȧ���ٶ�SS����
  IRIS_CLOSE = 16;// ��Ȧ���ٶ�SS��С

  TILT_UP = 21;/* ��̨��SS���ٶ����� */
  TILT_DOWN = 22;/* ��̨��SS���ٶ��¸� */
  PAN_LEFT = 23;/* ��̨��SS���ٶ���ת */
  PAN_RIGHT = 24;/* ��̨��SS���ٶ���ת */
  UP_LEFT = 25;/* ��̨��SS���ٶ���������ת */
  UP_RIGHT = 26;/* ��̨��SS���ٶ���������ת */
  DOWN_LEFT = 27;/* ��̨��SS���ٶ��¸�����ת */
  DOWN_RIGHT = 28;/* ��̨��SS���ٶ��¸�����ת */
  PAN_AUTO = 29;/* ��̨��SS���ٶ������Զ�ɨ�� */

  FILL_PRE_SEQ = 30;/* ��Ԥ�õ����Ѳ������ */
  SET_SEQ_DWELL = 31;/* ����Ѳ����ͣ��ʱ�� */
  SET_SEQ_SPEED = 32;/* ����Ѳ���ٶ� */
  CLE_PRE_SEQ = 33;/* ��Ԥ�õ��Ѳ��������ɾ�� */
  STA_MEM_CRUISE = 34;/* ��ʼ��¼�켣 */
  STO_MEM_CRUISE = 35;/* ֹͣ��¼�켣 */
  RUN_CRUISE = 36;/* ��ʼ�켣 */
  RUN_SEQ = 37;/* ��ʼѲ�� */
  STOP_SEQ = 38;/* ֹͣѲ�� */
  GOTO_PRESET = 39;/* ����ת��Ԥ�õ� */
  //**********************��̨�������� end*************************/

  {*************************************************
  �ط�ʱ���ſ�������궨��
  NET_DVR_PlayBackControl
  NET_DVR_PlayControlLocDisplay
  NET_DVR_DecPlayBackCtrl�ĺ궨��
  ����֧�ֲ鿴����˵���ʹ���
  **************************************************}
  NET_DVR_PLAYSTART = 1;//��ʼ����
  NET_DVR_PLAYSTOP = 2;//ֹͣ����
  NET_DVR_PLAYPAUSE = 3;//��ͣ����
  NET_DVR_PLAYRESTART = 4;//�ָ�����
  NET_DVR_PLAYFAST = 5;//���
  NET_DVR_PLAYSLOW = 6;//����
  NET_DVR_PLAYNORMAL = 7;//�����ٶ�
  NET_DVR_PLAYFRAME = 8;//��֡��
  NET_DVR_PLAYSTARTAUDIO = 9;//������
  NET_DVR_PLAYSTOPAUDIO = 10;//�ر�����
  NET_DVR_PLAYAUDIOVOLUME = 11;//��������
  NET_DVR_PLAYSETPOS = 12;//�ı��ļ��طŵĽ���
  NET_DVR_PLAYGETPOS = 13;//��ȡ�ļ��طŵĽ���
  NET_DVR_PLAYGETTIME = 14;//��ȡ��ǰ�Ѿ����ŵ�ʱ��(���ļ��طŵ�ʱ����Ч)
  NET_DVR_PLAYGETFRAME = 15;//��ȡ��ǰ�Ѿ����ŵ�֡��(���ļ��طŵ�ʱ����Ч)
  NET_DVR_GETTOTALFRAMES = 16;//��ȡ��ǰ�����ļ��ܵ�֡��(���ļ��طŵ�ʱ����Ч)
  NET_DVR_GETTOTALTIME = 17;//��ȡ��ǰ�����ļ��ܵ�ʱ��(���ļ��طŵ�ʱ����Ч)
  NET_DVR_THROWBFRAME = 20;//��B֡
  NET_DVR_SETSPEED = 24;//���������ٶ�
  NET_DVR_KEEPALIVE = 25;//�������豸������(����ص�����������2�뷢��һ��)
  NET_DVR_PLAYSETTIME = 26;//������ʱ�䶨λ
  NET_DVR_PLAYGETTOTALLEN = 27;//��ȡ��ʱ��طŶ�Ӧʱ����ڵ������ļ����ܳ���
  NET_DVR_PLAY_FORWARD = 29;//�����л�Ϊ����
  NET_DVR_PLAY_REVERSE = 30;//�����л�Ϊ����
  NET_DVR_SET_TRANS_TYPE = 32;//����ת��װ����
  NET_DVR_PLAY_CONVERT = 33;//�����л�Ϊ����

  //Զ�̰����������£�
  //* key value send to CONFIG program */
  KEY_CODE_1 = 1;
  KEY_CODE_2 = 2;
  KEY_CODE_3 = 3;
  KEY_CODE_4 = 4;
  KEY_CODE_5 = 5;
  KEY_CODE_6 = 6;
  KEY_CODE_7 = 7;
  KEY_CODE_8 = 8;
  KEY_CODE_9 = 9;
  KEY_CODE_0 = 10;
  KEY_CODE_POWER = 11;
  KEY_CODE_MENU = 12;
  KEY_CODE_ENTER = 13;
  KEY_CODE_CANCEL = 14;
  KEY_CODE_UP = 15;
  KEY_CODE_DOWN = 16;
  KEY_CODE_LEFT = 17;
  KEY_CODE_RIGHT = 18;
  KEY_CODE_EDIT = 19;
  KEY_CODE_ADD = 20;
  KEY_CODE_MINUS = 21;
  KEY_CODE_PLAY = 22;
  KEY_CODE_REC = 23;
  KEY_CODE_PAN = 24;
  KEY_CODE_M = 25;
  KEY_CODE_A = 26;
  KEY_CODE_F1 = 27;
  KEY_CODE_F2 = 28;

  //* for PTZ control */
  KEY_PTZ_UP_START = KEY_CODE_UP;
  KEY_PTZ_UP_STOP = 32;

  KEY_PTZ_DOWN_START = KEY_CODE_DOWN;
  KEY_PTZ_DOWN_STOP = 33;


  KEY_PTZ_LEFT_START = KEY_CODE_LEFT;
  KEY_PTZ_LEFT_STOP = 34;

  KEY_PTZ_RIGHT_START = KEY_CODE_RIGHT;
  KEY_PTZ_RIGHT_STOP = 35;

  KEY_PTZ_AP1_START = KEY_CODE_EDIT;/* ��Ȧ+ */
  KEY_PTZ_AP1_STOP = 36;

  KEY_PTZ_AP2_START = KEY_CODE_PAN;/* ��Ȧ- */
  KEY_PTZ_AP2_STOP = 37;

  KEY_PTZ_FOCUS1_START = KEY_CODE_A;/* �۽�+ */
  KEY_PTZ_FOCUS1_STOP = 38;

  KEY_PTZ_FOCUS2_START = KEY_CODE_M;/* �۽�- */
  KEY_PTZ_FOCUS2_STOP = 39;

  KEY_PTZ_B1_START = 40;/* �䱶+ */
  KEY_PTZ_B1_STOP = 41;

  KEY_PTZ_B2_START = 42;/* �䱶- */
  KEY_PTZ_B2_STOP = 43;

  //9000����
  KEY_CODE_11 = 44;
  KEY_CODE_12 = 45;
  KEY_CODE_13 = 46;
  KEY_CODE_14 = 47;
  KEY_CODE_15 = 48;
  KEY_CODE_16 = 49;

  //*************************������������ begin*******************************/
  //����NET_DVR_SetDVRConfig��NET_DVR_GetDVRConfig,ע�����Ӧ�����ýṹ
  NET_DVR_GET_DEVICECFG = 100;//��ȡ�豸����
  NET_DVR_SET_DEVICECFG = 101;//�����豸����
  NET_DVR_GET_NETCFG = 102;//��ȡ�������
  NET_DVR_SET_NETCFG = 103;//�����������
  NET_DVR_GET_PICCFG = 104;//��ȡͼ�����
  NET_DVR_SET_PICCFG = 105;//����ͼ�����
  NET_DVR_GET_COMPRESSCFG = 106;//��ȡѹ������
  NET_DVR_SET_COMPRESSCFG = 107;//����ѹ������
  NET_DVR_GET_RECORDCFG = 108;//��ȡ¼��ʱ�����
  NET_DVR_SET_RECORDCFG = 109;//����¼��ʱ�����
  NET_DVR_GET_DECODERCFG = 110;//��ȡ����������
  NET_DVR_SET_DECODERCFG = 111;//���ý���������
  NET_DVR_GET_RS232CFG = 112;//��ȡ232���ڲ���
  NET_DVR_SET_RS232CFG = 113;//����232���ڲ���
  NET_DVR_GET_ALARMINCFG = 114;//��ȡ�����������
  NET_DVR_SET_ALARMINCFG = 115;//���ñ����������
  NET_DVR_GET_ALARMOUTCFG = 116;//��ȡ�����������
  NET_DVR_SET_ALARMOUTCFG = 117;//���ñ����������
  NET_DVR_GET_TIMECFG = 118;//��ȡDVRʱ��
  NET_DVR_SET_TIMECFG = 119;//����DVRʱ��
  NET_DVR_GET_PREVIEWCFG = 120;//��ȡԤ������
  NET_DVR_SET_PREVIEWCFG = 121;//����Ԥ������
  NET_DVR_GET_VIDEOOUTCFG = 122;//��ȡ��Ƶ�������
  NET_DVR_SET_VIDEOOUTCFG = 123;//������Ƶ�������
  NET_DVR_GET_USERCFG = 124;//��ȡ�û�����
  NET_DVR_SET_USERCFG = 125;//�����û�����
  NET_DVR_GET_EXCEPTIONCFG = 126;//��ȡ�쳣����
  NET_DVR_SET_EXCEPTIONCFG = 127;//�����쳣����
  NET_DVR_GET_ZONEANDDST = 128;//��ȡʱ������ʱ�Ʋ���
  NET_DVR_SET_ZONEANDDST = 129;//����ʱ������ʱ�Ʋ���
  NET_DVR_GET_SHOWSTRING = 130;//��ȡ�����ַ�����
  NET_DVR_SET_SHOWSTRING = 131;//���õ����ַ�����
  NET_DVR_GET_EVENTCOMPCFG = 132;//��ȡ�¼�����¼�����
  NET_DVR_SET_EVENTCOMPCFG = 133;//�����¼�����¼�����

  NET_DVR_GET_AUXOUTCFG = 140;//��ȡ�������������������(HS�豸�������2006-02-28)
  NET_DVR_SET_AUXOUTCFG = 141;//���ñ������������������(HS�豸�������2006-02-28)
  NET_DVR_GET_PREVIEWCFG_AUX = 142;//��ȡ-sϵ��˫���Ԥ������(-sϵ��˫���2006-04-13)
  NET_DVR_SET_PREVIEWCFG_AUX = 143;//����-sϵ��˫���Ԥ������(-sϵ��˫���2006-04-13)

  NET_DVR_GET_PICCFG_EX = 200;//��ȡͼ�����(SDK_V14��չ����)
  NET_DVR_SET_PICCFG_EX = 201;//����ͼ�����(SDK_V14��չ����)
  NET_DVR_GET_USERCFG_EX = 202;//��ȡ�û�����(SDK_V15��չ����)
  NET_DVR_SET_USERCFG_EX = 203;//�����û�����(SDK_V15��չ����)
  NET_DVR_GET_COMPRESSCFG_EX = 204;//��ȡѹ������(SDK_V15��չ����2006-05-15)
  NET_DVR_SET_COMPRESSCFG_EX = 205;//����ѹ������(SDK_V15��չ����2006-05-15)

  NET_DVR_GET_NETAPPCFG = 222;//��ȡ����Ӧ�ò��� NTP/DDNS/EMAIL
  NET_DVR_SET_NETAPPCFG = 223;//��������Ӧ�ò��� NTP/DDNS/EMAIL
  NET_DVR_GET_NTPCFG = 224;//��ȡ����Ӧ�ò��� NTP
  NET_DVR_SET_NTPCFG = 225;//��������Ӧ�ò��� NTP
  NET_DVR_GET_DDNSCFG = 226;//��ȡ����Ӧ�ò��� DDNS
  NET_DVR_SET_DDNSCFG = 227;//��������Ӧ�ò��� DDNS
  //��ӦNET_DVR_EMAILPARA
  NET_DVR_GET_EMAILCFG = 228;//��ȡ����Ӧ�ò��� EMAIL
  NET_DVR_SET_EMAILCFG = 229;//��������Ӧ�ò��� EMAIL

  NET_DVR_GET_NFSCFG = 230;/* NFS disk config */
  NET_DVR_SET_NFSCFG = 231;/* NFS disk config */

  NET_DVR_GET_SHOWSTRING_EX = 238;//��ȡ�����ַ�������չ(֧��8���ַ�)
  NET_DVR_SET_SHOWSTRING_EX = 239;//���õ����ַ�������չ(֧��8���ַ�)
  NET_DVR_GET_NETCFG_OTHER = 244;//��ȡ�������
  NET_DVR_SET_NETCFG_OTHER = 245;//�����������

  //��ӦNET_DVR_EMAILCFG�ṹ
  NET_DVR_GET_EMAILPARACFG = 250;//Get EMAIL parameters
  NET_DVR_SET_EMAILPARACFG = 251;//Setup EMAIL parameters

  NET_DVR_GET_DDNSCFG_EX = 274;//��ȡ��չDDNS����
  NET_DVR_SET_DDNSCFG_EX = 275;//������չDDNS����

  NET_DVR_SET_PTZPOS = 292;//��̨����PTZλ��
  NET_DVR_GET_PTZPOS = 293;//��̨��ȡPTZλ��
  NET_DVR_GET_PTZSCOPE = 294;//��̨��ȡPTZ��Χ

  NET_DVR_GET_AP_INFO_LIST = 305;//��ȡ����������Դ����
  NET_DVR_SET_WIFI_CFG = 306;//����IP����豸���߲���
  NET_DVR_GET_WIFI_CFG = 307;//��ȡIP����豸���߲���
  NET_DVR_SET_WIFI_WORKMODE = 308;//����IP����豸���ڹ���ģʽ����
  NET_DVR_GET_WIFI_WORKMODE = 309;//��ȡIP����豸���ڹ���ģʽ����
  NET_DVR_GET_WIFI_STATUS = 310;	//��ȡ�豸��ǰwifi����״̬
  //***************************DS9000��������(_V30) begin *****************************/
  //����(NET_DVR_NETCFG_V30�ṹ)
  NET_DVR_GET_NETCFG_V30 = 1000;//��ȡ�������
  NET_DVR_SET_NETCFG_V30 = 1001;//�����������

  //ͼ��(NET_DVR_PICCFG_V30�ṹ)
  NET_DVR_GET_PICCFG_V30 = 1002;//��ȡͼ�����
  NET_DVR_SET_PICCFG_V30 = 1003;//����ͼ�����

  //¼��ʱ��(NET_DVR_RECORD_V30�ṹ)
  NET_DVR_GET_RECORDCFG_V30 = 1004;//��ȡ¼�����
  NET_DVR_SET_RECORDCFG_V30 = 1005;//����¼�����

  //�û�(NET_DVR_USER_V30�ṹ)
  NET_DVR_GET_USERCFG_V30 = 1006;//��ȡ�û�����
  NET_DVR_SET_USERCFG_V30 = 1007;//�����û�����

  //9000DDNS��������(NET_DVR_DDNSPARA_V30�ṹ)
  NET_DVR_GET_DDNSCFG_V30 = 1010;//��ȡDDNS(9000��չ)
  NET_DVR_SET_DDNSCFG_V30 = 1011;//����DDNS(9000��չ)

  //EMAIL����(NET_DVR_EMAILCFG_V30�ṹ)
  NET_DVR_GET_EMAILCFG_V30 = 1012;//��ȡEMAIL����
  NET_DVR_SET_EMAILCFG_V30 = 1013;//����EMAIL����

  //Ѳ������ (NET_DVR_CRUISE_PARA�ṹ)
  NET_DVR_GET_CRUISE = 1020;
  NET_DVR_SET_CRUISE = 1021;

  //��������ṹ���� (NET_DVR_ALARMINCFG_V30�ṹ)
  NET_DVR_GET_ALARMINCFG_V30 = 1024;
  NET_DVR_SET_ALARMINCFG_V30 = 1025;

  //��������ṹ���� (NET_DVR_ALARMOUTCFG_V30�ṹ)
  NET_DVR_GET_ALARMOUTCFG_V30 = 1026;
  NET_DVR_SET_ALARMOUTCFG_V30 = 1027;

  //��Ƶ����ṹ���� (NET_DVR_VIDEOOUT_V30�ṹ)
  NET_DVR_GET_VIDEOOUTCFG_V30 = 1028;
  NET_DVR_SET_VIDEOOUTCFG_V30 = 1029;

  //�����ַ��ṹ���� (NET_DVR_SHOWSTRING_V30�ṹ)
  NET_DVR_GET_SHOWSTRING_V30 = 1030;
  NET_DVR_SET_SHOWSTRING_V30 = 1031;

  //�쳣�ṹ���� (NET_DVR_EXCEPTION_V30�ṹ)
  NET_DVR_GET_EXCEPTIONCFG_V30 = 1034;
  NET_DVR_SET_EXCEPTIONCFG_V30 = 1035;

  //����232�ṹ���� (NET_DVR_RS232CFG_V30�ṹ)
  NET_DVR_GET_RS232CFG_V30 = 1036;
  NET_DVR_SET_RS232CFG_V30 = 1037;

  //����Ӳ�̽���ṹ���� (NET_DVR_NET_DISKCFG�ṹ)
  NET_DVR_GET_NET_DISKCFG = 1038;//����Ӳ�̽����ȡ
  NET_DVR_SET_NET_DISKCFG = 1039;//����Ӳ�̽�������

  //ѹ������ (NET_DVR_COMPRESSIONCFG_V30�ṹ)
  NET_DVR_GET_COMPRESSCFG_V30 = 1040;
  NET_DVR_SET_COMPRESSCFG_V30 = 1041;

  //��ȡ485���������� (NET_DVR_DECODERCFG_V30�ṹ)
  NET_DVR_GET_DECODERCFG_V30 = 1042;//��ȡ����������
  NET_DVR_SET_DECODERCFG_V30 = 1043;//���ý���������

  //��ȡԤ������ (NET_DVR_PREVIEWCFG_V30�ṹ)
  NET_DVR_GET_PREVIEWCFG_V30 = 1044;//��ȡԤ������
  NET_DVR_SET_PREVIEWCFG_V30 = 1045;//����Ԥ������

  //����Ԥ������ (NET_DVR_PREVIEWCFG_AUX_V30�ṹ)
  NET_DVR_GET_PREVIEWCFG_AUX_V30 = 1046;//��ȡ����Ԥ������
  NET_DVR_SET_PREVIEWCFG_AUX_V30 = 1047;//���ø���Ԥ������

  //IP�������ò��� ��NET_DVR_IPPARACFG�ṹ��
  NET_DVR_GET_IPPARACFG = 1048; //��ȡIP����������Ϣ
  NET_DVR_SET_IPPARACFG = 1049;//����IP����������Ϣ

  //IP�������ò��� ��NET_DVR_IPPARACFG_V40�ṹ��
  NET_DVR_GET_IPPARACFG_V40 = 1062; //��ȡIP����������Ϣ
  NET_DVR_SET_IPPARACFG_V40 = 1063;//����IP����������Ϣ

  //IP��������������ò��� ��NET_DVR_IPALARMINCFG�ṹ��
  NET_DVR_GET_IPALARMINCFG = 1050; //��ȡIP�����������������Ϣ
  NET_DVR_SET_IPALARMINCFG = 1051; //����IP�����������������Ϣ

  //IP��������������ò��� ��NET_DVR_IPALARMOUTCFG�ṹ��
  NET_DVR_GET_IPALARMOUTCFG = 1052;//��ȡIP�����������������Ϣ
  NET_DVR_SET_IPALARMOUTCFG = 1053;//����IP�����������������Ϣ

  //Ӳ�̹���Ĳ�����ȡ (NET_DVR_HDCFG�ṹ)
  NET_DVR_GET_HDCFG = 1054;//��ȡӲ�̹������ò���
  NET_DVR_SET_HDCFG = 1055;//����Ӳ�̹������ò���

  //�������Ĳ�����ȡ (NET_DVR_HDGROUP_CFG�ṹ)
  NET_DVR_GET_HDGROUP_CFG = 1056;//��ȡ����������ò���
  NET_DVR_SET_HDGROUP_CFG = 1057;//��������������ò���

  //�豸������������(NET_DVR_COMPRESSION_AUDIO�ṹ)
  NET_DVR_GET_COMPRESSCFG_AUD = 1058;//��ȡ�豸�����Խ��������
  NET_DVR_SET_COMPRESSCFG_AUD = 1059;//�����豸�����Խ��������

  //IP�������ò��� ��NET_DVR_IPPARACFG_V31�ṹ��
  NET_DVR_GET_IPPARACFG_V31 = 1060;//��ȡIP����������Ϣ
  NET_DVR_SET_IPPARACFG_V31 = 1061; //����IP����������Ϣ

  //�豸�������� ��NET_DVR_DEVICECFG_V40�ṹ��
  NET_DVR_GET_DEVICECFG_V40 = 1100;//��ȡ�豸����
  NET_DVR_SET_DEVICECFG_V40 = 1101;//�����豸����

  //����������(NET_DVR_NETCFG_MULTI�ṹ)
  NET_DVR_GET_NETCFG_MULTI = 1161;
  NET_DVR_SET_NETCFG_MULTI = 1162;

  //BONDING����(NET_DVR_NETWORK_BONDING�ṹ)
  NET_DVR_GET_NETWORK_BONDING = 1254;
  NET_DVR_SET_NETWORK_BONDING = 1255;

  //NATӳ�����ò��� ��NET_DVR_NAT_CFG�ṹ��
  NET_DVR_GET_NAT_CFG = 6111;    //��ȡNATӳ�����
  NET_DVR_SET_NAT_CFG = 6112;    //����NATӳ�����
  //*************************������������ end*******************************/

  //************************DVR��־ begin***************************/
  //* ���� */
  //������
  MAJOR_ALARM = 1;
  //������
  MINOR_ALARM_IN = 1;/* �������� */
  MINOR_ALARM_OUT = 2;/* ������� */
  MINOR_MOTDET_START = 3; /* �ƶ���ⱨ����ʼ */
  MINOR_MOTDET_STOP = 4; /* �ƶ���ⱨ������ */
  MINOR_HIDE_ALARM_START = 5;/* �ڵ�������ʼ */
  MINOR_HIDE_ALARM_STOP = 6;/* �ڵ��������� */
  MINOR_VCA_ALARM_START = 7;/*���ܱ�����ʼ*/
  MINOR_VCA_ALARM_STOP = 8;/*���ܱ���ֹͣ*/

  //* �쳣 */
  //������
  MAJOR_EXCEPTION = 2;
  //������
  MINOR_VI_LOST = 33;/* ��Ƶ�źŶ�ʧ */
  MINOR_ILLEGAL_ACCESS = 34;/* �Ƿ����� */
  MINOR_HD_FULL = 35;/* Ӳ���� */
  MINOR_HD_ERROR = 36;/* Ӳ�̴��� */
  MINOR_DCD_LOST = 37;/* MODEM ����(������ʹ��) */
  MINOR_IP_CONFLICT = 38;/* IP��ַ��ͻ */
  MINOR_NET_BROKEN = 39;/* ����Ͽ�*/
  MINOR_REC_ERROR = 40;/* ¼����� */
  MINOR_IPC_NO_LINK = 41;/* IPC�����쳣 */
  MINOR_VI_EXCEPTION = 42;/* ��Ƶ�����쳣(ֻ���ģ��ͨ��) */
  MINOR_IPC_IP_CONFLICT = 43;/*ipc ip ��ַ ��ͻ*/

  //��Ƶ�ۺ�ƽ̨
  MINOR_FANABNORMAL = 49;/* ��Ƶ�ۺ�ƽ̨������״̬�쳣 */
  MINOR_FANRESUME = 50;/* ��Ƶ�ۺ�ƽ̨������״̬�ָ����� */
  MINOR_SUBSYSTEM_ABNORMALREBOOT = 51;/* ��Ƶ�ۺ�ƽ̨��6467�쳣���� */
  MINOR_MATRIX_STARTBUZZER = 52;/* ��Ƶ�ۺ�ƽ̨��dm6467�쳣������������ */

  //* ���� */
  //������
  MAJOR_OPERATION = 3;
  //������
  MINOR_START_DVR = 65;/* ���� */
  MINOR_STOP_DVR = 66;/* �ػ� */
  MINOR_STOP_ABNORMAL = 67;/* �쳣�ػ� */
  MINOR_REBOOT_DVR = 68;/*���������豸*/

  MINOR_LOCAL_LOGIN = 80;/* ���ص�½ */
  MINOR_LOCAL_LOGOUT = 81;/* ����ע����½ */
  MINOR_LOCAL_CFG_PARM = 82;/* �������ò��� */
  MINOR_LOCAL_PLAYBYFILE = 83;/* ���ذ��ļ��طŻ����� */
  MINOR_LOCAL_PLAYBYTIME = 84;/* ���ذ�ʱ��طŻ�����*/
  MINOR_LOCAL_START_REC = 85;/* ���ؿ�ʼ¼�� */
  MINOR_LOCAL_STOP_REC = 86;/* ����ֹͣ¼�� */
  MINOR_LOCAL_PTZCTRL = 87;/* ������̨���� */
  MINOR_LOCAL_PREVIEW = 88;/* ����Ԥ�� (������ʹ��)*/
  MINOR_LOCAL_MODIFY_TIME = 89;/* �����޸�ʱ��(������ʹ��) */
  MINOR_LOCAL_UPGRADE = 90;/* �������� */
  MINOR_LOCAL_RECFILE_OUTPUT = 91;/* ���ر���¼���ļ� */
  MINOR_LOCAL_FORMAT_HDD = 92;/* ���س�ʼ��Ӳ�� */
  MINOR_LOCAL_CFGFILE_OUTPUT = 93;/* �������������ļ� */
  MINOR_LOCAL_CFGFILE_INPUT = 94;/* ���뱾�������ļ� */
  MINOR_LOCAL_COPYFILE = 95;/* ���ر����ļ� */
  MINOR_LOCAL_LOCKFILE = 96;/* ��������¼���ļ� */
  MINOR_LOCAL_UNLOCKFILE = 97;/* ���ؽ���¼���ļ� */
  MINOR_LOCAL_DVR_ALARM = 98;/* �����ֶ�����ʹ�������*/
  MINOR_IPC_ADD = 99;/* �������IPC */
  MINOR_IPC_DEL = 100;/* ����ɾ��IPC */
  MINOR_IPC_SET = 101;/* ��������IPC */
  MINOR_LOCAL_START_BACKUP = 102;/* ���ؿ�ʼ���� */
  MINOR_LOCAL_STOP_BACKUP = 103;/* ����ֹͣ����*/
  MINOR_LOCAL_COPYFILE_START_TIME = 104;/* ���ر��ݿ�ʼʱ��*/
  MINOR_LOCAL_COPYFILE_END_TIME = 105;/* ���ر��ݽ���ʱ��*/
  MINOR_LOCAL_ADD_NAS = 106;/*�����������Ӳ��*/
  MINOR_LOCAL_DEL_NAS = 107;/* ����ɾ��nas��*/
  MINOR_LOCAL_SET_NAS = 108;/* ��������nas��*/

  MINOR_REMOTE_LOGIN = 112;/* Զ�̵�¼ */
  MINOR_REMOTE_LOGOUT = 113;/* Զ��ע����½ */
  MINOR_REMOTE_START_REC = 114;/* Զ�̿�ʼ¼�� */
  MINOR_REMOTE_STOP_REC = 115;/* Զ��ֹͣ¼�� */
  MINOR_START_TRANS_CHAN = 116;/* ��ʼ͸������ */
  MINOR_STOP_TRANS_CHAN = 117;/* ֹͣ͸������ */
  MINOR_REMOTE_GET_PARM = 118;/* Զ�̻�ȡ���� */
  MINOR_REMOTE_CFG_PARM = 119;/* Զ�����ò��� */
  MINOR_REMOTE_GET_STATUS = 120;/* Զ�̻�ȡ״̬ */
  MINOR_REMOTE_ARM = 121;/* Զ�̲��� */
  MINOR_REMOTE_DISARM = 122;/* Զ�̳��� */
  MINOR_REMOTE_REBOOT = 123;/* Զ������ */
  MINOR_START_VT = 124;/* ��ʼ�����Խ� */
  MINOR_STOP_VT = 125;/* ֹͣ�����Խ� */
  MINOR_REMOTE_UPGRADE = 126;/* Զ������ */
  MINOR_REMOTE_PLAYBYFILE = 127;/* Զ�̰��ļ��ط� */
  MINOR_REMOTE_PLAYBYTIME = 128;/* Զ�̰�ʱ��ط� */
  MINOR_REMOTE_PTZCTRL = 129;/* Զ����̨���� */
  MINOR_REMOTE_FORMAT_HDD = 130;/* Զ�̸�ʽ��Ӳ�� */
  MINOR_REMOTE_STOP = 131;/* Զ�̹ػ� */
  MINOR_REMOTE_LOCKFILE = 132;/* Զ�������ļ� */
  MINOR_REMOTE_UNLOCKFILE = 133;/* Զ�̽����ļ� */
  MINOR_REMOTE_CFGFILE_OUTPUT = 134;/* Զ�̵��������ļ� */
  MINOR_REMOTE_CFGFILE_INTPUT = 135;/* Զ�̵��������ļ� */
  MINOR_REMOTE_RECFILE_OUTPUT = 136;/* Զ�̵���¼���ļ� */
  MINOR_REMOTE_DVR_ALARM = 137;/* Զ���ֶ�����ʹ�������*/
  MINOR_REMOTE_IPC_ADD = 138;/* Զ�����IPC */
  MINOR_REMOTE_IPC_DEL = 139;/* Զ��ɾ��IPC */
  MINOR_REMOTE_IPC_SET = 140;/* Զ������IPC */
  MINOR_REBOOT_VCA_LIB = 141;/*�������ܿ�*/
  MINOR_REMOTE_ADD_NAS = 142;/* Զ�����nas��*/
  MINOR_REMOTE_DEL_NAS = 143;/* Զ��ɾ��nas��*/
  MINOR_REMOTE_SET_NAS = 144;/* Զ������nas��*/

  //2009-12-16 ������Ƶ�ۺ�ƽ̨��־����
  MINOR_SUBSYSTEMREBOOT = 160;/*��Ƶ�ۺ�ƽ̨��dm6467 ��������*/
  MINOR_MATRIX_STARTTRANSFERVIDEO = 161;	/*��Ƶ�ۺ�ƽ̨�������л���ʼ����ͼ��*/
  MINOR_MATRIX_STOPTRANSFERVIDEO = 162;	/*��Ƶ�ۺ�ƽ̨�������л�ֹͣ����ͼ��*/
  MINOR_REMOTE_SET_ALLSUBSYSTEM = 163;	/*��Ƶ�ۺ�ƽ̨����������6467��ϵͳ��Ϣ*/
  MINOR_REMOTE_GET_ALLSUBSYSTEM = 164;	/*��Ƶ�ۺ�ƽ̨����ȡ����6467��ϵͳ��Ϣ*/
  MINOR_REMOTE_SET_PLANARRAY = 165;	/*��Ƶ�ۺ�ƽ̨�����üƻ���ѯ��*/
  MINOR_REMOTE_GET_PLANARRAY = 166;	/*��Ƶ�ۺ�ƽ̨����ȡ�ƻ���ѯ��*/
  MINOR_MATRIX_STARTTRANSFERAUDIO = 167;	/*��Ƶ�ۺ�ƽ̨�������л���ʼ������Ƶ*/
  MINOR_MATRIX_STOPRANSFERAUDIO = 168;	/*��Ƶ�ۺ�ƽ̨�������л�ֹͣ������Ƶ*/
  MINOR_LOGON_CODESPITTER = 169;	/*��Ƶ�ۺ�ƽ̨����½�����*/
  MINOR_LOGOFF_CODESPITTER = 170;	/*��Ƶ�ۺ�ƽ̨���˳������*/

  //*��־������Ϣ*/
  //������
  MAJOR_INFORMATION = 4;/*������Ϣ*/
  //������
  MINOR_HDD_INFO = 161;/*Ӳ����Ϣ*/
  MINOR_SMART_INFO = 162;/*SMART��Ϣ*/
  MINOR_REC_START = 163;/*��ʼ¼��*/
  MINOR_REC_STOP = 164;/*ֹͣ¼��*/
  MINOR_REC_OVERDUE = 165;/*����¼��ɾ��*/
  MINOR_LINK_START = 166;//����ǰ���豸
  MINOR_LINK_STOP = 167;//�Ͽ�ǰ���豸��
  MINOR_NET_DISK_INFO = 168;//����Ӳ����Ϣ

  //����־��������ΪMAJOR_OPERATION=03��������ΪMINOR_LOCAL_CFG_PARM=0x52����MINOR_REMOTE_GET_PARM=0x76����MINOR_REMOTE_CFG_PARM=0x77ʱ��dwParaType:����������Ч���京�����£�
  PARA_VIDEOOUT = 1;
  PARA_IMAGE = 2;
  PARA_ENCODE = 4;
  PARA_NETWORK = 8;
  PARA_ALARM = 16;
  PARA_EXCEPTION = 32;
  PARA_DECODER = 64;/*������*/
  PARA_RS232 = 128;
  PARA_PREVIEW = 256;
  PARA_SECURITY = 512;
  PARA_DATETIME = 1024;
  PARA_FRAMETYPE = 2048;/*֡��ʽ*/
  //vca
  PARA_VCA_RULE = 4096;//��Ϊ����
  //************************DVR��־ End***************************/


  //*******************�����ļ�����־��������ֵ*************************/
  NET_DVR_FILE_SUCCESS = 1000;//����ļ���Ϣ
  NET_DVR_FILE_NOFIND = 1001;//û���ļ�
  NET_DVR_ISFINDING = 1002;//���ڲ����ļ�
  NET_DVR_NOMOREFILE = 1003;//�����ļ�ʱû�и�����ļ�
  NET_DVR_FILE_EXCEPTION = 1004;//�����ļ�ʱ�쳣

  //*********************�ص��������� begin************************/
  COMM_ALARM = 0x1100;//8000������Ϣ�����ϴ�����ӦNET_DVR_ALARMINFO
  COMM_ALARM_RULE = 0x1102;//��Ϊ����������Ϣ����ӦNET_VCA_RULE_ALARM
  COMM_ALARM_PDC = 0x1103;//������ͳ�Ʊ����ϴ�����ӦNET_DVR_PDC_ALRAM_INFO
  COMM_ALARM_ALARMHOST = 0x1105;//���籨�����������ϴ�����ӦNET_DVR_ALARMHOST_ALARMINFO
  COMM_ALARM_FACE = 0x1106;//�������ʶ�𱨾���Ϣ����ӦNET_DVR_FACEDETECT_ALARM
  COMM_RULE_INFO_UPLOAD = 0x1107;  // �¼�������Ϣ�ϴ�
  COMM_ALARM_AID = 0x1110;  //��ͨ�¼�������Ϣ
  COMM_ALARM_TPS = 0x1111;  //��ͨ����ͳ�Ʊ�����Ϣ
  COMM_UPLOAD_FACESNAP_RESULT = 0x1112;  //����ʶ�����ϴ�
  COMM_ALARM_TFS = 0x1113;  //��ͨȡ֤������Ϣ
  COMM_ALARM_TPS_V41 = 0x1114;  //��ͨ����ͳ�Ʊ�����Ϣ��չ
  COMM_ALARM_AID_V41 = 0x1115;  //��ͨ�¼�������Ϣ��չ
  COMM_ALARM_VQD_EX =  0x1116;	 //��Ƶ������ϱ���
  COMM_SENSOR_VALUE_UPLOAD = 0x1120;  //ģ��������ʵʱ�ϴ�
  COMM_SENSOR_ALARM  = 0x1121;  //ģ���������ϴ�
  COMM_SWITCH_ALARM   = 0x1122;	 //����������
  COMM_ALARMHOST_EXCEPTION   =  0x1123; //�����������ϱ���
  COMM_ALARMHOST_OPERATEEVENT_ALARM  = 0x1124;  //�����¼������ϴ�
  COMM_ALARMHOST_SAFETYCABINSTATE = 0x1125;	 //������״̬
  COMM_ALARMHOST_ALARMOUTSTATUS  = 0x1126;	 //���������/����״̬
  COMM_ALARMHOST_CID_ALARM 	 = 0x1127;	 //���汨���ϴ�
  COMM_ALARMHOST_EXTERNAL_DEVICE_ALARM = 0x1128;	 //������������豸�����ϴ�
  COMM_ALARMHOST_DATA_UPLOAD    = 0x1129;	 //���������ϴ�
  COMM_ALARM_AUDIOEXCEPTION	 =  0x1150;	 //����������Ϣ
  COMM_ALARM_DEFOCUS    =      0x1151;	 //�齹������Ϣ
  COMM_ALARM_BUTTON_DOWN_EXCEPTION =  0x1152;	 //��ť���±�����Ϣ
  COMM_ALARM_ALARMGPS   =    0x1202; //GPS������Ϣ�ϴ�
  COMM_TRADEINFO      =  0x1500;  //ATMDVR�����ϴ�������Ϣ
  COMM_UPLOAD_PLATE_RESULT  =   0x2800;	 //�ϴ�������Ϣ
  COMM_ITC_STATUS_DETECT_RESULT  = 0x2810;  //ʵʱ״̬������ϴ�(���ܸ���IPC)
  COMM_IPC_AUXALARM_RESULT  = 0x2820;  //PIR���������߱��������ȱ����ϴ�
  COMM_UPLOAD_PICTUREINFO    = 0x2900;	 //�ϴ�ͼƬ��Ϣ
  COMM_SNAP_MATCH_ALARM   = 0x2902;  //�������ȶԽ���ϴ�
  COMM_ITS_PLATE_RESULT   =  0x3050;  //�ն�ͼƬ�ϴ�
  COMM_ITS_TRAFFIC_COLLECT  = 0x3051;  //�ն�ͳ�������ϴ�
  COMM_ITS_GATE_VEHICLE = 0x3052;  //����ڳ���ץ�������ϴ�
  COMM_ITS_GATE_FACE  = 0x3053 ; //���������ץ�������ϴ�
  COMM_ITS_GATE_COSTITEM = 0x3054;  //����ڹ����շ���ϸ 2013-11-19
  COMM_ITS_GATE_HANDOVER = 0x3055 ; //����ڽ��Ӱ����� 2013-11-19
  COMM_ITS_PARK_VEHICLE  = 0x3056;  //ͣ���������ϴ�
  COMM_ITS_BLACKLIST_ALARM  = 0x3057;  //�����������ϴ�
  COMM_ALARM_V30	 =  0x4000;	 //9000������Ϣ�����ϴ�
  COMM_IPCCFG	 =  0x4001;	 //9000�豸IPC�������øı䱨����Ϣ�����ϴ�
  COMM_IPCCFG_V31 = 0x4002;	 //9000�豸IPC�������øı䱨����Ϣ�����ϴ���չ 9000_1.1
  COMM_IPCCFG_V40 =  0x4003; // IVMS 2000 ��������� NVR IPC�������øı�ʱ������Ϣ�ϴ�
  COMM_ALARM_DEVICE = 0x4004;  //�豸�������ݣ�����ͨ��ֵ����256����չ
  COMM_ALARM_CVR	 =  0x4005;  //CVR 2.0.X�ⲿ��������
  COMM_ALARM_HOT_SPARE = 0x4006;  //�ȱ��쳣������N+1ģʽ�쳣������
  COMM_ALARM_V40 = 0x4007;	//�ƶ���⣬��Ƶ��ʧ���ڵ���IO�ź����ȱ�����Ϣ�����ϴ�����������Ϊ�ɱ䳤

  COMM_ITS_ROAD_EXCEPTION = 0x4500;	 //·���豸�쳣����
  COMM_ITS_EXTERNAL_CONTROL_ALARM = 0x4520;  //��ر���
  COMM_SCREEN_ALARM    =  0x5000;  //������������������
  COMM_DVCS_STATE_ALARM = 0x5001;  //�ֲ�ʽ���������������ϴ�
  COMM_ALARM_VQD		 = 0x6000;  //VQD���������ϴ�
  COMM_PUSH_UPDATE_RECORD_INFO  = 0x6001;  //��ģʽ¼����Ϣ�ϴ�
  COMM_DIAGNOSIS_UPLOAD = 0x5100;  //��Ϸ�����VQD�����ϴ�

  //*************�����쳣����(��Ϣ��ʽ, �ص���ʽ(����))****************/
  EXCEPTION_EXCHANGE = 32768;//�û�����ʱ�쳣
  EXCEPTION_AUDIOEXCHANGE = 32769;//�����Խ��쳣
  EXCEPTION_ALARM = 32770;//�����쳣
  EXCEPTION_PREVIEW = 32771;//����Ԥ���쳣
  EXCEPTION_SERIAL = 32772;//͸��ͨ���쳣
  EXCEPTION_RECONNECT = 32773;//Ԥ��ʱ����
  EXCEPTION_ALARMRECONNECT = 32774;//����ʱ����
  EXCEPTION_SERIALRECONNECT = 32775;//͸��ͨ������
  EXCEPTION_PLAYBACK = 32784;//�ط��쳣
  EXCEPTION_DISKFMT = 32785;//Ӳ�̸�ʽ��

  //********************Ԥ���ص�����*********************/
  NET_DVR_SYSHEAD = 1;//ϵͳͷ����
  NET_DVR_STREAMDATA = 2;//��Ƶ�����ݣ�����������������Ƶ�ֿ�����Ƶ�����ݣ�
  NET_DVR_AUDIOSTREAMDATA = 3;//��Ƶ������
  NET_DVR_STD_VIDEODATA = 4;//��׼��Ƶ������
  NET_DVR_STD_AUDIODATA = 5;//��׼��Ƶ������

  //�ص�Ԥ���е�״̬����Ϣ
  NET_DVR_REALPLAYEXCEPTION = 111;//Ԥ���쳣
  NET_DVR_REALPLAYNETCLOSE = 112;//Ԥ��ʱ���ӶϿ�
  NET_DVR_REALPLAY5SNODATA = 113;//Ԥ��5sû���յ�����
  NET_DVR_REALPLAYRECONNECT = 114;//Ԥ������

  //********************�طŻص�����*********************/
  NET_DVR_PLAYBACKOVER = 101;//�ط����ݲ������
  NET_DVR_PLAYBACKEXCEPTION = 102;//�ط��쳣
  NET_DVR_PLAYBACKNETCLOSE = 103;//�ط�ʱ�����ӶϿ�
  NET_DVR_PLAYBACK5SNODATA = 104;//�ط�5sû���յ�����

  //*********************�ص��������� end************************/
  //�豸�ͺ�(DVR����)
  //* �豸���� */
  DVR = 1;/*����δ�����dvr���ͷ���NETRET_DVR*/
  ATMDVR = 2;/*atm dvr*/
  DVS = 3;/*DVS*/
  DEC = 4;/* 6001D */
  ENC_DEC = 5;/* 6001F */
  DVR_HC = 6;/*8000HC*/
  DVR_HT = 7;/*8000HT*/
  DVR_HF = 8;/*8000HF*/
  DVR_HS = 9;/* 8000HS DVR(no audio) */
  DVR_HTS = 10; /* 8016HTS DVR(no audio) */
  DVR_HB = 11; /* HB DVR(SATA HD) */
  DVR_HCS = 12; /* 8000HCS DVR */
  DVS_A = 13; /* ��ATAӲ�̵�DVS */
  DVR_HC_S = 14; /* 8000HC-S */
  DVR_HT_S = 15;/* 8000HT-S */
  DVR_HF_S = 16;/* 8000HF-S */
  DVR_HS_S = 17; /* 8000HS-S */
  ATMDVR_S = 18;/* ATM-S */
  LOWCOST_DVR = 19;/*7000Hϵ��*/
  DEC_MAT = 20; /*��·������*/
  DVR_MOBILE = 21;/* mobile DVR */
  DVR_HD_S = 22;   /* 8000HD-S */
  DVR_HD_SL = 23;/* 8000HD-SL */
  DVR_HC_SL = 24;/* 8000HC-SL */
  DVR_HS_ST = 25;/* 8000HS_ST */
  DVS_HW = 26; /* 6000HW */
  DS630X_D = 27; /* ��·������ */
  IPCAM = 30;/*IP �����*/
  MEGA_IPCAM = 31;/*X52MFϵ��,752MF,852MF*/
  IPCAM_X62MF = 32;/*X62MFϵ�пɽ���9000�豸,762MF,862MF*/
  IPDOME = 40; /*IP �������*/
  IPDOME_MEGA200 = 41;/*IP 200��������*/
  IPDOME_MEGA130 = 42;/*IP 130��������*/
  IPMOD = 50;/*IP ģ��*/
  DS71XX_H = 71;/* DS71XXH_S */
  DS72XX_H_S = 72;/* DS72XXH_S */
  DS73XX_H_S = 73;/* DS73XXH_S */
  DS76XX_H_S = 76;/* DS76XX_H_S */
  DS81XX_HS_S = 81;/* DS81XX_HS_S */
  DS81XX_HL_S = 82;/* DS81XX_HL_S */
  DS81XX_HC_S = 83;/* DS81XX_HC_S */
  DS81XX_HD_S = 84;/* DS81XX_HD_S */
  DS81XX_HE_S = 85;/* DS81XX_HE_S */
  DS81XX_HF_S = 86;/* DS81XX_HF_S */
  DS81XX_AH_S = 87;/* DS81XX_AH_S */
  DS81XX_AHF_S = 88;/* DS81XX_AHF_S */
  DS90XX_HF_S = 90;  /*DS90XX_HF_S*/
  DS91XX_HF_S = 91;  /*DS91XX_HF_S*/
  DS91XX_HD_S = 92; /*91XXHD-S(MD)*/
  //**********************�豸���� end***********************/

  {*************************************************
  �������ýṹ������(����_V30Ϊ9000����)
  **************************************************}
  //Уʱ�ṹ����

  //ʱ�����


  //ʱ���(�ӽṹ)

  //*�豸�������쳣����ʽ*/
  NOACTION = 0x0;/*����Ӧ*/
  WARNONMONITOR = 0x1;/*�������Ͼ���*/
  WARNONAUDIOOUT = 0x2;/*��������*/
  UPTOCENTER = 0x4;/*�ϴ�����*/
  TRIGGERALARMOUT = 0x8;/*�����������*/
  TRIGGERCATPIC = 0x10;/*����ץͼ���ϴ�E-mail*/
  SEND_PIC_FTP = 0x200;  /*ץͼ���ϴ�ftp*/


  //*0x00: ����Ӧ*/
  //*0x01: �������Ͼ���*/
  //*0x02: ��������*/
  //*0x04: �ϴ�����*/
  //*0x08: �����������*/
  //*0x10: ����JPRGץͼ���ϴ�Email*/
  //*0x20: �������ⱨ��������*/
  //*0x40: �������ӵ�ͼ(Ŀǰֻ��PCNVR֧��)*/
  //*0x200: ץͼ���ϴ�FTP*/

  //*0x00: ����Ӧ*/
  //*0x01: �������Ͼ���*/
  //*0x02: ��������*/
  //*0x04: �ϴ�����*/
  //*0x08: �����������*/
  //*0x10: ����JPRGץͼ���ϴ�Email*/
  //*0x20: �������ⱨ��������*/
  //*0x40: �������ӵ�ͼ(Ŀǰֻ��PCNVR֧��)*/
  //*0x200: ץͼ���ϴ�FTP*/

  //�������쳣����ṹ(�ӽṹ)(�ദʹ��)(9000��չ)
  //*0x00: ����Ӧ*/
  //*0x01: �������Ͼ���*/
  //*0x02: ��������*/
  //*0x04: �ϴ�����*/
  //*0x08: �����������*/
  //*0x10: ����JPRGץͼ���ϴ�Email*/
  //*0x20: �������ⱨ��������*/
  //*0x40: �������ӵ�ͼ(Ŀǰֻ��PCNVR֧��)*/
  //*0x200: ץͼ���ϴ�FTP*/

  //�������쳣����ṹ(�ӽṹ)(�ദʹ��)
  //*0x00: ����Ӧ*/
  //*0x01: �������Ͼ���*/
  //*0x02: ��������*/
  //*0x04: �ϴ�����*/
  //*0x08: �����������*/
  //*0x10: Jpegץͼ���ϴ�EMail*/

  //DVR�豸����
  //���²��ɸ���

  //*IP��ַ*/

  /// char[16]

  /// BYTE[128]


  //*�������ݽṹ(�ӽṹ)(9000��չ)*/

  //*�������ݽṹ(�ӽṹ)*/

  //pppoe�ṹ

  //�������ýṹ(9000��չ)

  //��������������Ϣ�ṹ��

  //�������������ýṹ

  //�������ýṹ


  //IP���ӶԽ��ֻ�����

  //Ip���ӶԽ���Ƶ��ز�������

  //IP�ֻ����жԽ��������ýṹ��

  //ͨ��ͼ��ṹ
  //�ƶ����(�ӽṹ)(���鷽ʽ��չ)

  //ͨ��ͼ��ṹ
  //�ƶ����(�ӽṹ)(9000��չ)

  //�ƶ����(�ӽṹ)

  //�ڵ�����(�ӽṹ)(9000��չ)  �����С704*576

  //�ڵ�����(�ӽṹ)  �����С704*576

  //�źŶ�ʧ����(�ӽṹ)(9000��չ)

  //�źŶ�ʧ����(�ӽṹ)

  //�ڵ�����(�ӽṹ)


  //ͨ��ͼ��ṹ(9000��չ)
  //��ʾͨ����
  //��Ƶ�źŶ�ʧ����
  //�ƶ����
  //�ڵ�����
  //�ڵ�  �����С704*576
  //OSD
  //* 0: XXXX-XX-XX ������ */
  //* 1: XX-XX-XXXX ������ */
  //* 2: XXXX��XX��XX�� */
  //* 3: XX��XX��XXXX�� */
  //* 4: XX-XX-XXXX ������*/
  //* 5: XX��XX��XXXX�� */
  //* 0: ����ʾOSD */
  //* 1: ͸��,��˸ */
  //* 2: ͸��,����˸ */
  //* 3: ��˸,��͸�� */
  //* 4: ��͸��,����˸ */

  //ͨ��ͼ��ṹSDK_V14��չ
  //��ʾͨ����
  //�źŶ�ʧ����
  //�ƶ����
  //�ڵ�����
  //�ڵ�  �����С704*576
  //OSD
  //* 0: XXXX-XX-XX ������ */
  //* 1: XX-XX-XXXX ������ */
  //* 2: XXXX��XX��XX�� */
  //* 3: XX��XX��XXXX�� */
  //* 4: XX-XX-XXXX ������*/
  //* 5: XX��XX��XXXX�� */
  //* 0: ����ʾOSD */
  //* 1: ͸��,��˸ */
  //* 2: ͸��,����˸ */
  //* 3: ��˸,��͸�� */
  //* 4: ��͸��,����˸ */

  //ͨ��ͼ��ṹ(SDK_V13��֮ǰ�汾)
  //��ʾͨ����
  //�źŶ�ʧ����
  //�ƶ����
  //�ڵ�����
  //�ڵ�  �����С704*576
  //OSD
  //* 0: XXXX-XX-XX ������ */
  //* 1: XX-XX-XXXX ������ */
  //* 2: XXXX��XX��XX�� */
  //* 3: XX��XX��XXXX�� */
  //* 4: XX-XX-XXXX ������*/
  //* 5: XX��XX��XXXX�� */
  //* 0: ����ʾOSD */
  //* 1: ͸��,��˸ */
  //* 2: ͸��,����˸ */
  //* 3: ��˸,��͸�� */
  //* 4: ��͸��,����˸ */

  //����ѹ������(�ӽṹ)(9000��չ)
  // 13-384K 14-448K 15-512K 16-640K 17-768K 18-896K 19-1024K 20-1280K 21-1536K 22-1792K 23-2048K
  //���λ(31λ)�ó�1��ʾ���Զ�������, 0-30λ��ʾ����ֵ��
  //2006-08-11 ���ӵ�P֡�����ýӿڣ����Ը���ʵʱ����ʱ����

  //ͨ��ѹ������(9000��չ)

  //����ѹ������(�ӽṹ)
  // 13-384K 14-448K 15-512K 16-640K 17-768K 18-896K 19-1024K 20-1280K 21-1536K 22-1792K 23-2048K
  //���λ(31λ)�ó�1��ʾ���Զ�������, 0-30λ��ʾ����ֵ(MIN-32K MAX-8192K)��

  //ͨ��ѹ������

  //����ѹ������(�ӽṹ)(��չ) ����I֡���
  // 13-384K 14-448K 15-512K 16-640K 17-768K 18-896K 19-1024K 20-1280K 21-1536K 22-1792K 23-2048K
  //���λ(31λ)�ó�1��ʾ���Զ�������, 0-30λ��ʾ����ֵ(MIN-32K MAX-8192K)��
  //2006-08-11 ���ӵ�P֡�����ýӿڣ����Ը���ʵʱ����ʱ����

  //ͨ��ѹ������(��չ)

  //ʱ���¼���������(�ӽṹ)

  //ȫ��¼���������(�ӽṹ)

  //ͨ��¼���������(9000��չ)

  //ͨ��¼���������

  //��̨Э���ṹ����

  //***************************��̨����(end)******************************/

  //ͨ��������(��̨)��������(9000��չ)

  //ͨ��������(��̨)��������

  //ppp��������(�ӽṹ)

  //ppp��������(�ӽṹ)

  //RS232���ڲ�������(9000��չ)

  //RS232���ڲ�������(9000��չ)

  //RS232���ڲ�������




  //���������������(256·NVR��չ)
  //*0x00: ����Ӧ*/
  //*0x01: �������Ͼ���*/
  //*0x02: ��������*/
  //*0x04: �ϴ�����*/
  //*0x08: �����������*/
  //*0x10: ����JPRGץͼ���ϴ�Email*/
  //*0x20: �������ⱨ��������*/
  //*0x40: �������ӵ�ͼ(Ŀǰֻ��PCNVR֧��)*/
  //*0x200: ץͼ���ϴ�FTP*/
  //*������¼��ͨ��*/

  //���������������(9000��չ)







  //���������������

  //ģ�ⱨ�������������

  //�ϴ�������Ϣ(9000��չ)






  //////////////////////////////////////////////////////////////////////////////////////
  //IPC�����������
  //* IP�豸�ṹ */


  //ipc�����豸��Ϣ��չ��֧��ip�豸���������


  //* IPͨ��ƥ����� */

  //* IP�������ýṹ */



  //* ��չIP�������ýṹ */




  //*��ý���������������*/
  //�豸ͨ����Ϣ









  //uGetStream.Init();

  //* V40��չIP�������ýṹ */





  //ΪCVR��չ�ı�������
  //3-������״̬�쳣��4-ϵͳʱ���쳣��5-¼���ʣ���������ͣ�
  //6-������(ͨ��)�ƶ���ⱨ����7-������(ͨ��)�ڵ�������

  //* ����������� */


  //* IP����������ýṹ */

  //* IP����������� */

  //*IP�������*/

  //* ����������� */

  //* IP�����������ýṹ */
  //* IP����������� */
  //*IP����������Դ*/

  //ipc alarm info

  //ipc���øı䱨����Ϣ��չ 9000_1.1



  //����Ӳ����Ϣ����
  // dwStorageType & 0x1 ��ʾ�Ƿ�����ͨ¼��ר�ô洢��
  // dwStorageType & 0x2  ��ʾ�Ƿ��ǳ�֡¼��ר�ô洢��
  // dwStorageType & 0x4 ��ʾ�Ƿ���ͼƬ¼��ר�ô洢��



  //����������Ϣ������չ


  //����������Ϣ����


  //�������Ų����Ľṹ

  //DVR�������(9000��չ)
  //0-5��,1-10��,2-30��,3-1����,4-2����,5-5����,6-10����,7-�ֶ�

  //DVR�������
  //0-5��,1-10��,2-30��,3-1����,4-2����,5-5����,6-10����,7-�ֶ�

  //DVR����Ԥ������(9000��չ)

  //DVR����Ԥ������

  //DVR��Ƶ���

  //MATRIX��������ṹ



  //DVR��Ƶ���(9000��չ)

  //DVR��Ƶ���

  //���û�����(�ӽṹ)(��չ)
  //*����0: ���ؿ�����̨*/
  //*����1: �����ֶ�¼��*/
  //*����2: ���ػط�*/
  //*����3: �������ò���*/
  //*����4: ���ز鿴״̬����־*/
  //*����5: ���ظ߼�����(��������ʽ�����������ػ�)*/
  //*����6: ���ز鿴���� */
  //*����7: ���ع���ģ���IP camera */
  //*����8: ���ر��� */
  //*����9: ���عػ�/���� */
  //*����0: Զ�̿�����̨*/
  //*����1: Զ���ֶ�¼��*/
  //*����2: Զ�̻ط� */
  //*����3: Զ�����ò���*/
  //*����4: Զ�̲鿴״̬����־*/
  //*����5: Զ�̸߼�����(��������ʽ�����������ػ�)*/
  //*����6: Զ�̷��������Խ�*/
  //*����7: Զ��Ԥ��*/
  //*����8: Զ�����󱨾��ϴ����������*/
  //*����9: Զ�̿��ƣ��������*/
  //*����10: Զ�̿��ƴ���*/
  //*����11: Զ�̲鿴���� */
  //*����12: Զ�̹���ģ���IP camera */
  //*����13: Զ�̹ػ�/���� */
  {* �ޡ�����ʾ��֧�����ȼ�������
  �͡���Ĭ��Ȩ��:�������غ�Զ�̻ط�,���غ�Զ�̲鿴��־��״̬,���غ�Զ�̹ػ�/����
  �С����������غ�Զ�̿�����̨,���غ�Զ���ֶ�¼��,���غ�Զ�̻ط�,�����Խ���Զ��Ԥ�������ر���,����/Զ�̹ػ�/����
  �ߡ�������Ա *}

  //���û�����(�ӽṹ)(9000��չ)
  //*����0: ���ؿ�����̨*/
  //*����1: �����ֶ�¼��*/
  //*����2: ���ػط�*/
  //*����3: �������ò���*/
  //*����4: ���ز鿴״̬����־*/
  //*����5: ���ظ߼�����(��������ʽ�����������ػ�)*/
  //*����6: ���ز鿴���� */
  //*����7: ���ع���ģ���IP camera */
  //*����8: ���ر��� */
  //*����9: ���عػ�/���� */
  //*����0: Զ�̿�����̨*/
  //*����1: Զ���ֶ�¼��*/
  //*����2: Զ�̻ط� */
  //*����3: Զ�����ò���*/
  //*����4: Զ�̲鿴״̬����־*/
  //*����5: Զ�̸߼�����(��������ʽ�����������ػ�)*/
  //*����6: Զ�̷��������Խ�*/
  //*����7: Զ��Ԥ��*/
  //*����8: Զ�����󱨾��ϴ����������*/
  //*����9: Զ�̿��ƣ��������*/
  //*����10: Զ�̿��ƴ���*/
  //*����11: Զ�̲鿴���� */
  //*����12: Զ�̹���ģ���IP camera */
  //*����13: Զ�̹ػ�/���� */
  {*
  �ޡ�����ʾ��֧�����ȼ�������
  �͡���Ĭ��Ȩ��:�������غ�Զ�̻ط�,���غ�Զ�̲鿴��־��״̬,���غ�Զ�̹ػ�/����
  �С����������غ�Զ�̿�����̨,���غ�Զ���ֶ�¼��,���غ�Զ�̻ط�,�����Խ���Զ��Ԥ��
  ���ر���,����/Զ�̹ػ�/����
  �ߡ�������Ա
  *}

  //���û�����(SDK_V15��չ)(�ӽṹ)
  //*����0: ���ؿ�����̨*/
  //*����1: �����ֶ�¼��*/
  //*����2: ���ػط�*/
  //*����3: �������ò���*/
  //*����4: ���ز鿴״̬����־*/
  //*����5: ���ظ߼�����(��������ʽ�����������ػ�)*/
  //*����0: Զ�̿�����̨*/
  //*����1: Զ���ֶ�¼��*/
  //*����2: Զ�̻ط� */
  //*����3: Զ�����ò���*/
  //*����4: Զ�̲鿴״̬����־*/
  //*����5: Զ�̸߼�����(��������ʽ�����������ػ�)*/
  //*����6: Զ�̷��������Խ�*/
  //*����7: Զ��Ԥ��*/
  //*����8: Զ�����󱨾��ϴ����������*/
  //*����9: Զ�̿��ƣ��������*/
  //*����10: Զ�̿��ƴ���*/

  //���û�����(�ӽṹ)
  //*����0: ���ؿ�����̨*/
  //*����1: �����ֶ�¼��*/
  //*����2: ���ػط�*/
  //*����3: �������ò���*/
  //*����4: ���ز鿴״̬����־*/
  //*����5: ���ظ߼�����(��������ʽ�����������ػ�)*/
  //*����0: Զ�̿�����̨*/
  //*����1: Զ���ֶ�¼��*/
  //*����2: Զ�̻ط� */
  //*����3: Զ�����ò���*/
  //*����4: Զ�̲鿴״̬����־*/
  //*����5: Զ�̸߼�����(��������ʽ�����������ػ�)*/
  //*����6: Զ�̷��������Խ�*/
  //*����7: Զ��Ԥ��*/
  //*����8: Զ�����󱨾��ϴ����������*/
  //*����9: Զ�̿��ƣ��������*/
  //*����10: Զ�̿��ƴ���*/

  //DVR�û�����(��չ)

  //DVR�û�����(9000��չ)

  //DVR�û�����(SDK_V15��չ)

  //DVR�û�����

  //�쳣����������չ�ṹ��

  //DVR�쳣����(9000��չ)
  //*����0-����,1- Ӳ�̳���,2-���߶�,3-��������IP ��ַ��ͻ, 4-�Ƿ�����, 5-����/�����Ƶ��ʽ��ƥ��, 6-��Ƶ�ź��쳣, 7-¼���쳣*/

  //DVR�쳣����
  //*����0-����,1- Ӳ�̳���,2-���߶�,3-��������IP ��ַ��ͻ,4-�Ƿ�����, 5-����/�����Ƶ��ʽ��ƥ��, 6-��Ƶ�ź��쳣*/

  //ͨ��״̬(9000��չ)



  //ͨ��״̬

  //Ӳ��״̬

  //�豸����״̬��չ�ṹ��


  //DVR����״̬(9000��չ)


  //DVR����״̬


  //��־��Ϣ(9000��չ)

  //��־��Ϣ

  //************************������������������־���� begin************************************************/

  //*************************������������������־���� end***********************************************/

  //�������״̬(9000��չ)


  //�������״̬

  //ATMר��
  //****************************ATM(begin)***************************/
  NCR = 0;
  DIEBOLD = 1;
  WINCOR_NIXDORF = 2;
  SIEMENS = 3;
  OLIVETTI = 4;
  FUJITSU = 5;
  HITACHI = 6;
  SMI = 7;
  IBM = 8;
  BULL = 9;
  YiHua = 10;
  LiDe = 11;
  GDYT = 12;
  Mini_Banl = 13;
  GuangLi = 14;
  DongXin = 15;
  ChenTong = 16;
  NanTian = 17;
  XiaoXing = 18;
  GZYY = 19;
  QHTLT = 20;
  DRS918 = 21;
  KALATEL = 22;
  NCR_2 = 23;
  NXS = 24;

  //������Ϣ

  //*֡��ʽ*/

  //ATM����

  //SDK_V31 ATM
  //*��������*/

  //*��ʼ��ʶ����*/

  //*������Ϣλ��*/

  //*������Ϣ����*/

  //*OSD ���ӵ�λ��*/

  //*������ʾ��ʽ*/

  //*ʱ����ʾ��ʽ*/






  //�û��Զ���Э��


  //Э����Ϣ���ݽṹ



  //*****************************DS-6001D/F(begin)***************************/
  //DS-6001D Decoder


  //*�����豸�����붨��*/
  NET_DEC_STARTDEC = 1;
  NET_DEC_STOPDEC = 2;
  NET_DEC_STOPCYCLE = 3;
  NET_DEC_CONTINUECYCLE = 4;

  //*���ӵ�ͨ������*/

  //*ÿ������ͨ��������*/

  //*�����豸��������*/

  //2005-08-01
  //* �����豸͸��ͨ������ */



  //* ���������ļ��ط� */




  //*��ǰ�豸��������״̬*/




  //*****************************DS-6001D/F(end)***************************/

  //���ַ�����(�ӽṹ)

  //�����ַ�(9000��չ)

  //�����ַ���չ(8���ַ�)

  //�����ַ�

  //****************************DS9000�����ṹ(begin)******************************/
  //*EMAIL�����ṹ*/
  //��ԭ�ṹ���в���






  //*DVRʵ��Ѳ�����ݽṹ*/
  //****************************DS9000�����ṹ(end)******************************/
  //ʱ���

  //����ʱ����

  //ͼƬ����
  {*ע�⣺��ͼ��ѹ���ֱ���ΪVGAʱ��֧��0=CIF, 1=QCIF, 2=D1ץͼ��
  ���ֱ���Ϊ3=UXGA(1600x1200), 4=SVGA(800x600), 5=HD720p(1280x720),6=VGA,7=XVGA, 8=HD900p
  ��֧�ֵ�ǰ�ֱ��ʵ�ץͼ*}

  //* aux video out parameter */
  //���������������

  //ntp

  //ddns


  //9000��չ


  //email

  //�����������

  //nfs�ṹ����






  //Ѳ��������(HIK IP����ר��)




  //************************************��·������(begin)***************************************/


  //����/ֹͣ��̬����



  //���ӵ�ͨ������ 2007-11-05

  //2007-11-05 ����ÿ������ͨ��������

  //2007-12-22

  {*
  *	��·������������1��485���ڣ�1��232���ڶ�������Ϊ͸��ͨ��,�豸�ŷ������£�
  *	0 RS485
  *	1 RS232 Console
  *}
  {*
  *	Զ�̴��������������,һ��RS232��һ��RS485
  *	1��ʾ232����
  *	2��ʾ485����
  *}


  //2007-12-24 Merry Christmas Eve...



  //2009-4-11 added by likui ��·������new

  {*
  *	��·������������1��485���ڣ�1��232���ڶ�������Ϊ͸��ͨ��,�豸�ŷ������£�
  *	0 RS485
  *	1 RS232 Console
  *}
  {*
  *	Զ�̴��������������,һ��RS232��һ��RS485
  *	1��ʾ232����
  *	2��ʾ485����
  *}





  //*��ý���������������*/

  //�豸ͨ����Ϣ


  //��̬������������

  //��̬����ȡ������

  //ȡ��ģʽ����������


  MAX_RESOLUTIONNUM = 64; //֧�ֵ����ֱ�����Ŀ


  //�ϴ�logo�ṹ

  //*��������*/
  NET_DVR_ENCODER_UNKOWN = 0;/*δ֪�����ʽ*/
  NET_DVR_ENCODER_H264 = 1;/*HIK 264*/
  NET_DVR_ENCODER_S264 = 2;/*Standard H264*/
  NET_DVR_ENCODER_MPEG4 = 3;/*MPEG4*/
  NET_DVR_ORIGINALSTREAM = 4;/*Original Stream*/
  NET_DVR_PICTURE = 5;//*Picture*/
  NET_DVR_ENCODER_MJPEG = 6;
  NET_DVR_ECONDER_MPEG2 = 7;
  //* �����ʽ */
  NET_DVR_STREAM_TYPE_UNKOWN = 0;/*δ֪�����ʽ*/
  NET_DVR_STREAM_TYPE_HIKPRIVT = 1; /*�����Զ�������ʽ*/
  NET_DVR_STREAM_TYPE_TS = 7;/* TS��� */
  NET_DVR_STREAM_TYPE_PS = 8;/* PS��� */
  NET_DVR_STREAM_TYPE_RTP = 9;/* RTP��� */

  //*����ͨ��״̬*/

  //*��ʾͨ��״̬*/
  NET_DVR_MAX_DISPREGION = 16;         /*ÿ����ʾͨ����������ʾ�Ĵ���*/
  //VGA�ֱ��ʣ�Ŀǰ���õ��ǣ�VGA_THS8200_MODE_XGA_60HZ��VGA_THS8200_MODE_SXGA_60HZ��
  //
  //*VGA*/
  //*HDMI*/
  //*DVI*/

  //��֡�ʶ���
  LOW_DEC_FPS_1_2 = 51;
  LOW_DEC_FPS_1_4 = 52;
  LOW_DEC_FPS_1_8 = 53;
  LOW_DEC_FPS_1_16 = 54;

  //*��Ƶ��ʽ��׼*/

  //*�����Ӵ��ڶ�Ӧ����ͨ������Ӧ�Ľ�����ϵͳ�Ĳ�λ��(������Ƶ�ۺ�ƽ̨�н�����ϵͳ��Ч)*/






  MAX_DECODECHANNUM = 32;//��·������������ͨ����
  MAX_DISPCHANNUM = 24;//��·�����������ʾͨ����

  //*�������豸״̬*/

  //2009-12-1 ���ӱ������벥�ſ���

  PASSIVE_DEC_PAUSE = 1;	/*����������ͣ(���ļ�����Ч)*/
  PASSIVE_DEC_RESUME = 2;	/*�ָ���������(���ļ�����Ч)*/
  PASSIVE_DEC_FAST = 3;   /*���ٱ�������(���ļ�����Ч)*/
  PASSIVE_DEC_SLOW = 4;   /*���ٱ�������(���ļ�����Ч)*/
  PASSIVE_DEC_NORMAL = 5;   /*������������(���ļ�����Ч)*/
  PASSIVE_DEC_ONEBYONE =	6;  /*�������뵥֡����(����)*/
  PASSIVE_DEC_AUDIO_ON = 7;   /*��Ƶ����*/
  PASSIVE_DEC_AUDIO_OFF = 8; 	 /*��Ƶ�ر�*/
  PASSIVE_DEC_RESETBUFFER = 9;    /*��ջ�����*/

  //2009-12-16 ���ӿ��ƽ���������ͨ������
  //************************************��·������(end)***************************************/

  //************************************��Ƶ�ۺ�ƽ̨(begin)***************************************/
  MAX_SUBSYSTEM_NUM = 80;   //һ������ϵͳ�������ϵͳ����
  MAX_SUBSYSTEM_NUM_V40 = 120;   //һ������ϵͳ�������ϵͳ����
  MAX_SERIALLEN = 36;  //������кų���
  MAX_LOOPPLANNUM = 16;  //���ƻ��л���
  DECODE_TIMESEGMENT = 4;     //�ƻ�����ÿ��ʱ�����

  MAX_DOMAIN_NAME = 64;  /* ����������� */
  MAX_DISKNUM_V30 = 33; //9000�豸���Ӳ����/* ���33��Ӳ��(����16������SATAӲ�̡�1��eSATAӲ�̺�16��NFS��) */
  MAX_DAYS = 7;       //ÿ������
  MAX_DISPNUM_V41 = 32;
  MAX_WINDOWS_NUM = 12;
  MAX_VOUTNUM = 32;
  MAX_SUPPORT_RES = 32;
  MAX_BIGSCREENNUM = 100;

  VIDEOPLATFORM_ABILITY = 0x210; //��Ƶ�ۺ�ƽ̨������
  MATRIXDECODER_ABILITY_V41 = 0x260; //������������

  NET_DVR_MATRIX_BIGSCREENCFG_GET = 1140;//��ȡ����ƴ�Ӳ���







  //************************************��Ƶ�ۺ�ƽ̨(end)***************************************/



  //*��ϵͳ���ͣ�1-��������ϵͳ��2-��������ϵͳ��3-���������ϵͳ��4-����������ϵͳ��5-�������ϵͳ��6-����������ϵͳ��7-������ϵͳ��8-V6������ϵͳ��9-V6��ϵͳ��0-NULL���˲���ֻ�ܻ�ȡ��*/

  //��ǿ�ͱ���������Ϊ��������Դ�ɱ����ã���ͨ�����ܱ�����)

  //  [FieldOffsetAttribute(0)]



  //����ƴ�Ӵ���Ļ��Ϣ
  //��ʼ�������Ϊ��׼�����������


  //************************************��Ƶ�ۺ�ƽ̨(end)***************************************/



  //���λ����Ϣ

  //�����Χ��Ϣ

  //rtsp���� ipcameraר��

  //********************************�ӿڲ����ṹ(begin)*********************************/

  //NET_DVR_Login()�����ṹ

  //NET_DVR_Login_V30()�����ṹ
  //bySupport & 0x1, ��ʾ�Ƿ�֧����������
  //bySupport & 0x2, ��ʾ�Ƿ�֧�ֱ���
  //bySupport & 0x4, ��ʾ�Ƿ�֧��ѹ������������ȡ
  //bySupport & 0x8, ��ʾ�Ƿ�֧�ֶ�����
  //bySupport & 0x10, ��ʾ֧��Զ��SADP
  //bySupport & 0x20, ��ʾ֧��Raid������
  //bySupport & 0x40, ��ʾ֧��IPSAN Ŀ¼����
  //bySupport & 0x80, ��ʾ֧��rtp over rtsp
  //bySupport1 & 0x1, ��ʾ�Ƿ�֧��snmp v30
  //bySupport1 & 0x2, ֧�����ֻطź�����
  //bySupport1 & 0x4, �Ƿ�֧�ֲ������ȼ�
  //bySupport1 & 0x8, �����豸�Ƿ�֧�ֲ���ʱ�����չ
  //bySupport1 & 0x10, ��ʾ�Ƿ�֧�ֶ������������33����
  //bySupport1 & 0x20, ��ʾ�Ƿ�֧��rtsp over http
  //bySupport1 & 0x80, ��ʾ�Ƿ�֧�ֳ����±�����Ϣ2012-9-28, �һ���ʾ�Ƿ�֧��NET_DVR_IPPARACFG_V40�ṹ��
  //bySupport3 & 0x1, ��ʾ�Ƿ������
  // bySupport3 & 0x4 ��ʾ֧�ְ������ã� ������� ͨ��ͼ��������������������IP�������롢������������
  // �û��������豸����״̬��JPEGץͼ����ʱ��ʱ��ץͼ��Ӳ���������
  //bySupport3 & 0x8Ϊ1 ��ʾ֧��ʹ��TCPԤ����UDPԤ�����ಥԤ���е�"��ʱԤ��"�ֶ���������ʱԤ������������ʹ�����ַ�ʽ������ʱԤ����������bySupport3 & 0x8Ϊ0ʱ����ʹ�� "˽����ʱԤ��"Э�顣
  //bySupport3 & 0x10 ��ʾ֧��"��ȡ����������Ҫ״̬��V40��"��
  //bySupport3 & 0x20 ��ʾ�Ƿ�֧��ͨ��DDNS��������ȡ��

  //  byLanguageType ����0 ��ʾ ���豸
  //  byLanguageType & 0x1��ʾ֧������
  //  byLanguageType & 0x2��ʾ֧��Ӣ��

  //sdk���绷��ö�ٱ���������Զ������

  //��ʾģʽ

  //����ģʽ

  //ץͼģʽ

  //ʵʱ����ģʽ


  //SDK״̬��Ϣ(9000����)

  //SDK����֧����Ϣ(9000����)

  //�����豸��Ϣ

  //Ӳ������ʾ�������(�ӽṹ)

  //Ӳ����Ԥ������

  //¼���ļ�����

  //¼���ļ�����(9000)
  //3-����|�ƶ���� 4-����&�ƶ���� 5-����� 6-�ֶ�¼��,7���𶯱�����8-����������9-���ܱ�����10-PIR������11-���߱�����12-���ȱ���,14-���ܽ�ͨ�¼�

  //¼���ļ�����(cvr)
  //3-����|�ƶ���� 4-����&�ƶ���� 5-����� 6-�ֶ�¼��,7���𶯱�����8-����������9-���ܱ�����10-PIR������11-���߱�����12-���ȱ���,14-���ܽ�ͨ�¼�

  //¼���ļ�����(������)

  //¼���ļ����������ṹ
  //3-����|�ƶ���� 4-����&�ƶ���� 5-����� 6-�ֶ�¼��

  //��̨����ѡ��Ŵ���С(HIK ����ר��)

  //�����Խ�����

















  //wifi����״̬


  //���ܿ�����Ϣ
  MAX_VCA_CHAN = 16;//�������ͨ����
  // byControlType &1 �Ƿ�����ץ�Ĺ���

  //���ܿ�����Ϣ�ṹ

  //�����豸������
  //bySupport & 0x1����ʾ�Ƿ�֧�����ܸ��� 2012-3-22
  //bySupport & 0x2����ʾ�Ƿ�֧��128·ȡ����չ2012-12-27

  //��Ϊ������������

  //����ͨ������

  //����ATMģʽ����(ATM��������)

  //��Ϊ��������ģʽ

  //ͨ�������������

  //��Ϊ�������ṹ
  // bySupport & 0x01 ֧�ֱ궨����

  // ��ͨ�������ṹ
  //***********************************end*******************************************/

  //************************************���ܲ����ṹ*********************************/
  //���ܹ��ýṹ
  //����ֵ��һ��,������ֵΪ��ǰ����İٷֱȴ�С, ����ΪС�������λ
  //������ṹ

  //�����ṹ

  //��Ϊ�����¼�����

  //��Ϊ�����¼�������չ

  //�����洩Խ��������

  //�߽ṹ

  //             public void init()
  //             {
  //                 struStart = new NET_VCA_POINT();
  //                 struEnd = new NET_VCA_POINT();
  //             }

  //�ýṹ�ᵼ��xaml�������������������������������������ʱ��û���ҵ�
  //��ʱ���νṹ��
  //����ͽṹ��
  /// DWORD->unsigned int


  //             public void init()
  //             {
  //                 struPlaneBottom = new NET_VCA_LINE();
  //                 struPlaneBottom.init();
  //                 byRes2 = new byte[38];
  //             }

  //����/�뿪�������

  //���ݱ����ӳ�ʱ������ʶ�����д�ͼƬ�����������IO����һ�£�1�뷢��һ����
  //���ֲ���

  //�ǻ�����

  //����/�������

  //ͣ������

  //���ܲ���

  //��Ա�ۼ�����

  //�����˶�����

  //�ʸ߲���

  //�𴲲���

  //��Ʒ����

  // ��Ʒ��ȡ



  //��ֽ������

  //����������

  //����¼�

  //β�����

  //���ز���

  //��ǿͻ�����






  //�����¼�����

  //[FieldOffsetAttribute(0)]
  //public NET_VCA_TRAVERSE_PLANE struTraversePlane;//��Խ���������
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_AREA struArea;//����/�뿪�������
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_INTRUSION struIntrusion;//���ֲ���
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_LOITER struLoiter;//�ǻ�����
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_TAKE_LEFT struTakeTeft;//����/�������
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_PARKING struParking;//ͣ������
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_RUN struRun;//���ܲ���
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_HIGH_DENSITY struHighDensity;//��Ա�ۼ�����
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_VIOLENT_MOTION struViolentMotion;	//�����˶�
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_REACH_HIGHT struReachHight;      //�ʸ�
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_GET_UP struGetUp;           //��
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_LEFT struLeft;            //��Ʒ����
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_TAKE struTake;            // ��Ʒ��ȡ
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_HUMAN_ENTER struHumanEnter;      //��Ա����
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_OVER_TIME struOvertime;        //������ʱ
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_STICK_UP struStickUp;//��ֽ��
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_SCANNER struScanner;//����������
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_LEAVE_POSITION struLeavePos;        //��ڲ���
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_TRAIL struTrail;           //β�����
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_FALL_DOWN struFallDown;        //���ز���
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_AUDIO_ABNORMAL struAudioAbnormal;   //��ǿͻ��
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_ADV_REACH_HEIGHT struReachHeight;     //�����ʸ߲���
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_TOILET_TARRY struToiletTarry;     //��޳�ʱ����
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_YARD_TARRY struYardTarry;       //�ŷ糡��������
  //[FieldOffsetAttribute(0)]
  //public NET_VCA_ADV_TRAVERSE_PLANE struAdvTraversePlane;//���߾��������

  // �ߴ����������

  //�ߴ������

  //�������ṹ

  //��Ϊ�������ýṹ��

  //�ߴ���˲���

  //���򴥷�����

  //�������ṹ

  //��Ϊ�������ýṹ��

  //��Ŀ��ṹ��

  //�򻯵Ĺ�����Ϣ, ��������Ļ�����Ϣ

  //ǰ���豸��ַ��Ϣ�����ܷ����Ǳ�ʾ����ǰ���豸�ĵ�ַ��Ϣ�������豸��ʾ�����ĵ�ַ

  //��Ϊ��������ϱ��ṹ

  //��Ϊ��������DSP��Ϣ���ӽṹ

  //��������

  //������ɫ�����ṹ��

  //ͼƬ����

  //��ɫ������

  //������ɫ�����ṹ��

  //��������

  //��������

  //���������б�

  //ͨ������ģʽ

  //ͨ������ģʽ�����ṹ��

  //�豸ͨ�������ṹ��

  //��ͨ����Ϣ������

  //��ͨ�������ṹ��


  //��ͨ���������ýṹ��

  //��Ƶ������ϼ���¼�

  //��Ƶ��������¼������ṹ��

  //��Ƶ��������¼�����

  //��Ƶ��������¼�����

  //��׼��������

  //��׼�������������ṹ��

  //��Ƶ������ϱ����ṹ��

  //�궨���ӽṹ

  //�궨�������ýṹ

  //������ýṹ

  //����ģʽ

  //�ֶ����ƽṹ

  //����ģʽ�ṹ


  //��������Ϊ��������ṹ
  //�������ṹ

  // �����ǹ���ṹ

  // IVMS��Ϊ�������ýṹ

  //���ܷ�����ȡ���ƻ��ӽṹ

  //���ܷ����ǲ������ýṹ

  //��������

  //������������ṹ

  //ATM�����������

  //IVMS������������

  //IVMS��ATM�����������

  // ivms ����ͼƬ�ϴ��ṹ

  // IVMS ���������

  //************************************end******************************************/
  //NAS��֤����




  //����Ӳ�̽ṹ����

  MAX_NET_DISK = 16;


  //�¼�����
  //������

  INQUEST_START_INFO = 0x1001;      /*Ѷ�ʿ�ʼ��Ϣ*/
  INQUEST_STOP_INFO = 0x1002;       /*Ѷ��ֹͣ��Ϣ*/
  INQUEST_TAG_INFO = 0x1003;       /*�ص�����Ϣ*/
  INQUEST_SEGMENT_INFO = 0x1004;      /*��ѶƬ��״̬��Ϣ*/


  //��Ϊ���������Ͷ�Ӧ�Ĵ����ͣ� 0xffff��ʾȫ��

  // ������100����Ӧ��С����

  //��ŵCVR
  MAX_ID_COUNT = 256;
  MAX_STREAM_ID_COUNT = 1024;
  STREAM_ID_LEN = 32;
  PLAN_ID_LEN = 32;

  // ����Ϣ - 72�ֽڳ�

  //�¼��������� 200-04-07 9000_1.1
  SEARCH_EVENT_INFO_LEN = 300;

  //��������


  //�������� ��ֵ��ʾ


  //�ƶ����


  //�ƶ����--��ֵ


  //��Ϊ����


  //��Ϊ����--��ֵ��ʽ����

  //��Ѷ�¼���������

  //��������������

  //�������������� ��ͨ���Ű�ֵ��ʾ




  //����������

  //�ƶ������

  //��Ϊ�������


  //��Ѷ�¼���ѯ���


  //��id¼���ѯ���


  //struMotionRet = new EVENT_MOTION_RET();
  //struMotionRet.init();
  //���ҷ��ؽ��


  //SDK_V35  2009-10-26

  // �궨��������

  MAX_RECT_NUM = 6;

  // PDC �궨����

  // �궨�ߵ��������������ʾ��ǰ�궨����ʵ�ʱ�ʾ���Ǹ߶��߻��ǳ����ߡ�
  //*�����ñ궨��Ϣ��ʱ�������Ӧλ������ʹ�ܣ���������ز�������û������ʹ�ܣ���궨����Ի�ȡ��ص����������*/

  {*��fValue��ʾĿ��߶ȵ�ʱ��struStartPoint��struEndPoint�ֱ��ʾĿ��ͷ����ͽŲ��㡣
  * ��fValue��ʾ�߶γ��ȵ�ʱ��struStartPoint��struEndPoint�ֱ��ʾ�߶���ʼ����յ㣬
  * mode��ʾ��ǰ�����߱�ʾ�߶��߻��ǳ����ߡ�*}

  MAX_LINE_SEG_NUM = 8;

  //*�궨������Ŀǰ��Ҫ4-8�������ߣ��Ի�ȡ�������ز���*/

  {*�ýṹ���ʾIAS���ܿ�궨���������а���һ��Ŀ����һ����Ӧ�ĸ߶ȱ궨�ߣ�
  * Ŀ���Ϊվ����������Ӿ��ο򣻸߶���������ʶ����ͷ���㵽�ŵ�ı궨�ߣ��ù�һ�������ʾ��*}

  MAX_SAMPLE_NUM = 5;


  CALIB_PT_NUM = 4;

  // �궨����������
  // ��������ر궨�������Է��ڸýṹ����

  // �궨���ýṹ

  //����ͳ�Ʒ���ṹ��



  //���ð���Ϣ�ṹ��




  //byControlType &1 �Ƿ�����ץ�Ĺ���
  //byControlType &2 �Ƿ���������ǰ���豸

  {*����������ͳ�Ʋ���  ������Ϊ�ڲ��ؼ��ֲ���
  * HUMAN_GENERATE_RATE
  * Ŀ�������ٶȲ���������PDC������Ŀ����ٶȡ��ٶ�Խ�죬Ŀ��Խ�������ɡ�
  * ��������Ƶ���������ϲ�ԱȶȽϵ�ʱ���������õĹ��������Сʱ��Ӧ�ӿ�Ŀ�������ٶȣ� ����Ŀ���©�죻
  * ��������Ƶ�жԱȶȽϸ�ʱ�����߹�������ϴ�ʱ��Ӧ�ý���Ŀ�������ٶȣ��Լ�����졣
  * Ŀ�������ٶȲ�������5����1���ٶ�������5����죬Ĭ�ϲ���Ϊ3��
  *
  * DETECT_SENSITIVE
  * Ŀ���������ȿ��Ʋ���������PDC����һ���������򱻼��ΪĿ��������ȡ�
  * ������Խ�ߣ���������Խ���ױ����ΪĿ�꣬������Խ����Խ�Ѽ��ΪĿ�ꡣ
  * ��������Ƶ���������ϲ�ԱȶȽϵ�ʱ��Ӧ��߼�������ȣ� ����Ŀ���©�죻
  * ��������Ƶ�жԱȶȽϸ�ʱ��Ӧ�ý��ͼ�������ȣ��Լ�����졣
  * ��Ӧ��������5��������1��������ͣ�5����ߣ�Ĭ�ϼ���Ϊ3��
  *
  * TRAJECTORY_LEN
  * �켣���ɳ��ȿ��Ʋ�������ʾ���ɹ켣ʱҪ��Ŀ������λ�����ء�
  * ��Ӧ��������5��������1�����ɳ�������켣����������5�����ɳ�����̣��켣������죬Ĭ�ϼ���Ϊ3��
  *
  * TRAJECT_CNT_LEN
  * �켣�������ȿ��Ʋ�������ʾ�켣����ʱҪ��Ŀ������λ�����ء�
  * ��Ӧ��������5��������1������Ҫ�󳤶�����켣����������5������Ҫ�󳤶���̣��켣������죬Ĭ�ϼ���Ϊ3��
  *
  * PREPROCESS
  * ͼ��Ԥ������Ʋ�����0 - ������1 - ����Ĭ��Ϊ0��
  *
  * CAMERA_ANGLE
  * ������Ƕ���������� 0 - ��б�� 1 - ��ֱ��Ĭ��Ϊ0��
  *}




  //��֡ͳ�ƽ��ʱʹ��


  //��֡ͳ�ƽ��ʱʹ��


  //��������Ϣ��ѯ

  // �Ƿ����ó����������ó�����Ϊ�����ʱ����ֶ���Ч������������������ó���λ����Ϣʱ��Ϊʹ��λ





  MAX_POSITION_NUM = 10;

  //Ѳ��·��������Ϣ

  //����Ѳ������������Ϣ

  //������ع���˵����ýṹ��

  //�����о����

  //********************************���ܽ�ͨ�¼� begin****************************************/
  MAX_REGION_NUM	= 8;  // �����б������Ŀ
  MAX_TPS_RULE = 8;   // ������������Ŀ
  MAX_AID_RULE = 8;   // ����¼�������Ŀ
  MAX_LANE_NUM = 8;   // ��󳵵���Ŀ

  //��ͨ�¼�����



  // ��ͨͳ�Ʋ���


  //����ṹ��

  //��������

  //��������

  //��ͨ�¼�����

  //������ͨ�¼�����ṹ��

  //��ͨ�¼�����

  //������ͨ�¼�����ṹ��(��չ)

  //��ͨ�¼�����(��չ)

  //��ͨͳ�Ʋ����ṹ��

  //��ͨ����ͳ�ƹ������ýṹ��

  //��ͨͳ�Ʋ����ṹ��(��չ)

  //��ͨ����ͳ�ƹ������ýṹ��(��չ)

  //��ͨ�¼���Ϣ

  //��ͨ�¼�����

  //�������нṹ��








  //������������





  //Ŀǰֻ�����������¼�����Ա�ۼ��¼�ʵʱ�����ϴ�



  //��������ʱ���

  //������Чʱ�������

  //��������������Ϣ

  //�������ýṹ��

  //�ೡ����������

  //ȡ֤��ʽ

  //����������Ϣ

  //��ͨ�¼�����(��չ)

  //��ͨͳ����Ϣ����(��չ)

  //*******************************���ܽ�ͨ�¼� end*****************************************/

  //******************************����ʶ�� begin******************************************/


  //����ʶ�����ӽṹ

  //******************************����ʶ�� end******************************************/

  //******************************ץ�Ļ�*******************************************/
  //IO��������

  //IO�������

  //���������

  //���̵ƹ��ܣ�2��IO����һ�飩

  //���ٹ���(2��IO����һ�飩

  //��Ƶ��������

  //��������

  //��ƽ������

  //�ع����

  //��̬����

  //��ҹת����������
  //��ʱģʽ����
  //ģʽ2
  //��ʱģʽ����
  //�������봥��ģʽ����

  //GammaУ��

  //���ⲹ������

  //���ֽ��빦��

  //CMOSģʽ��ǰ�˾�ͷ����

  //ǰ�˲�������
  //20-HDMI_720P50�����
  //21-HDMI_720P60�����
  //22-HDMI_1080I60�����
  //23-HDMI_1080I50�����
  //24-HDMI_1080P24�����
  //25-HDMI_1080P25�����
  //26-HDMI_1080P30�����
  //27-HDMI_1080P50�����
  //28-HDMI_1080P60�����
  //40-SDI_720P50,
  //41-SDI_720P60,
  //42-SDI_1080I50,
  //43-SDI_1080I60,
  //44-SDI_1080P24,
  //45-SDI_1080P25,
  //46-SDI_1080P30,
  //47-SDI_1080P50,
  //48-SDI_1080P60

  //͸��

  //���ӷ���

  //����ģʽ

  //SMART IR(������)���ò���

  //��byIrisMode ΪP-Iris1ʱ��Ч�����ú����Ȧ��С�ȼ�������ģʽ

  //ǰ�˲�������
  //20-HDMI_720P50�����
  //21-HDMI_720P60�����
  //22-HDMI_1080I60�����
  //23-HDMI_1080I50�����
  //24-HDMI_1080P24�����
  //25-HDMI_1080P25�����
  //26-HDMI_1080P30�����
  //27-HDMI_1080P50�����
  //28-HDMI_1080P60�����

  {*0-�رա�1-640*480@25fps��2-640*480@30ps��3-704*576@25fps��4-704*480@30fps��5-1280*720@25fps��6-1280*720@30fps��
  * 7-1280*720@50fps��8-1280*720@60fps��9-1280*960@15fps��10-1280*960@25fps��11-1280*960@30fps��
  * 12-1280*1024@25fps��13--1280*1024@30fps��14-1600*900@15fps��15-1600*1200@15fps��16-1920*1080@15fps��
  * 17-1920*1080@25fps��18-1920*1080@30fps��19-1920*1080@50fps��20-1920*1080@60fps��21-2048*1536@15fps��22-2048*1536@20fps��
  * 23-2048*1536@24fps��24-2048*1536@25fps��25-2048*1536@30fps��26-2560*2048@25fps��27-2560*2048@30fps��
  * 28-2560*1920@7.5fps��29-3072*2048@25fps��30-3072*2048@30fps��31-2048*1536@12.5��32-2560*1920@6.25��
  * 33-1600*1200@25��34-1600*1200@30��35-1600*1200@12.5��36-1600*900@12.5��37-1600@900@15��38-800*600@25��39-800*600@30*}

  //������ɫ

  //��������






  //ͼ�������Ϣ����




  // bySupport&0x1����ʾ�Ƿ�֧����չ���ַ���������
  // bySupport&0x2����ʾ�Ƿ�֧����չ��Уʱ���ýṹ
  // bySupport&0x4, ��ʾ�Ƿ�֧�ֶ�����(��������)
  // bySupport&0x8, ��ʾ�Ƿ�֧��������bonding����(�����ݴ�)
  // bySupport&0x10, ��ʾ�Ƿ�֧�������Խ�
  //2013-07-09 ����������
  // wSupportMultiRadar&0x1����ʾ ����RS485�״� ֧�ֳ��������״ﴦ��
  // wSupportMultiRadar&0x2����ʾ ����������Ȧ ֧�ֳ��������״ﴦ��
  // wSupportMultiRadar&0x4����ʾ ���п��� ֧�ֳ��������״ﴦ��
  // wSupportMultiRadar&0x8����ʾ ��Ƶ��� ֧�ֳ��������״ﴦ��
  // ��ʾ֧�ֵ�ICRԤ�õ㣨�˹�Ƭƫ�Ƶ㣩��
  // byExpandRs485SupportSensor &0x1����ʾ�羯������֧�ֳ�����
  // byExpandRs485SupportSensor &0x2����ʾ��ʽ�羯������֧�ֳ�����
  // byExpandRs485SupportSignalLampDet &0x1����ʾ�羯������֧������źŵƼ����
  // byExpandRs485SupportSignalLampDet &0x2����ʾ��ʽ�羯������֧������źŵƼ����







  //2013-07-09 �쳣����
  //*0x00: ����Ӧ*/
  //*0x01: �������Ͼ���*/
  //*0x02: ��������*/
  //*0x04: �ϴ�����*/
  //*0x08: ��������������̵��������*/
  //*0x10: ����JPRGץͼ���ϴ�Email*/
  //*0x20: �������ⱨ��������*/
  //*0x40: �������ӵ�ͼ(Ŀǰֻ��PCNVR֧��)*/
  //*0x200: ץͼ���ϴ�FTP*/

  //�����ÿ��Ԫ�ض���ʾһ���쳣������0- Ӳ�̳���,1-���߶�,2-IP ��ַ��ͻ, 3-�������쳣, 4-�źŵƼ�����쳣




  //����ģʽ



  //*ftp�ϴ�����*/

  //*����������ͼƬ�����Ԫ�� */
  PICNAME_ITEM_DEV_NAME = 1;		/*�豸��*/
  PICNAME_ITEM_DEV_NO = 2;		/*�豸��*/
  PICNAME_ITEM_DEV_IP = 3;		/*�豸IP*/
  PICNAME_ITEM_CHAN_NAME = 4;	/*ͨ����*/
  PICNAME_ITEM_CHAN_NO = 5;		/*ͨ����*/
  PICNAME_ITEM_TIME = 6;		/*ʱ��*/
  PICNAME_ITEM_CARDNO = 7;		/*����*/
  PICNAME_ITEM_PLATE_NO = 8;   /*���ƺ���*/
  PICNAME_ITEM_PLATE_COLOR = 9;   /*������ɫ*/
  PICNAME_ITEM_CAR_CHAN = 10;  /*������*/
  PICNAME_ITEM_CAR_SPEED = 11;  /*�����ٶ�*/
  PICNAME_ITEM_CARCHAN = 12;  /*����*/
  PICNAME_ITEM_PIC_NUMBER = 13;  //ͼƬ���
  PICNAME_ITEM_CAR_NUMBER = 14;  //�������

  PICNAME_ITEM_SPEED_LIMIT_VALUES = 15; //����ֵ
  PICNAME_ITEM_ILLEGAL_CODE = 16; //����Υ������
  PICNAME_ITEM_CROSS_NUMBER = 17; //·�ڱ��
  PICNAME_ITEM_DIRECTION_NUMBER = 18; //������

  PICNAME_MAXITEM = 15;
  //ͼƬ����


  //��������2013-09-27
  PICNAME_ITEM_PARK_DEV_IP = 1;	/*�豸IP*/
  PICNAME_ITEM_PARK_PLATE_NO = 2;/*���ƺ���*/
  PICNAME_ITEM_PARK_TIME = 3;	/*ʱ��*/
  PICNAME_ITEM_PARK_INDEX = 4;   /*��λ���*/
  PICNAME_ITEM_PARK_STATUS = 5;  /*��λ״̬*/

  //ͼƬ������չ 2013-09-27

  //* ����ץͼ����*/

  //DVRץͼ�������ã����ߣ�

  //ץ�Ĵ�������ṹ(����)


  //ʹ������Ʋ���ʱ, ������Ǽ�������Ƶ�������ǿЧӦ, ����Ҫ��Ϊ1;����Ϊ0


  //***************************** end *********************************************/
  IPC_PROTOCOL_NUM = 50;  //ipc Э��������

  //Э������

  //Э���б�

  MAX_ALERTLINE_NUM = 8; //��󾯽�������

  //Խ������ѯ����

  MAX_INTRUSIONREGION_NUM = 8; //�����������



  //������������
  //*0-�ƶ�������� ��1-Խ����⣬ 2-��������*/


  //IPSAN �ļ�Ŀ¼����


  //DVR�豸����
  //���²��ɸ���
  //bySupport & 0x1, ��ʾ�Ƿ�֧����������
  //bySupport & 0x2, ��ʾ�Ƿ�֧�ֱ���
  //bySupport & 0x4, ��ʾ�Ƿ�֧��ѹ������������ȡ
  //bySupport & 0x8, ��ʾ�Ƿ�֧�ֶ�����
  //bySupport & 0x10, ��ʾ֧��Զ��SADP
  //bySupport & 0x20, ��ʾ֧��Raid������
  //bySupport & 0x40, ��ʾ֧��IPSAN����
  //bySupport & 0x80, ��ʾ֧��rtp over rtsp
  //bySupport1 & 0x1, ��ʾ�Ƿ�֧��snmp v30
  //bySupport1 & 0x2, ֧�����ֻطź�����
  //bySupport1 & 0x4, �Ƿ�֧�ֲ������ȼ�
  //bySupport1 & 0x8, �����豸�Ƿ�֧�ֲ���ʱ�����չ
  //bySupport1 & 0x10, ��ʾ�Ƿ�֧�ֶ������������33����
  //bySupport1 & 0x20, ��ʾ�Ƿ�֧��rtsp over http
  //bySupport2 & 0x1, ��ʾ�Ƿ�֧����չ��OSD�ַ�����(�ն˺�ץ�Ļ���չ����)

  MAX_ZEROCHAN_NUM = 16;
  //��ͨ��ѹ�����ò���
  //V2.0����14-15, 15-18, 16-22;

  //��ͨ�����Ų���

  DESC_LEN_64 = 64;


  //snmpv30

  PROCESSING = 0;    //���ڴ���
  PROCESS_SUCCESS = 100;   //�������
  PROCESS_EXCEPTION = 400;   //�����쳣
  PROCESS_FAILED = 500;   //����ʧ��
  PROCESS_QUICK_SETUP_PD_COUNT = 501; //һ����������3��Ӳ��

  SOFTWARE_VERSION_LEN = 48;


  MAX_SADP_NUM = 256;  //�������豸�����Ŀ

  //***************************** end *********************************************/

  //*******************************���ݽṹ begin********************************/
  //��ȡ�����豸��Ϣ�ӿڶ���
  DESC_LEN_32 = 32;   //�����ֳ���
  MAX_NODE_NUM = 256;  //�ڵ����



  //���ݽ����б�
  BACKUP_SUCCESS            =    100;  //�������
  BACKUP_CHANGE_DEVICE      =    101;  //�����豸�����������豸��������

  BACKUP_SEARCH_DEVICE      =    300;  //�������������豸
  BACKUP_SEARCH_FILE        =    301;  //��������¼���ļ�
  BACKUP_SEARCH_LOG_FILE    =    302;  //����������־�ļ�

  BACKUP_EXCEPTION		   =    400;  //�����쳣
  BACKUP_FAIL			   =	500;  //����ʧ��

  BACKUP_TIME_SEG_NO_FILE   =    501;  //ʱ�������¼���ļ�
  BACKUP_NO_RESOURCE        =    502;  //���벻����Դ
  BACKUP_DEVICE_LOW_SPACE   =    503;  //�����豸��������
  BACKUP_DISK_FINALIZED     =    504;  //��¼���̷���
  BACKUP_DISK_EXCEPTION     =    505;  //��¼�����쳣
  BACKUP_DEVICE_NOT_EXIST   =    506;  //�����豸������
  BACKUP_OTHER_BACKUP_WORK  =    507;  //���������ݲ����ڽ���
  BACKUP_USER_NO_RIGHT      =    508;  //�û�û�в���Ȩ��
  BACKUP_OPERATE_FAIL       =    509;  //����ʧ��
  BACKUP_NO_LOG_FILE        =    510;  //Ӳ��������־

  //���ݹ��̽ӿڶ���

  //********************************* end *******************************************/

  //�����б�

  MAX_ABILITYTYPE_NUM = 12;   //���������

  // ѹ�����������б�

  //ģʽA



  //�������С 12�ֽ�



  MAX_HOLIDAY_NUM = 32;


  //���ձ�������ʽ


  MAX_LINK_V30 = 128;



  MAX_BOND_NUM = 2;

  //��BONDING�������ýṹ��

  //BONDING�������ýṹ��


  //�������


  //6-10m 7-30m 8-1h 9-12h 10-24h


  MAX_PIC_EVENT_NUM = 32;
  MAX_ALARMIN_CAPTURE = 16;








  //ͨ��ץͼ�ƻ�



  //¼���ǩ
  LABEL_NAME_LEN = 40;

  LABEL_IDENTIFY_LEN = 64;


  MAX_DEL_LABEL_IDENTIFY = 20;// ɾ��������ǩ��ʶ����



  //��ǩ�����ṹ��

  //��ǩ��Ϣ�ṹ��

  CARDNUM_LEN_V30 = 40;

  PICTURE_NAME_LEN = 64;


  MAX_RECORD_PICTURE_NUM = 50;   //��󱸷�ͼƬ����



  STEP_READY      = 0;    //׼������
  STEP_RECV_DATA  = 1;    //��������������
  STEP_UPGRADE    = 2;    //����ϵͳ
  STEP_BACKUP     = 3;    //����ϵͳ
  STEP_SEARCH     = 255;  //���������ļ�








  //*�����Ӵ��ڶ�Ӧ����ͨ������Ӧ�Ľ�����ϵͳ�Ĳ�λ��(������Ƶ�ۺ�ƽ̨�н�����ϵͳ��Ч)*/
  //��ʾ����������Ƶ�ֱ��ʣ�1-D1,2-720P,3-1080P���豸����Ҫ���ݴ�//�ֱ��ʽ��н���ͨ���ķ��䣬��1�������ó�1080P�����豸���4������ͨ
  //����������˽���ͨ��


  //*���ֹ����壬0-��Ƶ�ۺ�ƽ̨�ڲ���������ʾͨ�����ã�1-������������ʾͨ������*/





  NET_DVR_V6PSUBSYSTEMARAM_GET = 1501;//��ȡV6��ϵͳ����
  NET_DVR_V6PSUBSYSTEMARAM_SET = 1502;//����V6��ϵͳ����


  MAX_REDAREA_NUM = 6;   //�����̵��������



  INQUEST_MESSAGE_LEN  = 44;    //��Ѷ�ص�����Ϣ����
  INQUEST_MAX_ROOM_NUM = 2;    //�����Ѷ�Ҹ���
  MAX_RESUME_SEGMENT   = 2;     //֧��ͬʱ�ָ���Ƭ����Ŀ




  //0x1:���� 0x2:�ز� 0x4:����

  //6-160��7-192��8-224��9-256��10-320��11-384��12-448��
  //13-512��14-640��15-768��16-896ǰ16��ֵ����)17-1024��18-1280��19-1536��
  //20-1792��21-2048��22-3072��23-4096��24-8192
  //8-16Сʱ, 9-20Сʱ,10-22Сʱ,11-24Сʱ








  //ͨ����ȡDVR������״̬����λbps

  //ͨ��DVR����ǰ��IPC��IP��ַ

  //��ʱ������


  //67DVS
  //֤����������


  //����״̬





  //֤�����


  UPLOAD_CERTIFICATE = 1; //�ϴ�֤��


  //channel record status
  //***ͨ��¼��״̬*****//


  //****NVR end***//


  //*������Ϣ*/



  //2011-04-18
  //*�������Ϣ,���9999������1��ʼ */

  //*��������Ϣ�����2048��*/




  //*����������Ϣ�����20��*/


  //*����������Ϣ*/

  //���256���û���1��256

  //���255����Դ��

  //���255���û���



  MATRIX_PROTOCOL_NUM   = 20;    //֧�ֵ�������Э����
  KEYBOARD_PROTOCOL_NUM = 20;    //֧�ֵ�������Э����



  //����ץ�Ĺ���(����)

  //����ץ�Ĺ������

  //����ץ�Ľ�������ϴ�

  //�齹�����









  //��������ṹ��

  //��Ա��Ϣ�ṹ��


  //��������Ϣ





  MAX_FACE_PIC_LEN = 6144;   //�������ͼƬ���ݳ���




  //�������СΪ44�ֽ�



  //����ץ����Ϣ
  //������������Ϣ

  //�������ȶԽ�������ϴ�







  //������������

  //�洢·������

  //********************************��������ʶ�� end****************************/
  //�ֱ���
  NOT_AVALIABLE = 0;
  SVGA_60HZ = 52505660;
  SVGA_75HZ = 52505675;
  XGA_60HZ = 67207228;
  XGA_75HZ = 67207243;
  SXGA_60HZ = 84017212;
  SXGA2_60HZ = 84009020;
  _720P_60HZ = 83978300;
  _720P_50HZ = 83978290;
  _1080I_60HZ = 394402876;
  _1080I_50HZ = 394402866;
  _1080P_60HZ = 125967420;
  _1080P_50HZ = 125967410;
  _1080P_30HZ = 125967390;
  _1080P_25HZ = 125967385;
  _1080P_24HZ = 125967384;
  UXGA_60HZ = 105011260;
  UXGA_30HZ = 105011230;
  WSXGA_60HZ = 110234940;
  WUXGA_60HZ = 125982780;
  WUXGA_30HZ = 125982750;
  WXGA_60HZ = 89227324;
  SXGA_PLUS_60HZ = 91884860;

  //��ʾͨ������ָ�ģʽ

  //��ʾͨ����Ϣ

  //����ƴ����Ϣ



  MAX_WINDOWS = 16;//��󴰿���
  MAX_WINDOWS_V41 = 36;

  STARTDISPCHAN_VGA = 1;
  STARTDISPCHAN_BNC = 9;
  STARTDISPCHAN_HDMI	= 25;
  STARTDISPCHAN_DVI = 29;




  //*��ʾͨ�����ýṹ��*/

  //*�������豸״̬*/

  //*�������豸״̬*/
  //*��ʾͨ��״̬*/

  //*******************************�ļ��ط�-Զ�̻ط�����*******************************/

  MAX_BIGSCREENNUM_SCENE = 100;

  //��ʾͨ�����ýṹ

  //��ʾ����������Ƶ�ֱ��ʣ�1-D1,2-720P,3-1080P���豸����Ҫ���ݴ�//�ֱ��ʽ��н���ͨ���ķ��䣬��1�������ó�1080P�����豸���4������ͨ����������˽���ͨ��


  //*��ý���������������*/



  //��Ѳ����ṹ

  //��������ͨ�����ýṹ��

  //[FieldOffsetAttribute(0)]
  //[MarshalAsAttribute(UnmanagedType.ByValArray, SizeConst = 5480, ArraySubType = UnmanagedType.I1)]
  //public byte[] byRes;



  NET_DVR_GET_ALLWINCFG = 1503; //���ڲ�����ȡ


  //*******************************��������*******************************/
  MAX_WIN_COUNT = 224; //֧�ֵ���󿪴���



  MAX_LAYOUT_COUNT = 16;		//��󲼾���



  MAX_CAM_COUNT = 224;




  //*******************************�����������*******************************/
  //*���ͨ������*/


  //*******************************������*******************************/
  SCREEN_PROTOCOL_NUM = 20;   //֧�ֵ�������������Э����

  //����������������

  //����������������

  //*******************************�����ź�״̬*******************************/










  //*******************************��ͼ�ϴ�*******************************/

  //*******************************OSD*******************************/
  MAX_OSDCHAR_NUM = 256;


  //*******************************��ȡ������Ϣ*******************************/

  //*******************************��Ļ����*******************************/
  //��Ļ����Դ����


  //��ʾ��Ԫ��ɫ����

  //��ʾ��Ԫλ�ÿ���



  //*******************************��Ļ����V41*******************************/

  //*******************************Ԥ������*******************************/
  MAX_PLAN_ACTION_NUM = 32; 	//Ԥ����������
  DAYS_A_WEEK = 7;	//һ��7��
  MAX_PLAN_COUNT = 16;	//Ԥ������


  //*Ԥ������Ϣ*/


  //*Ԥ������*/

  //*******************************��ȡ�豸״̬*******************************/
  //*Ԥ���б�*/

  //*******************************Ԥ������*******************************/
  //�ýṹ�����Ϊͨ�ÿ��ƽṹ��

  //*******************************��ȡ�豸״̬*******************************/

  //91ϵ��HD-SDI����DVR �����Ϣ




  //��ȫ����״̬
  PULL_DISK_SUCCESS = 1;     // ��ȫ���̳ɹ�
  PULL_DISK_FAIL = 2;        // ��ȫ����ʧ��
  PULL_DISK_PROCESSING = 3;  // ����ֹͣ����
  PULL_DISK_NO_ARRAY = 4;	// ���в�����
  PULL_DISK_NOT_SUPPORT = 5; // ��֧�ְ�ȫ����

  //ɨ������״̬
  SCAN_RAID_SUC = 1; 	// ɨ�����гɹ�
  SCAN_RAID_FAIL = 2; 	// ɨ������ʧ��
  SCAN_RAID_PROCESSING = 3;	// ����ɨ������
  SCAN_RAID_NOT_SUPPORT = 4; // ��֧������ɨ��

  //����ǰ���������״̬
  SET_CAMERA_TYPE_SUCCESS = 1;  // �ɹ�
  SET_CAMERA_TYPE_FAIL = 2;  // ʧ��
  SET_CAMERA_TYPE_PROCESSING	= 3;   // ���ڴ���

  //9000 2.2



  //�˿�ӳ�����ýṹ��

  //�˿�ӳ�����ýṹ��

  //Upnp�˿�ӳ��״̬�ṹ��

  //Upnp�˿�ӳ��״̬�ṹ��


  //¼��طŽṹ��






  MAX_PRO_PATH = 256; //���Э��·������


  //Ԥ��V40�ӿ�

  ///ץ�Ļ�
  ///
  MAX_OVERLAP_ITEM_NUM = 50;       //����ַ���������
  NET_ITS_GET_OVERLAP_CFG = 5072;//��ȡ�ַ����Ӳ������ã������ITS�նˣ�
  NET_ITS_SET_OVERLAP_CFG = 5073;//�����ַ����Ӳ������ã������ITS�նˣ�

  //�ַ������������������ṹ��

  //�����ַ�������Ϣ�ṹ��

  //�ַ����������ýṹ��

  //�ַ�����������Ϣ�ṹ��

  //�ַ������������������ṹ��

  //�������������ṹ��



















  //********************************�ӿڲ����ṹ(end)*********************************/


  //********************************SDK�ӿں�������*********************************/

  {*********************************************************
  Function:	NET_DVR_Init
  Desc:		��ʼ��SDK����������SDK������ǰ�ᡣ
  Input:
  Output:
  Return:	TRUE��ʾ�ɹ���FALSE��ʾʧ�ܡ�
  **********************************************************}

  {*********************************************************
  Function:	NET_DVR_Cleanup
  Desc:		�ͷ�SDK��Դ���ڽ���֮ǰ������
  Input:
  Output:
  Return:	TRUE��ʾ�ɹ���FALSE��ʾʧ��
  **********************************************************}




  {*********************************************************
  Function:	EXCEPYIONCALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}



  {*********************************************************
  Function:	MESSCALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}


  {*********************************************************
  Function:	MESSCALLBACKEX
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}


  {*********************************************************
  Function:	MESSCALLBACKNEW
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}


  {*********************************************************
  Function:	MESSAGECALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}



  {*********************************************************
  Function:	MSGCallBack
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}



















  //Ԥ����ؽӿ�

  {*********************************************************
  Function:	REALDATACALLBACK
  Desc:		Ԥ���ص�
  Input:	lRealHandle ��ǰ��Ԥ�����
  dwDataType ��������
  pBuffer ������ݵĻ�����ָ��
  dwBufSize ��������С
  pUser �û�����
  Output:
  Return:	void
  **********************************************************}

  {*********************************************************
  Function:	NET_DVR_RealPlay_V30
  Desc:		ʵʱԤ����
  Input:	lUserID [in] NET_DVR_Login()��NET_DVR_Login_V30()�ķ���ֵ
  lpClientInfo [in] Ԥ������
  cbRealDataCallBack [in] �������ݻص�����
  pUser [in] �û�����
  bBlocked [in] �������������Ƿ�������0����1����
  Output:
  Return:	1��ʾʧ�ܣ�����ֵ��ΪNET_DVR_StopRealPlay�Ⱥ����ľ������
  **********************************************************}

  {*********************************************************
  Function:	NET_DVR_RealPlay_V40
  Desc:		ʵʱԤ����չ�ӿڡ�
  Input:	lUserID [in] NET_DVR_Login()��NET_DVR_Login_V30()�ķ���ֵ
  lpPreviewInfo [in] Ԥ������
  fRealDataCallBack_V30 [in] �������ݻص�����
  pUser [in] �û�����
  Output:
  Return:	1��ʾʧ�ܣ�����ֵ��ΪNET_DVR_StopRealPlay�Ⱥ����ľ������
  **********************************************************}

  // [DllImport(@"..\bin\HCNetSDK.dll")]
  // public static extern int NET_DVR_GetRealPlayerIndex(int lRealHandle);
  {*********************************************************
  Function:	NET_DVR_StopRealPlay
  Desc:		ֹͣԤ����
  Input:	lRealHandle [in] Ԥ�������NET_DVR_RealPlay����NET_DVR_RealPlay_V30�ķ���ֵ
  Output:
  Return:
  **********************************************************}

  {*********************************************************
  Function:	DRAWFUN
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}












  {*********************************************************
  Function:	REALDATACALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}


  {*********************************************************
  Function:	STDDATACALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}




  //��̬����I֡


  //��̨������ؽӿ�
























  //�ļ�������ط�








  //2007-04-16���Ӳ�ѯ��������ŵ��ļ�����










  {*********************************************************
  Function:	PLAYDATACALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}













  //����





  //Զ�̸�ʽ��Ӳ��



  //����





  //�����Խ�
  {*********************************************************
  Function:	VOICEDATACALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}


  {*********************************************************
  Function:	VOICEDATACALLBACKV30
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}





  //����ת��



  //�����㲥

  {*********************************************************
  Function:	VOICEAUDIOSTART
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}









  //͸��ͨ������
  {*********************************************************
  Function:	SERIALDATACALLBACK
  Desc:		(�ص�����)
  Input:
  Output:
  Return:
  **********************************************************}


  //485��Ϊ͸��ͨ��ʱ����Ҫָ��ͨ���ţ���Ϊ��ͬͨ����485�����ÿ��Բ�ͬ(���粨����)




  //���� nBitrate = 16000



  //����



  //Զ�̿��Ʊ�����ʾ

  //Զ�̿����豸���ֶ�¼��


  //���뿨
















  //��ȡ���뿨���кŴ˽ӿ���Ч������GetBoardDetail�ӿڻ��(2005-12-08֧��)

  //��־






  //��ֹ2004��8��5��,��113���ӿ�
  //ATM DVR


  //2005-09-15

  //JPEGץͼ���ڴ�

  //2006-02-16


  //2006-08-28 704-640 ��������




  //2006-08-28 ATM���˿�����


  //2006-11-10 ֧���Կ��������






  //�����豸DS-6001D/DS-6001F



  //2005-08-01










  //��·������
  //2007-11-30 V211֧�����½ӿ� //11











  //2007-12-22 ����֧�ֽӿ� //18





  //2009-4-13 ����
















  NET_DVR_SHOWLOGO = 1;/*��ʾLOGO*/
  NET_DVR_HIDELOGO = 2;/*����LOGO*/



  //*��ʾͨ�������붨��*/
  //�Ϻ����� ����


  DISP_CMD_ENLARGE_WINDOW = 1;	/*��ʾͨ���Ŵ�ĳ������*/
  DISP_CMD_RENEW_WINDOW = 2;	/*��ʾͨ�����ڻ�ԭ*/


  //end

  //�ָ�Ĭ��ֵ

  //�������

  //����

  //�ر�DVR

  //�������� begin












  //��ȡUPNP�˿�ӳ��״̬

  //��Ƶ��������


  //�����ļ�





  //������־�ļ�д��ӿ�





  //ǰ�������




  //��Ƶ�ۺ�ƽ̨

  //SDK_V222
  //�����豸����
  DS6001_HF_B = 60;//��Ϊ������DS6001-HF/B
  DS6001_HF_P = 61;//����ʶ��DS6001-HF/P
  DS6002_HF_B = 62;//˫�����٣�DS6002-HF/B
  DS6101_HF_B = 63;//��Ϊ������DS6101-HF/B
  IDS52XX = 64;//���ܷ�����IVMS
  DS9000_IVS = 65;//9000ϵ������DVR
  DS8004_AHL_A = 66;//����ATM, DS8004AHL-S/A
  DS6101_HF_P = 67;//����ʶ��DS6101-HF/P

  //������ȡ����
  VCA_DEV_ABILITY = 256;//�豸���ܷ�����������
  VCA_CHAN_ABILITY = 272;//��Ϊ��������
  MATRIXDECODER_ABILITY = 512;//��·��������ʾ����������
  //��ȡ/���ô�ӿڲ�����������
  //����ʶ��NET_VCA_PLATE_CFG��
  NET_DVR_SET_PLATECFG = 150;//���ó���ʶ�����
  NET_DVR_GET_PLATECFG = 151;//��ȡ����ʶ�����
  //��Ϊ��Ӧ��NET_VCA_RULECFG��
  NET_DVR_SET_RULECFG = 152;//������Ϊ��������
  NET_DVR_GET_RULECFG = 153;//��ȡ��Ϊ��������

  //˫������궨������NET_DVR_LF_CFG��
  NET_DVR_SET_LF_CFG = 160;//����˫����������ò���
  NET_DVR_GET_LF_CFG = 161;//��ȡ˫����������ò���

  //���ܷ�����ȡ�����ýṹ
  NET_DVR_SET_IVMS_STREAMCFG = 162;//�������ܷ�����ȡ������
  NET_DVR_GET_IVMS_STREAMCFG = 163;//��ȡ���ܷ�����ȡ������

  //���ܿ��Ʋ����ṹ
  NET_DVR_SET_VCA_CTRLCFG = 164;//�������ܿ��Ʋ���
  NET_DVR_GET_VCA_CTRLCFG = 165;//��ȡ���ܿ��Ʋ���

  //��������NET_VCA_MASK_REGION_LIST
  NET_DVR_SET_VCA_MASK_REGION = 166;//���������������
  NET_DVR_GET_VCA_MASK_REGION = 167;//��ȡ�����������

  //ATM�������� NET_VCA_ENTER_REGION
  NET_DVR_SET_VCA_ENTER_REGION = 168;//���ý����������
  NET_DVR_GET_VCA_ENTER_REGION = 169;//��ȡ�����������

  //�궨������NET_VCA_LINE_SEGMENT_LIST
  NET_DVR_SET_VCA_LINE_SEGMENT = 170;//���ñ궨��
  NET_DVR_GET_VCA_LINE_SEGMENT = 171;//��ȡ�궨��

  // ivms��������NET_IVMS_MASK_REGION_LIST
  NET_DVR_SET_IVMS_MASK_REGION = 172;//����IVMS�����������
  NET_DVR_GET_IVMS_MASK_REGION = 173;//��ȡIVMS�����������
  // ivms����������NET_IVMS_ENTER_REGION
  NET_DVR_SET_IVMS_ENTER_REGION = 174;//����IVMS�����������
  NET_DVR_GET_IVMS_ENTER_REGION = 175;//��ȡIVMS�����������

  NET_DVR_SET_IVMS_BEHAVIORCFG = 176;//�������ܷ�������Ϊ�������
  NET_DVR_GET_IVMS_BEHAVIORCFG = 177;//��ȡ���ܷ�������Ϊ�������

  // IVMS �طż���
  NET_DVR_IVMS_SET_SEARCHCFG = 178;//����IVMS�طż�������
  NET_DVR_IVMS_GET_SEARCHCFG = 179;//��ȡIVMS�طż�������

  //�ṹ�����궨��
  VCA_MAX_POLYGON_POINT_NUM = 10;//����������֧��10����Ķ����
  MAX_RULE_NUM = 8;//����������
  MAX_TARGET_NUM = 30;//���Ŀ�����
  MAX_CALIB_PT = 6;//���궨�����
  MIN_CALIB_PT = 4;//��С�궨�����
  MAX_TIMESEGMENT_2 = 2;//���ʱ�����
  MAX_LICENSE_LEN = 16;//���ƺ���󳤶�
  MAX_PLATE_NUM = 3;//���Ƹ���
  MAX_MASK_REGION_NUM = 4;//����ĸ���������
  MAX_SEGMENT_NUM = 6;//������궨�����������Ŀ
  MIN_SEGMENT_NUM = 3;//������궨��С��������Ŀ
  {*********************************************************
  Function:	NET_DVR_GetDeviceAbility
  Desc:
  Input:
  Output:
  Return:	TRUE��ʾ�ɹ���FALSE��ʾʧ�ܡ�
  **********************************************************}

  //�����ؼ���

  //����/��ȡ�����ؼ���


  //��ȡ/������Ϊ����Ŀ����ӽӿ�


  //�궨�������ýṹ

  //LF˫��������ýṹ

  //L/F�ֶ����ƽṹ

  //L/FĿ����ٽṹ


  //˫���������ģʽ���ýӿ�


  //ʶ�𳡾�

  //ʶ������־



  //��Ƶʶ�𴥷�����

  MAX_CHINESE_CHAR_NUM = 64;    // ������������
  //���ƿɶ�̬�޸Ĳ���

  {*wMinPlateWidth:�ò���Ĭ������Ϊ80���أ��ò��������ö��ڳ��ƺ������ӳ���ʶ��˵���ĵ�
  ʶ����Ӱ�죬������ù�����ô��������г���С���ƾͻ�©ʶ����������г��ƿ���ձ�ϴ󣬿��԰Ѹò��������Դ󣬱��ڼ��ٶ���ٳ��ƵĴ����ڱ�������½�������Ϊ80�� �ڸ�������½�������Ϊ120
  wTriggerDuration �� �ⲿ�����źų���֡�������京���ǴӴ����źſ�ʼʶ���֡��������ֵ�ڵ��ٳ�����������Ϊ50��100�����ٳ�����������Ϊ15��25���ƶ�ʶ��ʱ���Ҳ���ⲿ����������Ϊ15��25��������Ը����ֳ������������
  *}
  //����ʶ������ӽṹ

  //����ʶ�����ò���

  //����ʶ�����ӽṹ

  //���Ƽ����

  //�������ܿ�


  //�궨������






  //2009-7-22 end

  //�ʼ�������� 9000_1.1




  //2009-8-18 ץ�Ļ�
  PLATE_INFO_LEN = 1024;
  PLATE_NUM_LEN = 16;
  FILE_NAME_LEN = 256;

  //liscense plate result
  //Ŀǰ��17λ����ȷ��ms:20090724155526948
  //*ע��������� dwPicLen ���ȵ� ͼƬ ��Ϣ*/





  //ģʽ1(����)
  //ģʽ2

  NET_DVR_GET_CCDPARAMCFG = 1067;       //IPC��ȡCCD��������
  NET_DVR_SET_CCDPARAMCFG = 1068;      //IPC����CCD��������

  //ͼ����ǿ��
  //ͼ����ǿȥ����������

  //ͼ����ǿ��ȥ�뼶���ȶ���ʹ������

  NET_DVR_GET_IMAGEREGION = 1062;       //ͼ����ǿ��ͼ����ǿȥ�������ȡ
  NET_DVR_SET_IMAGEREGION = 1063;       //ͼ����ǿ��ͼ����ǿȥ�������ȡ
  NET_DVR_GET_IMAGEPARAM = 1064;       // ͼ����ǿ��ͼ�����(ȥ�롢��ǿ�����ȶ���ʹ��)��ȡ
  NET_DVR_SET_IMAGEPARAM = 1065;       // ͼ����ǿ��ͼ�����(ȥ�롢��ǿ�����ȶ���ʹ��)����

  //ͼ����ǿʱ��β������ã����տ�ʼ


  {*********************************************************
  Function:	NET_DVR_Login_V30
  Desc:
  Input:	sDVRIP [in] �豸IP��ַ
  wServerPort [in] �豸�˿ں�
  sUserName [in] ��¼���û���
  sPassword [in] �û�����
  Output:	lpDeviceInfo [out] �豸��Ϣ
  Return:	-1��ʾʧ�ܣ�����ֵ��ʾ���ص��û�IDֵ
  **********************************************************}

  {*********************************************************
  Function:	NET_DVR_Logout_V30
  Desc:		�û�ע���豸��
  Input:	lUserID [in] �û�ID��
  Output:
  Return:	TRUE��ʾ�ɹ���FALSE��ʾʧ��
  **********************************************************}


























  WM_NETERROR = 0x0400 + 102;          //�����쳣��Ϣ
  WM_STREAMEND = 0x0400 + 103;		  //�ļ����Ž���

  FILE_HEAD = 0;      //�ļ�ͷ
  VIDEO_I_FRAME = 1;  //��ƵI֡
  VIDEO_B_FRAME = 2;  //��ƵB֡
  VIDEO_P_FRAME = 3;  //��ƵP֡
  VIDEO_BP_FRAME = 4; //��ƵBP֡
  VIDEO_BBP_FRAME = 5; //��ƵB֡B֡P֡
  AUDIO_PACKET = 10;   //��Ƶ��










  // �쳣�ص�����
  //֡���ݻص�����

  //ģ���ʼ��

  //ģ������



  // ����ID��ʱ��δ�����ȡ�����


  //����ID��ʱ��δ���������


  // ��ʼ����������������֡

  // ����ʱ�䶨λ


  // ����ʱ�䶨λ

  // ����ʱ�䶨λ





  // 0:  file head
  // 1:  video I frame
  // 2:  video B frame
  // 3:  video P frame
  // 10: audio frame
  // 11: private frame only for PS


  //      [System.Runtime.InteropServices.MarshalAsAttribute(System.Runtime.InteropServices.UnmanagedType.LPStr)]



  {******************************************************************************
  * function��get a empty port number
  * parameters��
  * return�� 0 - 499 : empty port number
  *          -1      : server is full
  * comment��
  ******************************************************************************}


  {******************************************************************************
  * function��open standard stream data for analyzing
  * parameters��lHandle - working port number
  *             pHeader - pointer to file header or info header
  * return��TRUE or FALSE
  * comment��
  ******************************************************************************}


  {******************************************************************************
  * function��close analyzing
  * parameters��lHandle - working port number
  * return��
  * comment��
  ******************************************************************************}


  {******************************************************************************
  * function��input stream data
  * parameters��lHandle		- working port number
  *			  pBuffer		- data pointer
  *			  dwBuffersize	- data size
  * return��TRUE or FALSE
  * comment��
  ******************************************************************************}


  {******************************************************************************
  * function��get analyzed packet
  * parameters��lHandle		- working port number
  *			  pPacketInfo	- returned structure
  * return��-1 : error
  *          0 : succeed
  *		   1 : failed
  *		   2 : file end (only in file mode)
  * comment��
  ******************************************************************************}


  {******************************************************************************
  * function��get remain data from input buffer
  * parameters��lHandle		- working port number
  *			  pBuf	        - pointer to the mem which stored remain data
  *             dwSize        - size of remain data
  * return�� TRUE or FALSE
  * comment��
  ******************************************************************************}






  DATASTREAM_HEAD = 0;		//����ͷ
  DATASTREAM_BITBLOCK = 1;		//�ֽ�����
  DATASTREAM_KEYFRAME = 2;		//�ؼ�֡����
  DATASTREAM_NORMALFRAME = 3;		//�ǹؼ�֡����


  MESSAGEVALUE_DISKFULL = 0x01;
  MESSAGEVALUE_SWITCHDISK = 0x02;
  MESSAGEVALUE_CREATEFILE = 0x03;
  MESSAGEVALUE_DELETEFILE = 0x04;
  MESSAGEVALUE_SWITCHFILE = 0x05;
























  //�豸��������
  REGIONTYPE = 0;//��������
  MATRIXTYPE = 11;//����ڵ�
  DEVICETYPE = 2;//�����豸
  CHANNELTYPE = 3;//����ͨ��
  USERTYPE = 5;//�����û�


  //��Ƶ�ۺ�ƽ̨���




