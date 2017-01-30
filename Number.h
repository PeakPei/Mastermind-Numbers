//
//  Number.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 5/31/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Number : NSObject <NSCoding>

@property (nonatomic,strong) NSNumber *FirstNumber;
@property (nonatomic,strong) NSNumber *SecondNumber;
@property (nonatomic,strong) NSNumber *ThirdNumber;
@property (nonatomic,strong) NSNumber *FourthNumber;
@property (nonatomic,assign) int NumberLength;
@property (nonatomic,assign) int PositiveResult;
@property (nonatomic,assign) int NegativeResult;

@end
