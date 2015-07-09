//
// Created by a on 09/07/15.
//

#import "ASLSlotDataSource.h"
#import "ASLSlotCell.h"

NSString *const kSlotMachineCellIdentifier = @"kSlotMachineCellIdentifier";

@interface ASLSlotDataSource ()

@property(nonatomic, strong) NSArray *imageNames;

@end

@implementation ASLSlotDataSource

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties

- (NSArray *)imageNames {
    if (_imageNames == nil) {
        _imageNames = @[@"fruittype-avocado", @"fruittype-burrito", @"fruittype-skeleton"];
    }
    return _imageNames;
}

#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASLSlotCell *slotMachineCell = [tableView dequeueReusableCellWithIdentifier:kSlotMachineCellIdentifier];
    NSUInteger imageIndex = indexPath.row % self.imageNames.count;
    [slotMachineCell configureWithImageName:self.imageNames[imageIndex]];
    return slotMachineCell;
}

#pragma mark - Notifications

@end
