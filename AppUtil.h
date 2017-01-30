//
//  AppUtil.h
//  Basaksehir_HD
//
//  Created by mahir tarlan on 12/6/13.
//  Copyright (c) 2013 igones. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MENU_WILL_OPEN_NOTIFICATON_KEY @"MENU_WILL_OPEN_NOTIFICATON_KEY"
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenCenterX [[UIScreen mainScreen] bounds].size.width / 2
#define kScreenCenterY [[UIScreen mainScreen] bounds].size.height / 2
@interface AppUtil : NSObject


+ (CGFloat) calculateHeightForText:(NSString *)str forWidth:(CGFloat)width forFont:(UIFont *)font;
+ (CGFloat) calculateWidthForText:(NSString *)str forHeight:(CGFloat)height forFont:(UIFont *)font;
+ (UIColor *) UIColorForHexColor:(NSString *) hexColor;
+ (UIImage*) circularScaleNCrop:(UIImage*)image forRect:(CGRect) rect;
+ (NSString*)base64forData:(NSData*)theData;
+ (BOOL) validateEmail: (NSString *) candidate;
+ (BOOL) isValidEmail:(NSString *)checkString;
@end
