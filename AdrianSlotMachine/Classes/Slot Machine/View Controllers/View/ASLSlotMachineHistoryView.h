//
// Created by a on 10/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASLSlotMachineHistoryView;

@protocol ASLSlotMachineHistoryViewDelegate

- (void)slotMachineHistoryViewCloseButtonTapped:(ASLSlotMachineHistoryView *)slotMachineHistoryView;

@end

@interface ASLSlotMachineHistoryView : UIView

@property(nonatomic, weak) id<ASLSlotMachineHistoryViewDelegate> delegate;

- (instancetype)initWithDataSource:(id <UITableViewDataSource>)dataSource;

@end
