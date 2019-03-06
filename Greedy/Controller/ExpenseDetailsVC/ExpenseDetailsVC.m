//
//  ExpenseDetailsVC.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC+Preparation.h"
#import "ExpenseDetailsVC+FrameManipulations.h"
#import "../../Services/CategoriesManager.h"

@interface ExpenseDetailsVC ()

@end

@implementation ExpenseDetailsVC

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupFieldsAndButtons];
  [self paintIfNecessary];
  [self mutateFontsIfNecessary];
}

- (void)viewWillAppear:(BOOL)animated {
  [self hideMaskAndCardview];
  if (![_expenseTitle isEqualToString:@""])
    [self.titleTextField setText:_expenseTitle];
}

- (void)viewDidAppear:(BOOL)animated {
  [self showMaskAndCardview];
}

- (void) mutateFontsIfNecessary {
  if (self.view.frame.size.width < 375) {
    UIFont *font = self.titleTextField.font;
    [self.titleTextField setFont:[font fontWithSize:14]];
    font = self.dateButton.titleLabel.font;
    [self.dateButton.titleLabel setFont:[font fontWithSize:14]];
    font = self.costTextField.font;
    [self.costTextField setFont:[font fontWithSize:14]];
    font = self.pickCategoryButton.titleLabel.font;
    [self.pickCategoryButton.titleLabel setFont:[font fontWithSize:14]];
  } else if (self.view.frame.size.width > 375) {
    UIFont *font = self.titleTextField.font;
    [self.titleTextField setFont:[font fontWithSize:18]];
    font = self.dateButton.titleLabel.font;
    [self.dateButton.titleLabel setFont:[font fontWithSize:18]];
    font = self.costTextField.font;
    [self.costTextField setFont:[font fontWithSize:18]];
    font = self.pickCategoryButton.titleLabel.font;
    [self.pickCategoryButton.titleLabel setFont:[font fontWithSize:18]];
  }
}

@end
