//
//  ILKDefine.h
//  TaisanTea
//
//  Created by Wei Ting Chen on 2014/3/25.
//  Copyright (c) 2014年 Wei Ting Chen. All rights reserved.
//



#import <Foundation/Foundation.h>


//華泰測試機 S套
//#define kServerURL @"https://Cibtstweb.hwataibank.com.tw/TicAppOK/TicMainAction"

//8/5 Q套
//#define kServerURL @"https://cibwebq.hwataibank.com.tw/TicAppOK/TicMainAction"

//8/12 正式機器
//#define kServerURL @"https://b2bank.hwataibank.com.tw/TicAppOK/TicMainAction"

//修改IP
//修改 VaktenManager.m 上方位址與下方物件

#define kBUILDVERSION [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey]
#define kOSVersion [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"]
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define kSessionId [OpenUDID value]
#define kDeviceId [OpenUDID value]
#define kApplicationTimeoutInMinutes 1 //timeout基礎單位值 勿改
#define kTimeOutSec 90 //connection 逾時最大限度
#define kApplicationDidTimeoutNotification @"AppTimeOut"
#define kApplicationTimeOutMsg @"閒置時間過長, 系統將自動登出"
#define kVerifySSL YES      //=============== 是否啟用本地SSL憑證驗證
#define kFileSSL @"CIB_S"   //=============== SSL憑證名稱 必須為.cer檔案, 名稱不需加上cer

#define kAppReviewAcc @"12380482" //=============== 非常重要 , 若是特定帳號則 VIP = Y 可連至特定IP============
#define kTestAcc @""  //"53127885"
#define kTestUserID @""
#define kAssociateCode @""
#define kConnectionFail @"請確認您的網路連線正常運作"
#define kSvrReturnEmpty @"未知的錯誤,請重新操作"
#define kNoData @"查無資料"
#define kTipTitle @"提示"
#define kNoPermission @"設備未綁定"
#define kTipSuccessMOTP @"綁定驗證成功"
#define kErrDataFormat @"請確認資料格式正確"
#define kErrDataMiss @"缺少必要資料"
#define kNONO @"敬請期待.."
#define kLoading @"讀取中..."
#define kCommitTran @"送出中..."
#define kHostUrl @"www.google.com"
#define kIsPhase1 NO

// ======================== Secure ========================

//KEY (密鑰) + 偏移 (IV 若不用則需設定 vinitVec 為nil) 參考DES3Util.h

#define DES3_KEY @"7ef537f59b12440e"
                //"7ef537f59b12440ea06b9ae647a843cc"
#if DEBUG
#define MGLog(args...) NSLog(@"%@", [NSString stringWithFormat: args])
#else
#define MGLog(args...) // do nothing
#endif

#ifndef ILK_STRONG
#if __has_feature(objc_arc)
#define ILK_STRONG strong
#else
#define ILK_STRONG retain
#endif
#endif

#ifndef ILK_WEAK
#if __has_feature(objc_arc_weak)
#define ILK_WEAK weak
#elif __has_feature(objc_arc)
#define ILK_WEAK unsafe_unretained
#else
#define ILK_WEAK assign
#endif
#endif


#define DES_KEY @"HT"
#define DES_Extra_String @"Bank"
