//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLSlotView.h"
#import "ASLSlotCell.h"
#import "ASLSlotDataSource.h"
#import "ASLFruits.h"


@interface ASLSlotView ()
@property(nonatomic, assign) NSUInteger currentItemNumber;
@property(nonatomic, assign) NSUInteger targetItemNumber;
@property(nonatomic, strong) NSTimer *timer;
@end

@implementation ASLSlotView

#pragma mark - Public Properties

- (void)setSlotDataSource:(id <ASLSlotViewDataSource>)slotDataSource {
    self.dataSource = slotDataSource;
    _slotDataSource = slotDataSource;
}

#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)spinSlotToItemNumber:(NSUInteger)itemNumber animated:(BOOL)animated {
    if (self.slotDataSource == nil) {
        return;
    }

    if (animated) {
        [self spinSlotAnimatedToItemNumber:itemNumber];
    } else {
        [self spinSlotWithoutAnimationToItemNumber:itemNumber];
    }
}

#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.rowHeight = UITableViewAutomaticDimension;
        self.estimatedRowHeight = kSlotCellHeight;
        self.showsVerticalScrollIndicator = NO;
        self.allowsSelection = NO;
        self.scrollEnabled = NO;
        [self registerClass:[ASLSlotCell class] forCellReuseIdentifier:kSlotMachineCellIdentifier];
    }

    return self;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)spinSlotWithoutAnimationToItemNumber:(NSUInteger)itemNumber {
    self.currentItemNumber = itemNumber;
    [self scrollSlotToItemNumber:itemNumber animated:NO];
    [self makeNeighboursFadedForItemNumber:itemNumber];
}

- (void)spinSlotAnimatedToItemNumber:(NSUInteger)itemNumber {
    if ([self.timer isValid]) {
        return;
    }

    self.targetItemNumber = itemNumber;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(scrollSlotAnimated) userInfo:nil repeats:YES];
}

- (CGFloat)halfOfSlotHeight {
    return self.frame.size.height / 2;
}

- (void)scrollSlotAnimated {
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

    void (^animations)() = ^{
        [self setContentOffset:contentOffset animated:NO];
    };
    
    if (itemNumber != self.targetItemNumber) {
        [UIView animateWithDuration:0.1
                         animations:animations];
        return;
    }

    [UIView animateWithDuration:1
                          delay:0
         usingSpringWithDamping:0.33
          initialSpringVelocity:10
                        options:UIViewAnimationOptionCurveLinear
                     animations:animations
                     completion:^(BOOL finished) {
                         NSUInteger theSameBeginItemNumber = self.targetItemNumber % [ASLFruits fruitTypes].count;
                         theSameBeginItemNumber = theSameBeginItemNumber == 0 ? 3 : theSameBeginItemNumber;
                         [self spinSlotWithoutAnimationToItemNumber:theSameBeginItemNumber];
                     }];
}

- (void)makeNeighboursFadedForItemNumber:(NSUInteger)itemNumber {
    ASLSlotCell *slotCell = (ASLSlotCell *) [self cellForRowAtIndexPath:[NSIndexPath indexPathForItem:itemNumber - 1 inSection:0]];
    [slotCell makeFadedAnimated:NO];
    slotCell = (ASLSlotCell *) [self cellForRowAtIndexPath:[NSIndexPath indexPathForItem:itemNumber + 1 inSection:0]];
    [slotCell makeFadedAnimated:NO];
}

- (CGFloat)offsetYForItemNumber:(NSUInteger)itemNumber {
    CGFloat halfOfSlotHeight = [self halfOfSlotHeight];
    return kSlotCellHeight * itemNumber + kSlotCellHeight / 2 - halfOfSlotHeight;
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
