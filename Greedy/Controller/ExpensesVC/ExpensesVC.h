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

// Toggle tables buttons outlets
@property (weak, nonatomic) IBOutlet UIButton*              showCategoriesButton;
@property (weak, nonatomic) IBOutlet UIButton*              showExpensesByDatesButton;

// Tables outlets
@property (weak, nonatomic) IBOutlet UITableView*           categoriesTable;
@property (strong, nonatomic)        UITableView*           expensesByDatesTable;

// ExpenseNameView outlets
@property (strong, nonatomic)        UIView*                expenseNameMask;
@property (weak, nonatomic) IBOutlet UIView*                expenseNameView;
@property (weak, nonatomic) IBOutlet UITextField*           expenseNameTextField;
@property (weak, nonatomic) IBOutlet UIButton*              expenseNameAddButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    expenseNameBottomConstraint;

// ExpenseDetailsView outlets
@property (strong, nonatomic)        UIView*                expenseDetailsMask;
@property (strong, nonatomic)        ExpensesDetails*       expenseDetailsView;

// CategoryExpensesView outlets
@property (strong, nonatomic)        CategoryExpenses*      categoryExpensesView;

@property (assign, nonatomic)        BOOL                   keyBoardShown;
@property (assign, nonatomic)        BOOL                   shaking;
@property (strong, nonatomic)        NSString*              selectedCategory;

@property (strong, nonatomic) UIRefreshControl*             refreshControl;
@property (strong, nonatomic) UIView* _Nullable             noCategoriesLabel;
@property (strong, nonatomic) UIView* _Nullable             noExpensesLabel;

- (void)createNewCategory;


@end

