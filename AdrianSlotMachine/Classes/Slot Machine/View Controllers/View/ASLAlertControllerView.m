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
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) ASLZigZagView *bottomZigZagView;
@property(nonatomic, strong) UIButton *confirmButton;

@end


@implementation ASLAlertControllerView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)initWithWin:(BOOL)win title:(NSAttributedString *)title image:(UIImage *)image {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupBlurView];
        [self setupWhiteBoxWithTitle:title image:image];
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

- (void)setupWhiteBoxWithTitle:(NSAttributedString *)title image:(UIImage *)image {
    _whiteBox = [[UIView alloc] init];
    _whiteBox.translatesAutoresizingMaskIntoConstraints = NO;
    _whiteBox.backgroundColor = [UIColor whiteColor];
    [self addSubview:_whiteBox];

    _topZigZagView = [self createAndAddZigZag];
    [self setupTitleLabelWithTitle:title];
    [self setupImageViewWithImage:image];
    _bottomZigZagView = [self createAndAddZigZag];
}

- (ASLZigZagView *)createAndAddZigZag {
    ASLZigZagView *zigZagView = [[ASLZigZagView alloc] init];
    zigZagView.translatesAutoresizingMaskIntoConstraints = NO;
    [_whiteBox addSubview:zigZagView];
    return zigZagView;
}

- (void)setupTitleLabelWithTitle:(NSAttributedString *)title {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _titleLabel.font = [UIFont fontWithName:@"EuphemiaUCAS" size:27];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_titleLabel setAttributedText:title];
    [_whiteBox addSubview:_titleLabel];
}

- (void)setupImageViewWithImage:(UIImage *)image {
    _imageView = [[UIImageView alloc] initWithImage:image];
    _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_whiteBox addSubview:_imageView];
}

- (void)setupConfirmButtonWithWin:(BOOL)win {
    _confirmButton = [[UIButton alloc] init];
    _confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_confirmButton setTitle:win ? @"CLAIM!" : @"OK!" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmButton setBackgroundColor:[UIColor asl_TurquoiseColor]];
    [_confirmButton addTarget:self action:@selector(confirmButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton.titleLabel.font = [UIFont fontWithName:@"EuphemiaUCAS" size:27];
    [self addSubview:_confirmButton];
}

- (void)setupConstraints {
    [self setupWhiteBoxConstraints];
    [self setupSelfConstraints];
}

- (void)setupWhiteBoxConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_topZigZagView, _titleLabel, _imageView, _bottomZigZagView);
    NSDictionary *metrics = @{
            @"kPadding" : @(kPadding),
            @"zigZagHeight" : @7,
            @"imageViewHeight": _imageView.image ? @128 : @0
    };
    [_whiteBox addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-kPadding-[_topZigZagView]-kPadding-|"
                                                                      options:NSLayoutFormatDirectionLeadingToTrailing
                                                                      metrics:metrics
                                                                        views:views]];

    [_whiteBox addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-kPadding-[_topZigZagView(zigZagHeight)]-kPadding-[_titleLabel]-kPadding-[_imageView(imageViewHeight)]-kPadding-[_bottomZigZagView(zigZagHeight)]-kPadding-|"
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
    [self.delegate alertControllerViewConfirmButtonTapped:self];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
