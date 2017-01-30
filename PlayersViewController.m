//
//  OptionsViewController.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/28/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "PlayersViewController.h"
#import "ComputerPlayer.h"
#import "RWGameData.h"
#import "SoundManager.h"

@interface PlayersViewController ()
@property (weak, nonatomic) IBOutlet UILabel *masterLabel;
@property (weak, nonatomic) IBOutlet UILabel *masterPowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *masterSwitch;
@property (weak, nonatomic) IBOutlet UILabel *randPowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *randSwitch;

@property (weak, nonatomic) IBOutlet UILabel *randLabel;
@property (weak, nonatomic) IBOutlet UILabel *luiLabel;
@property (weak, nonatomic) IBOutlet UILabel *luiPowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *luiSwitch;

@property (weak, nonatomic) IBOutlet UILabel *aliceLabel;
@property (weak, nonatomic) IBOutlet UILabel *alicePowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *aliceSwitch;
@property (weak, nonatomic) IBOutlet UILabel *jackLaabel;
@property (weak, nonatomic) IBOutlet UILabel *jackPowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *jackSwitch;

@property (weak, nonatomic) IBOutlet UILabel *marciaLabel;
@property (weak, nonatomic) IBOutlet UILabel *marciaPowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *marciaSwitch;

@property (weak, nonatomic) IBOutlet UILabel *sallyLabel;
@property (weak, nonatomic) IBOutlet UILabel *sallyPowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *sallySwitch;
@property (weak, nonatomic) IBOutlet UILabel *tanyaLabel;
@property (weak, nonatomic) IBOutlet UILabel *tanyaPowerLabel;
@property (weak, nonatomic) IBOutlet UISwitch *tanyaSwitch;
- (IBAction)submitClicked:(id)sender;

- (IBAction)masterSelected:(id)sender;
- (IBAction)randSelected:(id)sender;
- (IBAction)luiSelected:(id)sender;
- (IBAction)aliceSelected:(id)sender;
- (IBAction)jackSelected:(id)sender;
- (IBAction)marciaSelected:(id)sender;
- (IBAction)sallySelected:(id)sender;
- (IBAction)tanyaSelected:(id)sender;

@end

@implementation PlayersViewController

- (void)setSwitches {
    [_masterSwitch setOn:YES];
    [_randSwitch setOn:NO];
    [_luiSwitch setOn:NO];
    [_aliceSwitch setOn:NO];
    [_jackSwitch setOn:NO];
    [_marciaSwitch setOn:NO];
    [_sallySwitch setOn:NO];
    [_tanyaSwitch setOn:NO];
}

- (void)setSwitches2 {
    [_masterSwitch setOn:NO];
    [_randSwitch setOn:YES];
    [_luiSwitch setOn:NO];
    [_aliceSwitch setOn:NO];
    [_jackSwitch setOn:NO];
    [_marciaSwitch setOn:NO];
    [_sallySwitch setOn:NO];
    [_tanyaSwitch setOn:NO];
}

- (void)setSwitches3 {
    [_masterSwitch setOn:NO];
    [_randSwitch setOn:NO];
    [_luiSwitch setOn:YES];
    [_aliceSwitch setOn:NO];
    [_jackSwitch setOn:NO];
    [_marciaSwitch setOn:NO];
    [_sallySwitch setOn:NO];
    [_tanyaSwitch setOn:NO];
}

- (void)setSwitches4 {
    [_masterSwitch setOn:NO];
    [_randSwitch setOn:NO];
    [_luiSwitch setOn:NO];
    [_aliceSwitch setOn:YES];
    [_jackSwitch setOn:NO];
    [_marciaSwitch setOn:NO];
    [_sallySwitch setOn:NO];
    [_tanyaSwitch setOn:NO];
}

- (void)setSwitches5 {
    [_masterSwitch setOn:NO];
    [_randSwitch setOn:NO];
    [_luiSwitch setOn:NO];
    [_aliceSwitch setOn:NO];
    [_jackSwitch setOn:YES];
    [_marciaSwitch setOn:NO];
    [_sallySwitch setOn:NO];
    [_tanyaSwitch setOn:NO];
}

- (void)setSwitches6 {
    [_masterSwitch setOn:NO];
    [_randSwitch setOn:NO];
    [_luiSwitch setOn:NO];
    [_aliceSwitch setOn:NO];
    [_jackSwitch setOn:NO];
    [_marciaSwitch setOn:YES];
    [_sallySwitch setOn:NO];
    [_tanyaSwitch setOn:NO];
}

- (void)setSwitches7 {
    [_masterSwitch setOn:NO];
    [_randSwitch setOn:NO];
    [_luiSwitch setOn:NO];
    [_aliceSwitch setOn:NO];
    [_jackSwitch setOn:NO];
    [_marciaSwitch setOn:NO];
    [_sallySwitch setOn:YES];
    [_tanyaSwitch setOn:NO];
}

- (void)setSwitches8 {
    [_masterSwitch setOn:NO];
    [_randSwitch setOn:NO];
    [_luiSwitch setOn:NO];
    [_aliceSwitch setOn:NO];
    [_jackSwitch setOn:NO];
    [_marciaSwitch setOn:NO];
    [_sallySwitch setOn:NO];
    [_tanyaSwitch setOn:YES];
}

-(void)backClicked:(id)sender{
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};

    
    self.title = JALocalizedString(@"KEY47", @"");
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgBlueHD"]]];
            }else {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
            }
            
            [_masterSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_randSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_luiSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_aliceSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_jackSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_marciaSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_sallySwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_tanyaSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
        }
            break;
        case 1:{
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgYellowHD"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgYellow"]]];
            }
            [_masterSwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];
            [_randSwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];
            [_luiSwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];
            [_aliceSwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];
            [_jackSwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];
            [_marciaSwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];
            [_sallySwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];
            [_tanyaSwitch setOnTintColor:[UIColor colorWithR:24 G:170 B:237 A:1]];

        }
            break;
        case 2:{
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgPinkHD"]]];
            }else{
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgPink"]]];
            }
            [_masterSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_randSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_luiSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_aliceSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_jackSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_marciaSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_sallySwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_tanyaSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];

        }
            break;
            
        default:{
            
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgBlueHD"]]];
            }else {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
            }
            
            [_masterSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_randSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_luiSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_aliceSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_jackSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_marciaSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_sallySwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];
            [_tanyaSwitch setOnTintColor:[UIColor colorWithR:254 G:199 B:58 A:1]];

        }
            break;
    }

    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:FONT_GOODFISH size:23]}];
    
    
    UIImage *buttonImage = [UIImage imageNamed:@"backbtn.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = customBarItem;

    int size = 19;
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        size = 16;
    }
    
    self.headerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.headerLabel.text = JALocalizedString(@"KEY62", @"");
    self.headerLabel.textColor = [UIColor whiteColor];
    self.headerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.headerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.headerLabel.layer.shadowRadius = 0.0;
    self.headerLabel.layer.shadowOpacity = 0.6;
    self.headerLabel.layer.masksToBounds = NO;
    self.headerLabel.layer.shouldRasterize = YES;

    
    [self.submitButton setTitle:JALocalizedString(@"KEY36", @"") forState:UIControlStateNormal];
    [self.submitButton.titleLabel setFont:[UIFont fontWithName:FONT_ROBOTO size:size]];
    UIImage *image = nil;
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            image = [UIImage imageNamed:@"sendButton"];
        }
            break;
        case 1:{
            image = [UIImage imageNamed:@"setButton"];
        }
            break;
        case 2:{
            image = [UIImage imageNamed:@"sendButton"];
        }
            break;
        default:{
            image = [UIImage imageNamed:@"sendButton"];
        }
            break;
    }
    
    [self.submitButton setBackgroundImage:image forState:UIControlStateNormal];
    

    self.masterImage.contentMode = UIViewContentModeScaleAspectFit;

    
    if ([RWGameData sharedGameData].threeDigitGame) {
        self.masterPowerLabel.text = @"4.985";
    }else{
        self.masterPowerLabel.text = @"5.985";
    }
    self.masterPowerLabel.textColor = [UIColor whiteColor];
    self.masterPowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.masterPowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.masterPowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.masterPowerLabel.layer.shadowRadius = 0.0;
    self.masterPowerLabel.layer.shadowOpacity = 0.6;
    self.masterPowerLabel.layer.masksToBounds = NO;
    self.masterPowerLabel.layer.shouldRasterize = YES;

    self.masterLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.masterLabel.textColor = [UIColor whiteColor];
    self.masterLabel.text = @"Master";
    self.masterLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.masterLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.masterLabel.layer.shadowRadius = 0.0;
    self.masterLabel.layer.shadowOpacity = 0.6;
    self.masterLabel.layer.masksToBounds = NO;
    self.masterLabel.layer.shouldRasterize = YES;


    self.lucyImage.contentMode = UIViewContentModeScaleAspectFit;
    if ([RWGameData sharedGameData].threeDigitGame) {
        self.randPowerLabel.text = @"5.117";
    }else{
        self.randPowerLabel.text = @"6.117";
    }
    self.randPowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.randPowerLabel.textColor = [UIColor whiteColor];
    self.randPowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.randPowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.randPowerLabel.layer.shadowRadius = 0.0;
    self.randPowerLabel.layer.shadowOpacity = 0.6;
    self.randPowerLabel.layer.masksToBounds = NO;
    self.randPowerLabel.layer.shouldRasterize = YES;

    self.randLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.randLabel.textColor = [UIColor whiteColor];
    self.randLabel.text = @"Lucy";
    self.randLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.randLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.randLabel.layer.shadowRadius = 0.0;
    self.randLabel.layer.shadowOpacity = 0.6;
    self.randLabel.layer.masksToBounds = NO;
    self.randLabel.layer.shouldRasterize = YES;

    if ([RWGameData sharedGameData].threeDigitGame) {
        self.luiPowerLabel.text = @"6.213";
    }else{
        self.luiPowerLabel.text = @"7.213";
    }
    self.luiPowerLabel.textColor = [UIColor whiteColor];
    self.luiPowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.luiPowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.luiPowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.luiPowerLabel.layer.shadowRadius = 0.0;
    self.luiPowerLabel.layer.shadowOpacity = 0.6;
    self.luiPowerLabel.layer.masksToBounds = NO;
    self.luiPowerLabel.layer.shouldRasterize = YES;

    self.luiLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.luiLabel.textColor = [UIColor whiteColor];
    self.luiLabel.text = @"Maze";
    self.luiLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.luiLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.luiLabel.layer.shadowRadius = 0.0;
    self.luiLabel.layer.shadowOpacity = 0.6;
    self.luiLabel.layer.masksToBounds = NO;
    self.luiLabel.layer.shouldRasterize = YES;

    
    if ([RWGameData sharedGameData].threeDigitGame) {
        self.alicePowerLabel.text = @"7.189";
    }else{
        self.alicePowerLabel.text = @"8.189";
    }
    self.alicePowerLabel.textColor = [UIColor whiteColor];
    self.alicePowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.alicePowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.alicePowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.alicePowerLabel.layer.shadowRadius = 0.0;
    self.alicePowerLabel.layer.shadowOpacity = 0.6;
    self.alicePowerLabel.layer.masksToBounds = NO;
    self.alicePowerLabel.layer.shouldRasterize = YES;

    self.aliceLabel.textColor = [UIColor whiteColor];
    self.aliceLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.aliceLabel.text = @"Aveline";
    self.aliceLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.aliceLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.aliceLabel.layer.shadowRadius = 0.0;
    self.aliceLabel.layer.shadowOpacity = 0.6;
    self.aliceLabel.layer.masksToBounds = NO;
    self.aliceLabel.layer.shouldRasterize = YES;

    
    if ([RWGameData sharedGameData].threeDigitGame) {
        self.jackPowerLabel.text = @"9.183";
    }else{
        self.jackPowerLabel.text = @"10.183";
    }
    self.jackPowerLabel.textColor = [UIColor whiteColor];
    self.jackPowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.jackPowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.jackPowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.jackPowerLabel.layer.shadowRadius = 0.0;
    self.jackPowerLabel.layer.shadowOpacity = 0.6;
    self.jackPowerLabel.layer.masksToBounds = NO;
    self.jackPowerLabel.layer.shouldRasterize = YES;

    self.jackLaabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.jackLaabel.textColor = [UIColor whiteColor];
    self.jackLaabel.text = @"Vincent";
    self.jackLaabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.jackLaabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.jackLaabel.layer.shadowRadius = 0.0;
    self.jackLaabel.layer.shadowOpacity = 0.6;
    self.jackLaabel.layer.masksToBounds = NO;
    self.jackLaabel.layer.shouldRasterize = YES;

    if ([RWGameData sharedGameData].threeDigitGame) {
        self.marciaPowerLabel.text = @"11.134";
    }else{
        self.marciaPowerLabel.text = @"12.134";
    }
    self.marciaPowerLabel.textColor = [UIColor whiteColor];
    self.marciaPowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.marciaPowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.marciaPowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.marciaPowerLabel.layer.shadowRadius = 0.0;
    self.marciaPowerLabel.layer.shadowOpacity = 0.6;
    self.marciaPowerLabel.layer.masksToBounds = NO;
    self.marciaPowerLabel.layer.shouldRasterize = YES;

    self.marciaLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.marciaLabel.textColor = [UIColor whiteColor];
    self.marciaLabel.text = @"Elina";
    self.marciaLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.marciaLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.marciaLabel.layer.shadowRadius = 0.0;
    self.marciaLabel.layer.shadowOpacity = 0.6;
    self.marciaLabel.layer.masksToBounds = NO;
    self.marciaLabel.layer.shouldRasterize = YES;

    if ([RWGameData sharedGameData].threeDigitGame) {
        self.sallyPowerLabel.text = @"13.104";
    }else{
        self.sallyPowerLabel.text = @"14.104";
    }
    self.sallyPowerLabel.textColor = [UIColor whiteColor];
    self.sallyPowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.sallyPowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.sallyPowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.sallyPowerLabel.layer.shadowRadius = 0.0;
    self.sallyPowerLabel.layer.shadowOpacity = 0.6;
    self.sallyPowerLabel.layer.masksToBounds = NO;
    self.sallyPowerLabel.layer.shouldRasterize = YES;

    self.sallyLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.sallyLabel.textColor = [UIColor whiteColor];
    self.sallyLabel.text = @"Rhonin";
    self.sallyLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.sallyLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.sallyLabel.layer.shadowRadius = 0.0;
    self.sallyLabel.layer.shadowOpacity = 0.6;
    self.sallyLabel.layer.masksToBounds = NO;
    self.sallyLabel.layer.shouldRasterize = YES;

    if ([RWGameData sharedGameData].threeDigitGame) {
        self.tanyaPowerLabel.text = @"15.045";
    }else{
        self.tanyaPowerLabel.text = @"16.045";
    }
    self.tanyaPowerLabel.textColor = [UIColor whiteColor];
    self.tanyaPowerLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.tanyaPowerLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.tanyaPowerLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.tanyaPowerLabel.layer.shadowRadius = 0.0;
    self.tanyaPowerLabel.layer.shadowOpacity = 0.6;
    self.tanyaPowerLabel.layer.masksToBounds = NO;
    self.tanyaPowerLabel.layer.shouldRasterize = YES;

    self.tanyaLabel.font = [UIFont fontWithName:FONT_ROBOTO size:size];
    self.tanyaLabel.textColor = [UIColor whiteColor];
    self.tanyaLabel.text = @"Barret";
    self.tanyaLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.tanyaLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    self.tanyaLabel.layer.shadowRadius = 0.0;
    self.tanyaLabel.layer.shadowOpacity = 0.6;
    self.tanyaLabel.layer.masksToBounds = NO;
    self.tanyaLabel.layer.shouldRasterize = YES;

    
    switch ([RWGameData sharedGameData].playerId) {
        case 1:
            [self setSwitches];
            break;
        case 2:
            [self setSwitches2];
            break;
        case 3:
            [self setSwitches3];
            break;
        case 4:
            [self setSwitches4];
            break;
        case 5:
            [self setSwitches5];
            break;
        case 6:
            [self setSwitches6];
            break;
        case 7:
            [self setSwitches7];
            break;
        case 8:
            [self setSwitches8];
            break;
        default:
            [self setSwitches];
            break;
    }

    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(20, 20, 42, 42);
    [_backButton setBackgroundImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_backButton];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar sizeThatFits:self.view.frame.size];
}

- (void)back {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitClicked:(id)sender {

    switch ([RWGameData sharedGameData].playerId) {
        case 1:
            [self masterSelected:sender];
            break;
        case 2:
            [self randSelected:sender];
            break;
        case 3:
            [self luiSelected:sender];
            break;
        case 4:
            [self aliceSelected:sender];
            break;
        case 5:
            [self jackSelected:sender];
            break;
        case 6:
            [self marciaSelected:sender];
            break;
        case 7:
            [self sallySelected:sender];
            break;
        case 8:
            [self tanyaSelected:sender];
            break;
        default:
            [self masterSelected:sender];
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName: SSGameDataUpdatedFromiCloud object:nil];
}

- (IBAction)masterSelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 1;
    [RWGameData sharedGameData].playerName = self.masterLabel.text;
    [RWGameData sharedGameData].playerPower = self.masterPowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches];
}

- (IBAction)randSelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 2;
    [RWGameData sharedGameData].playerName = self.randLabel.text;
    [RWGameData sharedGameData].playerPower = self.randPowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches2];
}

- (IBAction)luiSelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 3;
    [RWGameData sharedGameData].playerName = self.luiLabel.text;
    [RWGameData sharedGameData].playerPower = self.luiPowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches3];
}

- (IBAction)aliceSelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 4;
    [RWGameData sharedGameData].playerName = self.aliceLabel.text;
    [RWGameData sharedGameData].playerPower = self.alicePowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches4];
}

- (IBAction)jackSelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 5;
    [RWGameData sharedGameData].playerName = self.jackLaabel.text;
    [RWGameData sharedGameData].playerPower = self.jackPowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches5];
}

- (IBAction)marciaSelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 6;
    [RWGameData sharedGameData].playerName = self.marciaLabel.text;
    [RWGameData sharedGameData].playerPower = self.marciaPowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches6];
}

- (IBAction)sallySelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 7;
    [RWGameData sharedGameData].playerName = self.sallyLabel.text;
    [RWGameData sharedGameData].playerPower = self.sallyPowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches7];
}

- (IBAction)tanyaSelected:(id)sender {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [RWGameData sharedGameData].playerId = 8;
    [RWGameData sharedGameData].playerName = self.tanyaLabel.text;
    [RWGameData sharedGameData].playerPower = self.tanyaPowerLabel.text;
    
    [[RWGameData sharedGameData] save];
    [self setSwitches8];
}
@end
