//
// Created by a on 09/07/15.
//

#import "ASLSlotCell.h"

CGFloat const kSlotCellHeight = 75;

@interface ASLSlotCell ()

@property(nonatomic, strong) UIImageView *slotImageView;

@end

@implementation ASLSlotCell

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)configureWithImageName:(NSString *)imageName {
    self.slotImageView.image = [UIImage imageNamed:imageName];
}

#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        [self setupBackground];
        [self setupImageView];
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

- (void)setupImageView {
    _slotImageView = [[UIImageView alloc] init];
    _slotImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:_slotImageView];
}

- (void)setupConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_slotImageView);
    NSDictionary *metrics = @{
            @"kCellHeight": @(kSlotCellHeight)
    };
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_slotImageView]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_slotImageView(kCellHeight)]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
