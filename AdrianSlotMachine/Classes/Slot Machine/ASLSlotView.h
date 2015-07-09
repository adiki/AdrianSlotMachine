//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ASLSlotView : UITableView

- (instancetype)initWithDataSource:(id <UITableViewDataSource>)dataSource;

- (void)spinSlotToItemNumber:(NSUInteger)itemNumber;
- (void)spinSlot;

@end
