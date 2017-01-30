//
//  Numbers.m
//  NumbersGame
//
//  Created by Alaattin Bedir on 5/31/15.
//  Copyright (c) 2015 Alaattin Bedir. All rights reserved.
//

#import "Numbers.h"
#import "TextureNumbers.h"
#import "RWGameData.h"

@implementation Numbers

NSMutableArray *doubleDigits;
NSMutableArray *notAvailableDigits;
NSMutableArray *availableDigits;
NSMutableArray *foundedDigits;
NSMutableArray *yeriSabitRakamDizisi;
EstimatedNumber *numberFounded;
EstimatedNumber *artiDortDegerliSayi;
NSMutableArray *foundedNumbers;
NSMutableArray *numbersPool;


@synthesize  tumSayilarBirTahmindeBulundu;
@synthesize  tumSayilarBulundu;
@synthesize  artiDortDegerliSayiBulundu;
@synthesize doubleDigits;
@synthesize myDoubleDigits;
@synthesize availableDigits;
@synthesize notAvailableDigits;
@synthesize foundedDigits;
@synthesize yeriSabitRakamDizisi;
@synthesize foundedNumbers;
@synthesize myNumbersPool;



+ (instancetype)sharedNumbers
{
    static Numbers *sharedNumbers;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNumbers = [[Numbers alloc] init];
    });
    return sharedNumbers;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.doubleDigits = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        self.myDoubleDigits = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
        self.availableDigits = [[NSMutableArray alloc] init];
        self.notAvailableDigits = [[NSMutableArray alloc] init];
        self.foundedDigits = [[NSMutableArray alloc] init];
        self.tumSayilarBirTahmindeBulundu = FALSE;
        self.artiDortDegerliSayiBulundu = FALSE;
        self.yeriSabitRakamDizisi = [[NSMutableArray alloc] init];
        self.foundedNumbers =  [[NSMutableArray alloc] init];
    }
    return self;
}


- (MyNumber*) createRandomMyNumber{
    NSMutableArray *digitsArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
   
    int firstNumberPosition = (int)(arc4random() % 10 + 0);
    NSNumber *firstNumber = [digitsArray objectAtIndex:firstNumberPosition];
    [digitsArray removeObjectAtIndex:firstNumberPosition];
    
    int secondNumberPosition = (int)(arc4random() % 9 + 0);
    NSNumber *secondNumber = [digitsArray objectAtIndex:secondNumberPosition];
    [digitsArray removeObjectAtIndex:secondNumberPosition];
    
    int thirdNumberPosition = (int)(arc4random() % 8 + 0);
    NSNumber *thirdNumber = [digitsArray objectAtIndex:thirdNumberPosition];
    [digitsArray removeObjectAtIndex:thirdNumberPosition];
    
    MyNumber *myNumber = [[MyNumber alloc]init];
    myNumber.FirstNumber = firstNumber;
    myNumber.SecondNumber = secondNumber;
    myNumber.ThirdNumber = thirdNumber;
    
    if ([RWGameData sharedGameData].fourDigitGame) {
        int fourthNumberPosition = (int)(arc4random() % 7 + 0);
        NSNumber *fourthNumber = [digitsArray objectAtIndex:fourthNumberPosition];
        [digitsArray removeObjectAtIndex:fourthNumberPosition];
        
        myNumber.FourthNumber = fourthNumber;
        NSLog(@":::MyNumber::: %@%@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber,myNumber.FourthNumber);
    }
    
    NSLog(@":::MyNumber::: %@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber);
    
    return myNumber;
}

- (MyNumber*) createRandomComputerNumber{
    NSMutableArray *digitsArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    
    int firstNumberPosition = (int)(arc4random() % 10 + 0);
    NSNumber *firstNumber = [digitsArray objectAtIndex:firstNumberPosition];
    [digitsArray removeObjectAtIndex:firstNumberPosition];
    
    int secondNumberPosition = (int)(arc4random() % 9 + 0);
    NSNumber *secondNumber = [digitsArray objectAtIndex:secondNumberPosition];
    [digitsArray removeObjectAtIndex:secondNumberPosition];
    
    int thirdNumberPosition = (int)(arc4random() % 8 + 0);
    NSNumber *thirdNumber = [digitsArray objectAtIndex:thirdNumberPosition];
    [digitsArray removeObjectAtIndex:thirdNumberPosition];
    
    MyNumber *myNumber = [[MyNumber alloc]init];
    myNumber.FirstNumber = firstNumber;
    myNumber.SecondNumber = secondNumber;
    myNumber.ThirdNumber = thirdNumber;
    
    if ([RWGameData sharedGameData].fourDigitGame) {
        int fourthNumberPosition = (int)(arc4random() % 7 + 0);
        NSNumber *fourthNumber = [digitsArray objectAtIndex:fourthNumberPosition];
        [digitsArray removeObjectAtIndex:fourthNumberPosition];
        myNumber.FourthNumber = fourthNumber;
        NSLog(@":::ComputerNumber::: %@%@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber,myNumber.FourthNumber);
    }
    
    NSLog(@":::ComputerNumber::: %@%@%@",myNumber.FirstNumber,myNumber.SecondNumber,myNumber.ThirdNumber);
    
    return myNumber;
}

-(void) createNumbersPool3{
    NSMutableArray *digitsArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    numbersPool = [NSMutableArray new];
    EstimatedNumber *temp = nil;
    NSNumber *number = nil;
    int index = 0;
    for (int i = 0; i < [digitsArray count]; i++) {
        // ilk sayiyi al sabit tut digerlerini degistir
        number = [doubleDigits objectAtIndex:i];
        temp = [[EstimatedNumber alloc]init];
        temp.FirstNumber = number;
        
        for (int j = 0; j<[digitsArray count]; j++) {
            
            if(j==i)
                continue;
            
            number = [doubleDigits objectAtIndex:j];
            temp.SecondNumber = number;
            
            for (int k = 0; k < [digitsArray count]; k++) {
                
                if (k==j || k==i) {
                    continue;
                }
                
                number = [doubleDigits objectAtIndex:k];
                temp.ThirdNumber = number;
                
                
                EstimatedNumber *tempToAdd = [[EstimatedNumber alloc]init];
                tempToAdd.FirstNumber = temp.FirstNumber;
                tempToAdd.SecondNumber = temp.SecondNumber;
                tempToAdd.ThirdNumber = temp.ThirdNumber;
                
                index++;
                [numbersPool addObject:tempToAdd];
                
//                NSLog(@"Pool Number %i. %@%@%@",index,tempToAdd.FirstNumber,tempToAdd.SecondNumber,tempToAdd.ThirdNumber);
                
            }
            
        }
    }
}

-(void) createNumbersPool4{
    NSMutableArray *digitsArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    numbersPool = [NSMutableArray new];
    EstimatedNumber *temp = nil;
    NSNumber *number = nil;
    int index = 0;
    for (int i = 0; i < [digitsArray count]; i++) {
        // ilk sayiyi al sabit tut digerlerini degistir
        number = [doubleDigits objectAtIndex:i];
        temp = [[EstimatedNumber alloc]init];
        temp.FirstNumber = number;

        for (int j = 0; j<[digitsArray count]; j++) {
            
            if(j==i)
                continue;
            
            number = [doubleDigits objectAtIndex:j];
            temp.SecondNumber = number;
            
            for (int k = 0; k < [digitsArray count]; k++) {

                if (k==j || k==i) {
                    continue;
                }
                
                number = [doubleDigits objectAtIndex:k];
                temp.ThirdNumber = number;
                

                for (int m = 0; m < [digitsArray count]; m++) {
                    
                    if (m==j || m==i || m == k) {
                        continue;
                    }
                    
                    
                    number = [doubleDigits objectAtIndex:m];
                    temp.FourthNumber = number;
                    
                    EstimatedNumber *tempToAdd = [[EstimatedNumber alloc]init];
                    tempToAdd.FirstNumber = temp.FirstNumber;
                    tempToAdd.SecondNumber = temp.SecondNumber;
                    tempToAdd.ThirdNumber = temp.ThirdNumber;
                    tempToAdd.FourthNumber = temp.FourthNumber;
                    
                    index++;
                    [numbersPool addObject:tempToAdd];
                    
//                    NSLog(@"Pool Number %i. %@%@%@%@",index,tempToAdd.FirstNumber,tempToAdd.SecondNumber,tempToAdd.ThirdNumber,tempToAdd.FourthNumber);
                }
                
            }
            
        }
    }
}

-(void) createMyNumbersPool3{
    NSMutableArray *digitsArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    myNumbersPool = [NSMutableArray new];
    EstimatedNumber *temp = nil;
    NSNumber *number = nil;
    int index = 0;
    for (int i = 0; i < [digitsArray count]; i++) {
        // ilk sayiyi al sabit tut digerlerini degistir
        number = [myDoubleDigits objectAtIndex:i];
        temp = [[EstimatedNumber alloc]init];
        temp.FirstNumber = number;
        
        for (int j = 0; j<[digitsArray count]; j++) {
            
            if(j==i)
                continue;
            
            number = [myDoubleDigits objectAtIndex:j];
            temp.SecondNumber = number;
            
            for (int k = 0; k < [digitsArray count]; k++) {
                
                if (k==j || k==i) {
                    continue;
                }
                
                number = [myDoubleDigits objectAtIndex:k];
                temp.ThirdNumber = number;
                
                
                EstimatedNumber *tempToAdd = [[EstimatedNumber alloc]init];
                tempToAdd.FirstNumber = temp.FirstNumber;
                tempToAdd.SecondNumber = temp.SecondNumber;
                tempToAdd.ThirdNumber = temp.ThirdNumber;
                
                index++;
                [myNumbersPool addObject:tempToAdd];
                
//                                NSLog(@"Pool Number %i. %@%@%@",index,tempToAdd.FirstNumber,tempToAdd.SecondNumber,tempToAdd.ThirdNumber);
                
            }
            
        }
    }
}


-(void) createMyNumbersPool4{
    NSMutableArray *digitsArray = [NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    myNumbersPool = [NSMutableArray new];
    EstimatedNumber *temp = nil;
    NSNumber *number = nil;
    int index = 0;
    for (int i = 0; i < [digitsArray count]; i++) {
        // ilk sayiyi al sabit tut digerlerini degistir
        number = [myDoubleDigits objectAtIndex:i];
        temp = [[EstimatedNumber alloc]init];
        temp.FirstNumber = number;
        
        for (int j = 0; j<[digitsArray count]; j++) {
            
            if(j==i)
                continue;
            
            number = [myDoubleDigits objectAtIndex:j];
            temp.SecondNumber = number;
            
            for (int k = 0; k < [digitsArray count]; k++) {
                
                if (k==j || k==i) {
                    continue;
                }
                
                number = [myDoubleDigits objectAtIndex:k];
                temp.ThirdNumber = number;
                
                
                for (int m = 0; m < [digitsArray count]; m++) {
                    
                    if (m==j || m==i || m == k) {
                        continue;
                    }
                    
                    
                    number = [doubleDigits objectAtIndex:m];
                    temp.FourthNumber = number;
                    
                    EstimatedNumber *tempToAdd = [[EstimatedNumber alloc]init];
                    tempToAdd.FirstNumber = temp.FirstNumber;
                    tempToAdd.SecondNumber = temp.SecondNumber;
                    tempToAdd.ThirdNumber = temp.ThirdNumber;
                    tempToAdd.FourthNumber = temp.FourthNumber;
                    
                    index++;
                    [myNumbersPool addObject:tempToAdd];
                    
//                    NSLog(@"Pool Number %i. %@%@%@%@",index,tempToAdd.FirstNumber,tempToAdd.SecondNumber,tempToAdd.ThirdNumber,tempToAdd.FourthNumber);
                }
                
            }
            
        }
    }
}

- (EstimatedNumber*)analyzeMyGuessNumber3:(EstimatedNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber{
    
    
    // Firstnumber analyzing
    if ([myNumber.FirstNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        myNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        myNumber.NegativeResult += 1;
    }
    
    // Second number analyzing
    if ([myNumber.SecondNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        myNumber.PositiveResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        myNumber.NegativeResult += 1;
    }
    
    // Third number analyzing
    if ([myNumber.ThirdNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        myNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        myNumber.NegativeResult += 1;
    }
    
    
    return myNumber;
    
}

- (EstimatedNumber*)analyzeMyGuessNumber4:(EstimatedNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber{
    
    // Firstnumber analyzing
    if ([myNumber.FirstNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        myNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.FourthNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        myNumber.NegativeResult += 1;
    }
    
    // Second number analyzing
    if ([myNumber.SecondNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        myNumber.PositiveResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.FourthNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        myNumber.NegativeResult += 1;
    }
    
    // Third number analyzing
    if ([myNumber.ThirdNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        myNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.FourthNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        myNumber.NegativeResult += 1;
    }
    
    // Fourth number analyzing
    if ([myNumber.FourthNumber intValue] == [estimatedNumber.FourthNumber intValue]){
        myNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.FourthNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.FourthNumber intValue]){
        myNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.FourthNumber intValue]){
        myNumber.NegativeResult += 1;
    }

    
    
    return myNumber;
    
}

- (EstimatedNumber*)analyzeMyNumber3:(MyNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber{
    
    
    // Firstnumber analyzing
    if ([myNumber.FirstNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        estimatedNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }
    
    // Second number analyzing
    if ([myNumber.SecondNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        estimatedNumber.PositiveResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }
    
    // Third number analyzing
    if ([myNumber.ThirdNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        estimatedNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }
    
    
    return estimatedNumber;
    
}

- (EstimatedNumber*)analyzeMyNumber4:(MyNumber*)myNumber withEstimatedNumber:(EstimatedNumber*)estimatedNumber{

    
    // Firstnumber analyzing
    if ([myNumber.FirstNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        estimatedNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.FourthNumber intValue] == [estimatedNumber.FirstNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }
    
    // Second number analyzing
    if ([myNumber.SecondNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        estimatedNumber.PositiveResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.FourthNumber intValue] == [estimatedNumber.SecondNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }
    
    // Third number analyzing
    if ([myNumber.ThirdNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        estimatedNumber.PositiveResult += 1;
    }else if([myNumber.SecondNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.FirstNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }else if([myNumber.FourthNumber intValue] == [estimatedNumber.ThirdNumber intValue]){
        estimatedNumber.NegativeResult += 1;
    }

    if ([RWGameData sharedGameData].fourDigitGame) {
        // Fourth number analyzing
        if ([myNumber.FourthNumber intValue] == [estimatedNumber.FourthNumber intValue]){
            estimatedNumber.PositiveResult += 1;
        }else if([myNumber.SecondNumber intValue] == [estimatedNumber.FourthNumber intValue]){
            estimatedNumber.NegativeResult += 1;
        }else if([myNumber.FirstNumber intValue] == [estimatedNumber.FourthNumber intValue]){
            estimatedNumber.NegativeResult += 1;
        }else if([myNumber.ThirdNumber intValue] == [estimatedNumber.FourthNumber intValue]){
            estimatedNumber.NegativeResult += 1;
        }
    }
    
    return estimatedNumber;
    
}


-(BOOL) isFindAllNumbers:(NSMutableArray*)guessNumberHistory {
    
    EstimatedNumber *myNumberGuess = [[EstimatedNumber alloc]init];
    BOOL resultValue = false;
    
    for (int i = 0; i<[guessNumberHistory count]; i++) {
        myNumberGuess = [guessNumberHistory objectAtIndex:i];
        
        //Eger pozitif deger 3 den buyuk ve negatif 0 ise sayilar bulunmustur.
        int total = myNumberGuess.PositiveResult + myNumberGuess.NegativeResult;

        int condition = 0;
        if ([RWGameData sharedGameData].threeDigitGame) {
            condition = 3;
        }else{
            condition = 4;
        }
        
        if(total >= condition)
            resultValue = YES;
    }
    
    return resultValue;
}


-(BOOL) isFindAllNumbersInOneGuess:(EstimatedNumber *)estimatedNumber {
    
    BOOL resultValue = NO;

    int total = estimatedNumber.PositiveResult + estimatedNumber.NegativeResult;
    int condition = 0;
    if ([RWGameData sharedGameData].threeDigitGame) {
        condition = 3;
    }else{
        condition = 4;
    }
    
    //Eger pozitif deger 3 den buyuk ve negatif 0 ise sayilar bulunmustur.
    if(total >= condition){
        numberFounded = estimatedNumber;
        tumSayilarBirTahmindeBulundu = YES;
        [foundedDigits removeAllObjects];
        if ([RWGameData sharedGameData].threeDigitGame) {
            [foundedDigits addObject:numberFounded.FirstNumber];
            [foundedDigits addObject:numberFounded.SecondNumber];
            [foundedDigits addObject:numberFounded.ThirdNumber];
        }else{
            [foundedDigits addObject:numberFounded.FirstNumber];
            [foundedDigits addObject:numberFounded.SecondNumber];
            [foundedDigits addObject:numberFounded.ThirdNumber];
            [foundedDigits addObject:numberFounded.FourthNumber];
        }
        resultValue = YES;
    }
    
    return resultValue;
}

-(void) createMyPossibleNumbersPool3:(EstimatedNumber *)myNumberGuess{
    
    NSMutableArray *tempNumbersPool = [NSMutableArray new];
    
    EstimatedNumber *myGuessNumber = [[EstimatedNumber alloc]init];
    myGuessNumber.FirstNumber = myNumberGuess.FirstNumber;
    myGuessNumber.SecondNumber = myNumberGuess.SecondNumber;
    myGuessNumber.ThirdNumber = myNumberGuess.ThirdNumber;
    myGuessNumber.PositiveResult = myNumberGuess.PositiveResult;
    myGuessNumber.NegativeResult = myNumberGuess.NegativeResult;
    
    EstimatedNumber *checkNumber = nil;
    int index = 0;
    EstimatedNumber *resultNumber = nil;
    for (int i = 0; i<[myNumbersPool count]; i++) {
        index++;
        
        checkNumber = (EstimatedNumber*)[myNumbersPool objectAtIndex:i];
        checkNumber.PositiveResult = 0;
        checkNumber.NegativeResult = 0;
        
        resultNumber = [self analyzeMyGuessNumber3:checkNumber withEstimatedNumber:myGuessNumber];
        
        if(resultNumber.PositiveResult ==  myGuessNumber.PositiveResult && resultNumber.NegativeResult ==  myGuessNumber.NegativeResult){
            [tempNumbersPool addObject:[myNumbersPool objectAtIndex:i]];
            //            NSLog(@"My Guncel Pool Number %i. %@%@%@",index,((EstimatedNumber*)[numbersPool objectAtIndex:i]).FirstNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).SecondNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).ThirdNumber);
        }
        
    }
    
    [myNumbersPool removeAllObjects];
    [myNumbersPool addObjectsFromArray:tempNumbersPool];
    NSLog(@"My Guncel muhtemel sayi havuzu: %lu",(unsigned long)[myNumbersPool count]);
    
}

-(void) createMyPossibleNumbersPool4:(EstimatedNumber *)myNumberGuess{
    
    NSMutableArray *tempNumbersPool = [NSMutableArray new];
    
    EstimatedNumber *myGuessNumber = [[EstimatedNumber alloc]init];
    myGuessNumber.FirstNumber = myNumberGuess.FirstNumber;
    myGuessNumber.SecondNumber = myNumberGuess.SecondNumber;
    myGuessNumber.ThirdNumber = myNumberGuess.ThirdNumber;
    myGuessNumber.FourthNumber = myNumberGuess.FourthNumber;

    myGuessNumber.PositiveResult = myNumberGuess.PositiveResult;
    myGuessNumber.NegativeResult = myNumberGuess.NegativeResult;
    
    EstimatedNumber *checkNumber = nil;
    int index = 0;
    EstimatedNumber *resultNumber = nil;
    for (int i = 0; i<[myNumbersPool count]; i++) {
        index++;
        
        checkNumber = (EstimatedNumber*)[myNumbersPool objectAtIndex:i];
        checkNumber.PositiveResult = 0;
        checkNumber.NegativeResult = 0;
        
        resultNumber = [self analyzeMyGuessNumber4:checkNumber withEstimatedNumber:myGuessNumber];
        
        if(resultNumber.PositiveResult ==  myGuessNumber.PositiveResult && resultNumber.NegativeResult ==  myGuessNumber.NegativeResult){
            [tempNumbersPool addObject:[myNumbersPool objectAtIndex:i]];
//            NSLog(@"My Guncel Pool Number %i. %@%@%@",index,((EstimatedNumber*)[numbersPool objectAtIndex:i]).FirstNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).SecondNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).ThirdNumber);
        }
        
    }
    
    [myNumbersPool removeAllObjects];
    [myNumbersPool addObjectsFromArray:tempNumbersPool];
    NSLog(@"My Guncel muhtemel sayi havuzu: %lu",(unsigned long)[myNumbersPool count]);
    
}

-(void) createPossibleNumbersPool3:(EstimatedNumber *)myNumberGuess{
    
    NSMutableArray *tempNumbersPool = [NSMutableArray new];
    
    EstimatedNumber *myGuessNumber = [[EstimatedNumber alloc]init];
    myGuessNumber.FirstNumber = myNumberGuess.FirstNumber;
    myGuessNumber.SecondNumber = myNumberGuess.SecondNumber;
    myGuessNumber.ThirdNumber = myNumberGuess.ThirdNumber;
    myGuessNumber.PositiveResult = myNumberGuess.PositiveResult;
    myGuessNumber.NegativeResult = myNumberGuess.NegativeResult;
    
    
    EstimatedNumber *checkNumber = nil;
    int index = 0;
    EstimatedNumber *resultNumber = nil;
    for (int i = 0; i<[numbersPool count]; i++) {
        index++;
        checkNumber = (EstimatedNumber*)[numbersPool objectAtIndex:i];
        checkNumber.PositiveResult = 0;
        checkNumber.NegativeResult = 0;
        
        resultNumber = [self analyzeMyGuessNumber3:checkNumber withEstimatedNumber:myGuessNumber];
        
        if(resultNumber.PositiveResult ==  myGuessNumber.PositiveResult && resultNumber.NegativeResult ==  myGuessNumber.NegativeResult){
            [tempNumbersPool addObject:[numbersPool objectAtIndex:i]];
            //            NSLog(@"Guncel Pool Number %i. %@%@%@",index,((EstimatedNumber*)[numbersPool objectAtIndex:i]).FirstNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).SecondNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).ThirdNumber);
        }
        
    }
    
    [numbersPool removeAllObjects];
    [numbersPool addObjectsFromArray:tempNumbersPool];
    NSLog(@"Guncel muhtemel sayi havuzu: %lu",(unsigned long)[numbersPool count]);
    
}

-(void) createPossibleNumbersPool4:(EstimatedNumber *)myNumberGuess{
    
    NSMutableArray *tempNumbersPool = [NSMutableArray new];
    
    EstimatedNumber *myGuessNumber = [[EstimatedNumber alloc]init];
    myGuessNumber.FirstNumber = myNumberGuess.FirstNumber;
    myGuessNumber.SecondNumber = myNumberGuess.SecondNumber;
    myGuessNumber.ThirdNumber = myNumberGuess.ThirdNumber;
    myGuessNumber.FourthNumber = myNumberGuess.FourthNumber;
    
    myGuessNumber.PositiveResult = myNumberGuess.PositiveResult;
    myGuessNumber.NegativeResult = myNumberGuess.NegativeResult;
    
    
    EstimatedNumber *checkNumber = nil;
    int index = 0;
    EstimatedNumber *resultNumber = nil;
    for (int i = 0; i<[numbersPool count]; i++) {
        index++;
        checkNumber = (EstimatedNumber*)[numbersPool objectAtIndex:i];
        checkNumber.PositiveResult = 0;
        checkNumber.NegativeResult = 0;
        
        resultNumber = [self analyzeMyGuessNumber4:checkNumber withEstimatedNumber:myGuessNumber];
        
        if(resultNumber.PositiveResult ==  myGuessNumber.PositiveResult && resultNumber.NegativeResult ==  myGuessNumber.NegativeResult){
            [tempNumbersPool addObject:[numbersPool objectAtIndex:i]];
//            NSLog(@"Guncel Pool Number %i. %@%@%@",index,((EstimatedNumber*)[numbersPool objectAtIndex:i]).FirstNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).SecondNumber,((EstimatedNumber*)[numbersPool objectAtIndex:i]).ThirdNumber);
        }
        
    }
    
    [numbersPool removeAllObjects];
    [numbersPool addObjectsFromArray:tempNumbersPool];
    NSLog(@"Guncel muhtemel sayi havuzu: %lu",(unsigned long)[numbersPool count]);
    
}


- (EstimatedNumber*)guessForFoundedNumbersHard3:(EstimatedNumber *)myNumberGuess guessNumberHistory:(NSMutableArray *)guessNumberHistory {
    EstimatedNumber *returnValue = [self createNumberByHardAI3:nil];;

    NSLog(@"%lu.Tahmin: %@%@%@", (unsigned long)([guessNumberHistory count]+1), returnValue.FirstNumber,returnValue.SecondNumber,returnValue.ThirdNumber);
    
    return returnValue;
}

- (EstimatedNumber*)guessForFoundedNumbersHard4:(EstimatedNumber *)myNumberGuess guessNumberHistory:(NSMutableArray *)guessNumberHistory {
    EstimatedNumber *returnValue = [self createNumberByHardAI4:nil];;
    
    NSLog(@"%lu.Tahmin: %@%@%@%@", (unsigned long)([guessNumberHistory count]+1), returnValue.FirstNumber,returnValue.SecondNumber,returnValue.ThirdNumber,returnValue.FourthNumber);
    
    return returnValue;
}

- (EstimatedNumber *)caseFourMinusOne:(NSMutableArray *)guessNumberHistory {
    EstimatedNumber *myNumberGuess = nil;
    // tutan rakamlarin yerini bul ve olmayan sayilardan havuzda olmayan bir tahmin yap
    
    
    int ilk = 0;
    int ikinci = 0;
    int ucuncu = 0;
    
    NSNumber *first = nil;
    NSNumber *second = nil;
    NSNumber *third = nil;
    
    for (int i = 0; i < [numbersPool count]; i++) {
        EstimatedNumber *temp2 = [[EstimatedNumber alloc]init];
        temp2 = [numbersPool objectAtIndex:i];
        
        if (first != nil && ([first intValue] == [temp2.FirstNumber intValue])) {
            ilk++;
            
        }
        
        if(second != nil && ([second intValue] == [temp2.SecondNumber intValue])){
            // ikinci siradaki sayilar yok
            ikinci ++;
            
        }
        
        if(third != nil && ([third intValue] == [temp2.ThirdNumber intValue])){
            // ucuncu siradaki sayilar yok
            ucuncu++;
        }
        
        first = temp2.FirstNumber;
        second = temp2.SecondNumber;
        third = temp2.ThirdNumber;
        
    }
    
    if ((ilk == [numbersPool count]-1) &&
        (ikinci == [numbersPool count]-1)) {
        //1 ve 2 ayni
        
        NSMutableArray *ucuncuSira = [NSMutableArray new];
        for (int j = 0; j< [numbersPool count]; j++) {
            
            EstimatedNumber *temp3 = [[EstimatedNumber alloc]init];
            temp3 = [numbersPool objectAtIndex:j];
            
            [ucuncuSira addObject:temp3.ThirdNumber];
        }
        
        int firstNumberPosition = (int)(arc4random() % [ucuncuSira count] + 0);
        NSNumber *firstNumber = [ucuncuSira objectAtIndex:firstNumberPosition];
        [ucuncuSira removeObjectAtIndex:firstNumberPosition];
        
        int secondNumberPosition = (int)(arc4random() % [ucuncuSira count] + 0);
        NSNumber *secondNumber = [ucuncuSira objectAtIndex:secondNumberPosition];
        [ucuncuSira removeObjectAtIndex:secondNumberPosition];
        
        int thirdNumberPosition = (int)(arc4random() % [ucuncuSira count] + 0);
        NSNumber *thirdNumber = [ucuncuSira objectAtIndex:thirdNumberPosition];
        [ucuncuSira removeObjectAtIndex:thirdNumberPosition];
        
        myNumberGuess = [[EstimatedNumber alloc]init];
        myNumberGuess.FirstNumber = firstNumber;
        myNumberGuess.SecondNumber = secondNumber;
        myNumberGuess.ThirdNumber = thirdNumber;
        
        NSLog(@"%lu.Tahmin: %@%@%@", (unsigned long)([guessNumberHistory count]+1), myNumberGuess.FirstNumber,myNumberGuess.SecondNumber,myNumberGuess.ThirdNumber);
        
        
        return myNumberGuess;
        
    }else if((ilk == [numbersPool count]-1) &&
             (ucuncu == [numbersPool count]-1)){
        //1 ve 3 ayni
        
        NSMutableArray *ikinciSira = [NSMutableArray new];
        for (int j = 0; j< [numbersPool count]; j++) {
            
            EstimatedNumber *temp3 = [[EstimatedNumber alloc]init];
            temp3 = [numbersPool objectAtIndex:j];
            
            [ikinciSira addObject:temp3.SecondNumber];
        }
        
        int firstNumberPosition = (int)(arc4random() % [ikinciSira count] + 0);
        NSNumber *firstNumber = [ikinciSira objectAtIndex:firstNumberPosition];
        [ikinciSira removeObjectAtIndex:firstNumberPosition];
        
        int secondNumberPosition = (int)(arc4random() % [ikinciSira count] + 0);
        NSNumber *secondNumber = [ikinciSira objectAtIndex:secondNumberPosition];
        [ikinciSira removeObjectAtIndex:secondNumberPosition];
        
        int thirdNumberPosition = (int)(arc4random() % [ikinciSira count] + 0);
        NSNumber *thirdNumber = [ikinciSira objectAtIndex:thirdNumberPosition];
        [ikinciSira removeObjectAtIndex:thirdNumberPosition];
        
        myNumberGuess = [[EstimatedNumber alloc]init];
        myNumberGuess.FirstNumber = firstNumber;
        myNumberGuess.SecondNumber = secondNumber;
        myNumberGuess.ThirdNumber = thirdNumber;
        
        NSLog(@"%lu.Tahmin: %@%@%@", (unsigned long)([guessNumberHistory count]+1), myNumberGuess.FirstNumber,myNumberGuess.SecondNumber,myNumberGuess.ThirdNumber);
        
        
        return myNumberGuess;
        
    }else if((ikinci == [numbersPool count]-1) &&
             (ucuncu == [numbersPool count]-1)){
        //2 ve 3 ayni
        NSMutableArray *ilkSira = [NSMutableArray new];
        for (int j = 0; j< [numbersPool count]; j++) {
            
            EstimatedNumber *temp3 = [[EstimatedNumber alloc]init];
            temp3 = [numbersPool objectAtIndex:j];
            
            [ilkSira addObject:temp3.FirstNumber];
        }
        
        int firstNumberPosition = (int)(arc4random() % [ilkSira count] + 0);
        NSNumber *firstNumber = [ilkSira objectAtIndex:firstNumberPosition];
        [ilkSira removeObjectAtIndex:firstNumberPosition];
        
        int secondNumberPosition = (int)(arc4random() % [ilkSira count] + 0);
        NSNumber *secondNumber = [ilkSira objectAtIndex:secondNumberPosition];
        [ilkSira removeObjectAtIndex:secondNumberPosition];
        
        int thirdNumberPosition = (int)(arc4random() % [ilkSira count] + 0);
        NSNumber *thirdNumber = [ilkSira objectAtIndex:thirdNumberPosition];
        [ilkSira removeObjectAtIndex:thirdNumberPosition];
        
        myNumberGuess = [[EstimatedNumber alloc]init];
        myNumberGuess.FirstNumber = firstNumber;
        myNumberGuess.SecondNumber = secondNumber;
        myNumberGuess.ThirdNumber = thirdNumber;
        
        NSLog(@"%lu.Tahmin: %@%@%@", (unsigned long)([guessNumberHistory count]+1), myNumberGuess.FirstNumber,myNumberGuess.SecondNumber,myNumberGuess.ThirdNumber);
        
        
        return myNumberGuess;
    }
    
    
    return myNumberGuess;
}

- (EstimatedNumber*)createNumberByHardAI3:(NSMutableArray*)guessNumberHistory {
    
    EstimatedNumber *myNumberGuess = [[EstimatedNumber alloc]init];
    
    if ([guessNumberHistory count] > 0) {
        EstimatedNumber *temp = (EstimatedNumber *)[guessNumberHistory objectAtIndex:[guessNumberHistory count]-1];
        if (temp.PositiveResult == 4 && temp.NegativeResult == -1 && [guessNumberHistory count] > 0 && [numbersPool count] >= 3) {
            
            myNumberGuess = [self caseFourMinusOne:guessNumberHistory];
            if (myNumberGuess) {
                return myNumberGuess;
            }
        }
    }
    
    
    int numberPosition = (int)(arc4random() % [numbersPool count] + 0);
    myNumberGuess = [numbersPool objectAtIndex:numberPosition];
    [numbersPool removeObjectAtIndex:numberPosition];
    
    NSLog(@"%lu.Tahmin: %@%@%@", (unsigned long)([guessNumberHistory count]+1), myNumberGuess.FirstNumber,myNumberGuess.SecondNumber,myNumberGuess.ThirdNumber);
    
    return myNumberGuess;
}

- (EstimatedNumber*)createNumberByHardAI4:(NSMutableArray*)guessNumberHistory {
    
    EstimatedNumber *myNumberGuess = [[EstimatedNumber alloc]init];

    int numberPosition = (int)(arc4random() % [numbersPool count] + 0);
    myNumberGuess = [numbersPool objectAtIndex:numberPosition];
    [numbersPool removeObjectAtIndex:numberPosition];
    
    NSLog(@"%lu.Tahmin: %@%@%@%@", (unsigned long)([guessNumberHistory count]+1), myNumberGuess.FirstNumber,myNumberGuess.SecondNumber,myNumberGuess.ThirdNumber,myNumberGuess.FourthNumber);
    
    return myNumberGuess;
}

- (EstimatedNumber*)createNumberByVeryHardAI3:(NSMutableArray*)guessNumberHistory {
    
    EstimatedNumber *myNumberGuess = [[EstimatedNumber alloc]init];
    
    // 1. TAHMIN
    if ([guessNumberHistory count] == 0) {
        // rastgele 3 sayi cekilecek ve mevcut sayi listesinden cikarilacak
        int firstNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
        NSNumber *firstNumber = [doubleDigits objectAtIndex:firstNumberPosition];
        [doubleDigits removeObjectAtIndex:firstNumberPosition];
        
        int secondNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
        NSNumber *secondNumber = [doubleDigits objectAtIndex:secondNumberPosition];
        [doubleDigits removeObjectAtIndex:secondNumberPosition];
        
        int thirdNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
        NSNumber *thirdNumber = [doubleDigits objectAtIndex:thirdNumberPosition];
        [doubleDigits removeObjectAtIndex:thirdNumberPosition];
        
        NSLog(@"1.Tahmin: %@%@%@", firstNumber,secondNumber,thirdNumber);
        
        myNumberGuess.FirstNumber = firstNumber;
        myNumberGuess.SecondNumber = secondNumber;
        myNumberGuess.ThirdNumber = thirdNumber;
        
        return myNumberGuess;
    }
    
    // 2. TAHMIN
    if ([guessNumberHistory count] == 1) {
        
        // ilk tahmin sonucunda tum sayilar bulundumu?
        if ([self isFindAllNumbersInOneGuess:[guessNumberHistory objectAtIndex:[guessNumberHistory count]-1]]) {
            //tum sayilar tek tahmin icinde bulundu..
            NSLog(@"tum sayilar tek tahmin icinde bulundu..");
            tumSayilarBirTahmindeBulundu = YES;
            myNumberGuess = [self guessForFoundedNumbersHard3:myNumberGuess guessNumberHistory:guessNumberHistory];
            if (myNumberGuess) {
                return myNumberGuess;
            }
        }else{
            // tum sayilar bulunamadi.
            
            // olmayan numaralari listeye ekle
            EstimatedNumber *temp = (EstimatedNumber*)[guessNumberHistory objectAtIndex:[guessNumberHistory count]-1];
            if (temp.NegativeResult == 0 && temp.PositiveResult == 0){
                [notAvailableDigits addObject:temp.FirstNumber];
                [notAvailableDigits addObject:temp.SecondNumber];
                [notAvailableDigits addObject:temp.ThirdNumber];
            }else{
                [availableDigits addObject:temp.FirstNumber];
                [availableDigits addObject:temp.SecondNumber];
                [availableDigits addObject:temp.ThirdNumber];
            }
            
            // rastgele 3 sayi cekilecek ve mevcut sayi listesinden cikarilacak
            int firstNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
            NSNumber *firstNumber = [doubleDigits objectAtIndex:firstNumberPosition];
            [doubleDigits removeObjectAtIndex:firstNumberPosition];
            
            int secondNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
            NSNumber *secondNumber = [doubleDigits objectAtIndex:secondNumberPosition];
            [doubleDigits removeObjectAtIndex:secondNumberPosition];
            
            int thirdNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
            NSNumber *thirdNumber = [doubleDigits objectAtIndex:thirdNumberPosition];
            [doubleDigits removeObjectAtIndex:thirdNumberPosition];
            
            NSLog(@"2.Tahmin: %@%@%@", firstNumber,secondNumber,thirdNumber);
            
            myNumberGuess.FirstNumber = firstNumber;
            myNumberGuess.SecondNumber = secondNumber;
            myNumberGuess.ThirdNumber = thirdNumber;
            
            return myNumberGuess;
            
        }
        
    }
    
    
    
    return [self createNumberByHardAI3:nil];
    
}


- (EstimatedNumber*)createNumberByVeryHardAI4:(NSMutableArray*)guessNumberHistory {
    
    EstimatedNumber *myNumberGuess = [[EstimatedNumber alloc]init];

    // 1. TAHMIN
    if ([guessNumberHistory count] == 0) {
        // rastgele 3 sayi cekilecek ve mevcut sayi listesinden cikarilacak
        int firstNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
        NSNumber *firstNumber = [doubleDigits objectAtIndex:firstNumberPosition];
        [doubleDigits removeObjectAtIndex:firstNumberPosition];
        
        int secondNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
        NSNumber *secondNumber = [doubleDigits objectAtIndex:secondNumberPosition];
        [doubleDigits removeObjectAtIndex:secondNumberPosition];
        
        int thirdNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
        NSNumber *thirdNumber = [doubleDigits objectAtIndex:thirdNumberPosition];
        [doubleDigits removeObjectAtIndex:thirdNumberPosition];
        
        myNumberGuess.FirstNumber = firstNumber;
        myNumberGuess.SecondNumber = secondNumber;
        myNumberGuess.ThirdNumber = thirdNumber;
        
        int fourthNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
        NSNumber *fourthNumber = [doubleDigits objectAtIndex:fourthNumberPosition];
        [doubleDigits removeObjectAtIndex:fourthNumberPosition];
        
        NSLog(@"1.Tahmin: %@%@%@%@", firstNumber,secondNumber,thirdNumber,fourthNumber);
        myNumberGuess.FourthNumber = fourthNumber;
        
        return myNumberGuess;
    }
    
    // 2. TAHMIN
    if ([guessNumberHistory count] == 1) {
        
        // ilk tahmin sonucunda tum sayilar bulundumu?
        if ([self isFindAllNumbersInOneGuess:[guessNumberHistory objectAtIndex:[guessNumberHistory count]-1]]) {
            //tum sayilar tek tahmin icinde bulundu..
            NSLog(@"tum sayilar tek tahmin icinde bulundu..");
            tumSayilarBirTahmindeBulundu = YES;
            myNumberGuess = [self guessForFoundedNumbersHard4:myNumberGuess guessNumberHistory:guessNumberHistory];
            if (myNumberGuess) {
                return myNumberGuess;
            }
        }else{
            // tum sayilar bulunamadi.
            
            // olmayan numaralari listeye ekle
            EstimatedNumber *temp = (EstimatedNumber*)[guessNumberHistory objectAtIndex:[guessNumberHistory count]-1];
            int total = temp.PositiveResult + temp.NegativeResult;
            if (total == 0){
                if ([RWGameData sharedGameData].threeDigitGame) {
                    [notAvailableDigits addObject:temp.FirstNumber];
                    [notAvailableDigits addObject:temp.SecondNumber];
                    [notAvailableDigits addObject:temp.ThirdNumber];
                }else{
                    [notAvailableDigits addObject:temp.FirstNumber];
                    [notAvailableDigits addObject:temp.SecondNumber];
                    [notAvailableDigits addObject:temp.ThirdNumber];
                    [notAvailableDigits addObject:temp.FourthNumber];
                }
                
            }else{
                if ([RWGameData sharedGameData].threeDigitGame) {
                    [availableDigits addObject:temp.FirstNumber];
                    [availableDigits addObject:temp.SecondNumber];
                    [availableDigits addObject:temp.ThirdNumber];
                }else{
                    [availableDigits addObject:temp.FirstNumber];
                    [availableDigits addObject:temp.SecondNumber];
                    [availableDigits addObject:temp.ThirdNumber];
                    [availableDigits addObject:temp.FourthNumber];
                }
            }
            
            // rastgele 3 sayi cekilecek ve mevcut sayi listesinden cikarilacak
            int firstNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
            NSNumber *firstNumber = [doubleDigits objectAtIndex:firstNumberPosition];
            [doubleDigits removeObjectAtIndex:firstNumberPosition];
            
            int secondNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
            NSNumber *secondNumber = [doubleDigits objectAtIndex:secondNumberPosition];
            [doubleDigits removeObjectAtIndex:secondNumberPosition];
            
            int thirdNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
            NSNumber *thirdNumber = [doubleDigits objectAtIndex:thirdNumberPosition];
            [doubleDigits removeObjectAtIndex:thirdNumberPosition];
            
            int fourthNumberPosition = (int)(arc4random() % [doubleDigits count] + 0);
            NSNumber *fourthNumber = [doubleDigits objectAtIndex:fourthNumberPosition];
            [doubleDigits removeObjectAtIndex:fourthNumberPosition];
            
            
            NSLog(@"2.Tahmin: %@%@%@%@", firstNumber,secondNumber,thirdNumber,fourthNumber);
            
            myNumberGuess.FirstNumber = firstNumber;
            myNumberGuess.SecondNumber = secondNumber;
            myNumberGuess.ThirdNumber = thirdNumber;
            myNumberGuess.FourthNumber = fourthNumber;
            
            return myNumberGuess;
            
        }
        
    }
    
    
    
    return [self createNumberByHardAI4:nil];
    
}



@end
