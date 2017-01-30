//
//  MenuViewViewController.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/28/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "MenuViewController.h"
#import <Parse/Parse.h>
#import "MenuCarousel.h"
#import <Google/Analytics.h>
#import "RWGameData.h"
#import "JNWSpringAnimation.h"
#import "CustomButton.h"
#import "SoundManager.h"
#import "HowToPlayViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#define MID_X CGRectGetMidX(self.view.frame)
#define MID_Y CGRectGetMidY(self.view.frame)

#define SOUND_BUTTON_IPHONE (IS_IPHONE_6P ? CGRectMake(347, 30, 42, 42) :(IS_IPHONE_6 ? CGRectMake(327, 28, 42, 42) : IS_IPHONE_5 ? CGRectMake(270, 30, 36, 35) : CGRectMake(270, 30, 35, 35)))
#define SOUND_BUTTON_POSITION IS_IPHONE ? SOUND_BUTTON_IPHONE : (IS_IPAD_PRO ? CGRectMake(900, 62, 62, 62) : CGRectMake(690, 62, 62, 62))

#define APPNAME_IPHONE (IS_IPHONE_6P ? CGRectMake(145, 132, 125, 30) :(IS_IPHONE_6 ? CGRectMake(125, 117, 125, 30) : IS_IPHONE_5 ? CGRectMake(107, 120, 107, 27) : CGRectMake(113, 102, 95, 25)))
#define APPNAME_IPHONE_POSITION IS_IPHONE ? APPNAME_IPHONE : (IS_IPAD_PRO ? CGRectMake(400, 292, 210, 49) : CGRectMake(280, 212, 210, 49))

#define APPNAME_IPHONE2 (IS_IPHONE_6P ? CGRectMake(96, 90, 230, 34) :(IS_IPHONE_6 ? CGRectMake(76, 75, 230, 34) : IS_IPHONE_5 ? CGRectMake(65, 82, 190, 31) : CGRectMake(71, 67, 178, 29)))
#define APPNAME_IPHONE_POSITION2 IS_IPHONE ? APPNAME_IPHONE2 : (IS_IPAD_PRO ? CGRectMake(320, 228, 370, 55) : CGRectMake(200, 148, 370, 55))

#define MENU_ITEM_WIDTH_IPHONE (IS_IPHONE_6P ? 308 :(IS_IPHONE_6 ? 271 : IS_IPHONE_5 ? 211 : 207))
#define MENU_ITEM_WIDTH IS_IPHONE ? MENU_ITEM_WIDTH_IPHONE : (IS_IPAD_PRO ? 650 : 400)

#define MENU_ITEM_HEIGHT_IPHONE (IS_IPHONE_6P ? 60 :(IS_IPHONE_6 ? 60 : IS_IPHONE_5 ? 50 : 45))
#define MENU_ITEM_HEIGHT IS_IPHONE ? MENU_ITEM_HEIGHT_IPHONE : 80

#define MENU_ITEM_X_IPHONE (IS_IPHONE_6P ? MID_X-153 :(IS_IPHONE_6 ? MID_X-134 : IS_IPHONE_5 ? MID_X-106 : MID_X-105))
#define MENU_ITEM_X IS_IPHONE ?  MENU_ITEM_X_IPHONE : (IS_IPAD_PRO ? MID_X-325 : MID_X-200)

#define CARAUSEL_Y_IPHONE (IS_IPHONE_6P ? 190 :(IS_IPHONE_6 ? 165 : IS_IPHONE_5 ? 160 : 135))
#define CARAUSEL_Y IS_IPHONE ? CARAUSEL_Y_IPHONE: (IS_IPAD_PRO ? 420 : 280)

#define VERSION_LABEL_IPHONE (IS_IPHONE_6P ? CGRectMake(120, 650, 210, 25) :(IS_IPHONE_6 ? CGRectMake(105, 590, 210, 25) : IS_IPHONE_5 ? CGRectMake(88, 495, 210, 25) : CGRectMake(88, 430, 210, 25)))
#define VERSION_LABEL IS_IPHONE ? VERSION_LABEL_IPHONE : (IS_IPAD_PRO ? CGRectMake(425, 1240, 210, 25) : CGRectMake(280, 905, 210, 25))


@interface MenuViewController (){
    UIButton *howToPlayButton;
    UIButton *optionsButton;
    UIButton *topPlayersButton;
    UIImageView *backgroundView;
    UILabel *versionLabel;
    BOOL isGame;
    BOOL isExecuted;
    MenuCarousel *menuCarousel;
}
@end

@implementation MenuViewController

@synthesize appDelegate,appNameImageView,appNameImageView2,bannerMain;


-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}




-(void)settingsClicked:(id)sender{

    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    isGame = NO;
    
    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                                      action:@"button_press"  // Event action (required)
                                                                       label:@"settings"          // Event label
                                                                       value:nil] build]];    // Event value
    
    
    [appDelegate.tracker set:kGAIScreenName value:@"Settings Screen"];
    [appDelegate.tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    
    [self performSegueWithIdentifier:@"menuSettings" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    if ([RWGameData sharedGameData].noAd == 99 || [[RWGameData sharedGameData] IAPAd]){
        
    }else {
        HZBannerAdOptions *options = [[HZBannerAdOptions alloc] init];
        [HZBannerAd placeBannerInView:self.view
                             position:HZBannerPositionBottom
                              options:options
                              success:^(HZBannerAd *banner) {
                                  
                                  self.bannerMain = banner;
                              }
         
                              failure:^(NSError *error) {
                                  NSLog(@"Error = %@",error);
                              }
         ];
    }
    
    [SoundManager sharedManager].allowsBackgroundMusic = YES;
    [[SoundManager sharedManager] prepareToPlay];
    
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [appDelegate.tracker set:kGAIScreenName value:@"Menu Screen"];
    [appDelegate.tracker send:[[GAIDictionaryBuilder createScreenView] build]];
    

    

    [[SoundManager sharedManager] setMusicVolume:0.5];
    [[SoundManager sharedManager] setSoundVolume:0.5];
    [[SoundManager sharedManager] playMusic:@"NumbersGameMusic.wav" looping:YES];

    
//    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/NumbersGameMusic.wav", [[NSBundle mainBundle] resourcePath]]];
//    
//    NSError *error;
//    appDelegate.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
//    appDelegate.audioPlayer.numberOfLoops = -1;
//    
//    if (!appDelegate.audioPlayer)
//        NSLog(@"Audio player failed");
//        else
//            [appDelegate.audioPlayer play];

    

//    PFUser *user = [PFUser user];
//    user.username = @"Alaattin Bedir";
//    user.password = @"186995";
//    user.email = @"alaattinbedir@hotmail.com";
//    
//    // other fields can be set if you want to save more information
//    user[@"phone"] = @"5055362405";
    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            // Hooray! Let them use the app now.
//        } else {
//            NSString *errorString = [error userInfo][@"error"];
//            // Show the errorString somewhere and let the user try again.
//            NSLog(@"%@",errorString);
//        }
//    }];
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
    backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            [backgroundView setImage:[UIImage imageNamed:@"background"]];
        }
            break;
        case 1:{
            [backgroundView setImage:[UIImage imageNamed:@"bgYellow"]];
        }
            break;
        case 2:{
            [backgroundView setImage:[UIImage imageNamed:@"bgPink"]];
        }
            break;
            
        default:{
            [backgroundView setImage:[UIImage imageNamed:@"background"]];
        }
            break;
    }
    

    
    [self.view addSubview:backgroundView];
   
    
    
    
    if (!_settingsButton) {
        _settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingsButton.hidden = NO;
        _settingsButton.frame = SOUND_BUTTON_POSITION;
        
        switch ([RWGameData sharedGameData].thema)
        {
            case 0:{
                [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
            }
                break;
            case 1:{
                [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings_blue.png"] forState:UIControlStateNormal];
            }
                break;
            case 2:{
                [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings_blue.png"] forState:UIControlStateNormal];
            }
                break;
                
            default:{
                [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
            }
                break;
        }
        
        [_settingsButton addTarget:self action:@selector(settingsClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_settingsButton];
    }
    
    
    appNameImageView2 = [[UIImageView alloc] initWithFrame:APPNAME_IPHONE_POSITION2];
    
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind.png"]];
        }
            break;
        case 1:{
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind2.png"]];
        }
            break;
        case 2:{
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind2.png"]];
        }
            break;
            
        default:{
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind.png"]];
        }
            break;
    }
    
    
    [self.view addSubview:appNameImageView2];
    
    appNameImageView = [[UIImageView alloc] initWithFrame:APPNAME_IPHONE_POSITION];
    
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            [appNameImageView setImage:[UIImage imageNamed:@"app_name.png"]];
        }
            break;
        case 1:{
            [appNameImageView setImage:[UIImage imageNamed:@"app_name_blue.png"]];
        }
            break;
        case 2:{
            [appNameImageView setImage:[UIImage imageNamed:@"app_name_blue.png"]];
        }
            break;
            
        default:{
            [appNameImageView setImage:[UIImage imageNamed:@"app_name.png"]];
        }
            break;
    }
    
    
    [self.view addSubview:appNameImageView];
    

    
    
    topPlayersButton = [[CustomButton alloc] initWithFrameForMenuItem:CGRectMake(MENU_ITEM_X, MID_Y + 25, MENU_ITEM_WIDTH, MENU_ITEM_HEIGHT)
                                                         withTitle:JALocalizedString(@"KEY12", @"")
                                                      withIconName:@"TopPlayers"
                                                          withFont:[UIFont fontWithName:FONT_GOODFISH size:25]
                                                         withColor:[UIColor whiteColor]
                                                           withImageX:20
                                                           withImageY:9];
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
        }
            break;
        case 1:{
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
        }
            break;
        case 2:{
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
        }
            break;
            
        default:{
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
        }
            break;
    }
    
    [topPlayersButton addTarget:self action:@selector(moveToTopPlayers) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:topPlayersButton];
    
    CGFloat options_y = 93;
    if (IS_IPHONE_5 ) {
        options_y = 84;
    }else if (IS_IPHONE_4_OR_LESS){
        options_y = 78;
    }else if(IS_IPAD){
        options_y = 113;
    }
    
    optionsButton = [[CustomButton alloc] initWithFrameForMenuItem:CGRectMake(MENU_ITEM_X, MID_Y+options_y, MENU_ITEM_WIDTH, MENU_ITEM_HEIGHT)
                                                           withTitle:JALocalizedString(@"KEY11", @"")
                                                        withIconName:@"Extras"
                                                            withFont:[UIFont fontWithName:FONT_GOODFISH size:25]
                                                           withColor:[UIColor whiteColor]
                                                          withImageX:15
                                                        withImageY:11];
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
        }
            break;
        case 1:{
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
        }
            break;
        case 2:{
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
        }
            break;
            
        default:{
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
        }
            break;
    }
    
    
    [optionsButton addTarget:self action:@selector(moveToOptions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:optionsButton];
    
    CGFloat howtoplay_y = 161;
    if (IS_IPHONE_5) {
        howtoplay_y = 143;
    }else if (IS_IPHONE_4_OR_LESS){
        howtoplay_y = 131;
    }else if(IS_IPAD){
        howtoplay_y = 201;
    }
    

    howToPlayButton = [[CustomButton alloc] initWithFrameForMenuItem:CGRectMake(MENU_ITEM_X, MID_Y+howtoplay_y, MENU_ITEM_WIDTH, MENU_ITEM_HEIGHT)
                                                           withTitle:JALocalizedString(@"KEY34", @"")
                                                        withIconName:@"HowtoPlay"
                                                            withFont:[UIFont fontWithName:FONT_GOODFISH size:25]
                                                           withColor:[UIColor whiteColor]
                                                          withImageX:15
                                                          withImageY:9];
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
        }
            break;
        case 1:{
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
        }
            break;
        case 2:{
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
        }
            break;
            
        default:{
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
        }
            break;
    }
    
    [howToPlayButton addTarget:self action:@selector(moveToHowToPlayGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:howToPlayButton];
    
    
    int size = 19;
    if (IS_IPHONE_5) {
        size = 15;
    }else if (IS_IPHONE_4_OR_LESS){
        size = 15;
    }else if(IS_IPAD){
        size = 20;
    }
    
    versionLabel = [[UILabel alloc]initWithFrame:VERSION_LABEL];
    [versionLabel setTextColor:[UIColor whiteColor]];
    NSString *shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
//    NSNumber *buildNumber = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    [versionLabel setText:[NSString stringWithFormat:@"%@ %@", @"Mastermind Numbers", shortVersion]];
    
    [versionLabel setFont:[UIFont fontWithName:FONT_GOODFISH size:size]];
//    [self.view addSubview:versionLabel];

//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    
//    CGFloat offset = 80;
//    if (IS_IPHONE_5) {
//        offset -= 10;
//    }else if (IS_IPHONE_4_OR_LESS){
//        offset -= 20;
//    }else if (IS_IPAD){
//        offset += 50;
//    }
//    
//    CGPoint bottomMiddle = CGPointMake(MID_X, CGRectGetMaxY(self.view.frame) - offset);
//    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
//    loginButton.center = bottomMiddle;
//    [self.view addSubview:loginButton];
    
}

-(void)didSelectItem:(int)index{
    switch (index) {
        case 0:{
            [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
            [[SoundManager sharedManager] stopMusic];
            [self moveToSinglePlayerGame];
        }
            break;

        case 1:{
            [self moveToMultiPlayerGame];
        }
            break;

        case 2:{
            [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
            [[SoundManager sharedManager] stopMusic];
            [self moveToTrainingGame];
        }
            break;

        default:
            break;
    }
}

-(void)viewWillAppear:(BOOL)animated{

    if ([RWGameData sharedGameData].noAd == 99 || [[RWGameData sharedGameData] IAPAd]){
        [self.bannerMain setHidden:YES];
        [self.bannerMain removeFromSuperview];
        self.bannerMain = nil;
    }
    
    if(appDelegate.musicOn){
        [[SoundManager sharedManager] playMusic:@"NumbersGameMusic.wav" looping:YES];
    }else{
        [[SoundManager sharedManager] stopMusic];
    }
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerInvited) name:LocalPlayerIsInvited object:nil];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [super viewWillAppear:animated];
    
    if (menuCarousel) {
        [menuCarousel removeFromSuperview];
    }
    
    CGFloat caruselHeight = 210;
    if (IS_IPHONE_5) {
        caruselHeight = 140;
    }else if (IS_IPHONE_4_OR_LESS){
        caruselHeight = 130;
    }else if (IS_IPAD_PRO){
        caruselHeight = 330;
    }
    
    NSArray  *menuList = [[NSArray alloc] initWithObjects:@"Singleplayer",@"Multiplayer",@"Training", nil];
    menuCarousel = [[MenuCarousel alloc]initWithFrame:CGRectMake(0, CARAUSEL_Y, self.view.frame.size.width, caruselHeight) withList:menuList];
    menuCarousel.menuDelegate = self;
    menuCarousel.tag = 42;
    [self.view addSubview:menuCarousel];
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            [backgroundView setImage:[UIImage imageNamed:@"background"]];
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
            [appNameImageView setImage:[UIImage imageNamed:@"app_name.png"]];
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind.png"]];
        }
            break;
        case 1:{
            [backgroundView setImage:[UIImage imageNamed:@"bgYellow"]];
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings_blue.png"] forState:UIControlStateNormal];
            [appNameImageView setImage:[UIImage imageNamed:@"app_name_blue.png"]];
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind2.png"]];
        }
            break;
        case 2:{
            [backgroundView setImage:[UIImage imageNamed:@"bgPink"]];
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings_blue.png"] forState:UIControlStateNormal];
            [appNameImageView setImage:[UIImage imageNamed:@"app_name_blue.png"]];
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind2.png"]];
        }
            break;
            
        default:
        {
            [backgroundView setImage:[UIImage imageNamed:@"background"]];
            [howToPlayButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            [optionsButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            [topPlayersButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            [_settingsButton setBackgroundImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
            [appNameImageView setImage:[UIImage imageNamed:@"app_name.png"]];
            [appNameImageView2 setImage:[UIImage imageNamed:@"mastermind.png"]];            
        }
            break;
    }

    
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalPlayerIsInvited object:nil];
    if (!isGame) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        [super viewWillDisappear:animated];
    }

}


- (void)playerInvited {


    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"game_action"     // Event category (required)
                                                          action:@"multi_game_started"  // Event action (required)
                                                           label:@"invite"          // Event label
                                                           value:nil] build]];    // Event value
    isExecuted = NO;

    [self moveToMultiPlayerGame];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)checkInternetConnection {
    
    if ([RWGameData sharedGameData].noAd == 99 || [RWGameData sharedGameData].IAPAd){
        return YES;
    }
    
    NetworkStatus networkStatus = [appDelegate.internetReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                              withTitle:JALocalizedString(@"KEY45", @"")
                                                            withMessage:JALocalizedString(@"KEY93", @"") withModalType:ModalTypeWarning];
        alert.tag = 20;
        [self showCustomAlert:alert];
        
        return NO;
    }
    
    return YES;
}

-(void) moveToSinglePlayerGame{
    
    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"singleplayer"          // Event label
                                                           value:nil] build]];    // Event value
    
    isGame = YES;
    GameViewController *gameViewController = (GameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
    gameViewController.gameModeType = GameModeSinglePlayer;
    gameViewController.appModeType = [RWGameData sharedGameData].threeDigitGame ? AppModeThreeDigits : AppModeFourDigits;
    
    [self.navigationController pushViewController:gameViewController animated:YES];
}

-(void) moveToTrainingGame{
    if ([self checkInternetConnection]) {
        [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                                          action:@"button_press"  // Event action (required)
                                                                           label:@"training"          // Event label
                                                                           value:nil] build]];    // Event value
        
        isGame = YES;
        GameViewController *gameViewController = (GameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
        gameViewController.gameModeType = GameModeTraining;
        gameViewController.appModeType = [RWGameData sharedGameData].threeDigitGame ? AppModeThreeDigits : AppModeFourDigits;
        [self.navigationController pushViewController:gameViewController animated:YES];
    }
}

-(void) moveToHowToPlayGame{
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];      
    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"howtoplay"          // Event label
                                                           value:nil] build]];    // Event value
    
    isGame = YES;
    [self performSegueWithIdentifier:@"menuHowto" sender:self];
//    HowToPlayViewController *howtoplayViewController = (HowToPlayViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"HowToPlayViewController"];
//
//    [self.navigationController pushViewController:howtoplayViewController animated:YES];
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
        
        [self.view addSubview:alertView];
        [self.view bringSubviewToFront:alertView];
        
    });
    
}

-(void) moveToMultiPlayerGame{

    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"multiplayer"          // Event label
                                                           value:nil] build]];    // Event value
    
    isGame = YES;
    
    
    if ([RWGameData sharedGameData].multiRemainingGameCount > 0) {
        [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
        [[SoundManager sharedManager] stopMusic];

        if(![self.navigationController.visibleViewController isKindOfClass:[MenuViewController class]]){
            if (!isExecuted) {
                UINavigationController *vc = (UINavigationController *)appDelegate.window.rootViewController;
                [vc popToRootViewControllerAnimated:YES];
                
                GameViewController *gameViewController = (GameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
                gameViewController.gameModeType = GameModeMultiPlayer;
                gameViewController.appModeType = [RWGameData sharedGameData].threeDigitGame ? AppModeThreeDigits : AppModeFourDigits;
                [self.navigationController pushViewController:gameViewController animated:YES];
                isExecuted = YES;
            }

            
        }else{
            
            GameViewController *gameViewController = (GameViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
            gameViewController.gameModeType = GameModeMultiPlayer;
            gameViewController.appModeType = [RWGameData sharedGameData].threeDigitGame ? AppModeThreeDigits : AppModeFourDigits;
            [self.navigationController pushViewController:gameViewController animated:YES];
        }
    }else{
        NSString *message = [NSString stringWithFormat:JALocalizedString(@"KEY38", @""),[RWGameData sharedGameData].limitStep];
        CustomAlertView *alert = [[CustomAlertView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                              withTitle:JALocalizedString(@"KEY13", @"")
                                                            withMessage:message withModalType:ModalTypeInfo];
        alert.tag = 20;
        [self showCustomAlert:alert];
    }
}

-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LocalPlayerIsInvited object:nil];
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
  
    [appDelegate.tracker set:kGAIScreenName value:@"Top Players Screen"];
    [appDelegate.tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = [[GameKitHelper sharedGameKitHelper] _leaderboardIdentifier];
    }
    else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

-(void) moveToOptions{
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    isGame = NO;

    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"extras"          // Event label
                                                           value:nil] build]];    // Event value
    

    [appDelegate.tracker set:kGAIScreenName value:@"Extras Screen"];
    [appDelegate.tracker send:[[GAIDictionaryBuilder createScreenView] build]];

    
    [self performSegueWithIdentifier:@"menuOptions" sender:self];
    
}

-(void) moveToTopPlayers{
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    isGame = NO;
    [appDelegate.tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"     // Event category (required)
                                                          action:@"button_press"  // Event action (required)
                                                           label:@"topplayers"          // Event label
                                                           value:nil] build]];    // Event value

    
    [self showLeaderboardAndAchievements:YES];
    NSLog(@"moveToHowtoPlay");
}



@end
