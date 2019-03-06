//
//  ExpenseDetailsVC+CategoriesCollection.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC.h"
#import "../../View/CategoryCollectionCell.h"
#import "../../Services/CategoriesManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpenseDetailsVC (CategoriesCollection) <
  UICollectionViewDelegate,
  UICollectionViewDataSource
>

- (void)showCategoriesCollection;
- (void)hideCategoriesCollection;
- (void)paintDetailsViewWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
