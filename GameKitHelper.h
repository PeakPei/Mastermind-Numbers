//
//  GameKitHelper.h
//  CatRaceStarter
//
//  Created by Kauserali on 02/01/14.
//  Copyright (c) 2014 Raywenderlich. All rights reserved.
//


@import GameKit;

@protocol GameKitHelperDelegate <NSObject>
- (void)matchStarted;
- (void)matchRestarted;
- (void)matchEnded;
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data
   fromPlayer:(NSString *)playerID;
@end

extern NSString *const PresentAuthenticationViewController;
extern NSString *const LocalPlayerIsAuthenticated;
extern NSString *const LocalPlayerIsInvited;

@interface GameKitHelper : NSObject<GKMatchmakerViewControllerDelegate, GKMatchDelegate, GKLocalPlayerListener>

@property (nonatomic, readonly) UIViewController *authenticationViewController;
@property (nonatomic, readonly) NSError *lastError;

@property (nonatomic, strong) GKMatch *match;
@property (nonatomic, assign) id <GameKitHelperDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *playersDict;
@property (nonatomic, strong) NSString * _leaderboardIdentifier;
@property (nonatomic, strong) NSString * remotePlayerID;
@property (nonatomic, strong) NSString * remotePlayerName;
@property (nonatomic, strong) UIImage * AIPlayerPhoto;
@property (nonatomic, strong) UIImage * remotePlayerPhoto;
@property (nonatomic, strong) UIImage * localPlayerPhoto;
@property (nonatomic, assign) BOOL invitedGame;

+ (instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
- (void)reportStepsScore:(float)steps;
- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
                 viewController:(UIViewController *)viewController
                       delegate:(id<GameKitHelperDelegate>)theDelegate;
@end
