//
//  CustomButton.m
//  Basaksehir_HD
//
//  Created by mahir tarlan on 12/6/13.
//  Copyright (c) 2013 igones. All rights reserved.
//

#import "CustomButton.h"
#import "AppUtil.h"

@implementation CustomButton
@synthesize userData;
- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName withTitle:(NSString *) title withFont:(UIFont *) font {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.titleLabel setFont:font];
        [self.titleLabel setAccessibilityLabel:title];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        [self addBorderToLabel:self.titleLabel];
    }
    return self;
}

-(UILabel*) addBorderToLabel:(UILabel*)label{
    label.layer.shadowColor = [[UIColor blackColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    label.layer.shadowRadius = 1.5;
    label.layer.shadowOpacity = 0.6;
    label.layer.masksToBounds = NO;
    label.layer.shouldRasterize = YES;
    
    
    return label;
}

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName withTitle:(NSString *) title withFont:(UIFont *) font withColor:(UIColor *) textColor {
    self = [super initWithFrame:frame];
    if (self) {
    
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.titleLabel setFont:font];
        [self.titleLabel setAccessibilityLabel:title];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        [self addBorderToLabel:self.titleLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *) imageName withTitle:(NSString *) title withFont:(UIFont *) font fillXY:(BOOL) shouldFillXY {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[AppUtil UIColorForHexColor:@"EEEEEE"] forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.titleLabel setFont:font];
        [self.titleLabel setAccessibilityLabel:title];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *) title withFont:(UIFont *) font withColor:(UIColor *) textColor withLines:(int) numberOfLines withAlignment:(NSTextAlignment) textAlignment {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:textAlignment];
         self.titleLabel.numberOfLines=numberOfLines;
        [self.titleLabel setFont:font];
        [self.titleLabel setAccessibilityLabel:title];
        self.titleLabel.backgroundColor=[UIColor clearColor];
        
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame withIconName:(NSString *) iconName withCount:(long) count
{
        self = [super initWithFrame:frame];
        if (self) {
            [self setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        }
        return self;
}

- (id)initWithFrameForSmsButton:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 16)];
        titleLabel.text = @"TURKCELL ABONESİYSENİZ ŞİFRE ALMAK İÇİN";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:FONT_ROBOTO size:10];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [AppUtil UIColorForHexColor:@"989898"];
        [self addSubview:titleLabel];
        
        UILabel *passLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 50, 20)];
        passLabel.text = @"SIFRE";
        passLabel.backgroundColor = [UIColor clearColor];
        passLabel.font = [UIFont fontWithName:FONT_ROBOTO size:15];
        passLabel.textAlignment = NSTextAlignmentRight;
        passLabel.textColor = [AppUtil UIColorForHexColor:@"3C3C3C"];
        [self addSubview:passLabel];
        
        UIImage *iconImage = [UIImage imageNamed:@"sms_icon.png"];
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(passLabel.frame.size.width + 5, 20, iconImage.size.width, iconImage.size.height)];
        [self addSubview:iconImgView];
        iconImgView.image = iconImage;
        
        UILabel *receiverLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImgView.frame.origin.x + iconImgView.frame.size.width + 5, 20, 50, 20)];
        receiverLabel.text = @"2222";
        receiverLabel.backgroundColor = [UIColor clearColor];
        receiverLabel.font = [UIFont fontWithName:FONT_ROBOTO size:15];
        receiverLabel.textAlignment = NSTextAlignmentLeft;
        receiverLabel.textColor = [AppUtil UIColorForHexColor:@"3C3C3C"];
        [self addSubview:receiverLabel];
    }
    return self;
}

- (id)initWithFrameForLongSmsButton:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 16)];
        titleLabel.text = @"TURKCELL ABONESİ DEĞİLSENİZ ŞİFRE ALMAK İÇİN";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:FONT_ROBOTO size:10];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [AppUtil UIColorForHexColor:@"989898"];
        [self addSubview:titleLabel];
        
        UILabel *passLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 50, 20)];
        passLabel.text = @"SIFRE";
        passLabel.backgroundColor = [UIColor clearColor];
        passLabel.font = [UIFont fontWithName:FONT_ROBOTO size:15];
        passLabel.textAlignment = NSTextAlignmentRight;
        passLabel.textColor = [AppUtil UIColorForHexColor:@"3C3C3C"];
        [self addSubview:passLabel];
        
        UIImage *iconImage = [UIImage imageNamed:@"sms_icon.png"];
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(passLabel.frame.size.width + 5, 20, iconImage.size.width, iconImage.size.height)];
        [self addSubview:iconImgView];
        iconImgView.image = iconImage;
        
        UILabel *receiverLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImgView.frame.origin.x + iconImgView.frame.size.width + 5, 20, self.frame.size.width - iconImgView.frame.origin.x - iconImgView.frame.size.width - 5, 20)];
        receiverLabel.text = @"05327552222";
        receiverLabel.backgroundColor = [UIColor clearColor];
        receiverLabel.font = [UIFont fontWithName:FONT_ROBOTO size:15];
        receiverLabel.textAlignment = NSTextAlignmentLeft;
        receiverLabel.textColor = [AppUtil UIColorForHexColor:@"3C3C3C"];
        [self addSubview:receiverLabel];
    }
    return self;
}

- (id)initWithFrameForChangePassButton:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setTitle:@"   ŞİFRE DEĞİŞTİR" forState:UIControlStateNormal];
        [self setTitle:@"   ŞİFRE DEĞİŞTİR" forState:UIControlStateSelected];
        [self setTitleColor:[AppUtil UIColorForHexColor:@"787878"] forState:UIControlStateNormal];
        [self.titleLabel setFont:[UIFont fontWithName:FONT_ROBOTO size:11]];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self setImage:[UIImage imageNamed:@"sifre.png"] forState:UIControlStateNormal];
        [self.titleLabel setFrame:CGRectMake(self.imageView.frame.size.width + 10, (self.frame.size.height - 15)/2, self.frame.size.width - self.imageView.frame.size.width - 10, 15)];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
      
    }
    return self;
}

- (id)initWithFrameForSmsForTCKNButton:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 16)];
        titleLabel.text = @"TC NUMARANIZ MI YOK?";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:FONT_ROBOTO size:12];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [AppUtil UIColorForHexColor:@"989898"];
        [self addSubview:titleLabel];
        
        UILabel *passLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 100, 20)];
        passLabel.text = @"ADSOYAD";
        passLabel.backgroundColor = [UIColor clearColor];
        passLabel.font = [UIFont fontWithName:FONT_ROBOTO size:15];
        passLabel.textAlignment = NSTextAlignmentRight;
        passLabel.textColor = [AppUtil UIColorForHexColor:@"3C3C3C"];
        [self addSubview:passLabel];
        
        UIImage *iconImage = [UIImage imageNamed:@"sms_icon.png"];
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(passLabel.frame.size.width + 5, 20, iconImage.size.width, iconImage.size.height)];
        [self addSubview:iconImgView];
        iconImgView.image = iconImage;
        
        UILabel *receiverLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImgView.frame.origin.x + iconImgView.frame.size.width + 5, 20, 50, 20)];
        receiverLabel.text = @"2929";
        receiverLabel.backgroundColor = [UIColor clearColor];
        receiverLabel.font = [UIFont fontWithName:FONT_ROBOTO size:15];
        receiverLabel.textAlignment = NSTextAlignmentLeft;
        receiverLabel.textColor = [AppUtil UIColorForHexColor:@"3C3C3C"];
        [self addSubview:receiverLabel];
    }
    return self;
}

- (id)initWithFrameForCarauselMenuItem:(CGRect)frame withTitle:(NSString *) text withIconName:(NSString *) iconName withFont:(UIFont *) titleFont withColor:(UIColor *) textColor withImageX:(CGFloat) x 
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat y = 25;
        CGFloat offset = 15;
        UIImage *iconImage = [UIImage imageNamed:iconName];
        CGFloat imageWidth = iconImage.size.width;
        CGFloat imageHeight = iconImage.size.height;

        if (IS_IPAD) {
            y += 15;
            imageHeight += 28;
        }
        
        if (IS_IPHONE_5) {
            titleFont = [UIFont fontWithName:FONT_GOODFISH size:19];
            imageWidth -= 10;
            imageHeight -= 10;
            y -= 7;
            offset -= 9;
        }else if(IS_IPHONE_4_OR_LESS){
            titleFont = [UIFont fontWithName:FONT_GOODFISH size:15];
            imageWidth -= 15;
            imageHeight -= 15;
            y -= 9;
            offset = 2;
        }
        
        
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, self.frame.size.width, imageHeight)];
        iconImgView.contentMode = UIViewContentModeScaleAspectFit;

        [self addSubview:iconImgView];
        iconImgView.image = iconImage;

        
//        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImgView.frame.origin.x + iconImgView.frame.size.width + 5, 20, 50, 20)];
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconImgView.frame.size.height + y+offset, self.frame.size.width, 30)];
        itemLabel.text = text;
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.font = titleFont;
        itemLabel.textAlignment = NSTextAlignmentCenter;
        itemLabel.textColor = textColor;
        itemLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        itemLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        itemLabel.layer.shadowRadius = 3.0;
        itemLabel.layer.shadowOpacity = 0.6;
        itemLabel.layer.masksToBounds = NO;
        itemLabel.layer.shouldRasterize = YES;

        [self addSubview:itemLabel];
    }
    return self;
}

- (id)initWithFrameForMenuItem:(CGRect)frame withTitle:(NSString *) text withIconName:(NSString *) iconName withFont:(UIFont *) titleFont withColor:(UIColor *) textColor withImageX:(CGFloat) x withImageY:(CGFloat) y
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat ylabel = 16;
        CGRect frameTemp = frame;
        if (IS_IPAD) {
            frameTemp.size.width += 17;
            frameTemp.origin.x -= 9;
            self.frame = frameTemp;
            y += 11;
            ylabel += 10;
        }
        
        UIImage *iconImage = [UIImage imageNamed:iconName];
        CGFloat imageWidth = iconImage.size.width;
        CGFloat imageHeight = iconImage.size.height;
        
        if (IS_IPHONE_5) {
            titleFont = [UIFont fontWithName:FONT_GOODFISH size:20];
            imageWidth -= 10;
            imageHeight -= 10;
            ylabel -= 5;
        }else if(IS_IPHONE_4_OR_LESS){
            titleFont = [UIFont fontWithName:FONT_GOODFISH size:17];
            imageWidth -= 13;
            imageHeight -= 15;
            ylabel -= 8;
        }
        
        
        UIImageView *iconImgView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, imageWidth, imageHeight)];
        iconImgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:iconImgView];
        iconImgView.image = iconImage;
        
        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImgView.frame.origin.x + iconImgView.frame.size.width + 15, ylabel, 200, 30)];
//        UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, iconImgView.frame.size.height + 10, 200, 30)];
        itemLabel.text = text;
        itemLabel.backgroundColor = [UIColor clearColor];
        itemLabel.font = titleFont;
        itemLabel.textAlignment = NSTextAlignmentLeft;
        itemLabel.textColor = textColor;
        itemLabel.layer.shadowColor = [[UIColor blackColor] CGColor];
        itemLabel.layer.shadowOffset = CGSizeMake(0.0, 1.0);
        itemLabel.layer.shadowRadius = 3.0;
        itemLabel.layer.shadowOpacity = 0.6;
        itemLabel.layer.masksToBounds = NO;
        itemLabel.layer.shouldRasterize = YES;
        
        [self addSubview:itemLabel];
    }
    return self;
}

- (id)initWithFrameForTextButton:(CGRect)frame withTitle:(NSString *) text withFont:(UIFont *) titleFont withColor:(UIColor *) textColor {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitle:text forState:UIControlStateNormal];
        [self setTitleColor:textColor forState:UIControlStateNormal];
        [self.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [self.titleLabel setFont:titleFont];
        [self.titleLabel setAccessibilityLabel:text];
        self.titleLabel.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void) changeColorOfLabel:(UIColor *) newColor {
    titleLbl.textColor = newColor;
}

@end
