//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLAlertControllerView.h"
#import "UIColor+ASLSlotMachine.h"
#import "ASLZigZagView.h"

CGFloat const kPadding = 8;

@interface ASLAlertControllerView ()

@property(nonatomic, strong) UIVisualEffectView *blurView;
@property(nonatomic, strong) UIView *whiteBox;
@property(nonatomic, strong) ASLZigZagView *topZigZagView;
@property(nonatomic, strong) ASLZigZagView *bottomZigZagView;
@property(nonatomic, strong) UIButton *confirmButton;

@end


@implementation ASLAlertControllerView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)initWithWin:(BOOL)win {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupBlurView];
        [self setupWhiteBox];
        [self setupConfirmButtonWithWin:win];
        [self setupConstraints];
    }

    return self;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)setupBlurView {
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_blurView];
}

- (void)setupWhiteBox {
    _whiteBox = [[UIView alloc] init];
    _whiteBox.translatesAutoresizingMaskIntoConstraints = NO;
    _whiteBox.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteBox];

    _topZigZagView = [self createAndAddZigZag];
    _bottomZigZagView = [self createAndAddZigZag];
}

- (ASLZigZagView *)createAndAddZigZag {
    ASLZigZagView *zigZagView = [[ASLZigZagView alloc] init];
    zigZagView.translatesAutoresizingMaskIntoConstraints = NO;
    [_whiteBox addSubview:zigZagView];
    return zigZagView;
}

- (void)setupConfirmButtonWithWin:(BOOL)win {
    _confirmButton = [[UIButton alloc] init];
    _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_confirmButton setTitle:win ? @"CLAIM!" : @"OK!" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton setBackgroundColor:[UIColor aslTurquoiseColor]];
    [_confirmButton addTarget:self action:@selector(confirmButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton.titleLabel.font = [UIFont fontWithName:@"EuphemiaUCAS" size:29];
    [self addSubview:_confirmButton];
}

- (void)setupConstraints {
    [self setupWhiteBoxConstraints];
    [self setupSelfConstraints];
}

- (void)setupWhiteBoxConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_topZigZagView, _bottomZigZagView);
    NSDictionary *metrics = @{
            @"kPadding" : @(kPadding),
            @"zigZagHeight" : @7
    };
    [_whiteBox addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-kPadding-[_topZigZagView]-kPadding-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];

    [_whiteBox addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-kPadding-[_topZigZagView(zigZagHeight)]-200-[_bottomZigZagView(zigZagHeight)]-kPadding-|"
                                                                      options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                      metrics:metrics
                                                                        views:views]];
}

- (void)setupSelfConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_blurView, _whiteBox, _confirmButton);
    NSDictionary *metrics = @{
            @"kPadding" : @(kPadding)
    };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_blurView]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-kPadding-[_confirmButton]-kPadding-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_blurView]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_whiteBox][_confirmButton]-kPadding-|"
                                                                 options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                 metrics:metrics
                                                                   views:views]];
}

- (void)confirmButtonTapped:(UIButton *)confirmButton {

}

#pragma mark - Protocols
#pragma mark - Notifications

@end
