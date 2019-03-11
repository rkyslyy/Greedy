//
//  ExpenseDetailsVC+Preparation.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC+Preparation.h"
#import "ExpenseDetailsVC+FrameManipulations.h"
#import "ExpenseDetailsVC+DatePicker.h"
#import "ExpenseDetailsVC+CategoriesCollection.h"
#import "../../Services/ExpensesManager.h"

@implementation ExpenseDetailsVC (Preparation)

- (void) dismissSelf {
  if (self.keyboardShown) {
    return [self hideKeyboardAndMoveDown:nil];
  }
  if (self.pickingCategory) {
    return [self hideCategoriesCollection];
  }
  if (self.selectedExpense) {
    NSMutableArray <UIView *> *viewsToShake = [NSMutableArray array];
    if (self.titleTextField.text.length == 0) {
      [viewsToShake addObject:self.titleTextField];
    }
    if (self.costTextField.text.length == 0 || [self.costTextField.text floatValue] == 0) {
      [viewsToShake addObject:self.costTextField];
    }
    if ([self.pickCategoryButton.titleLabel.text isEqualToString:@"Pick category"]) {
      [viewsToShake addObject:self.pickCategoryButton];
    }
    if (viewsToShake.count) {
      return [self shake:viewsToShake];
    }
    NSDateFormatter *dF = [[NSDateFormatter alloc] init];
    [dF setDateFormat:@"MMM dd, yyyy"];
    [dF setLocale:NSLocale.currentLocale];
    NSDate *date = [dF dateFromString:self.dateButton.titleLabel.text];
    self.selectedExpense.title = self.titleTextField.text;
    self.selectedExpense.category = self.pickCategoryButton.titleLabel.text;
    self.selectedExpense.cost = [self.costTextField.text floatValue];
    self.selectedExpense.date = date;
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [delegate saveContext];
  }
  if (self.tableToReload) {
    [self.tableToReload reloadData];
  }
  [self.textFieldToClear setText:@""];
  [UIView animateWithDuration:0.2f animations:^{
    [self.blurredMask setAlpha:0.f];
    [self.cardView setFrame:CGRectOffset(self.cardView.frame, 0, 300)];
    self.cardViewBottomConstraint.constant -= 300;
    if (self.needDarkenStatusBar) {
      UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDefault;
      [self setNeedsStatusBarAppearanceUpdate];
    }
  } completion:^(BOOL finished) {
    [self.presentingViewController dismissViewControllerAnimated:false
                                                      completion:nil];
  }];
}

- (void) setupFieldsAndButtons {
  [self.titleTextField setDelegate:self];
  [self.titleTextField addTarget:self
                          action:@selector(controlLength)
                forControlEvents:UIControlEventEditingChanged];
  [self.costTextField setDelegate:self];
  [self.costTextField addTarget:self
                         action:@selector(controlCost)
               forControlEvents:UIControlEventEditingChanged];
  [self.costTextField addTarget:self
                         action:@selector(controlPoint)
               forControlEvents:UIControlEventEditingDidEnd];
  NSDate *today = [NSDate date];
  NSString *todayString = [NSDateFormatter localizedStringFromDate:today
                                                         dateStyle:NSDateFormatterMediumStyle
                                                         timeStyle:NSDateFormatterNoStyle];
  [self.dateButton setTitle:todayString forState:UIControlStateNormal];
  [self.dateButton addTarget:self
                      action:@selector(showDatePicker)
            forControlEvents:UIControlEventTouchUpInside];
  [self.pickCategoryButton addTarget:self
                              action:@selector(showCategoriesCollection)
                    forControlEvents:UIControlEventTouchUpInside];
  [self.doneWithExpenseButton addTarget:self
                                 action:@selector(commitChanges)
                       forControlEvents:UIControlEventTouchUpInside];
}

- (void) hideMaskAndCardview {
  [self.blurredMask setAlpha:0.f];
  [self.view setBackgroundColor:UIColor.clearColor];
  self.cardViewBottomConstraint.constant -= 300;
  [self.cardView setFrame:CGRectOffset(self.cardView.frame, 0, 300)];
}

- (void) showMaskAndCardview {
  [UIView animateWithDuration:0.2f animations:^{
    [self.blurredMask setAlpha:1.f];
    [self.cardView setFrame:CGRectOffset(self.cardView.frame, 0, -300)];
    self.cardViewBottomConstraint.constant += 300;
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
  } completion:^(BOOL finished) {
    UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissSelf)];
    [self.blurredMask addGestureRecognizer:maskTap];
    UITapGestureRecognizer *cardTap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(hideKeyboardAndMoveDown:)];
    [cardTap setCancelsTouchesInView:false];
    [self.cardView addGestureRecognizer:cardTap];
  }];
}

- (void) commitChanges {
  if (!self.selectedExpense) {
    NSMutableArray <UIView *> *viewsToShake = [NSMutableArray array];
    if (self.titleTextField.text.length == 0) {
      [viewsToShake addObject:self.titleTextField];
    }
    if (self.costTextField.text.length == 0 || [self.costTextField.text floatValue] == 0) {
      [viewsToShake addObject:self.costTextField];
    }
    if ([self.pickCategoryButton.titleLabel.text isEqualToString:@"Pick category"]) {
      [viewsToShake addObject:self.pickCategoryButton];
    }
    if (viewsToShake.count) {
      return [self shake:viewsToShake];
    }
  }
  NSDateFormatter *dF = [[NSDateFormatter alloc] init];
  [dF setDateFormat:@"MMM dd, yyyy"];
  [dF setLocale:NSLocale.currentLocale];
  NSDate *date = [dF dateFromString:self.dateButton.titleLabel.text];
  if (self.selectedExpense) {
    [ExpensesManager delete:self.selectedExpense];
    self.selectedExpense = nil;
  } else {
    [ExpensesManager createNewExpenseWith:self.titleTextField.text
                                 category:self.pickCategoryButton.titleLabel.text
                                     cost:self.costTextField.text
                                     date:date];
  }
  [self dismissSelf];
}

- (void) shake:(NSMutableArray*)views {
  if (self.shaking) {
    return;
  }
  for (UIView *view in views) {
    self.shaking = YES;
    CGColorRef viewColor = view.layer.borderColor;
    [view.layer setBorderColor:[UIColor.redColor CGColor]];
    view.transform = CGAffineTransformMakeTranslation(20, 0);
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                       view.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                       [UIView transitionWithView:view duration:0.2
                                          options:UIViewAnimationOptionTransitionCrossDissolve
                                       animations:^{
                                         view.layer.borderColor = viewColor;
                                       } completion:^(BOOL finished) {
                                         self.shaking = NO;
                                       }];
                     }];
  }
}

- (void)paintIfNecessary {
  if (self.selectedExpense) {
    Category *category = [CategoriesManager getCategoryByName:self.selectedExpense.category];
    UIColor *color = [[ColorsManager getAllColors] objectAtIndex:category.colorIndex];
    [self paintDetailsViewWithColor:color];
    [self.titleTextField setText:self.selectedExpense.title];
    [self.pickCategoryButton setTitle:category.title forState:UIControlStateNormal];
    [self.dateButton setTitle:[NSDateFormatter localizedStringFromDate:self.selectedExpense.date
                                                             dateStyle:NSDateFormatterMediumStyle
                                                             timeStyle:NSDateFormatterNoStyle]
                     forState:UIControlStateNormal];
    [self.costTextField setText:[[NSNumber numberWithFloat:self.selectedExpense.cost] stringValue]];
    [self.pickCategoryButton setTitle:self.selectedExpense.category forState:UIControlStateNormal];
    [self.doneWithExpenseButton setImage:[UIImage imageNamed:@"rubbish-bin"]
                                forState:UIControlStateNormal];
  } else if (self.selectedCategory) {
    Category *category = self.selectedCategory;
    UIColor *color = [[ColorsManager getAllColors] objectAtIndex:category.colorIndex];
    [self paintDetailsViewWithColor:color];
    [self.pickCategoryButton setTitle:category.title forState:UIControlStateNormal];
  }
}

- (void) controlLength {
  if (self.titleTextField.text.length > 20) {
    [self.titleTextField setText:[self.titleTextField.text
                                  substringToIndex:self.titleTextField.text.length - 1]];
  }
}

@end
