//
// Created by a on 10/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLSlotMachineHistoryViewController.h"
#import "ASLSlotMachineHistoryView.h"
#import "ASLHistoryCell.h"
#import "ASLFruits.h"

NSString *const kHistoryCellIdentifier = @"kHistoryCellIdentifier";

@interface ASLSlotMachineHistoryViewController () <ASLSlotMachineHistoryViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *fruitsHistory;

@end

@implementation ASLSlotMachineHistoryViewController

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (instancetype)initWithFruitsHistory:(NSArray *)fruitsHistory {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        _fruitsHistory = fruitsHistory;
    }

    return self;
}


#pragma mark - IBActions
#pragma mark - Overridden

- (void)loadView {
    ASLSlotMachineHistoryView *slotMachineHistoryView = [[ASLSlotMachineHistoryView alloc] initWithDataSource:self];
    slotMachineHistoryView.delegate = self;
    self.view = slotMachineHistoryView;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - ASLSlotMachineHistoryViewDelegate

- (void)slotMachineHistoryViewCloseButtonTapped:(ASLSlotMachineHistoryView *)slotMachineHistoryView {
    [self.delegate slotMachineHistoryViewControllerCloseButtonTapped:self];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fruitsHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASLHistoryCell *historyCell = [tableView dequeueReusableCellWithIdentifier:kHistoryCellIdentifier];
    NSArray *fruitResult = self.fruitsHistory[indexPath.row];
    ASLFruitType fruitType = (ASLFruitType) [fruitResult[0] unsignedIntegerValue];
    NSString *firstImageName = [ASLFruits imageNameForFruitType:fruitType];
    fruitType = (ASLFruitType) [fruitResult[1] unsignedIntegerValue];
    NSString *secondImageName = [ASLFruits imageNameForFruitType:fruitType];
    fruitType = (ASLFruitType) [fruitResult[2] unsignedIntegerValue];
    NSString *thirdImageName = [ASLFruits imageNameForFruitType:fruitType];
    [historyCell configureWithFirstImageName:firstImageName
                             secondImageName:secondImageName
                              thirdImageName:thirdImageName];
    return historyCell;
}

#pragma mark - Notifications

@end
