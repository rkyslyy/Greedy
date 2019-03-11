//
//  ViewController.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ExpensesVC+Tables.h"
#import "ExpensesVC+ExpenseNameView.h"
#import "AppDelegate.h"

@interface ExpensesVC ()

@end

@implementation ExpensesVC

- (void)viewDidLoad {
  [super viewDidLoad];

  _categoriesTable.delegate = self;
  _categoriesTable.dataSource = self;
  _expenseNameTextField.delegate = self;
  _categoriesTable.layer.zPosition = 0.1f;
  _expenseNameView.layer.zPosition = 0.3f;
  [_showExpensesByDatesButton addTarget:self
                                     action:@selector(showExpensesByDates)
                           forControlEvents:UIControlEventTouchUpInside];
  [_showCategoriesButton addTarget:self
                                action:@selector(showCategories)
                      forControlEvents:UIControlEventTouchUpInside];
  [_expenseNameAddButton addTarget:self
                                action:@selector(beginEditingDetails)
                      forControlEvents:UIControlEventTouchUpInside];
  if (self.view.frame.size.width < 375) {
    UIFont *font = _expenseNameTextField.font;
    [_expenseNameTextField setFont:[font fontWithSize:14]];
    font = _showCategoriesButton.titleLabel.font;
    [_showCategoriesButton.titleLabel setFont:[font fontWithSize:14]];
    font = _showExpensesByDatesButton.titleLabel.font;
    [_showExpensesByDatesButton.titleLabel setFont:[font fontWithSize:14]];
  }
  [self setupRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
  [_categoriesTable reloadData];
}

- (void)setupRefreshControl {
  _refreshControl = [[UIRefreshControl alloc] init];
  _refreshControl.backgroundColor = UIColor.clearColor;
  _refreshControl.tintColor = UIColor.clearColor;
  if ([[CategoriesManager getAllCategories] count]) {
    UIView *refreshView = [[NSBundle.mainBundle loadNibNamed:@"AddNewCategoryXIB"
                                                       owner:self
                                                     options:nil] objectAtIndex:0];
    refreshView.frame = _refreshControl.bounds;
    [_refreshControl addSubview:refreshView];
  }
  [_refreshControl addTarget:self
                          action:@selector(createNewCategory)
                forControlEvents:UIControlEventValueChanged];
  [_categoriesTable addSubview:_refreshControl];
}

- (void)createNewCategory {
  if ([[CategoriesManager getAllCategories] count] == 18) {
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert setMessage:@"You've reached maximum of 18 categories"];
    [alert setTitle:@"Sorry"];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [_refreshControl endRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.2 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                     [self presentViewController:alert animated:true completion:nil];
                   });
    return;
  }
  [self performSegueWithIdentifier:@"editCategory" sender:nil];
  [_refreshControl endRefreshing];
}

- (void)beginEditingDetails {
  if (![[CategoriesManager getAllCategories] count]) {
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert setMessage:@"Create at least one category to add an expense"];
    [alert setTitle:@"No expenses categories"];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
    return;
  }
  if (_expenseNameMask) {
    [self endEditingExpenseName];
  }
  [_categoriesTable.refreshControl endRefreshing];
  [self performSegueWithIdentifier:@"toExpDetails" sender:nil];
}

- (IBAction)unwindTo:(UIStoryboardSegue *)unwindSegue {}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (![[CategoriesManager getAllCategories] count]) {
    [_expenseNameTextField resignFirstResponder];
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert setMessage:@"Create at least one category to add an expense"];
    [alert setTitle:@"No expenses categories"];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
    return;
  }
  if (_keyBoardShown) {
    return;
  }
  [self setKeyBoardShown:true];
  if (textField == _expenseNameTextField) {
    [self beginEditingExpenseName];
  }
}

@end
