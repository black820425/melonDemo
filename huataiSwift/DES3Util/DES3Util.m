//
//  DES3Util.m
//  Sunnybank
//
//  Created by KyleCheng on 2016/7/27.
//  Copyright © 2016年 Angus. All rights reserved.
//

#import "kDefine.h"
#import "DES3Util.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
//密鑰 + 偏移
//KEY (密鑰)
//IV 若不用則需設定 vinitVec 為nil

@implementation DES3Util

+(NSString*)DES_IV_YMDString
{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyyMMdd"];
  NSString *IVString = [dateFormat stringFromDate:[NSDate date]];
  
  return IVString;
}

+(NSString*)DES_IV_YMDHMSString
{
  NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
  [dateFormat setDateFormat:@"yyyyMMddhhmmss"];
  NSString *IVString = [dateFormat stringFromDate:[NSDate date]];
  
  return IVString;
}

// 加密方法
+ (NSData*)encrypt:(NSData*)jsonData {
  
  // prepare jsonData convert Byte
  Byte *dataByte = (Byte *)[jsonData bytes];
  size_t plainTextBufferSize = [jsonData length];
  
  // prepare vKeyString convert Byte
  NSString *vKeyString = [NSString stringWithFormat:@"%@%@",DES3_KEY,[self DES_IV_YMDString]];
  NSData* vKeyData = [vKeyString dataUsingEncoding:NSUTF8StringEncoding];
  Byte *vKeyByte = (Byte *)[vKeyData bytes];
  
  // prepare DES_IV_YMDString convert Byte
  NSData *vinitVecData = [[self DES_IV_YMDString] dataUsingEncoding:NSUTF8StringEncoding];
  Byte *vinitVecByte = (Byte *)[vinitVecData bytes];
  
  // prepare 3DES
  CCCryptorStatus ccStatus;
  uint8_t *bufferPtr = NULL;
  size_t bufferPtrSize = 0;
  size_t movedBytes = 0;
  
  bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
  bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
  memset((void *)bufferPtr, 0x0, bufferPtrSize);
  
  const void *vkey = (const void *) vKeyByte;
  const void *vplainText = (const void *) dataByte;
  const void *vinitVec = (const void *) vinitVecByte;
  
  ccStatus = CCCrypt(kCCEncrypt,
                     kCCAlgorithm3DES,
                     kCCOptionPKCS7Padding, //設置模式
                     vkey,
                     kCCKeySize3DES,
                     vinitVec,
                     vplainText,
                     plainTextBufferSize,
                     (void *)bufferPtr,
                     bufferPtrSize,
                     &movedBytes);
  
  if(ccStatus == kCCSuccess) {
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    return myData;

  } else {
    NSLog(@"ccStatus error --> %d",ccStatus);
  }
  
  // base64 轉換
  //NSString *result = [GTMBase64 stringByEncodingData:myData];
  
  return nil;
}
// 解密方法
+ (NSData*)decrypt:(NSData*)encryptData {
  // base64 轉換
  //NSData *encryptData = [GTMBase64 decodeString:encryptText];
  
  // prepare encryptData convert byte
  Byte *dataByte = (Byte *)[encryptData bytes];
  size_t plainTextBufferSize = [encryptData length];
  
  // prepare vKeyString convert byte
  NSString *vKeyString = [NSString stringWithFormat:@"%@%@",DES3_KEY,[self DES_IV_YMDString]];
  NSData* vKeyData = [vKeyString dataUsingEncoding:NSUTF8StringEncoding];
  Byte *vKeyByte = (Byte *)[vKeyData bytes];
  
  // prepare DES_IV_YMDString convert byte
  NSData *vinitVecData = [[self DES_IV_YMDString] dataUsingEncoding:NSUTF8StringEncoding];
  Byte *vinitVecByte = (Byte *)[vinitVecData bytes];
  
  // prepare 3DES
  CCCryptorStatus ccStatus;
  uint8_t *bufferPtr = NULL;
  size_t bufferPtrSize = 0;
  size_t movedBytes = 0;
  
  bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
  bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
  memset((void *)bufferPtr, 0x0, bufferPtrSize);
  
  const void *vplainText = dataByte;
  const void *vkey = (const void *) vKeyByte;
  const void *vinitVec = (const void *) vinitVecByte;
  
  ccStatus = CCCrypt(kCCDecrypt,
                     kCCAlgorithm3DES,
                     kCCOptionPKCS7Padding,
                     vkey,
                     kCCKeySize3DES,
                     vinitVec,
                     vplainText,
                     plainTextBufferSize,
                     (void *)bufferPtr,
                     bufferPtrSize,
                     &movedBytes);
  
  if(ccStatus == kCCSuccess) {
    NSData *resultData = [[NSData alloc] initWithBytes:(const void *)bufferPtr length:movedBytes];
    
    return resultData;
  } else {
    NSLog(@"ccStatus error --> %d",ccStatus);
  }
  
  return nil;
}

@end
