//
//  GameRulesViewController.m
//  MastermindNumbers
//
//  Created by Alaattin Bedir on 13.02.2016.
//  Copyright © 2016 Alaattin Bedir. All rights reserved.
//

#import "GameRulesViewController.h"
#import "RWGameData.h"

@interface GameRulesViewController ()

@end

@implementation GameRulesViewController
@synthesize scrollView;

- (CGFloat) calculateHeightForText:(NSString *)str forWidth:(CGFloat)width forFont:(UIFont *)font {
    if([str isKindOfClass:[NSNull class]]) return 0;
    CGFloat result = 20.0f;
    if (str) {
        CGSize textSize = { width, 20000.0f };
        CGRect textRect = [str boundingRectWithSize:textSize
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil];
        
        CGSize size = textRect.size;
        
        result = MAX(size.height, 30.0f);
    }
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgBlueHD"]]];
            }else {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
            }
            
        }
            break;
        case 1:{
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgYellowHD"]]];
            }else {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgYellow"]]];
            }
            
        }
            break;
        case 2:{
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgPinkHD"]]];
            }else {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgPink"]]];
            }
            
        }
            break;
            
        default:{
            if (IS_IPAD) {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgBlueHD"]]];
            }else {
                [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]]];
            }
            
        }
            break;
    }
    
    CGFloat offSet = 0;
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        offSet = -50;
    }else if(IS_IPHONE_6){
        offSet = 5;
    }else if (IS_IPHONE_6P){
        offSet = 30;
    }
    else if (IS_IPAD){
        offSet = 160;
    }
    
    int size = 19;
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        size = 16;
        
    }
    
    NSString *desc = [NSString stringWithFormat:JALocalizedString(@"KEY103", @""),[RWGameData sharedGameData].limitStep];
    UIFont *descFont = [UIFont fontWithName:FONT_ROBOTO size:16];
    int descHeight = [self calculateHeightForText:desc forWidth:scrollView.frame.size.width + offSet forFont:descFont] + 5;
    
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width + offSet, descHeight)];
    descLabel.backgroundColor = [UIColor clearColor];
    descLabel.text = desc;
    descLabel.font = descFont;
    descLabel.textColor = [UIColor whiteColor];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentJustified;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:FONT_ROBOTO size:16],
                                 NSBaselineOffsetAttributeName: @0,
                                 NSParagraphStyleAttributeName: paragraphStyle};
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:desc
                                                                         attributes:attributes];
    descLabel.attributedText = attributedText;
    
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descLabel.numberOfLines = 0;
    [scrollView addSubview:descLabel];

    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width + offSet, descHeight + 5);


    
    
    [self.okButton setTitle:JALocalizedString(@"KEY36", @"") forState:UIControlStateNormal];
    [self.okButton.titleLabel setFont:[UIFont fontWithName:FONT_ROBOTO size:size]];
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
    
    [self.okButton setBackgroundImage:image forState:UIControlStateNormal];
    
    


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

- (IBAction)dismissGameRules:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
