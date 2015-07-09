//
// Created by a on 09/07/15.
//

#import "ASLSlotMachineViewController.h"
#import "ASLSlotMachineControllerView.h"

@interface ASLSlotMachineViewController () <ASLSlotMachineControllerViewDelegate>
@end

@implementation ASLSlotMachineViewController

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden

- (void)loadView {
    ASLSlotMachineControllerView *slotMachineControllerView = [[ASLSlotMachineControllerView alloc] init];
    slotMachineControllerView.delegate = self;
    self.view = slotMachineControllerView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.slotMachineControllerView setupSlotMachine];
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (ASLSlotMachineControllerView *)slotMachineControllerView {
    return (ASLSlotMachineControllerView *) self.view;
}


#pragma mark - ASLSlotMachineControllerViewDelegate

- (void)slotMachineControllerViewSpinButtonTapped:(ASLSlotMachineControllerView *)slotMachineControllerView {
    [self.slotMachineControllerView setSpinButtonEnabled:NO];
    [self.slotMachineControllerView spinSlotMachine];
}

#pragma mark - Notifications

@end
