//
//  CustomConfirmView.m
//  Acdm_1
//
//  Created by mahir tarlan on 1/31/14.
//  Copyright (c) 2014 igones. All rights reserved.
//

#import "CustomConfirmView.h"
#import "AppUtil.h"
#import "CustomButton.h"
#import "SoundManager.h"

@interface CustomConfirmView()
{
    CustomButton *rejectButton;
    CustomButton *approveButton;
}
@end

@implementation CustomConfirmView

@synthesize delegate,alertMessage;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *) title withCancelTitle:(NSString *) cancelTitle withApproveTitle:(NSString *) approveTitle withMessage:(NSString *) message withModalType:(ModalType) modalType {
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
        int rejectButtonX = 145;
        int modalX = (self.frame.size.width - 280)/2;
        int modalY = (self.frame.size.height - 220)/2;
        int titleX = 67;
        int messageX = 20;
        if(IS_IPAD)
        {
            modalWidth += 60;
            modalHeight += 40;
            messageWidth += 80;
            rejectButtonX += 60;
            modalX -= 28;
            modalY -= 28;
            titleX += 22;
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
            case ModalTypeApprove:
                iconImg = [UIImage imageNamed:@"msgInfo"];
                break;
            case ModalTypeSuccess:
                iconImg = [UIImage imageNamed:@"msgInfo"];
                break;
            case ModalTypeWarning:
                iconImg = [UIImage imageNamed:@"modal_uyari.png"];
                break;
                
            default:
                break;
        }
        alertMessage = message;
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 18, 24, 24)];
        iconImgView.image = iconImg;
        [modalView addSubview:iconImgView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 18, 160, 24)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        titleLabel.font = [UIFont fontWithName:FONT_ROBOTO size:20];
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
        
        rejectButton = [[CustomButton alloc] initWithFrame:CGRectMake(10, modalView.frame.size.height - 59, 125, 52) withImageName:@"msgButton" withTitle:cancelTitle withFont:[UIFont fontWithName:FONT_ROBOTO size:18]
                                                 withColor:[UIColor whiteColor]];
        
        [rejectButton addTarget:self action:@selector(triggerCancel) forControlEvents:UIControlEventTouchUpInside];
        
       // [rejectButton setTitle:cancelTitle forState:UIControlStateNormal];
      //  [rejectButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        [modalView addSubview:rejectButton];
        
        approveButton = [[CustomButton alloc] initWithFrame:CGRectMake(rejectButtonX, modalView.frame.size.height - 59, 125, 52) withImageName:@"msgButton" withTitle:approveTitle withFont:[UIFont fontWithName:FONT_ROBOTO size:18] withColor:[UIColor whiteColor]];
        [approveButton addTarget:self action:@selector(triggerApprove) forControlEvents:UIControlEventTouchUpInside];
        
       // [approveButton setTitle:approveTitle forState:UIControlStateNormal];
      //  [approveButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        
        [modalView addSubview:approveButton];
        
        [self addSubview:modalView];
    }
    return self;
}

- (void)setBlock:(void (^)(void))approveCallback didReject:(void (^)(void))rejectCallback
{
    if(approveCallback != nil)
    {
        [approveButton removeTarget:self action:@selector(triggerApprove) forControlEvents:UIControlEventTouchUpInside];
        [approveButton addTarget:approveCallback action:@selector(invoke) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if(rejectCallback != nil)
    {
        [rejectButton removeTarget:self action:@selector(triggerApprove) forControlEvents:UIControlEventTouchUpInside];
        [rejectButton addTarget:rejectCallback action:@selector(invoke) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) triggerCancel {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [delegate didRejectCustomAlert:self];
    [self removeFromSuperview];
}

- (void) triggerApprove {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [delegate didApproveCustomAlert:self];
    [self removeFromSuperview];
}

@end
