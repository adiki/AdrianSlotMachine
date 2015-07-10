//
// Created by a on 10/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLHistoryCell.h"


@interface ASLHistoryCell ()

@property(nonatomic, strong) UIImageView *firstImageView;
@property(nonatomic, strong) UIImageView *secondImageView;
@property(nonatomic, strong) UIImageView *thirdImageView;

@end

@implementation ASLHistoryCell

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)configureWithFirstImageName:(NSString *)firstImageName secondImageName:(NSString *)secondImageName thirdImageName:(NSString *)thirdImageName {
    self.firstImageView.image = [UIImage imageNamed:firstImageName];
    self.secondImageView.image = [UIImage imageNamed:secondImageName];
    self.thirdImageView.image = [UIImage imageNamed:thirdImageName];
}

#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self setupBackground];
        [self setupImageViews];
        [self setupConstraints];
    }

    return self;
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)setupBackground {
    self.backgroundColor = [UIColor clearColor];
}

- (void)setupImageViews {
    _firstImageView = [self createAndAddImageView];
    _secondImageView = [self createAndAddImageView];
    _thirdImageView = [self createAndAddImageView];
}

- (UIImageView *)createAndAddImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView];
    return imageView;
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_firstImageView, _secondImageView, _thirdImageView);
    NSDictionary *metrics = @{
            @"kCellHeight": @75
    };
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[_firstImageView][_secondImageView(_firstImageView)][_thirdImageView(_firstImageView)]-16-|"
                                                                             options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                             metrics:metrics
                                                                               views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_firstImageView(kCellHeight)]|"
                                                                             options:NSLayoutFormatDirectionLeadingToTrailing
                                                                             metrics:metrics
                                                                               views:views]];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
