//
//  CustomButton.h
//  Basaksehir_HD
//
//  Created by mahir tarlan on 12/6/13.
//  Copyright (c) 2013 igones. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton
{
    UILabel *titleLbl;
}
@property (nonatomic,strong) id userData;
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName;
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName withTitle:(NSString *) title withFont:(UIFont *) font;
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName withTitle:(NSString *) title withFont:(UIFont *) font fillXY:(BOOL) shouldFillXY;
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName withTitle:(NSString *) title withFont:(UIFont *) font withColor:(UIColor *) textColor;
- (id)initWithFrame:(CGRect)frame withTitle:(NSString *) title withFont:(UIFont *) font withColor:(UIColor *) textColor withLines:(int) numberOfLines withAlignment:(NSTextAlignment) textAlignment;
- (id)initWithFrame:(CGRect)frame withIconName:(NSString *) iconName withCount:(long) count;
- (id)initWithFrameForSmsButton:(CGRect)frame ;
- (id)initWithFrameForLongSmsButton:(CGRect)frame;
- (id)initWithFrameForChangePassButton:(CGRect)frame;
- (id)initWithFrameForSmsForTCKNButton:(CGRect)frame;
- (void) changeColorOfLabel:(UIColor *) newColor;
- (id)initWithFrameForTextButton:(CGRect)frame withTitle:(NSString *) text withFont:(UIFont *) titleFont withColor:(UIColor *) textColor ;
- (id)initWithFrameForMenuItem:(CGRect)frame withTitle:(NSString *) text withIconName:(NSString *) iconName withFont:(UIFont *) titleFont withColor:(UIColor *) textColor withImageX:(CGFloat) x withImageY:(CGFloat) y;
- (id)initWithFrameForCarauselMenuItem:(CGRect)frame withTitle:(NSString *) text withIconName:(NSString *) iconName withFont:(UIFont *) titleFont withColor:(UIColor *) textColor withImageX:(CGFloat) x;
@end
