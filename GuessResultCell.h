//
//  GuessResultCell.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/18/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNumber.h"
#import "EstimatedNumber.h"

@interface GuessResultCell : UITableViewCell

@property (nonatomic, strong) MyNumber *myNumber;
@property (nonatomic, strong) EstimatedNumber *estimatedNumber;
@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *indexLabel2;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *numberResultLabel;
@property (nonatomic, strong) UILabel *numberResultNegativeLabel;
@property (nonatomic, strong) UILabel *estimatedNumberLabel;
@property (nonatomic, strong) UILabel *estimatedResultLabel;
@property (nonatomic, strong) UILabel *estimatedResultNegativeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withMyNumbers:(MyNumber *)_number andEstimatedNumbers:(EstimatedNumber*)_estimatedNumber;

@end
