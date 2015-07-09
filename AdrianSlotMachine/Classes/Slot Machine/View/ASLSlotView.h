//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASLSlotDataSource;
@class ASLSlotView;

@protocol ASLSlotViewDelegate <UITableViewDelegate>

- (void)slotViewDidFinishSpinning:(ASLSlotView *)slotView;

@end

@interface ASLSlotView : UITableView

- (BOOL)isAnimating;
- (void)spinSlotToItemNumber:(NSUInteger)itemNumber animated:(BOOL)animated;

@end
