//
// Created by a on 10/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASLSlotMachineHistoryViewController;


extern NSString *const kHistoryCellIdentifier;

@protocol ASLSlotMachineHistoryViewControllerDelegate

- (void)slotMachineHistoryViewControllerCloseButtonTapped:(ASLSlotMachineHistoryViewController *)slotMachineHistoryViewController;

@end

@interface ASLSlotMachineHistoryViewController : UIViewController

@property(nonatomic, weak) id<ASLSlotMachineHistoryViewControllerDelegate> delegate;

- (instancetype)initWithFruitsHistory:(NSArray *)fruitsHistory;
@end
