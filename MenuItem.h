//
//  MenuItem.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 9/16/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuItemDelegate <NSObject>
- (void) didSelectMenuItem:(int)index;
@end

@interface MenuItem : UIView{
    UILabel *titleLabel;
}

@property (nonatomic, strong) id<MenuItemDelegate> menuItemDelegate;
@property (nonatomic, strong) UIButton * menuButton;

- (id)initWithFrame:(CGRect)frame withIndex:(int)index;

@end
