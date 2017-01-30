//
//  NSColor+Hex.h
//  Beak
//
//  Created by Mike Rundle on 2/18/09.
//  Copyright 2009 Mike Rundle. All rights reserved.
//

@interface UIColor (Hex)

+ (UIColor *)colorFromHex:(unsigned int)colorCode;
+ (UIColor *)colorFromHex:(unsigned int)colorCode alpha:(CGFloat)alpha;

@end

