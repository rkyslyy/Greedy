//
//  CategoryExpensesVC.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/4/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Services/ExpensesManager.h"
#import "../../Services/CategoriesManager.h"
#import "../../Services/ColorsManager.h"
#import "../ExpenseDetailsVC/ExpenseDetailsVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryExpensesVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

// Outlets
@property (weak, nonatomic) IBOutlet UIView             *headerView;
@property (weak, nonatomic) IBOutlet UIButton           *backButton;
@property (weak, nonatomic) IBOutlet UIButton           *editButton;
@property (weak, nonatomic) IBOutlet UIImageView        *categoryIcon;
@property (weak, nonatomic) IBOutlet UILabel            *categoryTitle;
@property (weak, nonatomic) IBOutlet UILabel            *categoryTotal;
@property (weak, nonatomic) IBOutlet UITableView        *expensesTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidthConstraint;
//
@property (strong, nonatomic)        Category           *selectedCategory;

- (void) dismissSelf;

@end

NS_ASSUME_NONNULL_END
