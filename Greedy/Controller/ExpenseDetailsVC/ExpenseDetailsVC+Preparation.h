//
//  ExpenseDetailsVC+Preparation.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC.h"
#import "ExpenseDetailsVC+TextFields.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpenseDetailsVC (Preparation)

- (void)dismissSelf;
- (void)setupFieldsAndButtons;
- (void)hideMaskAndCardview;
- (void)showMaskAndCardview;
- (void)paintIfNecessary;

@end

NS_ASSUME_NONNULL_END
