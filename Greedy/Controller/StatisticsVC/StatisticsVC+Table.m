//
//  StatisticsVC+Table.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/11/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "StatisticsVC+Table.h"

@implementation StatisticsVC (Table)

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  StatisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"statisticsCell"];
  Category *category = [self.categories objectAtIndex:indexPath.row];
  [cell.categoryName setText:category.title];
  float categoryTotal = 0.f;
  if (self.selectedDateOption == Total) {
    categoryTotal = [ExpensesManager getTotalCostOf:category];
  }
  else if (self.selectedDateOption == Month) {
    categoryTotal = [ExpensesManager getMonthCostOf:category];
  }
  else {
    categoryTotal = [ExpensesManager getTodayCostOf:category];
  }
  NSString* totalString = [[[NSNumber numberWithFloat:categoryTotal]
                            stringValue] stringByAppendingString:@" UAH / "];
  float percents = ((categoryTotal / self.total) * 100);
  NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
  [fmt setPositiveFormat:@"0.##"];
  NSString *stringPercents = [fmt stringFromNumber:[NSNumber numberWithFloat:percents]];
  if (stringPercents.length > 3) stringPercents = [stringPercents substringToIndex:4];
  stringPercents = [stringPercents stringByAppendingString:@"%"];
  NSMutableAttributedString *stringPercentsAttr = [[NSMutableAttributedString alloc]
                                                   initWithString:[totalString
                                                     stringByAppendingString:stringPercents]];
  [stringPercentsAttr addAttribute:NSForegroundColorAttributeName
                             value:[[ColorsManager getAllColors] objectAtIndex:category.colorIndex]
                             range:[[totalString
                                     stringByAppendingString:stringPercents]
                                       rangeOfString:[totalString
                                         stringByAppendingString:stringPercents]]];
  [stringPercentsAttr addAttribute:NSForegroundColorAttributeName
                             value:UIColor.blackColor
                             range:[totalString rangeOfString:totalString]];
  UIFont *avenir = [UIFont fontWithName:@"AvenirNext-Medium" size:14];
  [stringPercentsAttr addAttribute:NSFontAttributeName
                             value:avenir
                             range:[[totalString
                                     stringByAppendingString:stringPercents]
                                       rangeOfString:[totalString
                                         stringByAppendingString:stringPercents]]];
  [cell.categoryTotal setAttributedText:stringPercentsAttr];
  UIColor *categoryColor = [[ColorsManager getAllColors] objectAtIndex:category.colorIndex];
  [cell paintSelfWithColor:categoryColor];
  [cell.iconImageView setImage:[IconsManager getIconForIndex:category.iconIndex]];
  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 61;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.categories.count;
}

@end
