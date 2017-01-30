//
//  GameRulesViewController.h
//  MastermindNumbers
//
//  Created by Alaattin Bedir on 13.02.2016.
//  Copyright © 2016 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameRulesViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *gameRulesHeaderLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UIButton *okButton;
- (IBAction)dismissGameRules:(id)sender;

@end
