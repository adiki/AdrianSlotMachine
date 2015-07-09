//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ASLFruitType) {
    ASLFruitTypeBurrito,
    ASLFruitTypeAvocado,
    ASLFruitTypeSkeleton,
};


@interface ASLFruits : NSObject

+ (NSArray *)fruitTypes;
+ (NSString *)imageNameForFruitType:(ASLFruitType)fruitType;

@end
