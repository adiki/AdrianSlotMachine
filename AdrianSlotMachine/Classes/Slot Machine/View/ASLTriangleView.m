//
// Created by a on 09/07/15.
//

#import "ASLTriangleView.h"
#import "UIColor+ASLSlotMachine.h"

@interface ASLTriangleView ()

@property(nonatomic, assign) ASLTriangleType triangleType;

@end

@implementation ASLTriangleView

#pragma mark - Public Properties

- (UIColor *)triangleColor {
    if (_triangleColor == nil) {
        _triangleColor = [UIColor asl_PinkColor];
    }
    return _triangleColor;
}

#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)initWithTriangleType:(ASLTriangleType)triangleType {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        _triangleType = triangleType;
        [self setupBackground];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextBeginPath(ctx);

    CGFloat firstX, firstY, secondX, secondY, thirdX, thirdY;
    switch (self.triangleType) {
        case ASLTriangleTypeLeft:
            firstX = CGRectGetMinX(rect);
            firstY = CGRectGetMinY(rect);
            secondX = CGRectGetMaxX(rect);
            secondY = CGRectGetMidY(rect);
            thirdX = CGRectGetMinX(rect);
            thirdY = CGRectGetMaxY(rect);
            break;
        case ASLTriangleTypeRight:
            firstX = CGRectGetMaxX(rect);
            firstY = CGRectGetMinY(rect);
            secondX = CGRectGetMinX(rect);
            secondY = CGRectGetMidY(rect);
            thirdX = CGRectGetMaxX(rect);
            thirdY = CGRectGetMaxY(rect);
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected ASLTriangleType."];
    }

    CGContextMoveToPoint   (ctx, firstX, firstY);  // top left
    CGContextAddLineToPoint(ctx, secondX, secondY);  // mid right
    CGContextAddLineToPoint(ctx, thirdX, thirdY);  // bottom left
    CGContextClosePath(ctx);

    CGContextSetFillColorWithColor(ctx, self.triangleColor.CGColor);
    CGContextFillPath(ctx);
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods

- (void)setupBackground {
    [self setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Protocols
#pragma mark - Notifications

@end
