//
// Created by a on 09/07/15.
//

#import "ASLSlotMachineControllerView.h"
#import "UIColor+ASLSlotMachine.h"
#import "ASLSlotMachineView.h"
#import "ASLSlotDataSource.h"

@interface ASLSlotMachineControllerView ()

@property(nonatomic, strong) UIView *centerContainer;
@property(nonatomic, strong) ASLSlotMachineView *slotMachineView;
@property(nonatomic, strong) UIButton *spinButton;

@end

@implementation ASLSlotMachineControllerView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)setupSlotMachine {
    [self.slotMachineView setupSlotMachine];
}

- (void)setSpinButtonEnabled:(BOOL)enabled {
    self.spinButton.enabled = enabled;
    self.spinButton.alpha = enabled ? 1.0f : 0.5f;
}

- (void)spinSlotMachineWithResult:(NSArray *)result completion:(void (^)())completion {
    [self.slotMachineView spinSlotMachineWithResult:result completion:completion];
}

#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)initWithSlotDataSource:(ASLSlotDataSource *)slotDataSource {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupBackground];
        [self setupCenterContainer];
        [self setupSlotMachineViewWithSlotDataSource:slotDataSource];
        [self setupSpinButton];
        [self setupConstraints];
    }

    return self;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)setupBackground {
    self.backgroundColor = [UIColor aslGrayColor];
}

- (void)setupCenterContainer {
    _centerContainer = [[UIView alloc] init];
    _centerContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_centerContainer];
}

- (void)setupSlotMachineViewWithSlotDataSource:(ASLSlotDataSource *)slotDataSource {
    _slotMachineView = [[ASLSlotMachineView alloc] initWithSlotDataSource:slotDataSource];
    _slotMachineView.translatesAutoresizingMaskIntoConstraints = NO;
    [_centerContainer addSubview:_slotMachineView];
}


- (void)setupSpinButton {
    _spinButton = [[UIButton alloc] init];
    _spinButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_spinButton setTitle:@"SPIN" forState:UIControlStateNormal];
    [_spinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_spinButton setBackgroundColor:[UIColor aslTurquoiseColor]];
    [_spinButton addTarget:self action:@selector(spinButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    _spinButton.titleLabel.font = [UIFont fontWithName:@"EuphemiaUCAS" size:29];
    [_centerContainer addSubview:_spinButton];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_centerContainer, _slotMachineView, _spinButton);
    [_centerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_slotMachineView(300)]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];
    [_centerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_slotMachineView(150)]-[_spinButton]|"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_centerContainer
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_centerContainer
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0f]];
}

- (void)spinButtonTapped:(UIButton *)spinButton {
    [self.delegate slotMachineControllerViewSpinButtonTapped:self];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
