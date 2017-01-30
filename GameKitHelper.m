//
//  GameKitHelper.m
//  CatRaceStarter
//
//  Created by Kauserali on 02/01/14.
//  Copyright (c) 2014 Raywenderlich. All rights reserved.
//

#import "GameKitHelper.h"
#import "AppDelegate.h"
#import <Google/Analytics.h>
#import "RWGameData.h"

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";
NSString *const LocalPlayerIsAuthenticated = @"local_player_authenticated";
NSString *const LocalPlayerIsInvited = @"local_player_invited";

@implementation GameKitHelper {
    BOOL _enableGameCenter;
    BOOL _matchStarted;
    GKInvite *inviteRequest;
    GKMatchRequest *matchRequest;
    AppDelegate *appDelegate;
}

@synthesize _leaderboardIdentifier,remotePlayerID,remotePlayerName,invitedGame,remotePlayerPhoto,localPlayerPhoto;

+ (instancetype)sharedGameKitHelper
{
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

- (id)init
{
    self = [super init];
    if (self) {
        _enableGameCenter = YES;
        inviteRequest = nil;
        matchRequest = nil;
        appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    return self;
}

-(void)dealloc{
    _delegate = nil;
}

-(void)reportStepsScore:(float)steps {
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:[[GameKitHelper sharedGameKitHelper] _leaderboardIdentifier]];
    score.value = steps;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(void)reportAIScore:(long)points {
    if(![GKLocalPlayer localPlayer].isAuthenticated)
        return;
    
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:@"AIRankingPointID"];
    score.value = points;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

-(void)reportScore:(long)points {
    if(![GKLocalPlayer localPlayer].isAuthenticated)
        return;
    
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:@"rankingPointID"];
    score.value =  points;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}

- (void)authenticateLocalPlayer
{
    //1
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    if (localPlayer.isAuthenticated) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LocalPlayerIsAuthenticated object:nil];
        // invitation delegate sets
        [[GKLocalPlayer localPlayer]registerListener:self];
        
        [self reportAIScore:[RWGameData sharedGameData].scoreAI];
        [self reportScore:[RWGameData sharedGameData].score];

        return;
    }
    //2
    localPlayer.authenticateHandler  =
    ^(UIViewController *viewController, NSError *error) {
        //3
        [self setLastError:error];
        
        if(viewController != nil) {
            //4
            [self setAuthenticationViewController:viewController];
        } else if([GKLocalPlayer localPlayer].isAuthenticated) {
            //5
            _enableGameCenter = YES;
            
            [self loadLocalPlayerPhoto:[GKLocalPlayer localPlayer]];
            // Get the default leaderboard identifier.
            [[GKLocalPlayer localPlayer] loadDefaultLeaderboardIdentifierWithCompletionHandler:^(NSString *leaderboardIdentifier, NSError *error) {
                
                if (error != nil) {
                    NSLog(@"%@", [error localizedDescription]);
                }
                else{
                    self._leaderboardIdentifier = leaderboardIdentifier;
                }
            }];
            
            [self reportAIScore:[RWGameData sharedGameData].scoreAI];
            [self reportScore:[RWGameData sharedGameData].score];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:LocalPlayerIsAuthenticated object:nil];

            // invitation delegate sets
             [[GKLocalPlayer localPlayer]registerListener:self];
            
        } else {
            //6
            _enableGameCenter = NO;
        }
    };
}

-(void)player:(GKPlayer *)player didAcceptInvite:(GKInvite *)invite{
    NSLog(@"didAcceptInvite invoked %@", invite);
    inviteRequest = invite;
    if (inviteRequest.playerGroup == 3) {
        [RWGameData sharedGameData].threeDigitGame = YES;
        [RWGameData sharedGameData].fourDigitGame = NO;
    }else {
        [RWGameData sharedGameData].threeDigitGame = NO;
        [RWGameData sharedGameData].fourDigitGame = YES;
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:LocalPlayerIsInvited object:nil];
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bilgi"
//                                                    message:@"Davet kabul edildi"
//                                                   delegate:self
//                                          cancelButtonTitle:@"Tamam"
//                                          otherButtonTitles:nil, nil];
//    [alert show];
}

-(void)player:(GKPlayer *)player didRequestMatchWithPlayers:(NSArray *)playerIDsToInvite{
    NSLog(@"didRequestMatchWithPlayers invoked %@", playerIDsToInvite);
    matchRequest = [[GKMatchRequest alloc] init];
    matchRequest.minPlayers = 2; // At least 2. Minimum number of players before a match can start
    matchRequest.maxPlayers = 2; //Up to 4. Maximum number of concurrent players in a match.
    matchRequest.playersToInvite = playerIDsToInvite;
    matchRequest.playerGroup = [RWGameData sharedGameData].threeDigitGame == YES ? 3 : 4;

//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bilgi"
//                                                    message:@"Davet edilen oyuncular"
//                                                   delegate:self
//                                          cancelButtonTitle:@"Tamam"
//                                          otherButtonTitles:nil, nil];
//    [alert show];
}


- (void) loadPlayerPhoto: (GKPlayer*) player
{
    [player loadPhotoForSize:GKPhotoSizeSmall withCompletionHandler:^(UIImage *photo, NSError *error) {
        if (photo != nil)
        {
            self.remotePlayerPhoto = photo;
        }
        if (error != nil)
        {
            // Handle the error if necessary.
        }
    }];
}

- (void) loadLocalPlayerPhoto: (GKPlayer*) player
{
    [player loadPhotoForSize:GKPhotoSizeSmall withCompletionHandler:^(UIImage *photo, NSError *error) {
        if (photo != nil)
        {
            self.localPlayerPhoto = photo;
        }
        if (error != nil)
        {
            // Handle the error if necessary.
        }
    }];
}



- (void)lookupPlayers {
    
    NSLog(@"Looking up %lu players...", (unsigned long)_match.playerIDs.count);
    
    [GKPlayer loadPlayersForIdentifiers:_match.playerIDs withCompletionHandler:^(NSArray *players, NSError *error) {
        
        if (error != nil) {
            NSLog(@"Error retrieving player info: %@", error.localizedDescription);
            _matchStarted = NO;
            if ([_delegate respondsToSelector:@selector(matchEnded)]) {
                [_delegate matchEnded];
            }
        } else {
            
            // Populate players dict
            _playersDict = [NSMutableDictionary dictionaryWithCapacity:players.count];
            for (GKPlayer *player in players) {
                NSLog(@"Found player: %@", player.alias);
                remotePlayerID = player.playerID;
                remotePlayerName = player.alias;
                [self loadPlayerPhoto:player];
                [_playersDict setObject:player forKey:player.playerID];
            }
            
            
            [_playersDict setObject:[GKLocalPlayer localPlayer] forKey:[GKLocalPlayer localPlayer].playerID];
            [self loadLocalPlayerPhoto:[GKLocalPlayer localPlayer]];
            
            
            // Notify delegate match can begin
            _matchStarted = YES;
            if ([_delegate respondsToSelector:@selector(matchStarted)]) {
                [_delegate matchStarted];
            }
        }
    }];
}

- (void)findMatchWithMinPlayers:(int)minPlayers maxPlayers:(int)maxPlayers
                 viewController:(UIViewController *)viewController
                       delegate:(id<GameKitHelperDelegate>)delegate {
    
    NSLog(@"findMatchWithMinPlayers invoked");
    if (!_enableGameCenter) return;
    
    _matchStarted = NO;
    self.match = nil;
    _delegate = delegate;
    [viewController dismissViewControllerAnimated:NO completion:nil];
    
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = minPlayers;
    request.maxPlayers = maxPlayers;
    request.playerGroup = [RWGameData sharedGameData].threeDigitGame ? 3 : 4;
    
    if (inviteRequest) {
        request.playerGroup = inviteRequest.playerGroup;
        if (inviteRequest.playerGroup == 3) {
            [RWGameData sharedGameData].threeDigitGame = YES;
            [RWGameData sharedGameData].fourDigitGame = NO;
        }else {
            [RWGameData sharedGameData].threeDigitGame = NO;
            [RWGameData sharedGameData].fourDigitGame = YES;
        }

        self.invitedGame = YES;
        NSLog(@"Invited %@", inviteRequest);
        GKMatchmakerViewController *mmvc =
        [[GKMatchmakerViewController alloc] initWithInvite:inviteRequest];
        mmvc.matchmakerDelegate = self;
        [viewController presentViewController:mmvc animated:YES completion:nil];
        inviteRequest = nil;
    }else if(matchRequest){
        NSLog(@"Game center request %@", inviteRequest);
        self.invitedGame = YES;
        GKMatchmakerViewController *mmvc =
        [[GKMatchmakerViewController alloc] initWithMatchRequest:matchRequest];
        mmvc.matchmakerDelegate = self;
        [viewController presentViewController:mmvc animated:YES completion:nil];
        matchRequest = nil;
    }else{
        NSLog(@"Normal match request %@",request);
        GKMatchmakerViewController *mmvc =
        [[GKMatchmakerViewController alloc] initWithMatchRequest:request];
        mmvc.matchmakerDelegate = self;
        [viewController presentViewController:mmvc animated:YES completion:nil];
    }
    
}

- (void)setAuthenticationViewController:
(UIViewController *)authenticationViewController
{
    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PresentAuthenticationViewController
         object:self];
    }
}

- (void)setLastError:(NSError *)error
{
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@",
              [[_lastError userInfo] description]);
    }
}

#pragma mark GKMatchmakerViewControllerDelegate

// The user has cancelled matchmaking
- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];

    
    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"game_action"     // Event category (required)
                                                          action:@"multi_game_canceled"  // Event action (required)
                                                           label:@"cancel"          // Event label
                                                           value:nil] build]];    // Event value
    
    UINavigationController *vc = (UINavigationController *)appDelegate.window.rootViewController;
    [vc popToRootViewControllerAnimated:YES];

}

// Matchmaking has failed with an error
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error {
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"Error finding match: %@", error.localizedDescription);
}

// A peer-to-peer match has been found, the game should start
- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match {
    [viewController dismissViewControllerAnimated:YES completion:nil];
    self.match = match;
    match.delegate = self;
    if (!_matchStarted && match.expectedPlayerCount == 0) {
        NSLog(@"Ready to start match!");
        [self lookupPlayers];
    }
}

#pragma mark GKMatchDelegate

// The match received data sent from the player.
- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID {
    if (_match != match) return;
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(match:didReceiveData:fromPlayer:) ] ){
        [_delegate match:match didReceiveData:data fromPlayer:playerID];
    }
    
}

// The player state changed (eg. connected or disconnected)
- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state {
    if (_match != match) return;
    
    switch (state) {
        case GKPlayerStateConnected:
            // handle a new player connection.
            NSLog(@"Player connected!");
            
            if (!_matchStarted && match.expectedPlayerCount == 0) {
                NSLog(@"Ready to start match!");
                [self lookupPlayers];
            }
            
            break;
        case GKPlayerStateDisconnected:{
            
            NSString *gkMatchString = [NSString stringWithFormat:@"%@",self.match];
            if ([gkMatchString rangeOfString:@"connected"].location == NSNotFound)
            {
                NSLog(@"Session is actually closed.");
                // a player just disconnected.
                NSLog(@"Player disconnected!");
                
                _matchStarted = NO;
                
                if ([_delegate respondsToSelector:@selector(matchEnded)]) {
                    [_delegate matchEnded];
                }
                
            }else{
                NSLog(@"Session is NOT yet closed.");
            }
        }
            break;
        case GKPlayerStateUnknown:
            NSLog(@"Player State Unknown!");
            break;
    }
}


//-(BOOL)match:(GKMatch *)match shouldReinviteDisconnectedPlayer:(GKPlayer *)player{
//    return YES;
//}


- (void)reinvitePlayer : (NSString*) playerId{
    GKMatchRequest *request = [[GKMatchRequest alloc] init];
    request.minPlayers = 2;
    request.maxPlayers = 2;
    request.playersToInvite = @[playerId];
    request.inviteMessage = @"Reconnect?";
    request.playerGroup = [RWGameData sharedGameData].threeDigitGame ? 3 : 4;
    request.inviteeResponseHandler = ^(NSString *playerID, GKInviteeResponse response)
    {
        NSLog(@"Player response = %li.",(long)response);
        // [self updateUIForPlayer: playerID accepted: (response == GKInviteeResponseAccepted)];
    };
    
    [[GKMatchmaker sharedMatchmaker] addPlayersToMatch:_match matchRequest:request completionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"Unable to add player to match.");
            
            _matchStarted = NO;
            if ([_delegate respondsToSelector:@selector(matchEnded)]) {
                [_delegate matchEnded];
            }
            
        } else {
            
            [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"game_action"     // Event category (required)
                                                                  action:@"connection_estabilished"  // Event action (required)
                                                                   label:@"estabilished"          // Event label
                                                                   value:nil] build]];    // Event value
            
            NSLog(@"Successfully reconnected");
            [[GKMatchmaker sharedMatchmaker] finishMatchmakingForMatch:_match];
        }
    }];
}


// The match was unable to connect with the player due to an error.
- (void)match:(GKMatch *)match connectionWithPlayerFailed:(NSString *)playerID withError:(NSError *)error {
    
    if (_match != match) return;

    NSLog(@"Failed to connect to player with error: %@", error.localizedDescription);
    _matchStarted = NO;
    if ([_delegate respondsToSelector:@selector(matchEnded)]) {
        [_delegate matchEnded];
    }
}

// The match was unable to be established with any players due to an error.
- (void)match:(GKMatch *)match didFailWithError:(NSError *)error {
    
    if (_match != match) return;
    
    NSLog(@"Match failed with error: %@", error.localizedDescription);
    _matchStarted = NO;
    if ([_delegate respondsToSelector:@selector(matchEnded)]) {
        [_delegate matchEnded];
    }
}
@end
