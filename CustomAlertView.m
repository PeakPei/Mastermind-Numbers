//
//  CustomAlertView.m
//  Acdm_1
//
//  Created by mahir tarlan on 1/31/14.
//  Copyright (c) 2014 igones. All rights reserved.
//

#import "CustomAlertView.h"
#import "AppUtil.h"
#import "CustomButton.h"
#import "SoundManager.h"

@implementation CustomAlertView

@synthesize delegate,alertMessage;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *) title withMessage:(NSString *) message withModalType:(ModalType) modalType {
    self = [super initWithFrame:frame];
    if (self) {
        

        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bgView.backgroundColor = [UIColor blackColor];
        bgView.alpha = 0.0;

        
        [self addSubview:bgView];
        
        UIFont *messageFont = [UIFont fontWithName:FONT_ROBOTO size:18];
        
        int messageHeight = [AppUtil calculateHeightForText:message forWidth:240 forFont:messageFont] + 20;
        
        int modalHeight = messageHeight + 140;
        int modalWidth = 280;
        int messageWidth = 240;
        int modalX = (self.frame.size.width - 280)/2;
        int modalY = (self.frame.size.height - 220)/2;
        int titleX = 50;
        int messageX = 20;
        
        if(IS_IPAD)
        {
            modalWidth += 60;
            modalHeight += 40;
            messageWidth += 80;
            modalX -= 28;
            modalY -= 28;
            titleX += 32;
            messageX -= 8;
        }
        
        
        UIView *modalView = [[UIView alloc] initWithFrame:CGRectMake(modalX, modalY, modalWidth, modalHeight)];
        modalView.layer.cornerRadius = 10;
        modalView.layer.shadowColor = [UIColor blackColor].CGColor;
        modalView.layer.shadowOffset = CGSizeMake(0, 5);
        modalView.layer.shadowOpacity = 0.3f;
        modalView.layer.shadowRadius = 10.0f;

        modalView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgDialogBox"]];
        
        UIImage *iconImg = nil;
        switch (modalType) {
            case ModalTypeError:
                iconImg = [UIImage imageNamed:@"modal_carpibuton.png"];
                break;
            case ModalTypeInfo:
                iconImg = [UIImage imageNamed:@"msgInfo"];
                break;
            case ModalTypeSuccess:
                iconImg = [UIImage imageNamed:@"modal_pozirif.png"];
                break;
            case ModalTypeWarning:
                iconImg = [UIImage imageNamed:@"modal_uyari.png"];
                break;
                
            default:
                break;
        }
        alertMessage = message;
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(25, 18, 24, 24)];
        iconImgView.image = iconImg;
        [modalView addSubview:iconImgView];

        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 18, 180, 24)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        titleLabel.font = [UIFont fontWithName:FONT_ROBOTO size:19];
        titleLabel.textColor = [AppUtil UIColorForHexColor:@"0C548E"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [modalView addSubview:titleLabel];

        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(messageX, 60, messageWidth, messageHeight)];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.text = message;
        messageLabel.font = messageFont;
        messageLabel.textColor = [AppUtil UIColorForHexColor:@"0C548E"];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.numberOfLines = 0;
        [modalView addSubview:messageLabel];
        

        int btnWidth = 260;
        int btnHeight = 52;
        if(IS_IPAD)
        {
            btnWidth += 60;
            
        }
        
        CustomButton *dismissButton = [[CustomButton alloc] initWithFrame:CGRectMake(10, modalView.frame.size.height - 59, btnWidth, btnHeight) withImageName:@"msgButton" withTitle:JALocalizedString(@"KEY36", @"") withFont:[UIFont fontWithName:FONT_ROBOTO size:22]];
        dismissButton.layer.cornerRadius = 10;
        dismissButton.clipsToBounds = YES;
        [dismissButton addTarget:self action:@selector(triggerDismiss) forControlEvents:UIControlEventTouchUpInside];
        
      //  [dismissButton setTitle:@"Tamam" forState:UIControlStateNormal];
       // [dismissButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        [modalView addSubview:dismissButton];

        [self addSubview:modalView];
    }
    return self;
}



- (void) triggerDismiss {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [delegate didDismissCustomAlert:self];
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
