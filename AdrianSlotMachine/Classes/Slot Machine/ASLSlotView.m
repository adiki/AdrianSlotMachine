//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLSlotView.h"
#import "ASLSlotCell.h"
#import "ASLSlotDataSource.h"


@interface ASLSlotView ()
@property(nonatomic, assign) NSUInteger currentItemNumber;
@property(nonatomic, assign) NSUInteger targetItemNumber;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation ASLSlotView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)spinSlotToItemNumber:(NSUInteger)itemNumber {
    self.currentItemNumber = itemNumber;
    [self scrollSlotToItemNumber:itemNumber animated:NO];
    [self makeNeighboursFadedForItemNumber:itemNumber];
}

- (void)spinSlot {
    self.targetItemNumber = 100 + arc4random() % 28;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollSlot) userInfo:nil repeats:YES];
}

#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)initWithDataSource:(id <UITableViewDataSource>)dataSource {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = kSlotCellHeight;
        self.showsVerticalScrollIndicator = NO;
        self.allowsSelection = NO;
        self.scrollEnabled = NO;
        self.dataSource = dataSource;
        [self registerClass:[ASLSlotCell class] forCellReuseIdentifier:kSlotMachineCellIdentifier];
    }

    return self;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (CGFloat)halfOfSlotHeight {
    return self.frame.size.height / 2;
}

- (void)makeNeighboursFadedForItemNumber:(NSUInteger)itemNumber {
    ASLSlotCell *slotCell = (ASLSlotCell *) [self cellForRowAtIndexPath:[NSIndexPath indexPathForItem:itemNumber - 1 inSection:0]];
    [slotCell makeFadedAnimated:NO];
    slotCell = (ASLSlotCell *) [self cellForRowAtIndexPath:[NSIndexPath indexPathForItem:itemNumber + 1 inSection:0]];
    [slotCell makeFadedAnimated:NO];
}

- (void)scrollSlot {
    self.currentItemNumber += 2;
    self.currentItemNumber = MIN(self.currentItemNumber, self.targetItemNumber);
    [self scrollSlotToItemNumber:self.currentItemNumber animated:YES];
    if (self.currentItemNumber == self.targetItemNumber) {
        [self.timer invalidate];
        [self makeNeighboursFadedForItemNumber:self.currentItemNumber];
    }
}

- (void)scrollSlotToItemNumber:(NSUInteger)itemNumber animated:(BOOL)animated {
    CGFloat offsetY = [self offsetYForItemNumber:itemNumber];
    CGPoint contentOffset = CGPointMake(self.contentOffset.x, offsetY);
    if (animated == NO) {
        self.contentOffset = contentOffset;
        return;
    }
    [UIView animateWithDuration:0.1 animations:^{
        [self setContentOffset:contentOffset animated: NO];
    }];
}

- (CGFloat)offsetYForItemNumber:(NSUInteger)itemNumber {
    CGFloat halfOfSlotHeight = [self halfOfSlotHeight];
    return kSlotCellHeight * itemNumber + kSlotCellHeight / 2 - halfOfSlotHeight;
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
