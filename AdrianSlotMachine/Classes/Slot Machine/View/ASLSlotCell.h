//
// Created by a on 09/07/15.
//

#import <UIKit/UIKit.h>

extern CGFloat const kSlotCellHeight;

@interface ASLSlotCell : UITableViewCell

- (void)configureWithImageName:(NSString *)imageName;
- (void)makeFadedAnimated:(BOOL)animated;

- (void)setGlow;
@end
