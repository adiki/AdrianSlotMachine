//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASLAlertViewController;

@protocol ASLAlertViewControllerDelegate

- (void)alertViewControllerConfirmButtonTapped:(ASLAlertViewController *)alertViewController;

@end

@interface ASLAlertViewController : UIViewController

@property(nonatomic, weak) id <ASLAlertViewControllerDelegate> delegate;

- (instancetype)initWithWin:(BOOL)win title:(NSAttributedString *)title image:(UIImage *)image;

@end
