//
//  UINavigationBar+Custom.m
//  MastermindNumbers
//
//  Created by Alaattin Bedir on 14.02.2016.
//  Copyright © 2016 Alaattin Bedir. All rights reserved.
//

#import "UINavigationBar+Custom.h"

@implementation UINavigationBar (Custom)

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize newSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width,64);
    return newSize;
}

@end
