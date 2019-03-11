//
//  CategoryExpensesVC.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/4/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "CategoryExpensesVC.h"
#import "../../View/ExpenseCell.h"
#import "../CategoryDetails/CategoryDetailsVC.h"

@interface CategoryExpensesVC ()

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation CategoryExpensesVC

- (void)viewDidLoad {
  [super viewDidLoad];
  [_backButton addTarget:self
                      action:@selector(dismissSelf)
            forControlEvents:UIControlEventTouchUpInside];
  [self paintSelf];
  _refreshControl = [[UIRefreshControl alloc] init];
  _refreshControl.backgroundColor = UIColor.clearColor;
  _refreshControl.tintColor = UIColor.clearColor;
  UIView *refreshView = [[NSBundle.mainBundle loadNibNamed:@"RefreshControlXIB"
                                                     owner:self
                                                   options:nil] objectAtIndex:0];
  refreshView.frame = _refreshControl.bounds;
  [_refreshControl addSubview:refreshView];
  [_refreshControl addTarget:self
                          action:@selector(createNewExpense)
                forControlEvents:UIControlEventValueChanged];
  [_expensesTable addSubview:_refreshControl];
  [_editButton addTarget:self action:@selector(editCategory)
            forControlEvents:UIControlEventTouchUpInside];
  if (self.view.frame.size.width <= 375) {
    [_iconWidthConstraint setConstant:30];
    [_iconHeightConstraint setConstant:30];
  } else {
    [_iconWidthConstraint setConstant:40];
    [_iconHeightConstraint setConstant:40];
  }
}

- (void)viewWillAppear:(BOOL)animated {
  UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
  [UIView animateWithDuration:0.2f animations:^{
    [self setNeedsStatusBarAppearanceUpdate];
  }];
}

- (void)viewWillDisappear:(BOOL)animated {
  UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDefault;
  [UIView animateWithDuration:0.2f animations:^{
    [self setNeedsStatusBarAppearanceUpdate];
  }];
}


- (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
  CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
  CGFloat width = image.size.width * scale;
  CGFloat height = image.size.height * scale;
  CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                (size.height - height)/2.0f,
                                width,
                                height);
  UIGraphicsBeginImageContextWithOptions(size, NO, 0);
  [image drawInRect:imageRect];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}


- (void)editCategory {
  [self performSegueWithIdentifier:@"editCategory"
                            sender:[CategoriesManager getCategoryByName:_categoryTitle.text]];
}

- (void) dismissSelf {
  [self.presentingViewController dismissViewControllerAnimated:false completion:nil];
}

- (void) createNewExpense {
  Category *category = [CategoriesManager getCategoryByName:_categoryTitle.text];
  [self performSegueWithIdentifier:@"toExpDetails" sender:category];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.destinationViewController isKindOfClass:ExpenseDetailsVC.class]) {
    ExpenseDetailsVC *details = segue.destinationViewController;
    [details setHidesBottomBarWhenPushed:true];
    details.tableToReload = _expensesTable;
    if ([sender isKindOfClass:Expense.class]) {
      Expense *expense = sender;
      details.selectedExpense = expense;
    } else if ([sender isKindOfClass:Category.class]) {
      Category *category = sender;
      details.selectedCategory = category;
      [_refreshControl endRefreshing];
    }
  } else if ([segue.destinationViewController isKindOfClass:CategoryDetailsVC.class]) {
    CategoryDetailsVC *categoryDetails = segue.destinationViewController;
    categoryDetails.selectedCategory = sender;
    categoryDetails.headerToReload = _headerView;
    categoryDetails.titleToReload = _categoryTitle;
    categoryDetails.iconToReload = _categoryIcon;
    categoryDetails.parent = self;
  }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  [self recountTotal];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  [self recountTotal];
}

- (void)recountTotal {
  Category *category = [CategoriesManager getCategoryByName:_categoryTitle.text];
  NSNumber *total = [NSNumber numberWithFloat:[ExpensesManager getTotalCostOf:category]];
  _categoryTotal.text = [[total stringValue] stringByAppendingString:@" UAH"];
}

- (void) paintSelf {
  Category *category = _selectedCategory;
  UIColor *categoryColor = [[ColorsManager getAllColors] objectAtIndex:category.colorIndex];
  NSNumber *categoryTotal = [NSNumber numberWithFloat:[ExpensesManager getTotalCostOf:category]];
  UIImage *categoryIcon = [IconsManager getIconForIndex:category.iconIndex];
  [_headerView setBackgroundColor:categoryColor];
  [_categoryIcon setImage:categoryIcon];
  [_categoryTitle setText:category.title];
  [_categoryTotal setText:[[categoryTotal.stringValue
                                stringByAppendingString:@" UAH"]
                               stringByReplacingOccurrencesOfString:@"." withString:@","]];
  [_expensesTable registerNib:[UINib nibWithNibName:@"ExpenseCellXIB"
                                                 bundle:nil]
           forCellReuseIdentifier:@"expenseCell"];
  [_expensesTable setDelegate:self];
  [_expensesTable setDataSource:self];

}

- (IBAction)edgePan:(UIScreenEdgePanGestureRecognizer *)sender {
  [_backButton sendActionsForControlEvents:UIControlEventTouchUpInside];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  NSArray <Expense *> *expensesOfCategory = [ExpensesManager
                                             getAllExpensesOfCategory:_categoryTitle.text];
  expensesOfCategory = [expensesOfCategory
                        sortedArrayUsingComparator:
                        ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                          NSDate *one = ((Expense *)obj1).date;
                          NSDate *two = ((Expense *)obj2).date;
                          return [one compare:two] != NSOrderedDescending;
                        }];
  Expense *expense = [expensesOfCategory objectAtIndex:indexPath.row];
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  Category *category = [CategoriesManager getCategoryByName:_categoryTitle.text];
  return [[ExpensesManager getAllExpensesOfCategory:category.title] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSArray <Expense *> *expensesOfCategory = [ExpensesManager
                                             getAllExpensesOfCategory:_categoryTitle.text];
  expensesOfCategory = [expensesOfCategory
                        sortedArrayUsingComparator:
                        ^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
                          NSDate *one = ((Expense *)obj1).date;
                          NSDate *two = ((Expense *)obj2).date;
                          return [one compare:two] != NSOrderedDescending;
                        }];
  Expense *expense = [expensesOfCategory objectAtIndex:indexPath.row];
  [self performSegueWithIdentifier:@"toExpDetails" sender:expense];
}

@end
