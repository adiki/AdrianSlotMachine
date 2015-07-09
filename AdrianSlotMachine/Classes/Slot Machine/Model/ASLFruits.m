//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLFruits.h"


@implementation ASLFruits

#pragma mark - Public Properties
#pragma mark - Public Class Methods

+ (NSArray *)fruitTypes {
    return @[@(ASLFruitTypeBurrito), @(ASLFruitTypeAvocado), @(ASLFruitTypeSkeleton)];;
}

+ (NSString *)imageNameForFruitType:(ASLFruitType)fruitType {
    switch (fruitType) {
        case ASLFruitTypeBurrito:
            return @"fruittype-burrito";
        case ASLFruitTypeAvocado:
            return @"fruittype-avocado";
        case ASLFruitTypeSkeleton:
            return @"fruittype-skeleton";
        default:
            [NSException raise:NSGenericException format:@"Unexpected ASLFruitType."];
    }
}

#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - Protocols
#pragma mark - Notifications

@end
