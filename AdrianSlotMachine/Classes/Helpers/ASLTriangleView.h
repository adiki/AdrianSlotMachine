//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ASLTriangleType) {
    ASLTriangleTypeLeft,
    ASLTriangleTypeRight,
};

@interface ASLTriangleView : UIView

@property(nonatomic, strong) UIColor *triangleColor;

- (instancetype)initWithTriangleType:(ASLTriangleType)triangleType;

@end
