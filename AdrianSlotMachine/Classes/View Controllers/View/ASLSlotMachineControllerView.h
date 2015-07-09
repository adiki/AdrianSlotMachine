//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>

@class ASLSlotMachineControllerView;

@protocol ASLSlotMachineControllerViewDelegate

- (void)slotMachineControllerViewSpinButtonTapped:(ASLSlotMachineControllerView *)slotMachineControllerView;

@end

@interface ASLSlotMachineControllerView : UIView

@property(nonatomic, weak) id <ASLSlotMachineControllerViewDelegate> delegate;

- (void)setupSlotMachine;
- (void)setSpinButtonEnabled:(BOOL)enabled;

- (void)spinSlotMachine;
@end
