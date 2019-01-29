//
//  CategoryExpenses.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/2/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../Services/ExpensesManager.h"
#import "../Services/CategoriesManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryExpenses : UIView

@property (strong, nonatomic) IBOutlet UIView       *contentView;
@property (weak, nonatomic) IBOutlet UIView         *headerView;
@property (weak, nonatomic) IBOutlet UIButton       *backButton;
@property (weak, nonatomic) IBOutlet UIButton       *editButton;
@property (weak, nonatomic) IBOutlet UIImageView    *categoryIcon;
@property (weak, nonatomic) IBOutlet UILabel        *categoryTitle;
@property (weak, nonatomic) IBOutlet UILabel        *categoryTotal;
@property (weak, nonatomic) IBOutlet UITableView    *expensesTable;

- (void) showSelf;
- (void) recountTotal;



@end

NS_ASSUME_NONNULL_END
