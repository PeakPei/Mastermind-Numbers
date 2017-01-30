//
//  ChildViewController.m
//  
//
//  Created by Alaattin Bedir on 30.01.2016.
//
//

#import "ChildViewController.h"
#import "SoundManager.h"
#import "RWGameData.h"


#define FIRST_SCREEN_LABEL_IPHONE (IS_IPHONE_6P ? 460 :(IS_IPHONE_6 ? 415 : IS_IPHONE_5 ? 355 : 295 ))
#define FIRST_SCREEN_LABEL IS_IPHONE ? FIRST_SCREEN_LABEL_IPHONE : 700

#define FIRST_SCREEN_LABEL_IPHONE2 (IS_IPHONE_6P ? 515 :(IS_IPHONE_6 ? 470 : IS_IPHONE_5 ? 410 : 347 ))
#define FIRST_SCREEN_LABEL2 IS_IPHONE ? FIRST_SCREEN_LABEL_IPHONE2 : 760

#define FIRST_SCREEN_LABEL_IPHONE3 (IS_IPHONE_6P ? 570 :(IS_IPHONE_6 ? 525 : IS_IPHONE_5 ? 465 : 399 ))
#define FIRST_SCREEN_LABEL3 IS_IPHONE ? FIRST_SCREEN_LABEL_IPHONE3 : 820

#define SECOND_SCREEN_LABEL_IPHONE2 (IS_IPHONE_6P ? 522 :(IS_IPHONE_6 ? 477 : IS_IPHONE_5 ? 412 : 345 ))
#define SECOND_SCREEN_LABEL2 IS_IPHONE ? SECOND_SCREEN_LABEL_IPHONE2 : 760

#define SECOND_SCREEN_LABEL_IPHONE3 (IS_IPHONE_6P ? 577 :(IS_IPHONE_6 ? 532 : IS_IPHONE_5 ? 467 : 397 ))
#define SECOND_SCREEN_LABEL3 IS_IPHONE ? SECOND_SCREEN_LABEL_IPHONE3 : 820


@implementation ChildViewController
@synthesize screenImageView,firstLabelBackground,firstScreenSeconLabel,firstScreenThirdLabel,firstScreenFirstLabel,secondLabelBackground,thirdLabelBackground;



- (void)back {
    [[SoundManager sharedManager] playSound:@"MenuSelect.mp3" looping:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) changeBackground{
    
    UIImage *buttonImage = nil;
    
    switch ([RWGameData sharedGameData].thema)
    {
        case 0:{
            buttonImage = [UIImage imageNamed:@"backbtn.png"];
        }
            break;
        case 1:{
            buttonImage = [UIImage imageNamed:@"Backbtn2.png"];
        }
            break;
        case 2:{
            buttonImage = [UIImage imageNamed:@"Backbtn2.png"];
        }
            break;
            
        default:{
            buttonImage = [UIImage imageNamed:@"backbtn.png"];
            
        }
            break;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:buttonImage forState:UIControlStateNormal];
    
    CGFloat width = buttonImage.size.width;
    CGFloat heigth = buttonImage.size.height;
    if (IS_IPAD) {
        width+=100;
        heigth+=100;
    }else {
        width+=50;
        heigth+=50;
    }
    
    button.frame = CGRectMake(0, 0, width, heigth);
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(UILabel*) addBorderToLabel:(UILabel*)label{
    label.layer.shadowColor = [[UIColor whiteColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    label.layer.shadowRadius = 1.5;
    label.layer.shadowOpacity = 0.6;
    label.layer.masksToBounds = NO;
    label.layer.shouldRasterize = YES;
    
    
    return label;
}

-(UIView*) addBorderToLabel2:(UIView*)view{
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    view.layer.shadowRadius = 0.0;
    view.layer.shadowOpacity = 0.6;
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    
    return view;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self changeBackground];
    // Do any additional setup after loading the view from its nib.
    self.automaticallyAdjustsScrollViewInsets = false;
    
    UIImage *image = nil;
    
    self.firstScreenFirstLabel = [[OSLabel alloc] init];
    self.firstScreenFirstLabel.backgroundColor = [UIColor clearColor];
    self.firstScreenFirstLabel.textColor = [UIColor whiteColor];
    self.firstScreenFirstLabel.numberOfLines = 0;
    self.firstScreenFirstLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.firstScreenFirstLabel.font = [UIFont fontWithName:FONT_GOODFISH size:17];
    self.firstScreenFirstLabel.adjustsFontSizeToFitWidth = YES;


    self.firstScreenSeconLabel = [[OSLabel alloc] init];
    self.firstScreenSeconLabel.textColor = [UIColor whiteColor];
    self.firstScreenSeconLabel.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
    self.firstScreenSeconLabel.numberOfLines = 0;
    self.firstScreenSeconLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.firstScreenSeconLabel.font = [UIFont fontWithName:FONT_GOODFISH size:17];
    self.firstScreenSeconLabel.adjustsFontSizeToFitWidth = YES;


    self.firstScreenThirdLabel = [[OSLabel alloc] init];
    self.firstScreenThirdLabel.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
    self.firstScreenThirdLabel.textColor = [UIColor whiteColor];
    self.firstScreenThirdLabel.numberOfLines = 0;
    self.firstScreenThirdLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.firstScreenThirdLabel.font = [UIFont fontWithName:FONT_GOODFISH size:17];
    self.firstScreenThirdLabel.adjustsFontSizeToFitWidth = YES;

    
    switch (self.index) {
        case 0:{
            image = [UIImage imageNamed:@"firstScreen.png"];
            
            self.firstLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(5, FIRST_SCREEN_LABEL, self.view.frame.size.width - 10, 50)];
            self.firstLabelBackground.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
            [self.firstScreenFirstLabel setFrame:CGRectMake(5, 0, self.view.frame.size.width - 15, 50)];
            self.firstScreenFirstLabel.text = JALocalizedString(@"KEY94", @"");
            [self.firstLabelBackground addSubview:self.firstScreenFirstLabel];
            
            self.secondLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(5, FIRST_SCREEN_LABEL2, self.view.frame.size.width - 10, 50)];
            self.secondLabelBackground.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
            [self.firstScreenSeconLabel setFrame:CGRectMake(5, 0, self.view.frame.size.width - 15, 50)];
            self.firstScreenSeconLabel.text = JALocalizedString(@"KEY95", @"");
            [self.secondLabelBackground addSubview:self.firstScreenSeconLabel];

            self.thirdLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(5, FIRST_SCREEN_LABEL3, self.view.frame.size.width - 10, 50)];
            self.thirdLabelBackground.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
            [self.firstScreenThirdLabel setFrame:CGRectMake(5, 0, self.view.frame.size.width - 15, 50)];
            self.firstScreenThirdLabel.text = JALocalizedString(@"KEY96", @"");
            [self.thirdLabelBackground addSubview:self.firstScreenThirdLabel];

        }
            break;
        case 1:{
            image = [UIImage imageNamed:@"secondScreen.png"];
            
            self.secondLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(5, SECOND_SCREEN_LABEL2, self.view.frame.size.width - 10, 50)];
            self.secondLabelBackground.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
            [self.firstScreenSeconLabel setFrame:CGRectMake(5, 0, self.view.frame.size.width - 15, 50)];
            self.firstScreenSeconLabel.text = JALocalizedString(@"KEY97", @"");
            [self.secondLabelBackground addSubview:self.firstScreenSeconLabel];
            
            self.thirdLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(5, SECOND_SCREEN_LABEL3, self.view.frame.size.width - 10, 50)];
            self.thirdLabelBackground.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
            [self.firstScreenThirdLabel setFrame:CGRectMake(5, 0, self.view.frame.size.width - 15, 50)];
            self.firstScreenThirdLabel.text = JALocalizedString(@"KEY98", @"");
            [self.thirdLabelBackground addSubview:self.firstScreenThirdLabel];
            
        }
            break;
        case 2:{
            image = [UIImage imageNamed:@"thirdScreen.png"];

            self.secondLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(5, SECOND_SCREEN_LABEL2, self.view.frame.size.width - 10, 50)];
            self.secondLabelBackground.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
            [self.firstScreenSeconLabel setFrame:CGRectMake(5, 0, self.view.frame.size.width - 15, 50)];
            self.firstScreenSeconLabel.text = JALocalizedString(@"KEY99", @"");
            [self.secondLabelBackground addSubview:self.firstScreenSeconLabel];
            
            self.thirdLabelBackground = [[UIView alloc] initWithFrame:CGRectMake(5, SECOND_SCREEN_LABEL3, self.view.frame.size.width - 10, 50)];
            self.thirdLabelBackground.backgroundColor = [UIColor colorWithR:238 G:160 B:68 A:1];
            [self.firstScreenThirdLabel setFrame:CGRectMake(5, 0, self.view.frame.size.width - 15, 50)];
            self.firstScreenThirdLabel.text = JALocalizedString(@"KEY100", @"");
            [self.thirdLabelBackground addSubview:self.firstScreenThirdLabel];

        }
            break;
            
        default:
            break;
    }

    self.screenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    [self.screenImageView setContentMode:UIViewContentModeScaleToFill];
    [self.screenImageView setImage:image];

    [self.view addSubview:self.screenImageView];
    
    
    [self.view addSubview:[self addBorderToLabel2:self.firstLabelBackground]];
    [self.view addSubview:[self addBorderToLabel2:self.secondLabelBackground]];
    [self.view addSubview:[self addBorderToLabel2:self.thirdLabelBackground]];

    [self.firstScreenFirstLabel adjustFontSizeToFit];
    [self.firstScreenSeconLabel adjustFontSizeToFit];
    [self.firstScreenThirdLabel adjustFontSizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
