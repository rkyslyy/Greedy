//
//  ExpensesVC+ExpenseNameView.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "ExpensesVC+ExpenseNameView.h"

@implementation ExpensesVC (ExpenseNameView)

- (void)createDarkMask {
  CGFloat height = self.view.frame.size.height -
                   (self.view.frame.size.height - self.expenseNameView.frame.origin.y);
  CGRect darkMaskFrame = CGRectMake(0, 0, self.view.frame.size.width, height);
  self.expenseNameMask = [[UIView alloc] initWithFrame:darkMaskFrame];
  self.expenseNameMask.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5f];
  self.expenseNameMask.alpha = 0.f;
  self.expenseNameMask.layer.zPosition = 0.2f;
  [self.view addSubview:self.expenseNameMask];
  [UIView animateWithDuration:0.2f animations:^{
    [self.expenseNameMask setAlpha:1.f];
  } completion:^(BOOL finished) {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]
                                    initWithTarget:self action:@selector(endEditingExpenseName)];
    [self.expenseNameMask addGestureRecognizer:tap];
  }];
}

- (void)dismissDarkMask {
  [UIView animateWithDuration:0.2f animations:^{
    [self.expenseNameMask setAlpha:0.f];
  } completion:^(BOOL finished) {
    [self.expenseNameMask removeFromSuperview];
    self.expenseNameMask = nil;
  }];
}

- (void)moveExpenseNameViewUp {
  [UIView animateWithDuration:0.2f animations:^{
    self.expenseNameView.frame = CGRectOffset(self.expenseNameView.frame, 0, -165);
    self.expenseNameBottomConstraint.constant += 165;
    CGRect smallerMaskFrame = self.expenseNameMask.frame;
    smallerMaskFrame.size.height -= 165;
    self.expenseNameMask.frame = smallerMaskFrame;
  }];
  if (self.expensesByDatesTable) {
    CGRect smallerTableFrame = self.expensesByDatesTable.frame;
    smallerTableFrame.size.height -= 165;
    self.expensesByDatesTable.frame = smallerTableFrame;
  }
}

- (void)moveExpenseNameViewDown {
  [UIView animateWithDuration:0.2f animations:^{
    self.expenseNameView.frame = CGRectOffset(self.expenseNameView.frame, 0, 165);
    self.expenseNameBottomConstraint.constant -= 165;
    CGRect biggerMaskFrame = self.expenseNameMask.frame;
    biggerMaskFrame.size.height += 165;
    self.expenseNameMask.frame = biggerMaskFrame;
  }];
  if (self.expensesByDatesTable) {
    CGRect biggerTableFrame = self.expensesByDatesTable.frame;
    biggerTableFrame.size.height += 165;
    self.expensesByDatesTable.frame = biggerTableFrame;
  }
}

- (void) beginEditingExpenseName {
  if (self.expenseNameMask) {
    return;
  }
  [self createDarkMask];
  [self moveExpenseNameViewUp];
}

- (void) endEditingExpenseName {
  if (!self.expenseNameMask) {
    return;
  }
  [self.view endEditing:true];
  [self setKeyBoardShown:false];
  [self dismissDarkMask];
  [self moveExpenseNameViewDown];
}

@end
