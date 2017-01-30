//
//  ResultNumber.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/18/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "ResultNumber.h"


@implementation ResultNumber

@synthesize myNumber;
@synthesize estimatedNumber;


- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.myNumber forKey: @"MyNumber"];
    [encoder encodeObject:self.estimatedNumber forKey: @"EstimatedNumber"];
    
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    if (self) {
        myNumber = [decoder decodeObjectForKey:@"MyNumber"];
        estimatedNumber = [decoder decodeObjectForKey:@"EstimatedNumber"];
    }
    return self;
}

@end
