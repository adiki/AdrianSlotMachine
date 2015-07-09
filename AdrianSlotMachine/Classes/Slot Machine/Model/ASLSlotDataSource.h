//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>
#import "ASLSlotView.h"

extern NSString *const kSlotMachineCellIdentifier;


@interface ASLSlotDataSource : NSObject <ASLSlotViewDataSource>

- (instancetype)initWithCellsCount:(NSInteger)cellsCount fruitTypes:(NSArray *)fruitTypes;

@end
