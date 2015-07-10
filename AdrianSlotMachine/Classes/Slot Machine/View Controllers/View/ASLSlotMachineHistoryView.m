//
// Created by a on 10/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLSlotMachineHistoryView.h"
#import "UIColor+ASLSlotMachine.h"
#import "ASLSlotMachineHistoryViewController.h"
#import "ASLHistoryCell.h"


@interface ASLSlotMachineHistoryView ()

@property(nonatomic, strong) UIButton *closeButton;
@property(nonatomic, strong) UITableView *historyTableView;

@end

@implementation ASLSlotMachineHistoryView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (instancetype)initWithDataSource:(id <UITableViewDataSource>)dataSource {
    self = [super init];

    if (self) {
        [self setupBackground];
        [self setupHistoryTableViewWithDataSource:dataSource];
        [self setupCloseButton];
        [self setupConstraints];
    }

    return self;
}


#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)setupBackground {
    self.backgroundColor = [UIColor asl_GrayColor];
}

- (void)setupHistoryTableViewWithDataSource:(id <UITableViewDataSource>)dataSource {
    _historyTableView = [[UITableView alloc] init];
    _historyTableView.translatesAutoresizingMaskIntoConstraints = NO;
    _historyTableView.backgroundColor = [UIColor asl_VeryLightGrayColor];
    _historyTableView.rowHeight = UITableViewAutomaticDimension;
    _historyTableView.estimatedRowHeight = 75;
    _historyTableView.contentInset = UIEdgeInsetsMake(3, 0, 3, 0);
    _historyTableView.allowsSelection = NO;
    _historyTableView.dataSource = dataSource;
    [_historyTableView registerClass:[ASLHistoryCell class] forCellReuseIdentifier:kHistoryCellIdentifier];
    _historyTableView.layer.cornerRadius = 12;
    _historyTableView.layer.borderWidth = 3;
    _historyTableView.layer.borderColor = [UIColor asl_TurquoiseColor].CGColor;
    [self addSubview:_historyTableView];
}

- (void)setupCloseButton {
    _closeButton = [[UIButton alloc] init];
    _closeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_closeButton setTitle:@"CLOSE" forState:UIControlStateNormal];
    [_closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_closeButton setBackgroundColor:[UIColor asl_TurquoiseColor]];
    [_closeButton addTarget:self action:@selector(closeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    _closeButton.titleLabel.font = [UIFont fontWithName:@"EuphemiaUCAS" size:27];
    [self addSubview:_closeButton];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_historyTableView, _closeButton);
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[_closeButton]-8-|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:nil
                                                                               views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-28-[_historyTableView]-8-[_closeButton]-8-|"
                                                                             options:NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight
                                                                             metrics:nil
                                                                               views:views]];
}

- (void)closeButtonTapped:(UIButton *)closeButton {
    [self.delegate slotMachineHistoryViewCloseButtonTapped:self];
}


#pragma mark - Protocols
#pragma mark - Notifications

@end
