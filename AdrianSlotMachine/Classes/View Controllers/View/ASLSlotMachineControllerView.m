//
// Created by a on 09/07/15.
//

#import "ASLSlotMachineControllerView.h"
#import "UIColor+ASLSlotMachine.h"
#import "ASLSlotMachineView.h"

@interface ASLSlotMachineControllerView ()

@property(nonatomic, strong) ASLSlotMachineView *slotMachineView;

@end

@implementation ASLSlotMachineControllerView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupBackground];
        [self setupSlotMachineView];
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


- (void)setupSlotMachineView {
    _slotMachineView = [[ASLSlotMachineView alloc] init];
    _slotMachineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_slotMachineView];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_slotMachineView);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_slotMachineView(300)]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_slotMachineView(150)]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_slotMachineView
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_slotMachineView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0f]];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
