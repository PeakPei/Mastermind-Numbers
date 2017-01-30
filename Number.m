//
//  Number.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 5/31/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "Number.h"
#import "RWGameData.h"

@implementation Number


- (id)init
{
    self = [super init];
    if (self) {
        self.PositiveResult = 0;
        if ([RWGameData sharedGameData].threeDigitGame) {
            self.NegativeResult = 0;
        }else{
            self.NegativeResult = 0;
        }

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_FirstNumber forKey:@"FirstNumber"];
    [encoder encodeObject:_SecondNumber forKey:@"SecondNumber"];
    [encoder encodeObject:_ThirdNumber forKey:@"ThirdNumber"];
    [encoder encodeObject:_FourthNumber forKey:@"FourthNumber"];
    [encoder encodeInt:_PositiveResult forKey:@"PositiveResult"];
    [encoder encodeInt:_NegativeResult forKey:@"NegativeResult"];
    [encoder encodeInt:_NumberLength forKey:@"NumberLength"];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    if (self) {
        _FirstNumber = [decoder decodeObjectForKey:@"FirstNumber"];
        _SecondNumber = [decoder decodeObjectForKey:@"SecondNumber"];
        _ThirdNumber = [decoder decodeObjectForKey:@"ThirdNumber"];
        _FourthNumber = [decoder decodeObjectForKey:@"FourthNumber"];
        _PositiveResult = [decoder decodeIntForKey:@"PositiveResult"];
        _NegativeResult = [decoder decodeIntForKey:@"NegativeResult"];
        _NumberLength = [decoder decodeIntForKey:@"NumberLength"];
    }
    return self;
}

@end
