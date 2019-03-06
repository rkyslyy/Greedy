//
//  ViewController.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Services/ExpensesManager.h"
#import "../../Services/CategoriesManager.h"
#import "../../View/CategoryTableCell.h"
#import "../../View/ExpenseCell.h"
#import "../../View/ExpensesDetails.h"
#import "../../View/CategoryExpenses.h"
#import "../ExpenseDetailsVC/ExpenseDetailsVC.h"
#import "../CategoryExpensesVC/CategoryExpensesVC.h"

@interface ExpensesVC : UIViewController <UITextFieldDelegate>

// Outlets
@property (weak, nonatomic) IBOutlet    UIButton           *showCategoriesButton;
@property (weak, nonatomic) IBOutlet    UIButton           *showExpensesByDatesButton;
@property (weak, nonatomic) IBOutlet    UIButton           *expenseNameAddButton;
@property (weak, nonatomic) IBOutlet    UITableView        *categoriesTable;
@property (weak, nonatomic) IBOutlet    UIView             *expenseNameView;
@property (weak, nonatomic) IBOutlet    UITextField        *expenseNameTextField;
@property (weak, nonatomic) IBOutlet    NSLayoutConstraint *expenseNameBottomConstraint;
//
@property (strong, nonatomic, nullable) UIView             *noCategoriesLabel;
@property (strong, nonatomic, nullable) UIView             *noExpensesLabel;
@property (strong, nonatomic)           UIView             *expenseNameMask;
@property (strong, nonatomic)           UIView             *expenseDetailsMask;
@property (strong, nonatomic)           UITableView        *expensesByDatesTable;
@property (strong, nonatomic)           ExpensesDetails    *expenseDetailsView;
@property (strong, nonatomic)           CategoryExpenses   *categoryExpensesView;
@property (strong, nonatomic)           NSString           *selectedCategory;
@property (strong, nonatomic)           UIRefreshControl   *refreshControl;
@property (assign, nonatomic)           BOOL               keyBoardShown;
@property (assign, nonatomic)           BOOL               shaking;

- (void)createNewCategory;

@end

