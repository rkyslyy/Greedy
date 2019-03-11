//
//  ColorsManager.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "ColorsManager.h"
#import "CategoriesManager.h"

@implementation ColorsManager

+ (NSArray<UIColor *> *)getAllColors {
  return @[[self handyColorWithRed:50 green:43 blue:128],
           [self handyColorWithRed:192 green:206 blue:46],
           [self handyColorWithRed:0 green:104 blue:55],
           [self handyColorWithRed:196 green:0 blue:122],
           [self handyColorWithRed:24 green:54 blue:100],
           [self handyColorWithRed:202 green:79 blue:28],
           [self handyColorWithRed:123 green:58 blue:14],
           [self handyColorWithRed:65 green:117 blue:5],
           [self handyColorWithRed:239 green:197 blue:21],
           [self handyColorWithRed:137 green:39 blue:19],
           [self handyColorWithRed:85 green:41 blue:128],
           [self handyColorWithRed:45 green:41 blue:40],
           [self handyColorWithRed:106 green:168 blue:66],
           [self handyColorWithRed:40 green:56 blue:65],
           [self handyColorWithRed:0 green:153 blue:162],
           [self handyColorWithRed:0 green:113 blue:188],
           [self handyColorWithRed:50 green:43 blue:128],
           [self handyColorWithRed:56 green:103 blue:109]];
}

+ (NSArray<UIColor *> *)getFreeColors {
  NSMutableArray <NSNumber *> *array = [NSMutableArray array];
  NSArray <Category *> *categories = [CategoriesManager getAllCategories];
  for (Category *category in categories) {
    [array addObject:[NSNumber numberWithInteger:category.colorIndex]];
  }
  NSArray <UIColor *> *colors = [self getAllColors];
  NSMutableArray <UIColor *> *freeColors = [NSMutableArray array];
  for (NSInteger i = 0; i < colors.count; ++i) {
    NSNumber *x = [NSNumber numberWithInteger:i];
    if (![array containsObject:x]) {
      [freeColors addObject:[colors objectAtIndex:i]];
    }
  }
  return freeColors;
}

+ (NSArray<NSNumber *> *)getFreeColorsIndexes {
  NSMutableArray <NSNumber *> *takenIndexes = [NSMutableArray array];
  NSArray <Category *> *categories = [CategoriesManager getAllCategories];
  for (Category *category in categories) {
    [takenIndexes addObject:[NSNumber numberWithInteger:category.colorIndex]];
  }
  NSMutableArray <NSNumber *> *freeIndexes = [NSMutableArray array];
  for (NSInteger i = 0; i < 18; ++i)
    if (![takenIndexes containsObject:[NSNumber numberWithInteger:i]]) {
      [freeIndexes addObject:[NSNumber numberWithInteger:i]];
    }
  return freeIndexes;
}

+ (UIColor *) handyColorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
  return [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1];
}

@end
