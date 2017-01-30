//
//  ComputerPlayersViewController.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/30/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HeyzapAds/HeyzapAds.h>
#import "JNWSpringAnimation.h"
#import "ExtrasCell.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"


@interface OptionsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, HZIncentivizedAdDelegate,SKPaymentTransactionObserver>{
    MBProgressHUD *HUD;
}

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *restoreButton;
@property (nonatomic, strong) NSDate *checkDate;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, assign) BOOL limitExceeded;
@property (nonatomic, assign) BOOL processed;

@end
