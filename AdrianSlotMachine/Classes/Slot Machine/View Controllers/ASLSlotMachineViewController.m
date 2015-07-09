//
// Created by a on 09/07/15.
//

#import "ASLSlotMachineViewController.h"
#import "ASLSlotMachineControllerView.h"
#import "ASLSlotDataSource.h"
#import "ASLSlotItemNumbersGenerator.h"
#import "ASLFruits.h"
#import "ASLAlertViewController.h"
#import "ASLAlertTransitioningDelegate.h"

@interface ASLSlotMachineViewController () <ASLSlotMachineControllerViewDelegate>

@property(nonatomic, strong) ASLSlotItemNumbersGenerator *slotItemNumbersGenerator;
@property(nonatomic, strong) ASLSlotDataSource *slotDataSource;
@property(nonatomic, strong) ASLAlertTransitioningDelegate *alertTransitioningDelegate;

@end

@implementation ASLSlotMachineViewController

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (instancetype)initWithSlotItemNumbersGenerator:(ASLSlotItemNumbersGenerator *)slotItemNumbersGenerator {
    self = [super init];

    if (self) {
        _slotItemNumbersGenerator = slotItemNumbersGenerator;
    }

    return self;
}

#pragma mark - IBActions
#pragma mark - Overridden

- (void)loadView {
    NSUInteger cellsCount = self.slotItemNumbersGenerator.generationUpperRange + 1;
    NSArray *fruitTypes = [ASLFruits fruitTypes];
    self.slotDataSource = [[ASLSlotDataSource alloc] initWithCellsCount:cellsCount fruitTypes:fruitTypes];
    ASLSlotMachineControllerView *slotMachineControllerView = [[ASLSlotMachineControllerView alloc] initWithSlotDataSource:self.slotDataSource];
    slotMachineControllerView.delegate = self;
    self.view = slotMachineControllerView;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.slotMachineControllerView setupSlotMachine];
}

#pragma mark - Private Properties

- (ASLAlertTransitioningDelegate *)alertTransitioningDelegate {
    if (_alertTransitioningDelegate == nil) {
        _alertTransitioningDelegate = [[ASLAlertTransitioningDelegate alloc] init];
    }
    return _alertTransitioningDelegate;
}

#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (ASLSlotMachineControllerView *)slotMachineControllerView {
    return (ASLSlotMachineControllerView *) self.view;
}

- (void)openAlert {
    ASLAlertViewController *alertViewController = [[ASLAlertViewController alloc] init];
    alertViewController.modalPresentationStyle = UIModalPresentationCustom;
    alertViewController.transitioningDelegate = self.alertTransitioningDelegate;
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - ASLSlotMachineControllerViewDelegate

- (void)slotMachineControllerViewSpinButtonTapped:(ASLSlotMachineControllerView *)slotMachineControllerView {
    [self.slotMachineControllerView setSpinButtonEnabled:NO];
    NSArray *result = [self.slotItemNumbersGenerator generateSlotItemNumbers];
    __weak typeof(self) weakSelf = self;
    [self.slotMachineControllerView spinSlotMachineWithResult:result completion:^{
        [weakSelf.slotMachineControllerView setSpinButtonEnabled:YES];
        [weakSelf openAlert];
    }];
}

#pragma mark - Notifications

@end
