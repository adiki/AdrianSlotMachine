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

@interface ASLSlotMachineView () <ASLSlotViewDelegate>

@property(nonatomic, strong) UIView *slotsContainer;
@property(nonatomic, strong) ASLSlotView *firstSlot;
@property(nonatomic, strong) ASLSlotView *secondSlot;
@property(nonatomic, strong) ASLSlotView *thirdSlot;
@property(nonatomic, strong) ASLTriangleView *leftTriangleView;
@property(nonatomic, strong) ASLTriangleView *rightTriangleView;
@property(nonatomic, copy) void (^completion)();

@end

@implementation ASLSlotMachineView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods

- (instancetype)initWithSlotDataSource:(ASLSlotDataSource *)slotDataSource {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setupSlotsContainer];
        [self setupSlotsWithSlotDataSource:slotDataSource];
        [self setupTriangles];
        [self setupConstraints];
    }

    return self;
}

- (void)setupSlotMachine {
    [self setupSlotsToInitialRandomItemNumbers];
}

- (void)spinSlotMachineWithResult:(NSArray *)result completion:(void (^)())completion {
    [self.firstSlot spinSlotToItemNumber:[result[0] unsignedIntegerValue] animated:YES];
    [self.secondSlot spinSlotToItemNumber:[result[1] unsignedIntegerValue] animated:YES];
    [self.thirdSlot spinSlotToItemNumber:[result[2] unsignedIntegerValue] animated:YES];
    self.completion = completion;
}

#pragma mark - IBActions
#pragma mark - Overridden
#pragma mark - Private Properties
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

- (void)setupSlotsWithSlotDataSource:(ASLSlotDataSource *)slotDataSource {
    _firstSlot = [self createAndAddSlotViewWithSlotDataSource:slotDataSource];
    _secondSlot = [self createAndAddSlotViewWithSlotDataSource:slotDataSource];
    _thirdSlot = [self createAndAddSlotViewWithSlotDataSource:slotDataSource];
}

- (ASLSlotView *)createAndAddSlotViewWithSlotDataSource:(ASLSlotDataSource *)slotDataSource {
    ASLSlotView *slotView = [[ASLSlotView alloc] init];
    slotView.dataSource = slotDataSource;
    slotView.delegate = self;
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

#pragma mark - ASLSlotViewDelegate

- (void)slotViewDidFinishSpinning:(ASLSlotView *)slotView {
    if (slotView != self.thirdSlot || self.completion == nil) {
        return;
    }
    self.completion();
    self.completion = nil;
}


#pragma mark - Notifications

@end
