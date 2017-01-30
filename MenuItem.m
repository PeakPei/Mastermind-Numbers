//
//  MenuItem.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 9/16/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

//#define FIRST_SCREEN_LABEL_IPHONE3 (IS_IPHONE_6P ? 570 :(IS_IPHONE_6 ? 525 : IS_IPHONE_5 ? 465 : 399 ))

#define CAROUSEL_ITEM_HEIGHT (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? (IS_IPHONE_6P ? self.frame.size.height-60 : self.frame.size.height-60) : self.frame.size.height-60
#define CAROUSEL_ITEM_WIDTH (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? (IS_IPHONE_6P ? self.frame.size.width-107 : (IS_IPHONE_6 ? self.frame.size.width-106 : IS_IPHONE_5 ? self.frame.size.width-109 : self.frame.size.width-112 )) : self.frame.size.width-350

#define CAROUSEL_ITEM_X (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? (IS_IPHONE_6P ? 55 : 55) : 175

#import "MenuItem.h"
#import "AppUtil.h"
#import "RWGameData.h"
#import "CustomButton.h"

@implementation MenuItem

@synthesize menuButton;


- (id)initWithFrame:(CGRect)frame withIndex:(int)index{
    self = [super initWithFrame:frame];
    if (self) {

        self.clipsToBounds = NO;
        
        NSString *title;
        NSString *iconName;
        CGFloat x;
        switch (index) {
            case 0:{
                title = JALocalizedString(@"KEY9", @"");
                iconName = @"singleplayer";
                x = 60;
            }
                break;
            case 1:{
                title = JALocalizedString(@"KEY10", @"");
                iconName = @"multiplayer";
                x = 60;
            }
                break;
            case 2:{
                title = JALocalizedString(@"KEY32", @"");
                iconName = @"training";
                x = 111;
            }
                break;
            default:
                break;
        }
        
        menuButton = [[CustomButton alloc] initWithFrameForCarauselMenuItem:CGRectMake(CAROUSEL_ITEM_X, 0,CAROUSEL_ITEM_WIDTH, CAROUSEL_ITEM_HEIGHT) withTitle:title
                                                               withIconName:iconName
                                                                   withFont:[UIFont fontWithName:FONT_GOODFISH size:25]
                                                                  withColor:[UIColor whiteColor]
                                                                 withImageX:x];
        
//        menuButton = [[UIButton alloc] initWithFrame:CGRectMake(CAROUSEL_ITEM_X, 0,CAROUSEL_ITEM_WIDTH, CAROUSEL_ITEM_HEIGHT)];
        
        menuButton.tag = index;
        [menuButton setBackgroundColor:[UIColor clearColor]];
        
        switch ([RWGameData sharedGameData].thema)
        {
            case 0:{
                [menuButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            }
                break;
            case 1:{
                [menuButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            }
                break;
            case 2:{
                [menuButton setBackgroundImage:[UIImage imageNamed:@"menuBlue"] forState:UIControlStateNormal];
            }
                break;
                
            default:{
                [menuButton setBackgroundImage:[UIImage imageNamed:@"menuYellow"] forState:UIControlStateNormal];
            }
                break;
        }

        [menuButton addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:menuButton];
        
    }
    return self;
}

-(void)menuItemClicked:(id)sender{
    NSLog(@"%@",sender);
    
    [_menuItemDelegate didSelectMenuItem:(int)((MenuItem*)sender).tag];
}

@end
