//
//  StatisticsCell.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/9/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView				*iconView;
@property (weak, nonatomic) IBOutlet UIImageView  *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel      *categoryName;
@property (weak, nonatomic) IBOutlet UILabel      *categoryTotal;

- (void) paintSelfWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
