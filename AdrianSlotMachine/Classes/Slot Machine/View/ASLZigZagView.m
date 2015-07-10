//
// Created by a on 09/07/15.
// Copyright (c) 2015 Adrian Sliwa. All rights reserved.
//

#import "ASLZigZagView.h"
#import "UIColor+ASLSlotMachine.h"


@implementation ASLZigZagView

#pragma mark - Public Properties
#pragma mark - Public Class Methods
#pragma mark - Public Instance Methods
#pragma mark - IBActions
#pragma mark - Overridden

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
    }

    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(ctx, 1.0f / self.contentScaleFactor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor asl_TurquoiseColor].CGColor);
    NSInteger squaresCount = (NSInteger) (CGRectGetWidth(rect) / CGRectGetHeight(rect));
    for (int i = 0; i < squaresCount; ++i) {
        CGContextBeginPath(ctx);
        CGContextMoveToPoint   (ctx, i * CGRectGetHeight(rect), CGRectGetMidY(rect));  // top left
        CGContextAddLineToPoint(ctx, i * CGRectGetHeight(rect) + CGRectGetMidY(rect), CGRectGetMinY(rect));  // mid right
        CGContextAddLineToPoint(ctx, (i + 1) * CGRectGetHeight(rect), CGRectGetMidY(rect));  // bottom left
        CGContextAddLineToPoint(ctx, i * CGRectGetHeight(rect) + CGRectGetMidY(rect), CGRectGetMaxY(rect));  // bottom left
        CGContextClosePath(ctx);
        CGContextStrokePath(ctx);
    }
}

#pragma mark - Private Properties
#pragma mark - Private Class Methods
#pragma mark - Private Instance Methods
#pragma mark - Protocols
#pragma mark - Notifications

@end
