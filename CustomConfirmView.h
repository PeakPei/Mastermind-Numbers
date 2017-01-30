//
//  CustomConfirmView.h
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

@class CustomConfirmView;

@protocol CustomConfirmDelegate <NSObject>
- (void) didApproveCustomAlert:(CustomConfirmView *) alertView;

@optional
- (void) didRejectCustomAlert:(CustomConfirmView *) alertView;

@end

@interface CustomConfirmView : UIView

@property (nonatomic, strong) id<CustomConfirmDelegate> delegate;
@property (nonatomic,strong) NSString *alertMessage;

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *) title withCancelTitle:(NSString *) cancelTitle withApproveTitle:(NSString *) approveTitle withMessage:(NSString *) message withModalType:(ModalType) modalType;
- (void)setBlock:(void (^)(void))approveCallback didReject:(void (^)(void))rejectCallback;

@end
