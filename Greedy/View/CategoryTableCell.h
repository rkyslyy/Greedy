//
//  CategoryCell.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpensesDetails.h"

@class ExpensesVC;

NS_ASSUME_NONNULL_BEGIN

@interface CategoryTableCell : UITableViewCell

// Outlets
@property (weak, nonatomic) IBOutlet UIView      *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel     *categoryTitle;
@property (weak, nonatomic) IBOutlet UIButton    *plusButton;
//
@property (strong, nonatomic)        NSString    *category;
@property (strong, nonatomic)        ExpensesVC  *parent;

- (void)setupButton;

@end

NS_ASSUME_NONNULL_END
