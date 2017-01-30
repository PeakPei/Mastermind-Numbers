//
//  Numbers.h
//  NumbersGame
//
//  Created by Alaattin Bedir on 5/31/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Number.h"
#import "EstimatedNumber.h"

@interface Numbers : NSObject

+ (instancetype)sharedNumbers;

- (MyNumber*) createRandomMyNumber;

- (MyNumber*) createRandomComputerNumber;

- (EstimatedNumber*)analyzeMyNumber3:(MyNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber;
- (EstimatedNumber*)analyzeMyNumber4:(MyNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber;

- (EstimatedNumber*)analyzeMyGuessNumber3:(EstimatedNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber;
- (EstimatedNumber*)analyzeMyGuessNumber4:(EstimatedNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber;

- (EstimatedNumber*)createNumberByVeryHardAI3:(NSMutableArray*)guessNumberHistory;
- (EstimatedNumber*)createNumberByVeryHardAI4:(NSMutableArray*)guessNumberHistory;

-(void) createNumbersPool4;

-(void) createMyNumbersPool4;

-(void) createNumbersPool3;

-(void) createMyNumbersPool3;

-(void) createPossibleNumbersPool3:(EstimatedNumber *)myNumberGuess;
-(void) createPossibleNumbersPool4:(EstimatedNumber *)myNumberGuess;

-(void) createMyPossibleNumbersPool3:(EstimatedNumber *)myNumberGuess;
-(void) createMyPossibleNumbersPool4:(EstimatedNumber *)myNumberGuess;

- (EstimatedNumber*)createNumberByHardAI3:(NSMutableArray*)guessNumberHistory;
- (EstimatedNumber*)createNumberByHardAI4:(NSMutableArray*)guessNumberHistory;


@property (nonatomic, assign) BOOL tumSayilarBirTahmindeBulundu;
@property (nonatomic, assign) BOOL tumSayilarBulundu;
@property (nonatomic, assign) BOOL artiDortDegerliSayiBulundu;
@property (nonatomic, assign) BOOL bulunanSayiIlkSirada;

@property (nonatomic, strong) NSMutableArray *doubleDigits;
@property (nonatomic, strong) NSMutableArray *myDoubleDigits;
@property (nonatomic, strong) NSMutableArray *availableDigits;
@property (nonatomic, strong) NSMutableArray *notAvailableDigits;
@property (nonatomic, strong) NSMutableArray *foundedDigits;

@property (nonatomic, strong) NSMutableArray *yeriSabitRakamDizisi;
@property (nonatomic, strong) NSMutableArray *foundedNumbers;
@property (nonatomic, strong) NSMutableArray *possibleNumbersPool;
@property (nonatomic, strong) NSMutableArray *myNumbersPool;



@end
