//
//  MultiplayerNetworking.m
//  CatRaceStarter
//
//  Created by Kauserali on 06/01/14.
//  Copyright (c) 2014 Raywenderlich. All rights reserved.
//

#import "MultiplayerNetworking.h"
#import "RWGameData.h"

#define playerIdKey @"PlayerId"
#define randomNumberKey @"randomNumber"



typedef NS_ENUM(UInt32, GameState) {
    kGameStateWaitingForMatch = 0,
    kGameStateWaitingForRandomNumber,
    kGameStateWaitingForStart,
    kGameStateActive,
    kGameStateDone
};

typedef NS_ENUM(UInt32, MessageType) {
    kMessageTypeRandomNumber = 0,
    kMessageTypeGameBegin,
    kMessageTypeChooseNumber,
    kMessageTypeMove,
    kMessageTypeMoveResult,
    kMessageTypeGameDraws,
    kMessageTypeGameOver,
    kMessageTypeRematch,
    kMessageTypeAcceptedRematch
};

typedef struct {
    MessageType messageType;
} Message;

typedef struct {
    Message message;
    UInt32 randomNumber;
} MessageRandomNumber;

typedef struct {
    Message message;
    UInt32 myNumber;
    BOOL invite;
    float power;
} MessageGameBegin;

typedef struct {
    Message message;
    BOOL rematch;
} MessageRematch;

typedef struct {
    Message message;
    BOOL rematch;
} MessageAcceptedRematch;

typedef struct {
    Message message;
    UInt32 myNumber;
    float power;
} MessageChooseNumber;

typedef struct {
    Message message;
    UInt32 estimatingNumber;
    UInt32 positiveResult;
    UInt32 negativeResult;
} MessageMove;


typedef struct {
    Message message;
    UInt32 estimatingNumber;
    UInt32 positiveResult;
    UInt32 negativeResult;
    BOOL player1Won;
} MessageGameOver;

typedef struct {
    Message message;
    UInt32 estimatingNumber;
    UInt32 positiveResult;
    UInt32 negativeResult;

    BOOL playersDraws;
} MessageGameDraws;

@implementation MultiplayerNetworking {
    UInt32 _ourRandomNumber;
    GameState _gameState;
    BOOL _isPlayer1, _receivedAllRandomNumbers;
    
    NSMutableArray *_orderOfPlayers;
}

- (id)init
{
    if (self = [super init]) {
        _ourRandomNumber = arc4random();
        _gameState = kGameStateWaitingForMatch;
        _orderOfPlayers = [NSMutableArray array];
        [_orderOfPlayers addObject:@{playerIdKey : [GKLocalPlayer localPlayer].playerID,
                                     randomNumberKey : @(_ourRandomNumber)}];
        
    }
    return self;
}

- (void)sendData:(NSData*)data
{
    NSError *error;
    GameKitHelper *gameKitHelper = [GameKitHelper sharedGameKitHelper];
    
    BOOL success = [gameKitHelper.match
                    sendDataToAllPlayers:data
                    withDataMode:GKMatchSendDataReliable
                    error:&error];
    
    if (!success) {
        NSLog(@"Error sending data:%@", error.localizedDescription);
        if ([_delegate respondsToSelector:@selector(matchEnded)]) {
            [_delegate matchEnded];
        }
    }
}

- (void)sendMove:(EstimatedNumber*)myEstimatedNumber {
    MessageMove messageMove;
    messageMove.message.messageType = kMessageTypeMove;
    
    NSString *_myNumber = nil;
    if ([RWGameData sharedGameData].threeDigitGame) {
        _myNumber = [NSString stringWithFormat:@"%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber];
    }else{
        _myNumber = [NSString stringWithFormat:@"%@%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber,myEstimatedNumber.FourthNumber];
    }
    
    messageMove.estimatingNumber = [_myNumber intValue];
    NSLog(@"Gonderilen sayi: %i",(unsigned int)messageMove.estimatingNumber);
    messageMove.positiveResult = [myEstimatedNumber PositiveResult];
    messageMove.negativeResult = [myEstimatedNumber NegativeResult];
    
    NSData *data = [NSData dataWithBytes:&messageMove
                                  length:sizeof(MessageMove)];
    [self sendData:data];
}

- (void)sendMoveResult:(EstimatedNumber*)myEstimatedNumber {
    MessageMove messageMove;
    messageMove.message.messageType = kMessageTypeMoveResult;
    
    NSString *_myNumber = nil;
    if ([RWGameData sharedGameData].threeDigitGame) {
        _myNumber = [NSString stringWithFormat:@"%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber];
    }else{
        _myNumber = [NSString stringWithFormat:@"%@%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber,myEstimatedNumber.FourthNumber];
    }
    
    messageMove.estimatingNumber = [_myNumber intValue];
    messageMove.positiveResult = [myEstimatedNumber PositiveResult];
    messageMove.negativeResult = [myEstimatedNumber NegativeResult];
    
    NSData *data = [NSData dataWithBytes:&messageMove
                                  length:sizeof(MessageMove)];
    [self sendData:data];
}

- (void)sendRandomNumber
{
    MessageRandomNumber message;
    message.message.messageType = kMessageTypeRandomNumber;
    message.randomNumber = _ourRandomNumber;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageRandomNumber)];
    [self sendData:data];
}

- (void)sendGameBegin {
    
    MessageGameBegin message;
    message.message.messageType = kMessageTypeGameBegin;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameBegin)];
    [self sendData:data];
    
}

- (void)sendGameBeginWithInvite:(BOOL)invite andNumber:(MyNumber*)myNumber{
    
    MessageGameBegin message;
    message.message.messageType = kMessageTypeGameBegin;
    message.invite = invite;
    
    NSString *_myNumber = nil;
    if ([RWGameData sharedGameData].threeDigitGame) {
        _myNumber = [NSString stringWithFormat:@"%@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber];
    }else{
        _myNumber = [NSString stringWithFormat:@"%@%@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber,myNumber.FourthNumber];
    }

    message.myNumber = [_myNumber intValue];
    if ([RWGameData sharedGameData].threeDigitGame) {
        message.power = [RWGameData sharedGameData].trainingAvarageSteps;
    }else{
        message.power = [RWGameData sharedGameData].trainingAvarage4Steps;
    }

    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameBegin)];
    [self sendData:data];
    
}

- (void)sendRematch:(BOOL)rematch {
    
    MessageRematch message;
    message.message.messageType = kMessageTypeRematch;
    message.rematch = rematch;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageRematch)];
    [self sendData:data];
    
}

- (void)sendAcceptedRematch:(BOOL)rematch {
    
    MessageAcceptedRematch message;
    message.message.messageType = kMessageTypeAcceptedRematch;
    message.rematch = rematch;
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageAcceptedRematch)];
    [self sendData:data];
    
}

- (void)sendChooseNumber:(MyNumber*)myNumber{
    
    MessageChooseNumber message;
    message.message.messageType = kMessageTypeChooseNumber;

    NSString *_myNumber = nil;
    if ([RWGameData sharedGameData].threeDigitGame) {
        _myNumber = [NSString stringWithFormat:@"%@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber];
    }else{
        _myNumber = [NSString stringWithFormat:@"%@%@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber,myNumber.FourthNumber];
    }

    message.myNumber = [_myNumber intValue];
    
    if ([RWGameData sharedGameData].threeDigitGame) {
        message.power = [RWGameData sharedGameData].trainingAvarageSteps;
    }else{
        message.power = [RWGameData sharedGameData].trainingAvarage4Steps;
    }

    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageChooseNumber)];
    [self sendData:data];
    
}

- (void)sendGameEnd:(BOOL)player1Won andNumber:(EstimatedNumber*)myEstimatedNumber {
    MessageGameOver message;
    message.message.messageType = kMessageTypeGameOver;
    message.player1Won = player1Won;
    
    if ([RWGameData sharedGameData].threeDigitGame) {
        if (myEstimatedNumber) {
            NSString *_myNumber = [NSString stringWithFormat:@"%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber];
            message.estimatingNumber = [_myNumber intValue];
            message.positiveResult = [myEstimatedNumber PositiveResult];
            message.negativeResult = [myEstimatedNumber NegativeResult];
        }else{
            message.estimatingNumber = 0;
            message.positiveResult = 0;
            message.negativeResult = 0;
        }
    }
    else{
        if (myEstimatedNumber) {
            NSString *_myNumber = [NSString stringWithFormat:@"%@%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber,myEstimatedNumber.FourthNumber];
            message.estimatingNumber = [_myNumber intValue];
            message.positiveResult = [myEstimatedNumber PositiveResult];
            message.negativeResult = [myEstimatedNumber NegativeResult];
        }else{
            message.estimatingNumber = 0;
            message.positiveResult = 0;
            message.negativeResult = 0;
        }
    }
    
    
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameOver)];
    [self sendData:data];

}

- (void)sendGameEndDraws:(EstimatedNumber*)myEstimatedNumber{
    MessageGameDraws message;
    message.message.messageType = kMessageTypeGameDraws;
    
    NSString *_myNumber = nil;
    if ([RWGameData sharedGameData].threeDigitGame) {
        _myNumber = [NSString stringWithFormat:@"%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber];
    }else{
        _myNumber = [NSString stringWithFormat:@"%@%@%@%@",myEstimatedNumber.FirstNumber,myEstimatedNumber.SecondNumber,myEstimatedNumber.ThirdNumber,myEstimatedNumber.FourthNumber];
    }
    
    message.estimatingNumber = [_myNumber intValue];
    message.positiveResult = [myEstimatedNumber PositiveResult];
    message.negativeResult = [myEstimatedNumber NegativeResult];

    message.playersDraws = YES;
    NSData *data = [NSData dataWithBytes:&message length:sizeof(MessageGameDraws)];
    [self sendData:data];
}


- (NSUInteger)indexForLocalPlayer
{
    NSString *playerId = [GKLocalPlayer localPlayer].playerID;
    
    return [self indexForPlayerWithId:playerId];
}

- (NSUInteger)indexForPlayerWithId:(NSString*)playerId
{
    __block NSUInteger index = -1;
    [_orderOfPlayers enumerateObjectsUsingBlock:^(NSDictionary
                                                  *obj, NSUInteger idx, BOOL *stop){
        NSString *pId = obj[playerIdKey];
        if ([pId isEqualToString:playerId]) {
            index = idx;
            *stop = YES;
        }
    }];
    return index;
}

- (void)tryStartGame
{
    if (_isPlayer1 && (_gameState == kGameStateWaitingForStart || _gameState == kGameStateActive)) {
        _gameState = kGameStateActive;
        
        BOOL invite = [GameKitHelper sharedGameKitHelper].invitedGame;
        
        [self sendGameBeginWithInvite:invite andNumber:[RWGameData sharedGameData].myNumber];
        
        //first player
        [self.delegate showStartGameMessage:NO];
        [GameKitHelper sharedGameKitHelper].invitedGame = NO;
    }
}

- (void)tryRestartGame
{
    if (_isPlayer1) {
        _gameState = kGameStateActive;
        
        //        BOOL invite = [GameKitHelper sharedGameKitHelper].invitedGame;
        
        [self sendGameBeginWithInvite:NO andNumber:[RWGameData sharedGameData].myNumber];
        
        //first player
        [self.delegate showStartGameMessage:NO];
        [GameKitHelper sharedGameKitHelper].invitedGame = NO;
    }
}

- (BOOL)allRandomNumbersAreReceived
{
    NSMutableArray *receivedRandomNumbers =
    [NSMutableArray array];
    
    for (NSDictionary *dict in _orderOfPlayers) {
        [receivedRandomNumbers addObject:dict[randomNumberKey]];
    }
    
    NSArray *arrayOfUniqueRandomNumbers = [[NSSet setWithArray:receivedRandomNumbers] allObjects];
    
    if (arrayOfUniqueRandomNumbers.count ==
        [GameKitHelper sharedGameKitHelper].match.playerIDs.count + 1) {
        return YES;
    }
    return NO;
}

-(void)processReceivedRandomNumber:(NSDictionary*)randomNumberDetails {
    //1
    if([_orderOfPlayers containsObject:randomNumberDetails]) {
        [_orderOfPlayers removeObjectAtIndex:
         [_orderOfPlayers indexOfObject:randomNumberDetails]];
    }
    //2
    [_orderOfPlayers addObject:randomNumberDetails];
    
    //3
    NSSortDescriptor *sortByRandomNumber =
    [NSSortDescriptor sortDescriptorWithKey:randomNumberKey
                                  ascending:NO];
    NSArray *sortDescriptors = @[sortByRandomNumber];
    [_orderOfPlayers sortUsingDescriptors:sortDescriptors];
    
    //4
    if ([self allRandomNumbersAreReceived]) {
        _receivedAllRandomNumbers = YES;
    }
}

//- (void)processPlayerAliases {
//    if ([self allRandomNumbersAreReceived]) {
//        NSMutableArray *playerAliases = [NSMutableArray arrayWithCapacity:_orderOfPlayers.count];
//        for (NSDictionary *playerDetails in _orderOfPlayers) {
//            NSString *playerId = playerDetails[playerIdKey];
//            [playerAliases addObject:((GKPlayer*)[GameKitHelper sharedGameKitHelper].playersDict[playerId]).alias];
//        }
//        if (playerAliases.count > 0) {
//            [self.delegate setPlayerAliases:playerAliases];
//        }
//    }
//}

- (BOOL)isLocalPlayerPlayer1
{
    NSDictionary *dictionary = _orderOfPlayers[0];
    if ([dictionary[playerIdKey]
         isEqualToString:[GKLocalPlayer localPlayer].playerID]) {
        NSLog(@"I'm player 1");
        return YES;
    }
    return NO;
}

#pragma mark GameKitHelper delegate methods

- (void)matchStarted {
    NSLog(@"Match has started successfully");
    if (_receivedAllRandomNumbers) {
        _gameState = kGameStateWaitingForStart;
    } else {
        _gameState = kGameStateWaitingForRandomNumber;
    }
    [self sendRandomNumber];
    [self tryStartGame];
}

- (void)matchRestarted {
    NSLog(@"Match has started successfully");
    if (_receivedAllRandomNumbers) {
        _gameState = kGameStateWaitingForStart;
    } else {
        _gameState = kGameStateWaitingForRandomNumber;
    }
    [self sendRandomNumber];
    [self tryRestartGame];
}

- (void)matchEnded {
    NSLog(@"Match has ended");
    if ([_delegate respondsToSelector:@selector(matchEnded)]) {
        [_delegate matchEnded];
    }
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data
   fromPlayer:(NSString *)playerID {
    //1
    Message *message = (Message*)[data bytes];
    if (message->messageType == kMessageTypeRandomNumber) {
        MessageRandomNumber *messageRandomNumber = (MessageRandomNumber*)[data bytes];
        
        NSLog(@"Received random number:%d", (unsigned int)messageRandomNumber->randomNumber);
        
        BOOL tie = NO;
        if (messageRandomNumber->randomNumber == _ourRandomNumber) {
            //2
            NSLog(@"Tie");
            tie = YES;
            _ourRandomNumber = arc4random();
            [self sendRandomNumber];
        } else {
            //3
            NSDictionary *dictionary = @{playerIdKey : playerID,
                                         randomNumberKey : @(messageRandomNumber->randomNumber)};
            [self processReceivedRandomNumber:dictionary];
        }
        
        //4
        if (_receivedAllRandomNumbers) {
            _isPlayer1 = [self isLocalPlayerPlayer1];
        }
        
        if (!tie && _receivedAllRandomNumbers) {
            //5
            if (_gameState == kGameStateWaitingForRandomNumber) {
                _gameState = kGameStateWaitingForStart;
            }
            [self tryStartGame];
        }
    } else if (message->messageType == kMessageTypeGameBegin) {
        NSLog(@"Begin game message received");
        _gameState = kGameStateActive;
        MessageGameBegin * messageGameBegin = (MessageGameBegin *) [data bytes];

        [RWGameData sharedGameData].playerRemotePower = [NSString stringWithFormat:@"%.3f",messageGameBegin->power];
        [self.delegate matchFirstStarted:messageGameBegin->invite andNumber:messageGameBegin->myNumber];

    } else if (message->messageType == kMessageTypeChooseNumber) {
        NSLog(@"Choose number message received");
        _gameState = kGameStateActive;
        MessageChooseNumber * messageChooseNumber = (MessageChooseNumber *) [data bytes];
        [RWGameData sharedGameData].playerRemotePower = [NSString stringWithFormat:@"%.3f",messageChooseNumber->power];
        [self.delegate chooseNumber:messageChooseNumber->myNumber];
        
    }else if (message->messageType == kMessageTypeMove) {
        NSLog(@"Move message received");
        NSLog(@"Data Length %lu ",(unsigned long)[data length]);
        NSString *responseString =[[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUnicodeStringEncoding];
        NSLog(@"%@",responseString);

        MessageMove *messageMove = (MessageMove *)[data bytes];
        NSLog(@"Received estimating number:%d", (unsigned int)messageMove->estimatingNumber);
        
        [self.delegate movePlayerNumber:messageMove->estimatingNumber];
    }else if (message->messageType == kMessageTypeMoveResult) {
        NSLog(@"Move Result message received");
        NSLog(@"Data Length %lu ",(unsigned long)[data length]);
        MessageMove *messageMove = (MessageMove*)[data bytes];
        NSLog(@"Received Result estimating number:%d", (unsigned int)messageMove->estimatingNumber);

        [self.delegate showPlayerResult:messageMove->estimatingNumber withPozitive:messageMove->positiveResult andNegative:messageMove->negativeResult];
    }else if(message->messageType == kMessageTypeGameDraws) {
        NSLog(@"Game Draws message received");
        MessageGameDraws * messageGameDraw = (MessageGameDraws *) [data bytes];
        [self.delegate gameOverWithDraws:messageGameDraw->estimatingNumber withPozitive:messageGameDraw->positiveResult andNegative:messageGameDraw->negativeResult];
    } else if(message->messageType == kMessageTypeGameOver) {
        NSLog(@"Game over message received");
        MessageGameOver * messageGameOver = (MessageGameOver *) [data bytes];
        if (messageGameOver->estimatingNumber == 0) {
            [self.delegate matchEnded];
        }else{
            [self.delegate gameOver:messageGameOver->player1Won andNumber:messageGameOver->estimatingNumber withPozitive:messageGameOver->positiveResult andNegative:messageGameOver->negativeResult];
        }
    }else if(message->messageType == kMessageTypeRematch) {
        NSLog(@"Rematch message received");
        MessageRematch * messageRematch = (MessageRematch *) [data bytes];
        [self.delegate rematchFirstStarted:messageRematch->rematch];
    }else if(message->messageType == kMessageTypeAcceptedRematch) {
        NSLog(@"Accepted Rematch message received");
        MessageAcceptedRematch * messageAcceptedRematch = (MessageAcceptedRematch *) [data bytes];
        [self.delegate restartMultiGame:messageAcceptedRematch->rematch];
    }
}
@end
