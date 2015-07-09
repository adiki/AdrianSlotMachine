//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>

@class ASLSlotDataSource;


@interface ASLSlotMachineView : UIView

- (instancetype)initWithSlotDataSource:(ASLSlotDataSource *)slotDataSource;
- (void)setupSlotMachine;
- (void)spinSlotMachineWithResult:(NSArray *)result completion:(void (^)())completion;

@end
