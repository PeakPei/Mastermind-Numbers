//
//  SettingsViewController.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 10/11/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "SettingsViewController.h"
#import "PlayersViewController.h"
#import "RWGameData.h"
#import "JNWSpringAnimation.h"
#import "CustomAlertView.h"
#import "SoundManager.h"
#import "GameRulesViewController.h"

@interface SettingsViewController ()

@end

#define SOUND_BUTTON_IPHONE (IS_IPHONE_6P ? CGRectMake(175, 30, 35, 35) :(IS_IPHONE_6 ? CGRectMake(175, 30, 35, 35) : IS_IPHONE_5 ? CGRectMake(160, 30, 32, 32) : CGRectMake(160, 30, 30, 30)))
#define SOUND_BUTTON_POSITION IS_IPHONE ? SOUND_BUTTON_IPHONE : CGRectMake(320, 62, 62, 62)


@implementation SettingsViewController
@synthesize themaSegmented,resetButton,AIPlayersButton,gameRulesButton,appDelegate;


-(UILabel*) addBorderToLabel:(UILabel*)label{
    label.layer.shadowColor = [[UIColor blackColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    label.layer.shadowRadius = 0.0;
    label.layer.shadowOpacity = 0.6;
    label.layer.masksToBounds = NO;
    label.layer.shouldRasterize = YES;

    return label;
}

-(UILabel*) addBorderToLabel2:(UILabel*)label{
    label.layer.shadowColor = [[UIColor whiteColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    label.layer.shadowRadius = 1.5;
    label.layer.shadowOpacity = 0.6;
    label.layer.masksToBounds = NO;
    label.layer.shouldRasterize = YES;
    
    
    return label;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};

    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:FONT_GOODFISH size:23]}];
    
    [self changeBackground];
    
    CGFloat size = 21;
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        size = 17;
    }
    
    self.title = JALocalizedString(@"KEY48", @"");
    
    [self.gameRulesLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self addBorderToLabel:self.gameRulesLabel];
    [self.gameRulesLabel setTextColor:[UIColor whiteColor]];
    [self.AIPlayersLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.AIPlayersLabel setTextColor:[UIColor whiteColor]];
    [self.developLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.developLabel setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.developLabel];
    [self.companyLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.companyLabel setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.companyLabel];
    [self.companyUrlLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.companyUrlLabel setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.companyUrlLabel];
    [self.aiPlayerLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.aiPlayerLabel setText:JALocalizedString(@"KEY49", @"")];
    [self.aiPlayerLabel setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.aiPlayerLabel];
    [self.numberDigitsLabel setText:JALocalizedString(@"KEY53", @"")];
    [self.numberDigitsLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.numberDigitsLabel setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.numberDigitsLabel];
    [self.resetTraining setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.resetTraining setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.resetTraining];
    [self.themesLabel setText:JALocalizedString(@"KEY61", @"")];
    [self.themesLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.themesLabel setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.themesLabel];
    
    [self.enableDragDropLabel setText:JALocalizedString(@"KEY113", @"")];
    [self.enableDragDropLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
    [self.enableDragDropLabel setTextColor:[UIColor whiteColor]];
    [self addBorderToLabel:self.enableDragDropLabel];
    
//    [themaSegmented selectedSegmentIndex].te

    
    
    BOOL on = YES;
    if ([RWGameData sharedGameData].showAIPlayers) {
        on = YES;
    }else{
        on = NO;
    }
    [self.aiplayersSwitch setOn:on animated:YES];

    BOOL onDrag = YES;
    if (appDelegate.enableDragAndDrop) {
        onDrag = YES;
    }else{
        onDrag = NO;
    }
    [self.enableDragDrop setOn:onDrag animated:YES];

    //255.199.48
    
    if ([RWGameData sharedGameData].threeDigitGame) {
        [self.numberDigitsSegmented setSelectedSegmentIndex:0];
    }else{
        [self.numberDigitsSegmented setSelectedSegmentIndex:1];
    }

    if (!appDelegate.musicOn) {
        self.musicBan.hidden = NO;
        self.musicButton.hidden = YES;
    }else{
        self.musicBan.hidden = YES;
        self.musicButton.hidden = NO;
    }
    
    if (!appDelegate.soundOn) {
        self.soundBan.hidden = NO;
        self.soundButton.hidden = YES;
    }else{
        self.soundBan.hidden = YES;
        self.soundButton.hidden = NO;
    }

    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar sizeThatFits:self.view.frame.size];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)back {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) changeBackground{
    
    
    CGFloat size = 17;
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        size = 15;
    }
    
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
            
            self.aiplayersSwitch.onTintColor = [UIColor colorWithR:254 G:199 B:58 A:1];
            self.enableDragDrop.onTintColor = [UIColor colorWithR:254 G:199 B:58 A:1];
            [self.numberDigitsSegmented setTintColor:[UIColor whiteColor]];
            [self.themaSegmented setTintColor:[UIColor whiteColor]];

//            [self.themaSegmented setTitle:JALocalizedString(@"KEY104", @"") forSegmentAtIndex:0];
//            [self.themaSegmented setTitle:JALocalizedString(@"KEY105", @"") forSegmentAtIndex:1];
//            [self.themaSegmented setTitle:JALocalizedString(@"KEY106", @"") forSegmentAtIndex:2];
            [self.themaSegmented setSelectedSegmentIndex:0];

            
            [self.resetButton setTitle:JALocalizedString(@"KEY59", @"") forState:UIControlStateNormal];
            [self.resetButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.resetButton setTitleColor:[UIColor colorWithR:1 G:47 B:74 A:1] forState:UIControlStateNormal];
            [self.resetButton setBackgroundImage:[UIImage imageNamed:@"bgSettings2"] forState:UIControlStateNormal];
            
            [self.AIPlayersButton setTitle:JALocalizedString(@"KEY47", @"") forState:UIControlStateNormal];
            [self.AIPlayersButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.AIPlayersButton setTitleColor:[UIColor colorWithR:1 G:47 B:74 A:1] forState:UIControlStateNormal];
            [self.AIPlayersButton setBackgroundImage:[UIImage imageNamed:@"bgSettings2"] forState:UIControlStateNormal];
            
            [self.gameRulesButton setTitle:JALocalizedString(@"KEY52", @"") forState:UIControlStateNormal];
            [self.gameRulesButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.gameRulesButton setTitleColor:[UIColor colorWithR:1 G:47 B:74 A:1] forState:UIControlStateNormal];
            [self.gameRulesButton setBackgroundImage:[UIImage imageNamed:@"bgSettings2"] forState:UIControlStateNormal];

            [self addBorderToLabel2:self.resetButton.titleLabel];
            [self addBorderToLabel2:self.AIPlayersButton.titleLabel];
            [self addBorderToLabel2:self.gameRulesButton.titleLabel];
        }
            break;
        case 1:{
            buttonImage = [UIImage imageNamed:@"Backbtn2.png"];
            if (IS_IPAD_PRO) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"yellowPRO"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgYellow"]]];
            }
            self.aiplayersSwitch.onTintColor = [UIColor colorWithR:24 G:170 B:237 A:1];
            self.enableDragDrop.onTintColor = [UIColor colorWithR:24 G:170 B:237 A:1];
            [self.numberDigitsSegmented setTintColor:[UIColor whiteColor]];
            [self.themaSegmented setTintColor:[UIColor whiteColor]];

//            [self.themaSegmented setTitle:JALocalizedString(@"KEY104", @"") forSegmentAtIndex:0];
//            [self.themaSegmented setTitle:JALocalizedString(@"KEY105", @"") forSegmentAtIndex:1];
//            [self.themaSegmented setTitle:JALocalizedString(@"KEY106", @"") forSegmentAtIndex:2];
            [self.themaSegmented setSelectedSegmentIndex:1];
            
            [self.resetButton setTitle:JALocalizedString(@"KEY59", @"") forState:UIControlStateNormal];
            [self.resetButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.resetButton setBackgroundImage:[UIImage imageNamed:@"bgSettings"] forState:UIControlStateNormal];
            [self.resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self.AIPlayersButton setTitle:JALocalizedString(@"KEY47", @"") forState:UIControlStateNormal];
            [self.AIPlayersButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.AIPlayersButton setBackgroundImage:[UIImage imageNamed:@"bgSettings"] forState:UIControlStateNormal];
            [self.AIPlayersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self.gameRulesButton setTitle:JALocalizedString(@"KEY52", @"") forState:UIControlStateNormal];
            [self.gameRulesButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.gameRulesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.gameRulesButton setBackgroundImage:[UIImage imageNamed:@"bgSettings"] forState:UIControlStateNormal];
            
            [self addBorderToLabel:self.resetButton.titleLabel];
            [self addBorderToLabel:self.AIPlayersButton.titleLabel];
            [self addBorderToLabel:self.gameRulesButton.titleLabel];

            
        }
            break;
        case 2:{
            buttonImage = [UIImage imageNamed:@"Backbtn2.png"];
            if (IS_IPAD_PRO) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pinkPRO"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgPink"]]];
            }
            self.aiplayersSwitch.onTintColor = [UIColor colorWithR:24 G:170 B:237 A:1];
            self.enableDragDrop.onTintColor = [UIColor colorWithR:24 G:170 B:237 A:1];
            [self.numberDigitsSegmented setTintColor:[UIColor whiteColor]];
//            [self.themaSegmented setTitle:JALocalizedString(@"KEY104", @"") forSegmentAtIndex:0];
//            [self.themaSegmented setTitle:JALocalizedString(@"KEY105", @"") forSegmentAtIndex:1];
//            [self.themaSegmented setTitle:JALocalizedString(@"KEY106", @"") forSegmentAtIndex:2];
            [self.themaSegmented setTintColor:[UIColor whiteColor]];

            [self.themaSegmented setSelectedSegmentIndex:2];
            
            [self.resetButton setTitle:JALocalizedString(@"KEY59", @"") forState:UIControlStateNormal];
            [self.resetButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.resetButton setBackgroundImage:[UIImage imageNamed:@"bgSettings"] forState:UIControlStateNormal];
            [self.resetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self.AIPlayersButton setTitle:JALocalizedString(@"KEY47", @"") forState:UIControlStateNormal];
            [self.AIPlayersButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.AIPlayersButton setBackgroundImage:[UIImage imageNamed:@"bgSettings"] forState:UIControlStateNormal];
            [self.AIPlayersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [self.gameRulesButton setTitle:JALocalizedString(@"KEY52", @"") forState:UIControlStateNormal];
            [self.gameRulesButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.gameRulesButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.gameRulesButton setBackgroundImage:[UIImage imageNamed:@"bgSettings"] forState:UIControlStateNormal];

            [self addBorderToLabel:self.resetButton.titleLabel];
            [self addBorderToLabel:self.AIPlayersButton.titleLabel];
            [self addBorderToLabel:self.gameRulesButton.titleLabel];
        }
            break;
            
        default:{
            buttonImage = [UIImage imageNamed:@"backbtn.png"];
            if (IS_IPAD_PRO) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bluePRO"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
            }
            self.aiplayersSwitch.onTintColor = [UIColor colorWithR:254 G:199 B:58 A:1];
            self.enableDragDrop.onTintColor = [UIColor colorWithR:254 G:199 B:58 A:1];
            [self.numberDigitsSegmented setTintColor:[UIColor whiteColor]];
            [self.themaSegmented setTintColor:[UIColor whiteColor]];

            [self.themaSegmented setSelectedSegmentIndex:0];
            
            [self.resetButton setTitle:JALocalizedString(@"KEY59", @"") forState:UIControlStateNormal];
            [self.resetButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.resetButton setBackgroundImage:[UIImage imageNamed:@"bgSettings2"] forState:UIControlStateNormal];
            [self.resetButton setTitleColor:[UIColor colorWithR:1 G:55 B:88 A:1] forState:UIControlStateNormal];
            
            [self.AIPlayersButton setTitle:JALocalizedString(@"KEY47", @"") forState:UIControlStateNormal];
            [self.AIPlayersButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.AIPlayersButton setBackgroundImage:[UIImage imageNamed:@"bgSettings2"] forState:UIControlStateNormal];
            [self.AIPlayersButton setTitleColor:[UIColor colorWithR:1 G:55 B:88 A:1] forState:UIControlStateNormal];
            
            [self.gameRulesButton setTitle:JALocalizedString(@"KEY52", @"") forState:UIControlStateNormal];
            [self.gameRulesButton.titleLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
            [self.gameRulesButton setTitleColor:[UIColor colorWithR:1 G:55 B:88 A:1] forState:UIControlStateNormal];
            [self.gameRulesButton setBackgroundImage:[UIImage imageNamed:@"bgSettings2"] forState:UIControlStateNormal];
            
            [self addBorderToLabel2:self.resetButton.titleLabel];
            [self addBorderToLabel2:self.AIPlayersButton.titleLabel];
            [self addBorderToLabel2:self.gameRulesButton.titleLabel];

        }
            break;
    }


    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionMusicSwitch:(id)sender {
    
}
- (IBAction)actionSoundSwitch:(id)sender {
}
- (IBAction)actionNumberDigits:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    switch (self.numberDigitsSegmented.selectedSegmentIndex)
    {
        case 0:{
            [RWGameData sharedGameData].threeDigitGame = YES;
            [RWGameData sharedGameData].fourDigitGame = NO;
            [[RWGameData sharedGameData] save];
        }
            break;
        case 1:{
            [RWGameData sharedGameData].fourDigitGame = YES;
            [RWGameData sharedGameData].threeDigitGame = NO;
            [[RWGameData sharedGameData] save];
        }
            break;
        default: 
            break; 
    }
    
    
}

- (void) showCustomAlert:(CustomAlertView *) alertView {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        
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
    });
    [self.view addSubview:alertView];
    [self.view bringSubviewToFront:alertView];
    
    
}

- (IBAction)actionResetTraining:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [[RWGameData sharedGameData] resetGamePower];
    
    CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                          withTitle:JALocalizedString(@"KEY13", @"")
                                                        withMessage:JALocalizedString(@"KEY60", @"")
                                                      withModalType:ModalTypeInfo];

    [self showCustomAlert:alert];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (IBAction)actionThemaChanged:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    switch (self.themaSegmented.selectedSegmentIndex)
    {
        case 0:{
            [RWGameData sharedGameData].thema = 0;
            [self changeBackground];
            [[RWGameData sharedGameData] save];
        }
            break;
        case 1:{
            [RWGameData sharedGameData].thema = 1;
            [self changeBackground];
            [[RWGameData sharedGameData] save];
        }
            break;
        case 2:{
            [RWGameData sharedGameData].thema = 2;
            [self changeBackground];
            [[RWGameData sharedGameData] save];
        }
            break;

        default:
            break;
    }
}

- (IBAction)actionGameRules:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    GameRulesViewController *rules = (GameRulesViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GameRulesViewController"];
    if (IS_IPAD) {
        rules.modalPresentationStyle = UIModalPresentationFormSheet;
    }else{
        rules.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:rules animated:YES completion: nil];

    
}

- (IBAction)emailAction:(id)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:@""];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"info@magiclampgames.com", nil];
        [mailer setToRecipients:toRecipients];
        
        //        UIImage *myImage = [UIImage imageNamed:@"mobiletuts-logo.png"];
        //        NSData *imageData = UIImagePNGRepresentation(myImage);
        //        [mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
        NSString *emailBody = @"";
        [mailer setMessageBody:emailBody isHTML:NO];
        
        if (IS_IPAD) {
            mailer.modalPresentationStyle = UIModalPresentationPageSheet;
        }
        [self presentViewController:mailer animated:YES completion:nil];
        
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failure"
                                                        message:@"Your device doesn't support the composer sheet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)actionMusic:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [[SoundManager sharedManager] stopMusic];
    self.musicButton.hidden = YES;
    self.musicBan.hidden = NO;
    appDelegate.musicOn = NO;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"musicOn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)actionSound:(id)sender {
    
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    self.soundButton.hidden = YES;
    self.soundBan.hidden = NO;
    appDelegate.soundOn = NO;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"soundOn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



- (IBAction)showAIPlayers:(id)sender {
    
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];

    
    [RWGameData sharedGameData].showAIPlayers = self.aiplayersSwitch.on ? YES : NO;
    [[RWGameData sharedGameData] save];
}

- (IBAction)actionAIPlayers:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    PlayersViewController *players = (PlayersViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"PlayersViewController"];
    if (IS_IPAD) {
        players.modalPresentationStyle = UIModalPresentationFormSheet;
    }else{
        players.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    [self presentViewController:players animated:YES completion: nil];
}

- (IBAction)actionRules:(id)sender {
    

    
}



- (IBAction)actionTips:(id)sender {

}


- (IBAction)actionSoundBan:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    self.soundButton.hidden = NO;
    self.soundBan.hidden = YES;
    appDelegate.soundOn = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"soundOn"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}
- (IBAction)actionMusicBan:(id)sender {
    [[SoundManager sharedManager] setMusicVolume:1.0];
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];    
    [[SoundManager sharedManager] playMusic:@"NumbersGameMusic.wav" looping:YES];

    
    self.musicButton.hidden = NO;
    self.musicBan.hidden = YES;
    appDelegate.musicOn = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"musicOn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (IBAction)actionEnableDragDrop:(id)sender {
    
    appDelegate.enableDragAndDrop = self.enableDragDrop.on ? YES : NO;
    
    [[NSUserDefaults standardUserDefaults] setBool:appDelegate.enableDragAndDrop forKey:@"enableDragDrop"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
    
}
@end
