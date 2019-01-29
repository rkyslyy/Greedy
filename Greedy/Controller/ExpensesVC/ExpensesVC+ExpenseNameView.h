//
//  ExpensesVC+ExpenseNameView.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "ExpensesVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpensesVC (ExpenseNameView)

- (void) beginEditingExpenseName;
- (void) createDarkMask;
- (void) dismissDarkMask;
- (void) moveExpenseNameViewUp;
- (void) moveExpenseNameViewDown;
- (void) endEditingExpenseName;

@end

NS_ASSUME_NONNULL_END
