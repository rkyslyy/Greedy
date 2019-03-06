//
//  CategoryDetailsVC+FrameManipulations.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/12/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "CategoryDetailsVC+FrameManipulations.h"
#import "CategoryDetailsVC+Collection.h"

@implementation CategoryDetailsVC (FrameManipulations)

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

- (void) hideKeyboardAndMoveDown:(nullable UITapGestureRecognizer*)tap {
  if (tap) {
    CGPoint tapLocation = [tap locationInView:self.pickColorButton];
    if ([self.pickColorButton.layer containsPoint:tapLocation])
      return;
    tapLocation = [tap locationInView:self.pickIconButton];
    if ([self.pickIconButton.layer containsPoint:tapLocation])
      return;
    tapLocation = [tap locationInView:self.collection];
    if ([self.collection.layer containsPoint:tapLocation])
      return;
  }
  if (self.keyboardShown) {
    [self.view endEditing:true];
    [self setKeyboardShown:false];
    [UIView animateWithDuration:(NSTimeInterval)0.2 animations:^{
      [self makeCardViewShorter];
      [self.doneWithCategoryButton setAlpha:1.f];
    }];
  } else if (self.pickingColor || self.pickingIcon) {
    [self hideCollection];
  }
}

@end
