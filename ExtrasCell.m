//
//  ExtrasCell.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 10/10/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "ExtrasCell.h"
#import "RWGameData.h"

@implementation ExtrasCell

@synthesize pictureImageView;
@synthesize titleLabel;
@synthesize detailLabel;
@synthesize buyImageView;
@synthesize remainingLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect cellFrame = self.bounds;
        self.frame = cellFrame;
        
        UIImage *image = nil;
        //        menuYellow

        switch ([RWGameData sharedGameData].thema)
        {
            case 0:{
                image = [UIImage imageNamed:@"menuYellow"];
            }
                break;
            case 1:{
                image = [UIImage imageNamed:@"extraCell"];
            }
                break;
            case 2:{
                image = [UIImage imageNamed:@"extraCell"];
            }
                break;
                
            default:
            {
                image = [UIImage imageNamed:@"menuYellow"];
            }
                break;
        }
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(10.0,10.0,10.0,10.0) resizingMode:UIImageResizingModeStretch]];
        
        pictureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 20, 70, 70)];
//        pictureImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        pictureImageView.layer.borderWidth = 1.0;
//        pictureImageView.layer.cornerRadius = 6;
        [self addSubview:pictureImageView];
        
        CGFloat sizeDetail = 16;
        CGFloat detailWidth  = cellFrame.size.width - 90;
        CGFloat offset = 120;
        if (IS_IPHONE_6) {
            offset = 71;
        }else if(IS_IPHONE_6P){
            offset = 40;
        }else if (IS_IPAD_PRO){
            offset = -570;
        }else if (IS_IPAD){
            offset = -300;
        }
        
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            sizeDetail = 12;
            detailWidth -= 30;
        }
        
        remainingLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - offset+15, 27, 90, 30)];
        remainingLabel.backgroundColor = [UIColor clearColor];
        remainingLabel.textColor = [UIColor colorWithR:76 G:76 B:76 A:1];
        remainingLabel.numberOfLines = 1;
        remainingLabel.lineBreakMode = NSLineBreakByWordWrapping;
        remainingLabel.font = [UIFont fontWithName:FONT_GOODFISH size:17];
        [self addSubview:remainingLabel];
        

        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 10, cellFrame.size.width - 145, 65)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor colorWithR:76 G:76 B:76 A:1];
        titleLabel.numberOfLines = 2;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.font = [UIFont fontWithName:FONT_GOODFISH size:22];
        [self addSubview:titleLabel];
        
        
        detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 40, detailWidth, 60)];
        detailLabel.backgroundColor = [UIColor clearColor];
        detailLabel.textColor = [UIColor colorWithR:51 G:51 B:51 A:1];
        detailLabel.numberOfLines = 1;
        detailLabel.font = [UIFont fontWithName:FONT_GOODFISH size:sizeDetail];
        [self addSubview:detailLabel];
        

        
        buyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - offset, 70, 80, 30)];
//        buyImageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        buyImageView.layer.borderWidth = 1.0;
//        buyImageView.layer.cornerRadius = 6;
        [self addSubview:buyImageView];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        UIImage *image = nil;
        //        menuYellow
        
        switch ([RWGameData sharedGameData].thema)
        {
            case 0:{
                image = [UIImage imageNamed:@"extraCell"];
            }
                break;
            case 1:{
                image = [UIImage imageNamed:@"menuYellow"];
            }
                break;
            case 2:{
                image = [UIImage imageNamed:@"menuYellow"];
            }
                break;
                
            default:
            {
                image = [UIImage imageNamed:@"extraCell"];
            }
                break;
        }
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(10.0,10.0,10.0,10.0) resizingMode:UIImageResizingModeStretch]];
    }else{
        UIImage *image = nil;
        //        menuYellow
        
        switch ([RWGameData sharedGameData].thema)
        {
            case 0:{
                image = [UIImage imageNamed:@"menuYellow"];
            }
                break;
            case 1:{
                image = [UIImage imageNamed:@"extraCell"];
            }
                break;
            case 2:{
                image = [UIImage imageNamed:@"extraCell"];
            }
                break;
                
            default:
            {
                image = [UIImage imageNamed:@"menuYellow"];
            }
                break;
        }
        
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [[UIImageView alloc] initWithImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(10.0,10.0,10.0,10.0) resizingMode:UIImageResizingModeStretch]];
    }
    // Configure the view for the selected state
}

@end
