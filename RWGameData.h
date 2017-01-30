//
//  RWGameData.h
//  SpaceShooter
//
//  Created by Marin Todorov on 15/1/14.
//  Copyright (c) 2014 fullmoonmanor. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const SSGameDataUpdatedFromiCloud = @"SSGameDataUpdatedFromiCloud";

@interface RWGameData : NSObject <NSCoding>

@property (assign, nonatomic) long score;
@property (assign, nonatomic) long scoreAI;
@property (assign, nonatomic) double trainingAvarageSteps;
@property (assign, nonatomic) double trainingAvarage4Steps;
@property (assign, nonatomic) long singleGameCount;
@property (assign, nonatomic) long offlineGameCount;
@property (assign, nonatomic) long trainingGameCount;
@property (assign, nonatomic) long trainingGame4Count;
@property (assign, nonatomic) long multiGameCount;
@property (assign, nonatomic) long multiWinCount;
@property (assign, nonatomic) long multiLostCount;
@property (assign, nonatomic) long multiDrawCount;
@property (assign, nonatomic) long multiWinCount4;
@property (assign, nonatomic) long multiLostCount4;
@property (assign, nonatomic) long multiDrawCount4;
@property (assign, nonatomic) long singleWinCount;
@property (assign, nonatomic) long singleLostCount;
@property (assign, nonatomic) long singleDrawCount;
@property (assign, nonatomic) long singleWinCount4;
@property (assign, nonatomic) long singleLostCount4;
@property (assign, nonatomic) long singleDrawCount4;
@property (assign, nonatomic) long multiRemainingGameCount;
@property (assign, nonatomic) long multiAvarageTime;
@property (strong, nonatomic) MyNumber *myNumber;
@property (strong, nonatomic) EstimatedNumber *opponentsNumber;
@property (strong, nonatomic) NSMutableArray *playerIDs;
@property (assign, nonatomic) long rewardedGameCount;
@property (strong, nonatomic) NSString *limitDate;
@property (assign, nonatomic) long dailyLimit;
@property (assign, nonatomic) long limitStep;
@property (assign, nonatomic) long noAd;
@property (assign, nonatomic) BOOL showAIPlayers;
@property (assign, nonatomic) long playerId;
@property (strong, nonatomic) NSString *playerName;
@property (strong, nonatomic) NSString *playerPower;
@property (strong, nonatomic) NSString *playerRemotePower;
@property (assign, nonatomic) BOOL IAPAd;
@property (assign, nonatomic) BOOL IAPPacket1;
@property (assign, nonatomic) BOOL IAPPacket2;
@property (assign, nonatomic) BOOL IAPPacket3;
@property (assign, nonatomic) BOOL threeDigitGame;
@property (assign, nonatomic) BOOL fourDigitGame;
@property (assign, nonatomic) long thema;
@property (assign, nonatomic) BOOL limitExceeded;
@property (assign, nonatomic) long timeInterval;

+(instancetype)sharedGameData;
-(void)reset;
-(void)resetGamePower;
-(void)save;

@end