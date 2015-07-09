//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>
#import "ASLSlotView.h"

extern NSString *const kSlotMachineCellIdentifier;

typedef NS_ENUM(NSInteger, ASLFruitType) {
    ASLFruitTypeBurrito,
    ASLFruitTypeAvocado,
    ASLFruitTypeSkeleton,
};



@interface ASLSlotDataSource : NSObject <ASLSlotViewDataSource>

@end
