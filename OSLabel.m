//
//  OSLabel.m
//  MastermindNumbers
//
//  Created by Alaattin Bedir on 3.02.2016.
//  Copyright © 2016 Alaattin Bedir. All rights reserved.
//

#import "OSLabel.h"

@implementation OSLabel

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
