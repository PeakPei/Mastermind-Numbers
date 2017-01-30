//
//  SettingsViewController.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 10/11/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *backgroundView;


@property (strong, nonatomic) IBOutlet UIButton *gameRulesButton;

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (strong, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISwitch *aiplayersSwitch;
@property (strong, nonatomic) IBOutlet UILabel *gameRulesLabel;
@property (weak, nonatomic) IBOutlet UILabel *aiPlayerLabel;
@property (strong, nonatomic) IBOutlet UIButton *AIPlayersButton;

@property (strong, nonatomic) IBOutlet UILabel *AIPlayersLabel;
@property (strong, nonatomic) IBOutlet UILabel *developLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyLabel;
@property (strong, nonatomic) IBOutlet UILabel *companyUrlLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *numberDigitsSegmented;
@property (strong, nonatomic) IBOutlet UILabel *numberDigitsLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *themaSegmented;
@property (strong, nonatomic) IBOutlet UILabel *resetTraining;
@property (strong, nonatomic) IBOutlet UILabel *themesLabel;

@property (strong, nonatomic) IBOutlet UIButton *emailButton;


@property (nonatomic, strong) UIButton *muteButton;

- (IBAction)actionNumberDigits:(id)sender;
- (IBAction)actionResetTraining:(id)sender;
- (IBAction)actionThemaChanged:(id)sender;
- (IBAction)actionGameRules:(id)sender;
- (IBAction)emailAction:(id)sender;

- (IBAction)showAIPlayers:(id)sender;

- (IBAction)actionAIPlayers:(id)sender;

-(void) changeBackground;
@property (strong, nonatomic) IBOutlet UIButton *musicButton;

@property (strong, nonatomic) IBOutlet UIButton *soundButton;
- (IBAction)actionMusic:(id)sender;
- (IBAction)actionSound:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *soundBan;
- (IBAction)actionSoundBan:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *musicBan;
@property (strong, nonatomic) IBOutlet UIButton *actionMusicBan;
- (IBAction)actionMusicBan:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *enableDragDrop;
- (IBAction)actionEnableDragDrop:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *enableDragDropLabel;




@end
