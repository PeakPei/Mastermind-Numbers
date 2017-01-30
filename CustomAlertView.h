//
//  CustomAlertView.h
//  Acdm_1
//
//  Created by mahir tarlan on 1/31/14.
//  Copyright (c) 2014 igones. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "AppConstants.h"
//#import "AlertBase.h"

//typedef enum {
//    ModalTypeError = 0,
//    ModalTypeWarning,
//    ModalTypeSuccess,
//    ModalTypeApprove,
//    ModalTypeInfo
//} ModalType;

@class CustomAlertView;

@protocol CustomAlertDelegate <NSObject>
- (void) didDismissCustomAlert:(CustomAlertView *) alertView;
@end

@interface CustomAlertView : UIView

@property (nonatomic, strong) id<CustomAlertDelegate> delegate;
@property (nonatomic,strong) NSString *alertMessage;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *) title withMessage:(NSString *) message withModalType:(ModalType) modalType;

@end
