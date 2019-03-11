//
//  ExpensesVC+Tables.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "ExpensesVC+Tables.h"

@implementation ExpensesVC (Tables)

// DataSource methods
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  if (tableView == self.categoriesTable) {
    NSArray <Category *> *categories = [CategoriesManager getAllCategories];
    Category *category = [categories objectAtIndex:indexPath.row];
    CategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
    cell.categoryTitle.text = category.title;
    cell.iconView.backgroundColor = [[ColorsManager getAllColors]
                                     objectAtIndex:category.colorIndex];
    [cell.iconImage setImage:[IconsManager getIconForIndex:category.iconIndex]];
    cell.category = category.title;
    cell.parent = self;
    UIFont *font = cell.categoryTitle.font;
    if (self.view.frame.size.width < 375) {
      [cell.categoryTitle setFont:[font fontWithSize:14]];
    }
    [cell setupButton];
    return cell;
  } else {
    NSArray <NSDate *> *dates = [ExpensesManager getExpensesDates];
    NSDate *date = [dates objectAtIndex:indexPath.section];
    NSArray <Expense *> *expensesOfDate = [ExpensesManager getAllExpensesBy:date];
    Expense *expense = [expensesOfDate objectAtIndex:indexPath.row];
    ExpenseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"expenseCell"];
    cell.title.text = expense.title;
    cell.date.text = [NSDateFormatter localizedStringFromDate:expense.date
                                                    dateStyle:NSDateFormatterMediumStyle
                                                    timeStyle:NSDateFormatterNoStyle];
    cell.cost.text = [[[[NSNumber numberWithFloat:expense.cost]
                        stringValue]
                       stringByAppendingString:@" UAH"]
                      stringByReplacingOccurrencesOfString:@"." withString:@","];
    [cell paintSelfFor:[CategoriesManager getCategoryByName:expense.category]];
    return cell;
  }
}

- (void) openDetailsWithCategory:(NSString *)categoryTitle {
  Category *category = [CategoriesManager getCategoryByName:categoryTitle];
  [self performSegueWithIdentifier:@"toExpDetails" sender:category];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (tableView == self.expensesByDatesTable) {
    return [[ExpensesManager getExpensesDates] count];
  }
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (tableView == self.categoriesTable) {
    return [[CategoriesManager getAllCategories] count];
  }
  NSArray <NSDate *> *dates = [ExpensesManager getExpensesDates];
  return [[ExpensesManager getAllExpensesBy:[dates objectAtIndex:section]] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  if (tableView == self.categoriesTable) {
    if (![[CategoriesManager getAllCategories] count]) {
      return [[NSBundle.mainBundle loadNibNamed:@"NoCategoriesLabelXIB"
                                          owner:self
                                        options:nil] objectAtIndex:0];
    }
    return nil;
  }
  if (tableView == self.categoryExpensesView.expensesTable) {
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
  }
  NSArray <NSString *> *dates = [ExpensesManager getExpensesDatesStrings];
  NSString *date = [dates objectAtIndex:section];
  if ([date isEqualToString:[NSDateFormatter localizedStringFromDate:[NSDate date]
                                                           dateStyle:NSDateFormatterMediumStyle
                                                           timeStyle:NSDateFormatterNoStyle]]) {
    date = @"Today";
  }
  if ([date isEqualToString:[NSDateFormatter
                             localizedStringFromDate:[NSDate.date dateByAddingTimeInterval:-86400.0]
                                                        dateStyle:NSDateFormatterMediumStyle
                             timeStyle:NSDateFormatterNoStyle]]) {
    date = @"Yesterday";
  }
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                self.expensesByDatesTable.frame.size.width,
                                                                30)];
  UILabel *headerLabel = [[UILabel alloc] initWithFrame:headerView.frame];
  NSMutableAttributedString *headerText = [[NSMutableAttributedString alloc] initWithString:date];
  UIFont *avenir = [UIFont fontWithName:@"Avenir" size:15];
  if (self.view.frame.size.width < 375) {
    avenir = [UIFont fontWithName:@"Avenir" size:14];
  }
  [headerText addAttribute:NSFontAttributeName value:avenir range:[date rangeOfString:date]];
  [headerText addAttribute:NSForegroundColorAttributeName
                     value:UIColor.darkGrayColor
                     range:[date rangeOfString:date]];
  [headerLabel setAttributedText:headerText];
  [headerLabel setTextAlignment:NSTextAlignmentCenter];
  [headerLabel setFrame:CGRectOffset(headerLabel.frame, 0, 10)];
  [headerView setBackgroundColor:UIColor.whiteColor];
  [headerView addSubview:headerLabel];
  return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  if (tableView != self.expensesByDatesTable) {
    return nil;
  }
  UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                                0,
                                                                self.view.frame.size.width,
                                                                35)];
  [footerView setBackgroundColor:UIColor.whiteColor];
  UIView *line = [[UIView alloc] initWithFrame:CGRectMake(
                                                          50,
                                                          5,
                                                          self.view.frame.size.width - 100,
                                                          1)];
  [line setBackgroundColor:UIColor.lightGrayColor];
  [footerView addSubview:line];
  UILabel *footerLabel = [[UILabel alloc] initWithFrame:CGRectMake(25,
                                                                   6,
                                                                   self.view.frame.size.width - 50,
                                                                   30)];
  NSArray <NSDate *> *dates = [ExpensesManager getExpensesDates];
  NSDate *date = [dates objectAtIndex:section];
  float total = [ExpensesManager getTotalCostBy:date];
  NSString *totalString = [[[[NSNumber numberWithFloat:total]
                             stringValue]
                               stringByAppendingString:@" UAH"]
                                 stringByReplacingOccurrencesOfString:@"."
                                                           withString:@","];
  NSMutableAttributedString *footerText = [[NSMutableAttributedString alloc]
                                           initWithString:totalString];
  UIFont *avenir = [UIFont fontWithName:@"Avenir" size:15];
  if (self.view.frame.size.width < 375) {
    avenir = [UIFont fontWithName:@"Avenir" size:14];
  }
  [footerText addAttribute:NSFontAttributeName
                     value:avenir
                     range:[totalString
                            rangeOfString:totalString]];
  [footerText addAttribute:NSForegroundColorAttributeName
                     value:UIColor.darkGrayColor
                     range:[totalString rangeOfString:totalString]];
  [footerLabel setAttributedText:footerText];
  [footerLabel setTextAlignment:NSTextAlignmentCenter];
  [footerView addSubview:footerLabel];
  return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (tableView == self.expensesByDatesTable) {
    return 30;
  }
  if (tableView == self.categoriesTable) {
    return [[CategoriesManager getAllCategories] count] ? 0 : 60;
  }
  return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return tableView == self.expensesByDatesTable ? 50 : 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  if (tableView == self.categoriesTable) {
    Category *category = [[CategoriesManager getAllCategories] objectAtIndex:indexPath.row];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self performSegueWithIdentifier:@"CategoryExpensesVC" sender:category];
    });
  } else if (tableView == self.expensesByDatesTable) {
    NSDate *date = [[ExpensesManager getExpensesDates] objectAtIndex:indexPath.section];
    NSArray <Expense *> *expensesOfDate = [ExpensesManager getAllExpensesBy:date];
    Expense *expense = [expensesOfDate objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"toExpDetails" sender:expense];
  }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.destinationViewController isKindOfClass:ExpenseDetailsVC.class]) {
    ExpenseDetailsVC *details = segue.destinationViewController;
    [details setHidesBottomBarWhenPushed:true];
    details.expenseTitle = self.expenseNameTextField.text;
    details.textFieldToClear = self.expenseNameTextField;
    if (self.expensesByDatesTable && !self.expensesByDatesTable.isHidden) {
      Expense *expense = sender;
      details.selectedExpense = expense;
      details.tableToReload = self.expensesByDatesTable;
      details.needDarkenStatusBar = YES;
    } else {
      Category *category = sender;
      details.selectedCategory = category;
      details.needDarkenStatusBar = YES;
    }
  } else if ([segue.destinationViewController isKindOfClass:CategoryExpensesVC.class]) {
    CategoryExpensesVC *categoryExpenses = segue.destinationViewController;
    categoryExpenses.selectedCategory = sender;
  } else if ([segue.destinationViewController isKindOfClass:CategoryDetailsVC.class]) {
    CategoryDetailsVC *categoryDetails = segue.destinationViewController;
    [categoryDetails setNeedDarkenStatusBar:true];
    [categoryDetails setTableToReload:self.categoriesTable];
    [self.refreshControl endRefreshing];
  }
}

- (void)showCategories {
  if (!self.categoriesTable.isHidden) {
    return;
  }
  [self.noExpensesLabel removeFromSuperview];
  [self setNoExpensesLabel:nil];
  if (![[CategoriesManager getAllCategories] count]) {
    self.noCategoriesLabel = [[NSBundle.mainBundle loadNibNamed:@"NoCategoriesLabelXIB"
                                                          owner:self
                                                        options:nil] objectAtIndex:0];
    [self.noCategoriesLabel setFrame:CGRectMake(0, 170, self.view.frame.size.width, 100)];
    [self.view addSubview:self.noCategoriesLabel];
  }

  UIColor *backgroundColor = self.showExpensesByDatesButton.backgroundColor;
  UIColor *textColor = self.showCategoriesButton.titleLabel.textColor;
  [self.showCategoriesButton setBackgroundColor:backgroundColor];
  [self.showCategoriesButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  [self.showCategoriesButton.layer setBorderWidth:0.f];
  [self.showExpensesByDatesButton setBackgroundColor:UIColor.whiteColor];
  [self.showExpensesByDatesButton setTitleColor:textColor forState:UIControlStateNormal];
  [self.showExpensesByDatesButton.layer setBorderWidth:1.f];
  [self.expensesByDatesTable removeFromSuperview];
  self.expensesByDatesTable = nil;
  [self.categoriesTable setHidden:false];
}

- (void)showExpensesByDates {
  if (self.expensesByDatesTable) {
    return;
  }
  [self.noCategoriesLabel removeFromSuperview];
  [self setNoCategoriesLabel:nil];
  UIColor *backgroundColor = self.showCategoriesButton.backgroundColor;
  UIColor *textColor = self.showExpensesByDatesButton.titleLabel.textColor;
  [self.showExpensesByDatesButton setBackgroundColor:backgroundColor];
  [self.showExpensesByDatesButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  [self.showExpensesByDatesButton.layer setBorderWidth:0.f];
  [self.showCategoriesButton setBackgroundColor:UIColor.whiteColor];
  [self.showCategoriesButton setTitleColor:textColor forState:UIControlStateNormal];
  [self.showCategoriesButton.layer setBorderWidth:1.f];
  [self.categoriesTable setHidden:true];
  [self createExpensesByDatesTable];
  if (![[ExpensesManager getExpensesDates] count]) {
    self.noExpensesLabel = [[NSBundle.mainBundle loadNibNamed:@"NoExpensesLabelXIB"
                                                        owner:self
                                                      options:nil] objectAtIndex:0];
    [self.noExpensesLabel setFrame:CGRectMake(0, 170, self.view.frame.size.width, 100)];
    [self.view addSubview:self.noExpensesLabel];
  }
}

- (void) createExpensesByDatesTable {
  self.expensesByDatesTable = [[UITableView alloc] initWithFrame:self.categoriesTable.frame style:UITableViewStylePlain];
  [self.expensesByDatesTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  self.expensesByDatesTable.delegate = self;
  self.expensesByDatesTable.dataSource = self;
  [self.expensesByDatesTable registerNib:[UINib nibWithNibName:@"ExpenseCellXIB" bundle:nil] forCellReuseIdentifier:@"expenseCell"];
  [self.view addSubview:self.expensesByDatesTable];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  [self.refreshControl removeFromSuperview];
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
  [self.refreshControl addTarget:self
                          action:@selector(createNewCategory)
                forControlEvents:UIControlEventValueChanged];
  [self.categoriesTable addSubview:self.refreshControl];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
  [self.refreshControl removeFromSuperview];
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
  [self.refreshControl addTarget:self
                          action:@selector(createNewCategory)
                forControlEvents:UIControlEventValueChanged];
  [self.categoriesTable addSubview:self.refreshControl];
}

@end
