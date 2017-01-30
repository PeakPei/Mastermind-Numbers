//
//  HowToPlayViewController.h
//  
//
//  Created by Alaattin Bedir on 30.01.2016.
//
//

#import <UIKit/UIKit.h>

@interface HowToPlayViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@end
