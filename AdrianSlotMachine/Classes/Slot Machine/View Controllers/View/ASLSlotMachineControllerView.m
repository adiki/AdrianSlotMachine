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
@property(nonatomic, strong) UIButton *viewHistoryButton;

@end

@implementation ASLSlotMachineControllerView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)setupSlotMachine {
    [self.slotMachineView setupSlotMachine];
}

- (void)setButtonsEnabled:(BOOL)enabled {
    self.spinButton.enabled = enabled;
    self.viewHistoryButton.enabled = enabled;
    self.spinButton.alpha = enabled ? 1.0f : 0.5f;
    self.viewHistoryButton.alpha = enabled ? 1.0f : 0.5f;
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
        [self setupButtons];
        [self setupConstraints];
    }

    return self;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)setupBackground {
    self.backgroundColor = [UIColor asl_GrayColor];
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

- (void)setupButtons {
    _spinButton = [self createAndAddButtonWithTitle:@"SPIN" sel:@selector(spinButtonTapped:)];
    _viewHistoryButton = [self createAndAddButtonWithTitle:@"VIEW HISTORY" sel:@selector(viewHistoryButtonTapped:)];
}

- (UIButton *)createAndAddButtonWithTitle:(NSString *)title sel:(SEL)sel {
    UIButton *button = [[UIButton alloc] init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor asl_TurquoiseColor]];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont fontWithName:@"EuphemiaUCAS" size:27];
    [_centerContainer addSubview:button];
    return button;
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_centerContainer, _slotMachineView, _spinButton, _viewHistoryButton);
    [_centerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_slotMachineView(300)]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];
    [_centerContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_slotMachineView(150)]-8-[_spinButton]-8-[_viewHistoryButton]|"
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

- (void)viewHistoryButtonTapped:(UIButton *)viewHistoryButton {
    [self.delegate slotMachineControllerViewViewHistoryButtonTapped:self];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
