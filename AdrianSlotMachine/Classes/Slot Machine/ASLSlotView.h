//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASLSlotDataSource;

@protocol ASLSlotViewDataSource <UITableViewDataSource>

- (NSInteger)differentFruitTypesCount;

@end

@interface ASLSlotView : UITableView

@property(nonatomic, weak) id <ASLSlotViewDataSource> slotDataSource;

- (void)spinSlotToItemNumber:(NSUInteger)itemNumber animated:(BOOL)animated;

@end
