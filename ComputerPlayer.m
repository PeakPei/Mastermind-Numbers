//
//  ComputerPlayer.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/28/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "ComputerPlayer.h"

@implementation ComputerPlayer


+ (instancetype)sharedComputerPlayer
{
    static ComputerPlayer *sharedNumbers;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNumbers = [[ComputerPlayer alloc] init];
    });
    return sharedNumbers;
}

- (id)init
{
    self = [super init];
    if (self) {
        _PlayerID = 1;
        _PlayerName = @"Master";
        _PlayerPower = @"4.985";
    }
    return self;
}

@end
