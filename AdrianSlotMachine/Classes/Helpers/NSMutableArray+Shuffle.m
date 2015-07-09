//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"


@implementation NSMutableArray (Shuffle)

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)shuffle {
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < arc4random_uniform(4) + 2; ++i) {
        for (NSUInteger j = 0; j < count; ++j) {
            NSInteger remainingCount = count - j;
            NSInteger exchangeIndex = j + arc4random_uniform(remainingCount);
            [self exchangeObjectAtIndex:j withObjectAtIndex:exchangeIndex];
        }
    }

}

#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - Protocols
#pragma mark - Notifications

@end
