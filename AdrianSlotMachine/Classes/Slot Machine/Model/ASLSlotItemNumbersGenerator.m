//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLSlotItemNumbersGenerator.h"
#import "ASLFruits.h"

NSInteger const kDistanceParameter = 21;
NSInteger const kGenerationUpperRange = 90;

@implementation ASLSlotItemNumbersGenerator

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (NSUInteger)generationUpperRange {
    return kGenerationUpperRange;
}

#pragma mark - IBActions

- (NSArray *)generateSlotItemNumbers {
    NSInteger fruitsCount = [ASLFruits fruitTypes].count;
    NSNumber *firstNumber = @(kGenerationUpperRange - fruitsCount - 2 * kDistanceParameter + 1 + arc4random() % fruitsCount);
    NSNumber *secondNumber = @(kGenerationUpperRange - fruitsCount - kDistanceParameter + 1 + arc4random() % fruitsCount);
    NSNumber *thirdNumber = @(kGenerationUpperRange - fruitsCount + 1 + arc4random() % fruitsCount);
    return @[firstNumber, secondNumber, thirdNumber];
}

#pragma mark - Overridden
#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - Protocols
#pragma mark - Notifications

@end
