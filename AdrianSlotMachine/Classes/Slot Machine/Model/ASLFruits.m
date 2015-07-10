//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLFruits.h"
#import "UIColor+ASLSlotMachine.h"


@implementation ASLFruits

#pragma mark - Public Properties
#pragma mark - Public Class Methods

+ (NSArray *)fruitTypes {
    return @[@(ASLFruitTypeBurrito), @(ASLFruitTypeAvocado), @(ASLFruitTypeSkeleton)];
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

+ (NSArray *)resultFruitsForSlotItemNumbers:(NSArray *)slotItemNumbers {
    NSMutableArray *resultFruits = [NSMutableArray array];

    NSInteger fruitTypesCount = [self fruitTypes].count;
    for (NSNumber *slotItemNumber in slotItemNumbers) {
        [resultFruits addObject:@([slotItemNumber integerValue] % fruitTypesCount)];
    }

    return [resultFruits copy];
}

+ (BOOL)winForResultFruits:(NSArray *)resultFruits {
    NSNumber *firstFruit = resultFruits.firstObject;
    for (int i = 1; i < resultFruits.count; ++i) {
        if ([resultFruits[i] isEqualToNumber:firstFruit] == NO) {
            return NO;
        }
    }
    return YES;
}

+ (NSAttributedString *)titleForResultFruits:(NSArray *)resultFruits {
    if ([self winForResultFruits:resultFruits] == NO) {
        return [self attributedStringForText:@"TRY AGAIN" pinkRange:NSMakeRange(0, 3)];
    }
    switch ((ASLFruitType) [resultFruits.firstObject integerValue]) {
        case ASLFruitTypeBurrito:
            return [self attributedStringForText:@"FREE BURRITO" pinkRange:NSMakeRange(0, 4)];
        case ASLFruitTypeAvocado:
            return [self attributedStringForText:@"FREE GUACAMOLE" pinkRange:NSMakeRange(0, 4)];
        case ASLFruitTypeSkeleton:
            return [self attributedStringForText:@"FREE SKELETON" pinkRange:NSMakeRange(0, 4)];
        default:
            [NSException raise:NSGenericException format:@"Unexpected ASLFruitType."];
    }
}

+ (UIImage *)imageForResultFruits:(NSArray *)resultFruits {
    if ([self winForResultFruits:resultFruits] == NO) {
        return nil;
    }
    return [UIImage imageNamed:[self imageNameForFruitType:(ASLFruitType) [resultFruits.firstObject integerValue]]];
}

#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties
#pragma mark - Private Class Methods

+ (NSAttributedString *)attributedStringForText:(NSString *)text pinkRange:(NSRange)pinkRange {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor asl_PinkColor]
                             range:pinkRange];
    return attributedString;
}

#pragma mark - Private Instance Methods
#pragma mark - Protocols
#pragma mark - Notifications

@end
