//
//  VaktenManager.h
//  LydsecVakten
//
//  Created by Jinfu Wang on 2016/4/22.
//  Copyright © 2016年 Jinfu Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Vakten/Vakten.h>
#import <Vakten/VaktenPKI.h>
extern NSString *const VTaskManagerRefreshNotification;

@interface VaktenManager : NSObject

typedef void(^CompleteHandle)(VResultCode resultCode);
typedef void(^CompleteTasksHandle)(VResultCode resultCode, NSArray *tasks);
typedef void(^CompleteOnePKITaskHandle)(VResultCode resultCode, VTaskPKI *task);

+ (instancetype)sharedInstance;

- (void)setDeviceToken:(NSData *)deviceToken;

- (void)associationOperationWithAssociationCode:(NSString *)associationCode complete:(CompleteHandle)handle;

- (void)authenticateOperationWithSessionID:(NSString *)sessionID complete:(CompleteHandle)handle;

- (void)getTasksOperationWithComplete:(CompleteTasksHandle)handle;

- (void)signTaskOperationWithTask:(VTask *)task complete:(CompleteHandle)handle;

- (void)cancelTaskOperationWithTask:(VTask *)task complete:(CompleteHandle)handle;

- (BOOL)isAssociated;

- (BOOL)isJailbroken;

//For PKI

- (void)associationPKIOperationWithAssociationCode:(NSString *)associationCode pin:(VPinManager *)pinManager confirmationPin:(VPinManager *)confirmationPinManager complete:(CompleteHandle)handle;

- (void)getTasksPKIOperationWithComplete:(CompleteTasksHandle)handle;

- (void)getOneTaskPKIOperationWithTaskId:(NSString *)taskId complete:(CompleteOnePKITaskHandle)handle;

- (void)signTaskPKIOperationWithTask:(VTaskPKI *)task pinManager:(VPinManager *)pinManager complete:(CompleteHandle)handle;

- (void)cancelTaskPKIOperationWithTask:(VTaskPKI *)task complete:(CompleteHandle)handle;

- (void)changePinPKIOperationWithCurrentPin:(VPinManager *)currentPin newPin:(VPinManager *)newPin withConfirmationPin:(VPinManager *)confirmationPin complete:(CompleteHandle)handle;

- (VGeoOTP*)generateGeoOTPCode;

- (NSString *)getOneTimePassword;

- (void)nextOneTimePassword;

@end
