//
//  AppUtil.m
//  Basaksehir_HD
//
//  Created by mahir tarlan on 12/6/13.
//  Copyright (c) 2013 igones. All rights reserved.
//

#import "AppUtil.h"
#import "AppDelegate.h"

@implementation AppUtil


+ (CGFloat) calculateHeightForText:(NSString *)str forWidth:(CGFloat)width forFont:(UIFont *)font {
    if([str isKindOfClass:[NSNull class]]) return 0;
    CGFloat result = 20.0f;
    if (str) {
        CGSize textSize = { width, 20000.0f };
        CGRect textRect = [str boundingRectWithSize:textSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil];
        
        CGSize size = textRect.size;
        
        result = MAX(size.height, 20.0f);
    }
    return result;
}

+ (CGFloat) calculateWidthForText:(NSString *)str forHeight:(CGFloat)height forFont:(UIFont *)font {
    CGFloat result = 20.0f;
    if (str) {
        CGSize textSize = { 20000.0f, height };
        
        CGRect textRect = [str boundingRectWithSize:textSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil];
        
        CGSize size = textRect.size;
        
        result = MAX(size.width, 20.0f);
    }
    return result;
}
+ (UIColor *) UIColorForHexColor:(NSString *) hexColor {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}


+ (NSURL *) getImageUrlByScale:(NSString *) urlString withBaseWidth:(int)baseWidth andBaseHeight:(int)baseHeight{
    int scaleFactor = [UIScreen mainScreen].scale;
    NSString *urlScalePart = [NSString stringWithFormat:@"?width=%i&height=%i", baseWidth*scaleFactor, baseHeight*scaleFactor];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, urlScalePart]];
    
    return url;
}

+ (NSURL *) getImageUrlByScale:(NSString *) urlString withImageView:(UIImageView *)imageView{
    int scaleFactor = [UIScreen mainScreen].scale;
    NSString *urlScalePart = [NSString stringWithFormat:@"?width=%i&height=%i", (int)imageView.frame.size.width * scaleFactor, (int)imageView.frame.size.height * scaleFactor];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", urlString, urlScalePart]];
    
    return url;
}


+ (UIImage*) circularScaleNCrop:(UIImage*)image forRect:(CGRect) rect {
    CGFloat ratio = rect.size.height / image.size.height;
    if(image.size.width < image.size.height) {
        ratio = rect.size.width / image.size.width;
    }
    
    UIImage *scaledImage = [UIImage imageWithCGImage:[image CGImage] scale:(image.scale * ratio) orientation:(image.imageOrientation)];
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:rect.size.width/2] addClip];
    [scaledImage drawInRect:rect];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;

}


+ (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (BOOL) validateEmail: (NSString *) candidate {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; //  return 0;
    return [emailTest evaluateWithObject:candidate];
}


+ (BOOL) isValidEmail:(NSString *)checkString {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}



@end
