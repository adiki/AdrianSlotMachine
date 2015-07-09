//
// Created by a on 09/07/15.
//

#import "ASLSlotDataSource.h"
#import "ASLSlotCell.h"
#import "ASLFruits.h"

NSString *const kSlotMachineCellIdentifier = @"kSlotMachineCellIdentifier";

@interface ASLSlotDataSource ()

@property(nonatomic, strong) NSArray *fruitTypes;
@property(nonatomic, assign) NSInteger cellsCount;

@end

@implementation ASLSlotDataSource

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (instancetype)initWithCellsCount:(NSInteger)cellsCount fruitTypes:(NSArray *)fruitTypes {
    self = [super init];

    if (self) {
        _cellsCount = cellsCount;
        _fruitTypes = fruitTypes;
    }

    return self;
}

#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - ASLSlotViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASLSlotCell *slotMachineCell = [tableView dequeueReusableCellWithIdentifier:kSlotMachineCellIdentifier];
    NSUInteger fruitIndex = indexPath.row % self.fruitTypes.count;
    ASLFruitType fruitType = (ASLFruitType) [self.fruitTypes[fruitIndex] unsignedIntegerValue];
    [slotMachineCell configureWithImageName:[ASLFruits imageNameForFruitType:fruitType]];
    return slotMachineCell;
}

#pragma mark - Notifications

@end
