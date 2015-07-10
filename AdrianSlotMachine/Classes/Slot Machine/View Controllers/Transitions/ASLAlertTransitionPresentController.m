//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLAlertTransitionPresentController.h"
#import "ASLAlertViewController.h"


@implementation ASLAlertTransitionPresentController

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    ASLAlertViewController *alertViewController = (ASLAlertViewController *) [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    alertViewController.view.frame = [[transitionContext containerView] frame];
    [transitionContext.containerView addSubview:alertViewController.view];
    [transitionContext completeTransition:YES];
}

#pragma mark - Notifications

@end
