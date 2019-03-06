//
//  StatisticsVC+PieChart.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/11/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "StatisticsVC+PieChart.h"

@implementation StatisticsVC (PieChart)

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
  return self.categories.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
  float categoryTotal = 0.f;
  if (self.selectedDateOption == Total) {
    categoryTotal = [ExpensesManager getTotalCostOf:[self.categories objectAtIndex:index]];
  }
  else if (self.selectedDateOption == Month) {
    categoryTotal = [ExpensesManager getMonthCostOf:[self.categories objectAtIndex:index]];
  }
  else {
    categoryTotal = [ExpensesManager getTodayCostOf:[self.categories objectAtIndex:index]];
  }
  return ((categoryTotal / self.total) * 100);
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index {
  return [[ColorsManager getAllColors] objectAtIndex:[self.categories objectAtIndex:index].colorIndex];
}

- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index {
  if (index == self.selectedSliceIndex) return;
  if (self.selectedSliceIndex == -1) {
    [UIView animateWithDuration:0.2f animations:^{
      [self.categoryName setAlpha:1.f];
      [self.categoryTotal setAlpha:1.f];
    }];
  }
  self.selectedSliceIndex = index;
  NSString *categoryTitle = [self.categories objectAtIndex:index].title;
  [self.categoryName setText:categoryTitle];
  NSMutableAttributedString *categoryTotal = [self
                                              getTotalString:[self.categories objectAtIndex:index]];
  [self.categoryTotal setAttributedText:categoryTotal];
}

- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index {
  if (self.categories.count < 2) return;
  if (index == self.selectedSliceIndex) {
    [UIView animateWithDuration:0.2f animations:^{
      [self.categoryName setAlpha:0.f];
      [self.categoryTotal setAlpha:0.f];
    }];
  }
  self.selectedSliceIndex = -1;
}

@end
