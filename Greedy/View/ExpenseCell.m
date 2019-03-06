//
//  ExpensesByDatesTableCell.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/1/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseCell.h"

@implementation ExpenseCell

- (void)paintSelfFor:(Category *)category {
  UIColor *color = [[ColorsManager getAllColors] objectAtIndex:category.colorIndex];
  [self.title.layer setBorderColor:color.CGColor];
  [self.title setTextColor:color];
  [self.date setTextColor:color];
  [self.cost setTextColor:color];
}

@end
