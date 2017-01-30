//
//  MenuCarousel.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 9/16/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuItem.h"

@protocol MenuCarouselDelegate <NSObject>
@optional
- (void) didSelectItem:(int) index;
@end

@interface MenuCarousel : UIView<UIScrollViewDelegate,MenuItemDelegate>{
    
}

@property (nonatomic, strong) id<MenuCarouselDelegate> menuDelegate;
@property (nonatomic, strong) UIScrollView *scroll;
@property (nonatomic, strong)UIPageControl *pageControl;
@property (nonatomic, strong) MenuItem *menuView;

- (id)initWithFrame:(CGRect)frame withList:(NSArray *) menuList;

@end
