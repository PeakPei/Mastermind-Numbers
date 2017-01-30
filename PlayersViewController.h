//
//  OptionsViewController.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/28/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayersViewController : UIViewController

@property (nonatomic, strong) UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;

@property (strong, nonatomic) IBOutlet UIImageView *masterImage;

@property (strong, nonatomic) IBOutlet UIImageView *lucyImage;

@property (strong, nonatomic) IBOutlet UIImageView *mazeImage;

@property (strong, nonatomic) IBOutlet UIImageView *avelineImage;

@property (strong, nonatomic) IBOutlet UIImageView *vincentImage;

@property (strong, nonatomic) IBOutlet UIImageView *elinaImage;

@property (strong, nonatomic) IBOutlet UIImageView *rhoninImage;

@property (strong, nonatomic) IBOutlet UIImageView *barretImage;

@end
