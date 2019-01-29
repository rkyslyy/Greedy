//
//  ExpenseDetailsVC+FrameManipulations.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpenseDetailsVC (FrameManipulations)

- (void) makeCardViewTaller;
- (void) makeCardViewShorter;
- (void) hideKeyboardAndMoveDown:(nullable UITapGestureRecognizer*)tap;

@end

NS_ASSUME_NONNULL_END
