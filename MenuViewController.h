//
//  MenuViewViewController.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/28/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayersViewController.h"
#import "GameViewController.h"
#import "GameKitHelper.h"
#import "MenuCarousel.h"

@import GameKit;

@interface MenuViewController : UIViewController<GKGameCenterControllerDelegate,MenuCarouselDelegate>

@property (nonatomic, strong) UIButton *settingsButton;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) HZBannerAd *bannerMain;
@property (strong, nonatomic) IBOutlet UIImageView *appNameImageView;
@property (strong, nonatomic) IBOutlet UIImageView *appNameImageView2;

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard;

@end
