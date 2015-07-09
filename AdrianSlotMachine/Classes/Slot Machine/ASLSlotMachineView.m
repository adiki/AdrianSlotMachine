//
// Created by a on 09/07/15.
//

#import "ASLSlotMachineView.h"
#import "ASLTriangleView.h"
#import "UIColor+ASLSlotMachine.h"
#import "ASLSlotDataSource.h"
#import "NSMutableArray+Shuffle.h"

CGFloat const kSlotsContainerMargin = 4;
CGFloat const kSlotsContainerBorderWidth = 6;
CGFloat const kTriangleViewHeight = 32;
CGFloat const kTriangleViewWidth = kTriangleViewHeight * 1.732f / 2;

@interface ASLSlotMachineView ()

@property(nonatomic, strong) UIView *slotsContainer;
@property(nonatomic, strong) ASLSlotView *firstSlot;
@property(nonatomic, strong) ASLSlotView *secondSlot;
@property(nonatomic, strong) ASLSlotView *thirdSlot;
@property(nonatomic, strong) ASLSlotDataSource *slotDataSource;
@property(nonatomic, strong) ASLTriangleView *leftTriangleView;
@property(nonatomic, strong) ASLTriangleView *rightTriangleView;

@end

@implementation ASLSlotMachineView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (void)setupSlotMachine {
    [self setupSlotsToInitialRandomItemNumbers];
}

- (void)spinSlotMachine {
    NSUInteger itemNumber = 50 + arc4random() % 3;
    [self.firstSlot spinSlotToItemNumber:itemNumber animated:YES];
    itemNumber = 71 + arc4random() % 3;
    [self.secondSlot spinSlotToItemNumber:itemNumber animated:YES];
    itemNumber = 92 + arc4random() % 3;
    [self.thirdSlot spinSlotToItemNumber:itemNumber animated:YES];
}

#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupSlotsContainer];
        [self setupSlots];
        [self setupTriangles];
        [self setupConstraints];
    }

    return self;
}

#pragma mark - Private Properties

- (ASLSlotDataSource *)slotDataSource {
    if (_slotDataSource == nil) {
        _slotDataSource = [[ASLSlotDataSource alloc] init];
    }
    return _slotDataSource;
}

#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)setupSlotsContainer {
    _slotsContainer = [[UIView alloc] init];
    _slotsContainer.translatesAutoresizingMaskIntoConstraints = NO;
    _slotsContainer.backgroundColor = [UIColor aslVeryLightGrayColor];
    _slotsContainer.layer.cornerRadius = 12;
    _slotsContainer.layer.borderWidth = kSlotsContainerBorderWidth;
    _slotsContainer.layer.borderColor = [UIColor aslTurquoiseColor].CGColor;
    [self addSubview:_slotsContainer];
}

- (void)setupSlots {
    _firstSlot = [self createAndAddSlotView];
    _secondSlot = [self createAndAddSlotView];
    _thirdSlot = [self createAndAddSlotView];
}

- (ASLSlotView *)createAndAddSlotView {
    ASLSlotView *slotView = [[ASLSlotView alloc] init];
    slotView.slotDataSource = self.slotDataSource;
    slotView.translatesAutoresizingMaskIntoConstraints = NO;
    [_slotsContainer addSubview:slotView];
    return slotView;
}

- (void)setupTriangles {
    _leftTriangleView = [self createAndAddTriangleWithType:ASLTriangleTypeLeft];
    _rightTriangleView = [self createAndAddTriangleWithType:ASLTriangleTypeRight];
}

- (ASLTriangleView *)createAndAddTriangleWithType:(ASLTriangleType)triangleType {
    ASLTriangleView *triangleView = [[ASLTriangleView alloc] initWithTriangleType:triangleType];
    triangleView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:triangleView];
    return triangleView;
}

- (void)setupConstraints {
    [self setupSlotsContainerConstraints];
    [self setupSelfConstraints];
}

- (void)setupSlotsContainerConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_firstSlot, _secondSlot, _thirdSlot);
    NSDictionary *metrics = @{
            @"marginH" : @(kSlotsContainerBorderWidth + 12),
            @"marginV" : @(kSlotsContainerBorderWidth),
    };
    [_slotsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-marginH-[_firstSlot]-2-[_secondSlot(_firstSlot)]-2-[_thirdSlot(_firstSlot)]-marginH-|"
                                                                 options:NSLayoutFormatAlignAllTop | NSLayoutFormatAlignAllBottom
                                                                 metrics:metrics
                                                                   views:views]];
    [_slotsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-marginV-[_firstSlot]-marginV-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
}

- (void)setupSelfConstraints {
    NSDictionary *views = NSDictionaryOfVariableBindings(_slotsContainer, _leftTriangleView, _rightTriangleView);
    NSDictionary *metrics = @{
            @"kSlotsContainerMargin" : @(kSlotsContainerMargin),
            @"kTriangleViewWidth" : @(kTriangleViewWidth),
            @"kTriangleViewHeight" : @(kTriangleViewHeight)
    };
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-kSlotsContainerMargin-[_slotsContainer]-kSlotsContainerMargin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftTriangleView(kTriangleViewWidth)]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_rightTriangleView(kTriangleViewWidth)]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-kSlotsContainerMargin-[_slotsContainer]-kSlotsContainerMargin-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_leftTriangleView(kTriangleViewHeight)]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_rightTriangleView(kTriangleViewHeight)]"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:metrics
                                                                   views:views]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_leftTriangleView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0f]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_rightTriangleView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0f
                                                      constant:0.0f]];
}

- (void)setupSlotsToInitialRandomItemNumbers {
    NSMutableArray *itemNumbers = [@[@1, @2, @3] mutableCopy];
    [itemNumbers shuffle];
    [self.firstSlot spinSlotToItemNumber:[itemNumbers[0] unsignedIntegerValue] animated:NO];
    [self.secondSlot spinSlotToItemNumber:[itemNumbers[1] unsignedIntegerValue] animated:NO];
    [self.thirdSlot spinSlotToItemNumber:[itemNumbers[2] unsignedIntegerValue] animated:NO];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
