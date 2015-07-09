//
// Created by a on 09/07/15.
//

#import "ASLSlotDataSource.h"
#import "ASLSlotCell.h"

NSString *const kSlotMachineCellIdentifier = @"kSlotMachineCellIdentifier";

@interface ASLSlotDataSource ()

@property(nonatomic, strong) NSArray *fruitTypes;

@end

@implementation ASLSlotDataSource

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties

- (NSArray *)fruitTypes {
    if (_fruitTypes == nil) {
        _fruitTypes = @[@(ASLFruitTypeBurrito), @(ASLFruitTypeAvocado), @(ASLFruitTypeSkeleton)];
    }
    return _fruitTypes;
}

#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (NSString *)imageNameForFruitType:(ASLFruitType)fruitType {
    switch (fruitType) {
        case ASLFruitTypeBurrito:
            return @"fruittype-burrito";
        case ASLFruitTypeAvocado:
            return @"fruittype-avocado";
        case ASLFruitTypeSkeleton:
            return @"fruittype-skeleton";
        default:
            [NSException raise:NSGenericException format:@"Unexpected ASLFruitType."];
    }
}

#pragma mark - ASLSlotViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 128;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASLSlotCell *slotMachineCell = [tableView dequeueReusableCellWithIdentifier:kSlotMachineCellIdentifier];
    NSUInteger fruitIndex = indexPath.row % self.fruitTypes.count;
    ASLFruitType fruitType = (ASLFruitType) [self.fruitTypes[fruitIndex] unsignedIntegerValue];
    [slotMachineCell configureWithImageName:[self imageNameForFruitType:fruitType]];
    return slotMachineCell;
}

- (NSInteger)differentFruitTypesCount {
    return self.fruitTypes.count;
}


#pragma mark - Notifications

@end
