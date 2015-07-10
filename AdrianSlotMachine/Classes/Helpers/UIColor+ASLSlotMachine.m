//
// Created by a on 09/07/15.
//

#import "UIColor+ASLSlotMachine.h"


@implementation UIColor (ASLSlotMachine)

+ (UIColor *)asl_GrayColor {
    return [self colorWithRedInt:234 greenInt:234 blueInt:234 alpha:1];
}

+ (UIColor *)asl_VeryLightGrayColor {
    return [self colorWithRedInt:251 greenInt:251 blueInt:251 alpha:1];
}

+ (UIColor *)asl_PinkColor {
    return [self colorWithRedInt:220 greenInt:0 blueInt:95 alpha:1];
}

+ (UIColor *)asl_TurquoiseColor {
    return [self colorWithRedInt:28 greenInt:206 blueInt:202 alpha:1];
}

#pragma mark - Private Class Methods

+ (UIColor *)colorWithRedInt:(NSUInteger)redInt greenInt:(NSUInteger)greenInt blueInt:(NSUInteger)blueInt alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:redInt / 255.0f green:greenInt / 255.0f blue:blueInt / 255.0f alpha:alpha];
}

@end
