//
//  ComputerPlayer.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/28/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComputerPlayer : NSObject

+ (instancetype)sharedComputerPlayer;


@property (nonatomic,strong) NSString *PlayerName;
@property (nonatomic,strong) NSString *PlayerPower;
@property (nonatomic,assign) int PlayerID;

@end
