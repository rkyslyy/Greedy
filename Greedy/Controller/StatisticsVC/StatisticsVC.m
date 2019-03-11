//
//  StatisticsVC.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/9/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "StatisticsVC+Table.h"
#import "StatisticsVC+PieChart.h"

@interface StatisticsVC ()

@end

@implementation StatisticsVC

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setSelectedDateOption:Total];
  [self setupPieChart];
  [_categoriesTable setDelegate:self];
  [_categoriesTable setDataSource:self];
  [_showTotal addTarget:self
                 action:@selector(switchToTotal)
       forControlEvents:UIControlEventTouchUpInside];
  [_showMonth addTarget:self
                 action:@selector(switchToMonth)
       forControlEvents:UIControlEventTouchUpInside];
  [_showToday addTarget:self
                 action:@selector(switchToToday)
       forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
  [self loadData];
  [self prepare];
}

- (void)viewDidAppear:(BOOL)animated {
  [_pieChart reloadData];
  _selectedSliceIndex = 0;
  [_pieChart setSliceSelectedAtIndex:0];
}

- (void)viewWillDisappear:(BOOL)animated {
  [_pieChart setSliceDeselectedAtIndex:_selectedSliceIndex];
  [_noExpensesLabel removeFromSuperview];
  _noExpensesLabel = nil;
}

- (void)switchToMonth {
  if (_selectedDateOption == Month) {
    return;
  }
  [self makeActiveButtonOf:Month];
  _selectedDateOption = Month;
  [self showNewSetting];
}

- (void)switchToTotal {
  if (_selectedDateOption == Total) {
    return;
  }
  [self makeActiveButtonOf:Total];
  _selectedDateOption = Total;
  [self showNewSetting];
}

- (void)switchToToday {
  if (_selectedDateOption == Today) {
    return;
  }
  [self makeActiveButtonOf:Today];
  _selectedDateOption = Today;
  [self showNewSetting];
}

- (void)showNewSetting {
  [self loadData];
  [self prepare];
  [_pieChart reloadData];
  [_pieChart setSliceSelectedAtIndex:0];
  [_categoriesTable reloadSections:[[NSIndexSet alloc] initWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationBottom];
}

- (void)loadData {
  if (_selectedDateOption == Total) {
    _categories = [CategoriesManager getAllNonZeroCategories];
    _total = 0.f;
    for (Category *category in _categories) {
      _total += [ExpensesManager getTotalCostOf:category];
    }
  } else if (_selectedDateOption == Month) {
    _categories = [CategoriesManager getMonthNonZeroCategories];
    _total = 0.f;
    for (Category *category in _categories) {
      _total += [ExpensesManager getMonthCostOf:category];
    }
  } else {
    _categories = [CategoriesManager getTodayNonZeroCategories];
    _total = 0.f;
    for (Category *category in _categories) {
      _total += [ExpensesManager getTodayCostOf:category];
    }
  }
}

- (void)prepare {
  if (!_categories.count) {
    _noExpensesLabel = [[NSBundle.mainBundle loadNibNamed:@"NoExpensesForStatLabelXIB"
                                                    owner:self
                                                  options:nil]
                        objectAtIndex:0];
    _noExpensesLabel.frame = CGRectMake(0, 200, self.view.frame.size.width, 50);
    [self.view addSubview:_noExpensesLabel];
    [_categoryName setAlpha:0.f];
    [_categoryTotal setAlpha:0.f];
    [_pieChart setAlpha:0.f];
    [_categoriesTable setAlpha:0.f];
    return;
  }
  [_noExpensesLabel removeFromSuperview];
  _noExpensesLabel = nil;
  NSString *firstCategoryTitle = [_categories objectAtIndex:0].title;
  [_categoryName setText:firstCategoryTitle];
  NSMutableAttributedString *firstCategoryTotal = [self getTotalString:nil];
  [_categoryTotal setAttributedText:firstCategoryTotal];
  _selectedSliceIndex = 0;
  [_categoryName setAlpha:1.f];
  [_categoryTotal setAlpha:1.f];
  [_pieChart setAlpha:1.f];
  [_categoriesTable setAlpha:1.f];

  [_categoriesTable reloadData];
}

- (NSMutableAttributedString*)getTotalString:(nullable Category *)cat {
  Category *category = cat ? cat : [_categories objectAtIndex:0];
  float categoryTotal;
  if (_selectedDateOption == Total) {
    categoryTotal = [ExpensesManager getTotalCostOf:category];
  }
  else if (_selectedDateOption == Month) {
    categoryTotal = [ExpensesManager getMonthCostOf:category];
  }
  else {
    categoryTotal = [ExpensesManager getTodayCostOf:category];
  }
  NSString *totalString = [[[NSNumber
                             numberWithFloat:categoryTotal]
                            stringValue] stringByAppendingString:@" UAH\n"];
  float percents = ((categoryTotal / _total) * 100);
  NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
  [fmt setPositiveFormat:@"0.##"];
  NSString *stringPercents = [fmt stringFromNumber:[NSNumber numberWithFloat:percents]];
  if (stringPercents.length > 3) {
    stringPercents = [stringPercents substringToIndex:4];
  }
  stringPercents = [stringPercents stringByAppendingString:@"%"];
  NSMutableAttributedString *stringPercentsAttr = [[NSMutableAttributedString alloc]
                                                   initWithString:[totalString
                                                     stringByAppendingString:stringPercents]];
  [stringPercentsAttr
   addAttribute:NSForegroundColorAttributeName
          value:[[ColorsManager getAllColors]
                   objectAtIndex:category.colorIndex]
          range:[[totalString
                  stringByAppendingString:stringPercents]
                    rangeOfString:[totalString stringByAppendingString:stringPercents]]];
  [stringPercentsAttr addAttribute:NSForegroundColorAttributeName
                             value:UIColor.blackColor range:[totalString rangeOfString:totalString]];
  UIFont *avenir = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
  [stringPercentsAttr
   addAttribute:NSFontAttributeName
          value:avenir
          range:[[totalString stringByAppendingString:stringPercents]
                 rangeOfString:[totalString stringByAppendingString:stringPercents]]];
  return stringPercentsAttr;
}

- (void) setupPieChart {
  [_pieChart setDelegate:self];
  [_pieChart setDataSource:self];
  [_pieChart setShowLabel:false];
}

- (void)makeActiveButtonOf:(DateType)type {
  UIButton *selectedButton;
  if (_selectedDateOption == Total) {
    selectedButton = _showTotal;
  }
  else if (_selectedDateOption == Month) {
    selectedButton = _showMonth;
  }
  else {
    selectedButton = _showToday;
  }
  UIColor *backgroundColor = selectedButton.backgroundColor;
  UIColor *textColor = _selectedDateOption == Total ? _showMonth.titleLabel.textColor
                                                    : _showTotal.titleLabel.textColor;
  [selectedButton setBackgroundColor:UIColor.whiteColor];
  [selectedButton setTitleColor:textColor forState:UIControlStateNormal];
  [selectedButton.layer setBorderWidth:1.f];
  UIButton *newButton;
  if (type == Total) {
    newButton = _showTotal;
  }
  else if (type == Month) {
    newButton = _showMonth;
  }
  else {
    newButton = _showToday;
  }
  [newButton setBackgroundColor:backgroundColor];
  [newButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
  [newButton.layer setBorderWidth:0.f];
}

@end
