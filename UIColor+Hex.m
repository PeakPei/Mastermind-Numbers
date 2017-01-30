//
//  NSColor+Hex.m
//  Beak
//
//  Created by Mike Rundle on 2/18/09.
//  Copyright 2009 Mike Rundle. All rights reserved.
//

#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorFromHex:(unsigned int)colorCode {
	UIColor *result = nil;
	unsigned char redByte, greenByte, blueByte;
	
	redByte		= (unsigned char) (colorCode >> 16);
	greenByte	= (unsigned char) (colorCode >> 8);
	blueByte	= (unsigned char) (colorCode);	// masks off high bits
	result = [UIColor
			  colorWithRed:		(float)redByte	/ 0xff
			  green:	(float)greenByte/ 0xff
			  blue:	(float)blueByte	/ 0xff
			  alpha:1.0];
	return result;
}

+ (UIColor *)colorFromHex:(unsigned int)colorCode alpha:(CGFloat)alpha {
	UIColor *result = nil;
	unsigned char redByte, greenByte, blueByte;
	
	redByte		= (unsigned char) (colorCode >> 16);
	greenByte	= (unsigned char) (colorCode >> 8);
	blueByte	= (unsigned char) (colorCode);	// masks off high bits
	result = [UIColor
			  colorWithRed:		(float)redByte	/ 0xff
			  green:	(float)greenByte/ 0xff
			  blue:	(float)blueByte	/ 0xff
			  alpha:alpha];
	return result;
}

@end
