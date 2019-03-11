//
//  ExpenseDetailsVC+FrameManipulations.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC+FrameManipulations.h"
#import "ExpenseDetailsVC+CategoriesCollection.h"

@implementation ExpenseDetailsVC (FrameManipulations)

- (void)makeCardViewTaller {
  CGRect newFrame = self.cardView.frame;
  newFrame.size.height += 170;
  newFrame.origin.y -= 170;
  [self.cardView setFrame:newFrame];
  self.cardViewHeightConstraint.constant += 170;
}

- (void)makeCardViewShorter {
  CGRect newFrame = self.cardView.frame;
  newFrame.size.height -= 170;
  newFrame.origin.y += 170;
  [self.cardView setFrame:newFrame];
  self.cardViewHeightConstraint.constant -= 170;
}

- (void) hideKeyboardAndMoveDown:(nullable UITapGestureRecognizer *)tap {
  if (tap) {
    CGPoint tapLocation = [tap locationInView:self.pickCategoryButton];
    if ([self.pickCategoryButton.layer containsPoint:tapLocation]) {
      return;
    }
    tapLocation = [tap locationInView:self.dateButton];
    if ([self.dateButton.layer containsPoint:tapLocation]) {
      return;
    }
    tapLocation = [tap locationInView:self.categoriesCollection];
    if ([self.categoriesCollection.layer containsPoint:tapLocation]) {
      return;
    }
  }
  if (self.keyboardShown) {
    [self.view endEditing:true];
    [self setKeyboardShown:false];
    [UIView animateWithDuration:(NSTimeInterval)0.2 animations:^{
      [self makeCardViewShorter];
      [self.doneWithExpenseButton setAlpha:1.f];
    }];
  } else if (self.pickingCategory) {
    [self hideCategoriesCollection];
  }
}

@end
