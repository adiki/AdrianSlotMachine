//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>

@class ASLSlotMachineControllerView;
@class ASLSlotDataSource;

@protocol ASLSlotMachineControllerViewDelegate

- (void)slotMachineControllerViewSpinButtonTapped:(ASLSlotMachineControllerView *)slotMachineControllerView;
- (void)slotMachineControllerViewViewHistoryButtonTapped:(ASLSlotMachineControllerView *)slotMachineControllerView;

@end

@interface ASLSlotMachineControllerView : UIView

@property(nonatomic, weak) id <ASLSlotMachineControllerViewDelegate> delegate;

- (instancetype)initWithSlotDataSource:(ASLSlotDataSource *)slotDataSource;

- (void)setupSlotMachine;
- (void)setButtonsEnabled:(BOOL)enabled;
- (void)spinSlotMachineWithResult:(NSArray *)result completion:(void (^)())completion;

@end
