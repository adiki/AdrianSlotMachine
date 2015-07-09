//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>

@protocol ASLSlotViewDataSource;


@interface ASLSlotMachineView : UIView

@property(nonatomic, weak) id <ASLSlotViewDataSource> slotDataSource;

- (void)setupSlotMachine;
- (void)spinSlotMachineWithResult:(NSArray *)result;

@end
