//
//  CategoryExpenses.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/2/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "CategoryExpenses.h"

@implementation CategoryExpenses

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self customInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self customInit];
  }
  return self;
}

- (void) customInit {
  [[NSBundle mainBundle] loadNibNamed:@"CategoryExpensesXIB"
                                owner:self
                              options:nil];
  [self.contentView setFrame:self.bounds];
  [self addSubview:self.contentView];
  [self.backButton addTarget:self
                      action:@selector(dismissSelf:)
            forControlEvents:UIControlEventTouchUpInside];
  UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(dismissSelf:)];
  [edgePan setEdges:UIRectEdgeLeft];
  [self addGestureRecognizer:edgePan];
  [self.layer setZPosition:0.6];
}

- (void)showSelf {
  [UIView animateWithDuration:0.2 animations:^{
    [self setFrame:CGRectOffset(self.frame, -self.frame.size.width, 0)];
  }];
}

- (void) dismissSelf:(UIScreenEdgePanGestureRecognizer*)pan {
  if (pan.state == UIGestureRecognizerStateEnded ||
      ![pan isKindOfClass:UIScreenEdgePanGestureRecognizer.class]) {
    [UIView animateWithDuration:0.2 animations:^{
      [self setFrame:CGRectOffset(self.frame, self.frame.size.width, 0)];
    } completion:^(BOOL finished) {
      [self removeFromSuperview];
    }];
  }
}

- (void)recountTotal {
  Category *category = [CategoriesManager getCategoryByName:self.categoryTitle.text];
  NSNumber *total = [NSNumber numberWithFloat:[ExpensesManager getTotalCostOf:category]];
  self.categoryTotal.text = [[total stringValue] stringByAppendingString:@" UAH"];
}

@end
