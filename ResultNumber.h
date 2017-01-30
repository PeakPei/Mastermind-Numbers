//
//  ResultNumber.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 8/18/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EstimatedNumber.h"

@interface ResultNumber : NSObject<NSCoding>

@property (nonatomic, strong) EstimatedNumber *myNumber;
@property (nonatomic, strong) EstimatedNumber *estimatedNumber;

@end
