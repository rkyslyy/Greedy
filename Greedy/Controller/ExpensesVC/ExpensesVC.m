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

  self.categoriesTable.delegate = self;
  self.categoriesTable.dataSource = self;
  self.expenseNameTextField.delegate = self;
  self.categoriesTable.layer.zPosition = 0.1f;
  self.expenseNameView.layer.zPosition = 0.3f;
  [self.showExpensesByDatesButton addTarget:self
                                     action:@selector(showExpensesByDates)
                           forControlEvents:UIControlEventTouchUpInside];
  [self.showCategoriesButton addTarget:self
                                action:@selector(showCategories)
                      forControlEvents:UIControlEventTouchUpInside];
  [self.expenseNameAddButton addTarget:self
                                action:@selector(beginEditingDetails)
                      forControlEvents:UIControlEventTouchUpInside];
  if (self.view.frame.size.width < 375) {
    UIFont *font = self.expenseNameTextField.font;
    [self.expenseNameTextField setFont:[font fontWithSize:14]];
    font = self.showCategoriesButton.titleLabel.font;
    [self.showCategoriesButton.titleLabel setFont:[font fontWithSize:14]];
    font = self.showExpensesByDatesButton.titleLabel.font;
    [self.showExpensesByDatesButton.titleLabel setFont:[font fontWithSize:14]];
  }
  self.refreshControl = [[UIRefreshControl alloc] init];
  self.refreshControl.backgroundColor = UIColor.clearColor;
  self.refreshControl.tintColor = UIColor.clearColor;
  if ([[CategoriesManager getAllCategories] count]) {
    UIView *refreshView = [[NSBundle.mainBundle loadNibNamed:@"AddNewCategoryXIB"
                                                       owner:self
                                                     options:nil] objectAtIndex:0];
    refreshView.frame = self.refreshControl.bounds;
    [self.refreshControl addSubview:refreshView];
  }
  [self.refreshControl addTarget:self action:@selector(createNewCategory)
                forControlEvents:UIControlEventValueChanged];
  [self.categoriesTable addSubview:self.refreshControl];
}

- (void)createNewCategory {
  if ([[CategoriesManager getAllCategories] count] == 18) {
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert setMessage:@"You've reached maximum of 18 categories"];
    [alert setTitle:@"Sorry"];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self.refreshControl endRefreshing];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.2 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                     [self presentViewController:alert animated:true completion:nil];
                   });
    return;
  }
  [self performSegueWithIdentifier:@"editCategory" sender:nil];
  [self.refreshControl endRefreshing];
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
  if (self.expenseNameMask)
    [self endEditingExpenseName];
  [self.categoriesTable.refreshControl endRefreshing];
  [self performSegueWithIdentifier:@"toExpDetails" sender:nil];
}

- (IBAction)unwindTo:(UIStoryboardSegue *)unwindSegue {}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (![[CategoriesManager getAllCategories] count]) {
    [self.expenseNameTextField resignFirstResponder];
    UIAlertController *alert = [[UIAlertController alloc] init];
    [alert setMessage:@"Create at least one category to add an expense"];
    [alert setTitle:@"No expenses categories"];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
    return;
  }
  if (self.keyBoardShown)
    return;
  [self setKeyBoardShown:true];
  if (textField == self.expenseNameTextField)
    [self beginEditingExpenseName];
}

- (void)viewWillAppear:(BOOL)animated {
  [_categoriesTable reloadData];
}


@end
