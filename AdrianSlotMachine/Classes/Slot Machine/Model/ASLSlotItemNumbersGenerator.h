//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ASLSlotItemNumbersGenerator : NSObject

@property(nonatomic, assign) NSUInteger generationUpperRange;

- (NSArray *)generateSlotItemNumbers;
@end
