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

- (void)makeFadedAnimated:(BOOL)animated {
    if (animated == NO) {
        self.slotImageView.alpha = 0.5;
        return;
    }
    [UIView animateWithDuration:1 animations:^{
        self.slotImageView.alpha = 0.5;
    }];
}

- (void)setGlow {
    self.slotImageView.layer.shadowColor = [UIColor yellowColor].CGColor;
    self.slotImageView.layer.shadowOffset = CGSizeMake(0, 0);
    self.slotImageView.layer.shadowOpacity = 0.75;
}

- (void)rotateImage {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 1.0;
    [self.slotImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
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

- (void)prepareForReuse {
    [super prepareForReuse];
    self.slotImageView.alpha = 1;
    self.slotImageView.layer.shadowOpacity = 0;
    [self.slotImageView.layer removeAllAnimations];
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
    _slotImageView.contentMode = UIViewContentModeScaleAspectFit;
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
