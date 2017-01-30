//
//  MenuCarousel.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 9/16/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#define FRAME_WIDTH self.frame.size.width


#define MENU_CAROUSEL_HEIGHT_IPHONE (IS_IPHONE_6P ? 205 : (IS_IPHONE_6 ? 200 : (IS_IPHONE_5 ? 165 : 150)))
#define MENU_CAROUSEL_HEIGHT IS_IPHONE ? MENU_CAROUSEL_HEIGHT_IPHONE : (IS_IPAD_PRO ? 290 : 250)

#define PAGE_CONTROL_Y_IPHONE (IS_IPHONE_6P ? 159 :(IS_IPHONE_6 ? 150 : IS_IPHONE_5 ? 105 : 90))
#define PAGE_CONTROL_Y IS_IPHONE ? PAGE_CONTROL_Y_IPHONE : (IS_IPAD_PRO ? 240 : 210)

#define MENU_CAROUSEL_WIDTH_IPHONE (IS_IPHONE_6P ? FRAME_WIDTH : (IS_IPHONE_6 ? FRAME_WIDTH : IS_IPHONE_5 ? FRAME_WIDTH : FRAME_WIDTH))
#define MENU_CAROUSEL_WIDTH IS_IPHONE ? MENU_CAROUSEL_WIDTH_IPHONE : FRAME_WIDTH

#define MENU_CAROUSEL_X_IPHONE (IS_IPHONE_6P ? 0 :(IS_IPHONE_6 ? 0 : IS_IPHONE_5 ? 0 : 0))
#define MENU_CAROUSEL_X IS_IPHONE ? MENU_CAROUSEL_X_IPHONE : 0

#define PAGE_CONTROL_X_IPHONE (IS_IPHONE_6P ? 1 :(IS_IPHONE_6 ? 3 : IS_IPHONE_5 ? 0 : 0))
#define PAGE_CONTROL_X IS_IPHONE ? PAGE_CONTROL_X_IPHONE: 0


#import "MenuCarousel.h"
#import "AppUtil.h"
#import "MenuItem.h"
#import "SoundManager.h"

@implementation MenuCarousel

@synthesize scroll;
@synthesize pageControl;
@synthesize menuDelegate;
@synthesize menuView;



- (id)initWithFrame:(CGRect)frame withList:(NSArray *) menuList{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(MENU_CAROUSEL_X, 0, MENU_CAROUSEL_WIDTH, MENU_CAROUSEL_HEIGHT)];
        
        int counter = 0;
        int innerPageCounter = 0;
        NSMutableArray *pageArray = [[NSMutableArray alloc] init];
        
        while (counter < [menuList count]) {
            NSString *row = [menuList objectAtIndex:counter];
            [pageArray addObject:row];

            menuView = [[MenuItem alloc] initWithFrame:CGRectMake(innerPageCounter * scroll.frame.size.width, 0, scroll.frame.size.width, scroll.frame.size.height) withIndex:counter];
            menuView.menuItemDelegate = self;
            menuView.backgroundColor = [UIColor clearColor];

            [scroll addSubview:menuView];
            innerPageCounter++;
            counter ++;
        }
        
        scroll.contentSize = CGSizeMake(innerPageCounter * scroll.frame.size.width, scroll.frame.size.height);
        scroll.pagingEnabled = YES;
        scroll.delegate = self;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.bounces = YES;
        scroll.clipsToBounds = NO;
        
        [self addSubview:scroll];
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(PAGE_CONTROL_X, PAGE_CONTROL_Y, self.frame.size.width, 36)];
        pageControl.numberOfPages = floor(counter);
        pageControl.currentPage = 0;
        if ([pageControl respondsToSelector:@selector(setPageIndicatorTintColor:)]) {
            pageControl.pageIndicatorTintColor = [AppUtil UIColorForHexColor:@"0c0c0c"]; //576274
        }
        if ([pageControl respondsToSelector:@selector(setCurrentPageIndicatorTintColor:)]) {
            pageControl.currentPageIndicatorTintColor = [AppUtil UIColorForHexColor:@"FFFFFF"];
        }
        [pageControl addTarget:self action:@selector(pageControllerChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:pageControl];
        
        
        
    }
    return self;
}

-(void) didSelectMenuItem:(int)index{
    [menuDelegate didSelectItem:index];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    float contentX = scrollView.contentOffset.x;
    int page = floor(contentX/scroll.frame.size.width);
    pageControl.currentPage = page;
}

-(void)pageControllerChanged:(id)sender
{

    [scroll scrollRectToVisible:CGRectMake(pageControl.currentPage * scroll.frame.size.width, 0, scroll.frame.size.width, scroll.frame.size.height) animated:YES];
}

@end
