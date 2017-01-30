//
//  GuessResultCell.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/18/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "GuessResultCell.h"
#import "RWGameData.h"

#define CELL_OPP_INDEX_IPHONE (IS_IPHONE_6P ? CGRectMake(238, 10, 33, 25) :(IS_IPHONE_6 ? CGRectMake(218, 10, 32, 25) : IS_IPHONE_5 ? CGRectMake(175, 10, 30, 25) : CGRectMake(170, 10, 30, 25) ))
#define CELL_OPP_INDEX IS_IPHONE ? CELL_OPP_INDEX_IPHONE : CGRectMake(500, 10, 33, 25)

#define CELL_MY_INDEX CGRectMake(4, 10, 31, 25)
#define CELL_MY_NUMBER CGRectMake(30, 10, 80, 25)

#define CELL_MY_POZITIVE3_IPHONE (IS_IPHONE_6P ? CGRectMake(82, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(82, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(76, 10, 25, 25) : CGRectMake(76, 10, 25, 25) ))
#define CELL_MY_POZITIVE3 IS_IPHONE ? CELL_MY_POZITIVE3_IPHONE : CGRectMake(95, 10, 25, 25)

#define CELL_MY_NEGATIVE3_IPHONE (IS_IPHONE_6P ? CGRectMake(112, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(112, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(105, 10, 25, 25) : CGRectMake(105, 10, 25, 25) ))
#define CELL_MY_NEGATIVE3 IS_IPHONE ? CELL_MY_NEGATIVE3_IPHONE : CGRectMake(125, 10, 25, 25)

#define CELL_MY_POZITIVE4_IPHONE (IS_IPHONE_6P ? CGRectMake(92, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(92, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(84, 10, 25, 25) : CGRectMake(84, 10, 25, 25) ))
#define CELL_MY_POZITIVE4 IS_IPHONE ? CELL_MY_POZITIVE4_IPHONE : CGRectMake(102, 10, 25, 25)

#define CELL_MY_NEGATIVE4_IPHONE (IS_IPHONE_6P ? CGRectMake(122, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(122, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(114, 10, 25, 25) : CGRectMake(114, 10, 25, 25) ))
#define CELL_MY_NEGATIVE4 IS_IPHONE ? CELL_MY_NEGATIVE4_IPHONE : CGRectMake(132, 10, 25, 25)



#define CELL_OPP_NUMBER_IPHONE (IS_IPHONE_6P ? CGRectMake(268, 10, 80, 25) :(IS_IPHONE_6 ? CGRectMake(248, 10, 80, 25) : IS_IPHONE_5 ? CGRectMake(200, 10, 80, 25) : CGRectMake(195, 10, 80, 25) ))
#define CELL_OPP_NUMBER IS_IPHONE ? CELL_OPP_NUMBER_IPHONE : CGRectMake(530,10, 100, 25)

#define CELL_OPP_POZITIVE3_IPHONE (IS_IPHONE_6P ? CGRectMake(316, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(296, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(240, 10, 25, 25) : CGRectMake(235, 10, 25, 25) ))
#define CELL_OPP_POZITIVE3 IS_IPHONE ? CELL_OPP_POZITIVE3_IPHONE : CGRectMake(595,10, 25, 25)

#define CELL_OPP_NEGATIVE3_IPHONE (IS_IPHONE_6P ? CGRectMake(345, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(325, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(270, 10, 25, 25) : CGRectMake(265, 10, 25, 25) ))
#define CELL_OPP_NEGATIVE3 IS_IPHONE ? CELL_OPP_NEGATIVE3_IPHONE : CGRectMake(625,10, 25, 25)


#define CELL_OPP_POZITIVE4_IPHONE (IS_IPHONE_6P ? CGRectMake(326, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(306, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(250, 10, 25, 25) : CGRectMake(245, 10, 25, 25) ))
#define CELL_OPP_POZITIVE4 IS_IPHONE ? CELL_OPP_POZITIVE4_IPHONE : CGRectMake(602,10, 25, 25)

#define CELL_OPP_NEGATIVE4_IPHONE (IS_IPHONE_6P ? CGRectMake(355, 10, 25, 25) :(IS_IPHONE_6 ? CGRectMake(335, 10, 25, 25) : IS_IPHONE_5 ? CGRectMake(280, 10, 25, 25) : CGRectMake(275, 10, 25, 25) ))
#define CELL_OPP_NEGATIVE4 IS_IPHONE ? CELL_OPP_NEGATIVE4_IPHONE : CGRectMake(632,10, 25, 25)


@implementation GuessResultCell

@synthesize myNumber;
@synthesize estimatedNumber;
@synthesize numberLabel;
@synthesize numberResultLabel;
@synthesize estimatedNumberLabel;
@synthesize estimatedResultLabel;
@synthesize numberResultNegativeLabel;
@synthesize estimatedResultNegativeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withMyNumbers:(MyNumber *)_number andEstimatedNumbers:(EstimatedNumber*)_estimatedNumber {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.myNumber = _number;
        self.estimatedNumber = _estimatedNumber;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        CGFloat fontSize = 23;
        CGFloat fontSize2 = 17;
        CGFloat fontSize3 = 21;
        if (IS_IPAD) {
            fontSize = 26;
            fontSize2 = 20;
        }
        
        if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
            fontSize = 20;
            fontSize2 = 16;
            fontSize3 = 19;
        }
        
        _indexLabel = [[UILabel alloc] initWithFrame:CELL_MY_INDEX];
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.font = [UIFont fontWithName:FONT_ROBOTO size:fontSize3];
        _indexLabel.textAlignment = NSTextAlignmentLeft;
        _indexLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _indexLabel.numberOfLines = 1;
        
        switch ([RWGameData sharedGameData].thema)
        {
            case 0:{
                _indexLabel.textColor = [UIColor colorWithR:248 G:196 B:138 A:1];
                [self addSubview:[self addBorderToLabel:_indexLabel]];
            }
                break;
            case 1:{
                _indexLabel.textColor = [UIColor colorWithR:23 G:140 B:193 A:1];
                [self addSubview:[self addBorderToLabel2:_indexLabel]];
                
            }
                break;
            case 2:{
                _indexLabel.textColor = [UIColor colorWithR:248 G:196 B:138 A:1];
                [self addSubview:[self addBorderToLabel:_indexLabel]];
            }
                break;
            default:{
                _indexLabel.textColor = [UIColor colorWithR:248 G:196 B:138 A:1];
                [self addSubview:[self addBorderToLabel:_indexLabel]];
            }
                break;
        }
        

        
        numberLabel = [[UILabel alloc] initWithFrame:CELL_MY_NUMBER];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.font = [UIFont fontWithName:FONT_ROBOTO size:fontSize];
        numberLabel.textColor = [UIColor whiteColor];
        numberLabel.textAlignment = NSTextAlignmentLeft;
        numberLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        numberLabel.numberOfLines = 1;
        
        [self addSubview:[self addBorderToLabel:numberLabel]];
        
        
        if ([RWGameData sharedGameData].threeDigitGame) {
            numberResultLabel = [[UILabel alloc] initWithFrame:CELL_MY_POZITIVE3];
        }else{
            numberResultLabel = [[UILabel alloc] initWithFrame:CELL_MY_POZITIVE4];
        }

        numberResultLabel.backgroundColor = [UIColor clearColor];
        numberResultLabel.font = [UIFont boldSystemFontOfSize:fontSize2];
        numberResultLabel.layer.masksToBounds = YES;
        numberResultLabel.layer.cornerRadius = 12.0;
        numberResultLabel.textColor = [UIColor colorWithRed:0.0/256.0 green:153.0/256.0 blue:76.0/256.0 alpha:1];
        numberResultLabel.textAlignment = NSTextAlignmentCenter;
        numberResultLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        numberResultLabel.numberOfLines = 1;
        [self addSubview:numberResultLabel];
        
        if ([RWGameData sharedGameData].threeDigitGame) {
            numberResultNegativeLabel = [[UILabel alloc] initWithFrame:CELL_MY_NEGATIVE3];
        }else{
            numberResultNegativeLabel = [[UILabel alloc] initWithFrame:CELL_MY_NEGATIVE4];
        }


        numberResultNegativeLabel.backgroundColor = [UIColor clearColor];
        numberResultNegativeLabel.layer.masksToBounds = YES;
        numberResultNegativeLabel.layer.cornerRadius = 12.0;
        numberResultNegativeLabel.font = [UIFont boldSystemFontOfSize:fontSize2];
        numberResultNegativeLabel.textColor = [UIColor colorWithR:213 G:10 B:10 A:1];
        numberResultNegativeLabel.textAlignment = NSTextAlignmentCenter;
        numberResultNegativeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        numberResultNegativeLabel.numberOfLines = 1;
        [self addSubview:numberResultNegativeLabel];
        

        _indexLabel2 = [[UILabel alloc] initWithFrame:CELL_OPP_INDEX];
        _indexLabel2.backgroundColor = [UIColor clearColor];
        _indexLabel2.font = [UIFont fontWithName:FONT_ROBOTO size:fontSize3];
        _indexLabel2.textAlignment = NSTextAlignmentLeft;
        _indexLabel2.lineBreakMode = NSLineBreakByTruncatingTail;
        _indexLabel2.numberOfLines = 1;
        
        switch ([RWGameData sharedGameData].thema)
        {
            case 0:{
                _indexLabel2.textColor = [UIColor colorWithR:248 G:196 B:138 A:1];
                [self addSubview:[self addBorderToLabel:_indexLabel2]];
            }
                break;
            case 1:{
                _indexLabel2.textColor = [UIColor colorWithR:23 G:140 B:193 A:1];
                [self addSubview:[self addBorderToLabel2:_indexLabel2]];
            }
                break;
            case 2:{
                _indexLabel2.textColor = [UIColor colorWithR:248 G:196 B:138 A:1];
                [self addSubview:[self addBorderToLabel:_indexLabel2]];
            }
                break;
            default:{
                _indexLabel2.textColor = [UIColor colorWithR:248 G:196 B:138 A:1];
                [self addSubview:[self addBorderToLabel:_indexLabel2]];
            }
                break;
        }
        
        


        
        estimatedNumberLabel = [[UILabel alloc] initWithFrame:CELL_OPP_NUMBER];
        estimatedNumberLabel.backgroundColor = [UIColor clearColor];
        estimatedNumberLabel.font = [UIFont fontWithName:FONT_ROBOTO size:fontSize];
        estimatedNumberLabel.textColor = [UIColor whiteColor];
        estimatedNumberLabel.textAlignment = NSTextAlignmentLeft;
        estimatedNumberLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        estimatedNumberLabel.numberOfLines = 1;
        [self addSubview:[self addBorderToLabel:estimatedNumberLabel]];
        
        if ([RWGameData sharedGameData].threeDigitGame) {
            estimatedResultLabel = [[UILabel alloc] initWithFrame:CELL_OPP_POZITIVE3];
        }else{
            estimatedResultLabel = [[UILabel alloc] initWithFrame:CELL_OPP_POZITIVE4];
        }

        estimatedResultLabel.backgroundColor = [UIColor clearColor];
        estimatedResultLabel.layer.masksToBounds = YES;
        estimatedResultLabel.layer.cornerRadius = 12.0;
        estimatedResultLabel.font = [UIFont boldSystemFontOfSize:fontSize2];
        estimatedResultLabel.textColor = [UIColor colorWithRed:0.0/256.0 green:153.0/256.0 blue:76.0/256.0 alpha:1];
        estimatedResultLabel.textAlignment = NSTextAlignmentCenter;
        estimatedResultLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        estimatedResultLabel.numberOfLines = 1;
        [self addSubview:estimatedResultLabel];

        if ([RWGameData sharedGameData].threeDigitGame) {
            estimatedResultNegativeLabel = [[UILabel alloc] initWithFrame:CELL_OPP_NEGATIVE3];
        }else{
            estimatedResultNegativeLabel = [[UILabel alloc] initWithFrame:CELL_OPP_NEGATIVE4];
        }
        
        estimatedResultNegativeLabel.backgroundColor = [UIColor clearColor];
        estimatedResultNegativeLabel.layer.masksToBounds = YES;
        estimatedResultNegativeLabel.layer.cornerRadius = 12.0;
        estimatedResultNegativeLabel.font = [UIFont boldSystemFontOfSize:fontSize2];
        estimatedResultNegativeLabel.textColor = [UIColor colorWithR:213 G:10 B:10 A:1];
        estimatedResultNegativeLabel.textAlignment = NSTextAlignmentCenter;
        estimatedResultNegativeLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        estimatedResultNegativeLabel.numberOfLines = 1;
        [self addSubview:estimatedResultNegativeLabel];

        self.layoutMargins = UIEdgeInsetsZero;
        
//        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height -1, [UIScreen mainScreen].bounds.size.width, 1)];/// change size as you need.
//        UIColor *color = nil;
//        if (IS_IPHONE_4_OR_LESS) {
//            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lines5"]];
//        }else if (IS_IPHONE_5) {
//            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lines5"]];
//        }else if(IS_IPHONE_6){
//            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lines"]];
//        }else if(IS_IPHONE_6P){
//            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lines6"]];
//        }else if(IS_IPAD){
//            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"linesHD"]];
//        }else{
//            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lines"]];
//        }
//        
//       
//        separatorLineView.backgroundColor = color;// you can also put image here
//        [self addSubview:separatorLineView];
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

-(UILabel*) addBorderToLabel2:(UILabel*)label{
    label.layer.shadowColor = [[UIColor whiteColor] CGColor];
    label.layer.shadowOffset = CGSizeMake(0.0, 1.0);
    label.layer.shadowRadius = 1.5;
    label.layer.shadowOpacity = 0.6;
    label.layer.masksToBounds = NO;
    label.layer.shouldRasterize = YES;
    
    
    return label;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
