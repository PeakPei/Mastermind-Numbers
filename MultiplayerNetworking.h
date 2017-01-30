//
//  MultiplayerNetworking.h
//  CatRaceStarter
//
//  Created by Kauserali on 06/01/14.
//  Copyright (c) 2014 Raywenderlich. All rights reserved.
//

#import "GameKitHelper.h"
#import "MyNumber.h"

@protocol MultiplayerNetworkingProtocol <NSObject>
- (void)matchEnded;
- (void)matchFirstStarted:(BOOL) invite andNumber:(int)number;
- (void)chooseNumber:(int)number;
- (void)showStartGameMessage:(BOOL) invite;
- (void)movePlayerNumber:(int)number;
- (void)showPlayerResult:(int)number withPozitive:(int)positive andNegative:(int)negative;
- (void)gameOver:(BOOL)player1Won andNumber:(int)number withPozitive:(int)positive andNegative:(int)negative;
- (void)gameOverWithDraws:(int)number withPozitive:(int)positive andNegative:(int)negative;
- (void)rematchFirstStarted:(BOOL)rematch;
- (void)restartMultiGame:(bool)rematch;
@end

@interface MultiplayerNetworking : NSObject<GameKitHelperDelegate>
@property (nonatomic, assign) id<MultiplayerNetworkingProtocol> delegate;
- (void)sendMove:(EstimatedNumber*)myEstimatedNumber;
- (void)sendMoveResult:(EstimatedNumber*)myEstimatedNumber;
- (void)sendGameEnd:(BOOL)player1Won andNumber:(EstimatedNumber*)myEstimatedNumber;
- (void)sendGameEndDraws:(EstimatedNumber*)myEstimatedNumber;
- (void)sendChooseNumber:(MyNumber*)myNumber;
- (void)sendGameBeginWithInvite:(BOOL)invite andNumber:(MyNumber*)myNumber;
- (void)sendRematch:(BOOL)rematch;
- (void)sendAcceptedRematch:(BOOL)rematch;
@end
