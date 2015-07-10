//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ASLAlertControllerView;

@protocol ASLAlertControllerViewDelegate

- (void)alertControllerViewConfirmButtonTapped:(ASLAlertControllerView *)alertControllerView;

@end

@interface ASLAlertControllerView : UIView

@property(nonatomic, weak) id <ASLAlertControllerViewDelegate> delegate;

- (instancetype)initWithWin:(BOOL)win title:(NSAttributedString *)title image:(UIImage *)image;

@end
