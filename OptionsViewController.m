//
//  ComputerPlayersViewController.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/30/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "OptionsViewController.h"
#import "RWGameData.h"
#import "AppDelegate.h"
#import "CustomAlertView.h"

#import "SoundManager.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface OptionsViewController (){
    AppDelegate *appDelegate;
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UITableView *_tableView;


@end

@implementation OptionsViewController
@synthesize checkDate,active,processed,limitExceeded;

- (void)setNavigationbarItems {
    
    UIButton *menuBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *menuBtnImage = [UIImage imageNamed:@"back"];
    UIImage *menuBtnImageClick = [UIImage imageNamed:@"back"];
    [menuBtn setBackgroundImage:menuBtnImage forState:UIControlStateNormal];
    [menuBtn setBackgroundImage:menuBtnImageClick forState:UIControlStateHighlighted];
    [menuBtn setBackgroundImage:menuBtnImageClick forState:UIControlStateSelected];
    [menuBtn addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    menuBtn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    self.navigationController.navigationItem.leftBarButtonItem = menuButton;
    
    
}

-(void) restoreClicked:(id)sender{
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    [HUD removeFromSuperViewOnHide];
    [HUD show:YES];
    HUD.labelText = JALocalizedString(@"KEY111", @"");
    [PFPurchase restore];
}

// required by protocol
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        
        switch(transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:
                // Unlock content
                //... Don't forget to call `finishTransaction`!
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:
                // Maybe show a progress bar?
                break;
            case SKPaymentTransactionStateFailed:
                // Handle error
                // You must call finishTransaction here too!
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:{
                // This is the one you want ;)
                // ...Re-unlock content...
                
                if (transaction.originalTransaction.payment.productIdentifier) {
                    [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
                } else {
                    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];
                }
                
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
            case SKPaymentTransactionStateDeferred:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
            default:
                // For debugging
                NSLog(@"Unexpected transaction state %@", @(transaction.transactionState));
                break;

        }
    }
}

-(void) provideContentForProductIdentifier:(NSString*)productIdentifier{
    if ([productIdentifier isEqualToString:@"com.magiclampgames.easynumbersgame.noadds"]) {
        HUD.labelText = JALocalizedString(@"KEY112", @"");
        [HUD hide:YES afterDelay:3];
        
        [RWGameData sharedGameData].IAPAd = YES;
        [[RWGameData sharedGameData] save];
        [self._tableView reloadData];
        
    }else {
        
        HUD.labelText = JALocalizedString(@"KEY112", @"");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:nil];
        
        
        [HUD hide:YES afterDelay:3];
    }
    
    

}

-(void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    HUD.labelText = error.localizedDescription;
    [HUD hide:YES afterDelay:3];
}

-(void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue {
    [HUD hide:YES afterDelay:3];
}


-(void)viewWillAppear:(BOOL)animated{
   
    
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self startTimer];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:FONT_GOODFISH size:23]}];
    
    
    
    
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    if ( appDelegate.iCloudEnabled) {
        // User has enabled icloud in your app...
    } else {
        // iCloud is not enabled for your app...
        
        
        CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                              withTitle:JALocalizedString(@"KEY108", @"")
                                                            withMessage:JALocalizedString(@"KEY109", @"")
                                                          withModalType:ModalTypeWarning];
        
        [self showCustomAlert:alert];
        
    }
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    UIImage *buttonImage = nil;

    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            buttonImage = [UIImage imageNamed:@"backbtn.png"];
            if (IS_IPAD_PRO) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bluePRO"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
            }
        }
            break;
        case 1:{
            buttonImage = [UIImage imageNamed:@"Backbtn2.png"];
            if (IS_IPAD_PRO) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"yelllowPRO"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgYellow"]]];
            }
        }
            break;
        case 2:{
            buttonImage = [UIImage imageNamed:@"Backbtn2.png"];
            if (IS_IPAD_PRO) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pinkPRO"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgPink"]]];
            }
        }
            break;
            
        default:{
            buttonImage = [UIImage imageNamed:@"backbtn.png"];
            if (IS_IPAD_PRO) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bluePRO"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
            }
        }
            break;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
    self.title = JALocalizedString(@"KEY11", @"");

    UIButton *restoreBtn     = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *restoreBtnImage = [UIImage imageNamed:@"sendButton"];
    [restoreBtn setBackgroundImage:restoreBtnImage forState:UIControlStateNormal];
    [restoreBtn addTarget:self action:@selector(restoreClicked:) forControlEvents:UIControlEventTouchUpInside];
    restoreBtn.frame = CGRectMake(0, 0, 84, 37);
    [restoreBtn setTitle:JALocalizedString(@"KEY110", @"") forState:UIControlStateNormal];
    [restoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [restoreBtn.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:22]];
    restoreBtn.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    restoreBtn.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    restoreBtn.titleLabel.layer.shadowRadius = 0.0;
    restoreBtn.titleLabel.layer.shadowOpacity = 0.6;
    restoreBtn.titleLabel.layer.masksToBounds = NO;
    restoreBtn.titleLabel.layer.shouldRasterize = YES;
    [restoreBtn setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];

    UIBarButtonItem *restoreButton = [[UIBarButtonItem alloc] initWithCustomView:restoreBtn];
    self.navigationItem.rightBarButtonItem = restoreButton;
    
    self._tableView.separatorColor = [UIColor clearColor];
    self._tableView.backgroundColor = [UIColor clearColor];
    self._tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self._tableView.separatorInset = UIEdgeInsetsMake(10, 0, 10, 0);

    
    [self._tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];

    
//    if([RWGameData sharedGameData].multiRemainingGameCount <= 0 )
//    {
//        self.active = YES;
////        [self checkDailyLimitExceed];
//    }else {
//        self.active = NO;
//    }
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    HUD = nil;
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

- (void)back {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backClicked:(id)sender{
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellTableIdentifier = @"CustomCellIdentifier";
    ExtrasCell *cell = (ExtrasCell *)[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
    if (cell == nil) {
        cell = [[ExtrasCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    }
    
//    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"extraCell"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([indexPath row] == 0) {
        NSString *remainingTime = nil;//[self remainingTime];
        if (remainingTime) {
            [cell.remainingLabel setHidden:NO];
            cell.remainingLabel.text = remainingTime;
            if (self.active) {
                cell.remainingLabel.textColor = [UIColor colorWithR:161 G:223 B:84 A:1];
            }else{
                cell.remainingLabel.textColor = [UIColor colorWithR:255 G:141 B:141 A:1];
            }
            
            cell.remainingLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
            cell.remainingLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
            cell.remainingLabel.layer.shadowRadius = 0.0;
            cell.remainingLabel.layer.shadowOpacity = 0.6;
            cell.remainingLabel.layer.masksToBounds = NO;
            cell.remainingLabel.layer.shouldRasterize = YES;
            
        }else {
            [cell.remainingLabel setHidden:YES];
        }
        
        cell.titleLabel.text = JALocalizedString(@"KEY63", @"");
        if (self.active) {
            cell.titleLabel.textColor = [UIColor colorWithR:161 G:223 B:84 A:1];
        }else{
            cell.titleLabel.textColor = [UIColor colorWithR:255 G:141 B:141 A:1];
        }
        
        cell.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.titleLabel.layer.shadowRadius = 0.0;
        cell.titleLabel.layer.shadowOpacity = 0.6;
        cell.titleLabel.layer.masksToBounds = NO;
        cell.titleLabel.layer.shouldRasterize = YES;
        
        NSString *message = [NSString stringWithFormat:JALocalizedString(@"KEY64", @""),[RWGameData sharedGameData].limitStep];
        cell.detailLabel.text = message;
        cell.detailLabel.textColor = [UIColor whiteColor];
        cell.detailLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.detailLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.detailLabel.layer.shadowRadius = 0.0;
        cell.detailLabel.layer.shadowOpacity = 0.6;
        cell.detailLabel.layer.masksToBounds = NO;
        cell.detailLabel.layer.shouldRasterize = YES;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.pictureImageView setImage:[UIImage imageNamed:@"rewardedVideo"]];

    }
    
    if ([indexPath row] == 1) {
        cell.titleLabel.text = JALocalizedString(@"KEY68", @"");
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.titleLabel.layer.shadowRadius = 0.0;
        cell.titleLabel.layer.shadowOpacity = 0.6;
        cell.titleLabel.layer.masksToBounds = NO;
        cell.titleLabel.layer.shouldRasterize = YES;
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.pictureImageView setImage:[UIImage imageNamed:@"Staricon"]];
        
        if (![RWGameData sharedGameData].IAPAd) {
            [cell.buyImageView setImage:[UIImage imageNamed:@"buy199"]];
        }

    }
    
    if ([indexPath row] == 2) {
        cell.titleLabel.text = JALocalizedString(@"KEY65", @"");
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.titleLabel.layer.shadowRadius = 0.0;
        cell.titleLabel.layer.shadowOpacity = 0.6;
        cell.titleLabel.layer.masksToBounds = NO;
        cell.titleLabel.layer.shouldRasterize = YES;

        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.pictureImageView setImage:[UIImage imageNamed:@"LifeIcon"]];
        [cell.buyImageView setImage:[UIImage imageNamed:@"buy099"]];
    }
    
    if ([indexPath row] == 3) {
        cell.titleLabel.text = JALocalizedString(@"KEY66", @"");
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.titleLabel.layer.shadowRadius = 0.0;
        cell.titleLabel.layer.shadowOpacity = 0.6;
        cell.titleLabel.layer.masksToBounds = NO;
        cell.titleLabel.layer.shouldRasterize = YES;

        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.pictureImageView setImage:[UIImage imageNamed:@"LifeIcon"]];
        [cell.buyImageView setImage:[UIImage imageNamed:@"buy199"]];
    }
    
    if ([indexPath row] == 4) {
        cell.titleLabel.text = JALocalizedString(@"KEY67", @"");
        cell.titleLabel.textColor = [UIColor whiteColor];
        cell.titleLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.titleLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        cell.titleLabel.layer.shadowRadius = 0.0;
        cell.titleLabel.layer.shadowOpacity = 0.6;
        cell.titleLabel.layer.masksToBounds = NO;
        cell.titleLabel.layer.shouldRasterize = YES;

        cell.accessoryType = UITableViewCellAccessoryNone;
        [cell.pictureImageView setImage:[UIImage imageNamed:@"LifeIcon"]];
        [cell.buyImageView setImage:[UIImage imageNamed:@"buy299"]];
    }
    

    
    return cell;
    
}

-(void) requestUTCTimeFromServer{
    NSString *utcTimeUrl = @"http://www.timeapi.org/utc/now";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:utcTimeUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSLog(@"%@",response);
                
                if(error == nil)
                {
                    NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                    NSLog(@"%@",text);
                    
                    [RWGameData sharedGameData].rewardedGameCount = 0;
                    [RWGameData sharedGameData].limitDate = text;
                    [RWGameData sharedGameData].limitExceeded = YES;
                    
                    [[RWGameData sharedGameData] save];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSString *message = [NSString stringWithFormat:JALocalizedString(@"KEY44", @""),[self remainingTime]];
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                                              withTitle:JALocalizedString(@"KEY13", @"")
                                                                            withMessage:message withModalType:ModalTypeInfo];
                        alert.tag = 30;
                        [self showCustomAlert:alert];
                        
                    });
                    
                }else {
                    
                    self.active = NO;
                    //set deactive
                    // hata olustu. internet baglantisi yok islem yapilamiyor
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                                              withTitle:JALocalizedString(@"KEY46", @"")
                                                                            withMessage:JALocalizedString(@"KEY45", @"") withModalType:ModalTypeError];
                        alert.tag = 40;
                        [self showCustomAlert:alert];
                    });
                }
                
                
            }] resume];
    
}

- (int)daysBetween2:(NSDate *)date1 and:(NSDate *)date2 {
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    return secondsBetween;
}

- (NSString *)timeFormatted:(long)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    long hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02ld:%02d:%02d",hours, minutes, seconds];
}

- (int)daysBetween:(NSDate *)dt1 and:(NSDate *)dt2 {
    NSUInteger unitFlags = NSDayCalendarUnit;
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:unitFlags fromDate:dt1 toDate:dt2 options:0];
    return (int)[components day]+1;
}

-(void)timerFired
{
    if ([self remainingTime]) {
        [self._tableView reloadData];
    }
}

-(NSString *) remainingTime{
    
    NSDate *utcLocal = nil;

    if ([RWGameData sharedGameData].limitDate) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
        utcLocal = [fmt dateFromString:[RWGameData sharedGameData].limitDate];
    }
    
    NSDate *utcCurrent = [NSDate date];
    long totalSeconds = [self daysBetween2:utcLocal and:utcCurrent];
    NSString *remainingTime = nil;
    if ([RWGameData sharedGameData].timeInterval*60 - totalSeconds > 0) {
        remainingTime = [self timeFormatted:[RWGameData sharedGameData].timeInterval*60-totalSeconds];
    }

    return remainingTime;
}

-(void) checkDailyLimitExceed{
    NSString *utcTimeUrl = @"http://www.timeapi.org/utc/now";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:utcTimeUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSLog(@"%@",response);
                
                if(error == nil)
                {
                    //
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * currentDate = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                        NSLog(@"%@",currentDate);
                        
                        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                        fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
                        NSDate *utcCurrent = [fmt dateFromString:currentDate];
                        
                        
                        NSDate *utcLocal = nil;
                        if ([RWGameData sharedGameData].limitDate) {
                            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
                            fmt.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
                            utcLocal = [fmt dateFromString:[RWGameData sharedGameData].limitDate];
                        }else{
                            // ilk kullanim
                            [RWGameData sharedGameData].limitExceeded = NO;
                            [[RWGameData sharedGameData] save];
                            
                            [self._tableView reloadData];
                            
                            return;
                        }
                        
                        int totalSeconds = [self daysBetween2:utcLocal and:utcCurrent];
                        int minutes = totalSeconds / 60;
                        if (minutes > [RWGameData sharedGameData].timeInterval) {
                            // set active videos
                            [RWGameData sharedGameData].limitExceeded = NO;
                            [[RWGameData sharedGameData] save];
                            [self._tableView reloadData];
                            
                        }else{
                            [RWGameData sharedGameData].limitExceeded = YES;
                            [[RWGameData sharedGameData] save];
                            [self._tableView reloadData];
                        }
                    });
                    
                }else{
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self._tableView reloadData];
                        //set deactive
                        // hata olustu. internet baglantisi yok islem yapilamiyor

                        
                        CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                                              withTitle:JALocalizedString(@"KEY46", @"")
                                                                            withMessage:JALocalizedString(@"KEY45", @"") withModalType:ModalTypeError];
                        alert.tag = 40;
                        [self showCustomAlert:alert];
                    });
                }
                
                
            }] resume];
    
}


-(void)startTimer
{
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

-(void) showHZRewardedAdVideos{
    
    // gunluk oyun limiti dolmussa zamani al ve kaydet 24 saat sonra video izlenebilecek
//    if([RWGameData sharedGameData].rewardedGameCount >= [RWGameData sharedGameData].dailyLimit*[RWGameData sharedGameData].limitStep){
//        [self requestUTCTimeFromServer];
//        
//        return;
//    }else {
    
        dispatch_async(dispatch_get_main_queue(), ^{
            //Incentivized Ads Delegate
            [HZIncentivizedAd setDelegate:self];
            
            // Later, such as after a level is completed
            [HZIncentivizedAd show];
            
            // As early as possible, and after showing a video, call fetch
            [HZIncentivizedAd fetch];
            
        });
//    }

}

- (void) showCustomAlert:(CustomAlertView *) alertView {
    

        [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            alertView.alpha = 1.0f;
        } completion:NULL];
        
        JNWSpringAnimation *scale = [JNWSpringAnimation animationWithKeyPath:@"transform.scale"];
        scale.damping = 32;
        scale.stiffness = 450;
        scale.mass = 2.4;
        scale.fromValue = @(0);
        scale.toValue = @(1.0);
        
        [alertView.layer addAnimation:scale forKey:scale.keyPath];
        alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
        
        [self.view addSubview:alertView];
        [self.view bringSubviewToFront:alertView];
    
}

- (void) didCompleteAdWithTag: (NSString *)tag {
    // When an incentivized video ad has been fully watched
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"game_action"     // Event category (required)
                                                                          action:@"heyzap_advideos"  // Event action (required)
                                                                           label:@"rewarded_video_watched"          // Event label
                                                                           value:nil] build]];    // Event value
        
        // Video izleyince 20 oyun kazaniyor.
        [RWGameData sharedGameData].multiRemainingGameCount +=[RWGameData sharedGameData].limitStep;
        if ([RWGameData sharedGameData].multiRemainingGameCount > 0) {
            self.active = NO;
            [self._tableView reloadData];
        }
        
        [RWGameData sharedGameData].rewardedGameCount += [RWGameData sharedGameData].limitStep;
        
        [[RWGameData sharedGameData] save];
    });
    
}

- (void) didFailToCompleteAdWithTag: (NSString *)tag {
    // When user fails to watch the incentivized video all the way through
    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"game_action"     // Event category (required)
                                                                      action:@"heyzap_advideos"  // Event action (required)
                                                                       label:@"rewarded_video_not_watched"          // Event label
                                                                       value:nil] build]];    // Event value
    

}

-(void) hideAfterDelay{
    // Do something...
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.processed) {
        return;
    }
    
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];

    switch ([indexPath row]) {
        case 0:{
            
            //Sadece oyun sayisi 0 lanmis ise kredi kazanabilir
//            if([RWGameData sharedGameData].multiRemainingGameCount <= 0 )
//            {
//                if (![RWGameData sharedGameData].limitExceeded) {
                    [self showHZRewardedAdVideos];
//                }
//                else{
//                    NSString *message = [NSString stringWithFormat:JALocalizedString(@"KEY44", @""),[self remainingTime]];
//                    CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
//                                                                          withTitle:JALocalizedString(@"KEY13", @"")
//                                                                        withMessage:message withModalType:ModalTypeInfo];
//                    alert.tag = 30;
//                    [self showCustomAlert:alert];
//                }
                
//            }else {
//                CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
//                                                                      withTitle:JALocalizedString(@"KEY13", @"")
//                                                                    withMessage:JALocalizedString(@"KEY43", @"") withModalType:ModalTypeInfo];
//                alert.tag = 20;
//                [self showCustomAlert:alert];
//            }
        }
            break;
        case 1:{
            if (![RWGameData sharedGameData].IAPAd) {
                
                [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [self performSelector:@selector(hideAfterDelay) withObject:self afterDelay:3.3];
                
                self.processed = YES;
                [PFPurchase buyProduct:@"com.magiclampgames.easynumbersgame.noadds" block:^(NSError *error) {
                    if (!error) {
                        // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
                        [RWGameData sharedGameData].IAPAd = YES;
                        [FBSDKAppEvents logPurchase:1.99 currency:@"USD"];
                        [[RWGameData sharedGameData] save];
                    }
                    self.processed = NO;
                }];
                
            }
        }
            break;
        case 2:{
            
            self.processed = YES;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self performSelector:@selector(hideAfterDelay) withObject:self afterDelay:3.3];
            
            [PFPurchase buyProduct:@"com.magiclampgames.easynumbersgame.gamepacket1" block:^(NSError *error) {
                if (!error) {
                    // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
                    [RWGameData sharedGameData].IAPPacket1 = YES;
                    [RWGameData sharedGameData].multiRemainingGameCount += 1000;
                    [[RWGameData sharedGameData] save];
                    [FBSDKAppEvents logPurchase:0.99 currency:@"USD"];
                }
                self.processed = NO;
            }];
        }
            break;
        case 3:{
           
            self.processed = YES;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self performSelector:@selector(hideAfterDelay) withObject:self afterDelay:3.3];
            
            [PFPurchase buyProduct:@"com.magiclampgames.easynumbersgame.gamepacket2" block:^(NSError *error) {
                if (!error) {
                    // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
                    [RWGameData sharedGameData].IAPPacket2 = YES;
                    [RWGameData sharedGameData].multiRemainingGameCount += 3000;
                    [FBSDKAppEvents logPurchase:1.99 currency:@"USD"];
                    [[RWGameData sharedGameData] save];
                }
                self.processed = NO;
            }];
            

        }
            break;
        case 4:{

            self.processed = YES;
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self performSelector:@selector(hideAfterDelay) withObject:self afterDelay:3.3];
            
            [PFPurchase buyProduct:@"com.magiclampgames.easynumbersgame.gamepacket3" block:^(NSError *error) {
                if (!error) {
                    // Run UI logic that informs user the product has been purchased, such as displaying an alert view.
                    [RWGameData sharedGameData].IAPPacket3 = YES;
                    [RWGameData sharedGameData].multiRemainingGameCount += 5000;
                    [FBSDKAppEvents logPurchase:2.99 currency:@"USD"];
                    [[RWGameData sharedGameData] save];
                }
                self.processed = NO;
            }];
        }
            break;
        default:
            break;
    }
    

}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue trgiggered");
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
