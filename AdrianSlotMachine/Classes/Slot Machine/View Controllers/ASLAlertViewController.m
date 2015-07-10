//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLAlertViewController.h"
#import "ASLAlertControllerView.h"


@interface ASLAlertViewController () <ASLAlertControllerViewDelegate>

@property(nonatomic, assign) BOOL win;
@property(nonatomic, strong) NSAttributedString *attributedTitle;
@property(nonatomic, strong) UIImage *image;

@end

@implementation ASLAlertViewController

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (instancetype)initWithWin:(BOOL)win title:(NSAttributedString *)title image:(UIImage *)image {
    self = [super initWithNibName:nil bundle:nil];

    if (self) {
        _win = win;
        _attributedTitle = title;
        _image = image;
    }

    return self;
}

#pragma mark - IBActions
#pragma mark - Overridden

- (void)loadView {
    ASLAlertControllerView *alertControllerView = [[ASLAlertControllerView alloc] initWithWin:self.win title:self.attributedTitle image:self.image];
    alertControllerView.delegate = self;
    self.view = alertControllerView;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - ASLAlertControllerViewDelegate

- (void)alertControllerViewConfirmButtonTapped:(ASLAlertControllerView *)alertControllerView {
    [self.delegate alertViewControllerConfirmButtonTapped:self];
}

#pragma mark - Notifications

@end
