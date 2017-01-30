//
//  ChildViewController.h
//  
//
//  Created by Alaattin Bedir on 30.01.2016.
//
//

#import <UIKit/UIKit.h>
#import "OSLabel.h"
#import "UILabel+MultilineAutoSize.h"

@interface ChildViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) OSLabel *firstScreenFirstLabel;
@property (strong, nonatomic) OSLabel *firstScreenSeconLabel;
@property (strong, nonatomic) OSLabel *firstScreenThirdLabel;
@property (strong, nonatomic) UIView *firstLabelBackground;
@property (strong, nonatomic) UIView *secondLabelBackground;
@property (strong, nonatomic) UIView *thirdLabelBackground;

@property (strong, nonatomic) UIImageView *screenImageView;

@end
