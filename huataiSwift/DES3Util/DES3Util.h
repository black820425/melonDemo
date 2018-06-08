//
//  DES3Util.h
//  Sunnybank
//
//  Created by KyleCheng on 2016/7/27.
//  Copyright © 2016年 Angus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DES3Util : NSObject

+(NSString*)DES_IV_YMDString;

+(NSString*)DES_IV_YMDHMSString;

+ (NSData*)encrypt:(NSData*)jsonData;

+ (NSData*)decrypt:(NSData*)encryptData;

@end
