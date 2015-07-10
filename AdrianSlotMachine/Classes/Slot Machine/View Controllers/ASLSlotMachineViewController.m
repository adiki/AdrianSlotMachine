//
// Created by a on 09/07/15.
//

#import "ASLSlotMachineViewController.h"
#import "ASLSlotMachineControllerView.h"
#import "ASLSlotDataSource.h"
#import "ASLSlotItemNumbersGenerator.h"
#import "ASLFruits.h"
#import "ASLAlertViewController.h"
#import "ASLSlotMachineHistoryViewController.h"

@interface ASLSlotMachineViewController () <ASLSlotMachineControllerViewDelegate, ASLAlertViewControllerDelegate, ASLSlotMachineHistoryViewControllerDelegate>

@property(nonatomic, strong) ASLSlotItemNumbersGenerator *slotItemNumbersGenerator;
@property(nonatomic, strong) ASLSlotDataSource *slotDataSource;
@property(nonatomic, strong) NSMutableArray *fruitsHistory;

@end

@implementation ASLSlotMachineViewController

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (instancetype)initWithSlotItemNumbersGenerator:(ASLSlotItemNumbersGenerator *)slotItemNumbersGenerator {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        _slotItemNumbersGenerator = slotItemNumbersGenerator;
        _fruitsHistory = [NSMutableArray array];
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
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (ASLSlotMachineControllerView *)slotMachineControllerView {
    return (ASLSlotMachineControllerView *) self.view;
}

- (void)openAlertWithResultFruits:(NSArray *)resultFruits {
    BOOL win = [ASLFruits winForResultFruits:resultFruits];
    NSAttributedString *title = [ASLFruits titleForResultFruits:resultFruits];
    UIImage *image = [ASLFruits imageForResultFruits:resultFruits];
    ASLAlertViewController *alertViewController = [[ASLAlertViewController alloc] initWithWin:win title:title image:image];
    alertViewController.delegate = self;
    alertViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - ASLSlotMachineControllerViewDelegate

- (void)slotMachineControllerViewSpinButtonTapped:(ASLSlotMachineControllerView *)slotMachineControllerView {
    [self.slotMachineControllerView setButtonsEnabled:NO];
    NSArray *generatedSlotItemNumbers = [self.slotItemNumbersGenerator generateSlotItemNumbers];
    NSArray *resultFruits = [ASLFruits resultFruitsForSlotItemNumbers:generatedSlotItemNumbers];
    [self.fruitsHistory insertObject:resultFruits atIndex:0];
    __weak typeof(self) weakSelf = self;
    [self.slotMachineControllerView spinSlotMachineWithResult:generatedSlotItemNumbers completion:^{
        [weakSelf.slotMachineControllerView setButtonsEnabled:YES];
        [weakSelf openAlertWithResultFruits:resultFruits];
    }];
}

- (void)slotMachineControllerViewViewHistoryButtonTapped:(ASLSlotMachineControllerView *)slotMachineControllerView {
    ASLSlotMachineHistoryViewController *slotMachineHistoryViewController = [[ASLSlotMachineHistoryViewController alloc] initWithFruitsHistory:[self.fruitsHistory copy]];
    slotMachineHistoryViewController.delegate = self;
    [self presentViewController:slotMachineHistoryViewController animated:YES completion:nil];
}


#pragma mark - ASLAlertViewControllerDelegate

- (void)alertViewControllerConfirmButtonTapped:(ASLAlertViewController *)alertViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)slotMachineHistoryViewControllerCloseButtonTapped:(ASLSlotMachineHistoryViewController *)slotMachineHistoryViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ASLSlotMachineHistoryViewControllerDelegate

#pragma mark - Notifications

@end
