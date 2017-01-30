//
//  NullCheck.m
//  Acdm_1
//
//  Created by Alaattin Bedir on 6/4/15.
//  Copyright (c) 2015 igones. All rights reserved.
//

#import "NullCheck.h"

@implementation NullCheck

BOOL isNotNull(id object){
    
    if (object == [NSNull null] || !object || object == nil || object == NULL || [object class] == [NSNull class])
        return NO;
    else
        return YES;
}

BOOL isNull(id object){
    
    if (object == [NSNull null] || !object || object == nil || object == NULL || [object class] == [NSNull class])
        return YES;
    else
        return NO;
}

@end
