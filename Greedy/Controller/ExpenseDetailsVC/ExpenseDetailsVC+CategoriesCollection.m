//
//  ExpenseDetailsVC+CategoriesCollection.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC+CategoriesCollection.h"
#import "ExpenseDetailsVC+FrameManipulations.h"

@implementation ExpenseDetailsVC (CategoriesCollection)

- (void)showCategoriesCollection {
    if (self.pickingCategory) return;
    [self setPickingCategory:true];
    CGFloat collectionY = self.cardView.frame.size.height - 75;
    BOOL needToMoveUp = true;
    if (self.keyboardShown) {
        [self.view endEditing:true];
        [self setKeyboardShown:false];
        collectionY -= 170;
        needToMoveUp = false;
    }
    CGRect collectionFrame = CGRectMake(50, collectionY, self.cardView.frame.size.width - 100, 200);
    self.categoriesCollection = [[UICollectionView alloc]
                                 initWithFrame:collectionFrame
                                 collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.categoriesCollection setShowsVerticalScrollIndicator:false];
    self.categoriesCollection.delegate = self;
    self.categoriesCollection.dataSource = self;
    [self.categoriesCollection registerNib:[UINib nibWithNibName:@"CategoryCollectionCellXIB"
                                                          bundle:nil]
                forCellWithReuseIdentifier:@"categoryCollectionCell"];
    self.categoriesCollection.backgroundColor = UIColor.clearColor;
    [self.cardView addSubview:self.categoriesCollection];
    if (needToMoveUp)
        [UIView animateWithDuration:0.2f animations:^{
            [self makeCardViewTaller];
            [self.doneWithExpenseButton setAlpha:0.f];
        }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryCollectionCell *cell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"categoryCollectionCell"
                                                              forIndexPath:indexPath];
    Category *category = [[CategoriesManager getAllCategories] objectAtIndex:indexPath.item];
    cell.icon.backgroundColor = [[ColorsManager getAllColors] objectAtIndex:category.colorIndex];
    cell.title.text = category.title;
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return [[CategoriesManager getAllCategories] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(70, 50);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray <Category *> *categories = [CategoriesManager getAllCategories];
    Category *category = [categories objectAtIndex:indexPath.item];
    UIColor *color = [[ColorsManager getAllColors] objectAtIndex:category.colorIndex];
    [self paintDetailsViewWithColor:color];
    [self.pickCategoryButton setTitle:category.title forState:UIControlStateNormal];
    [self hideCategoriesCollection];
}

- (void)paintDetailsViewWithColor:(UIColor *)color {
    [self.titleTextField.layer setBorderColor:color.CGColor];
    [self.titleTextField setTextColor:color];
    [self.titleTextField setAttributedPlaceholder:[self getPlaceholderPaintedWith:color
                                                                       andMessage:@"Expense name"]];
    [self.dateButton.layer setBorderColor:color.CGColor];
    [self.dateButton setTitleColor:color forState:UIControlStateNormal];
    [self.costTextField.layer setBorderColor:color.CGColor];
    [self.costTextField setTextColor:color];
    [self.costTextField setAttributedPlaceholder:[self getPlaceholderPaintedWith:color
                                                                      andMessage:@"0 UAH"]];
    [self.pickCategoryButton.layer setBorderColor:color.CGColor];
    [self.pickCategoryButton setTitleColor:color forState:UIControlStateNormal];
    [self.doneWithExpenseButton setBackgroundColor:color];
}

- (NSMutableAttributedString*)getPlaceholderPaintedWith:(UIColor *)color
                                             andMessage:(NSString *)message {
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc]
                                              initWithString:message];
    NSInteger fontSize = 16;
    if (self.view.frame.size.width < 375) fontSize = 14;
    else if (self.view.frame.size.width > 375) fontSize = 18;
    UIFont *avenir = [UIFont fontWithName:@"AvenirNext-Medium" size:fontSize];
    [placeholder addAttribute:NSFontAttributeName
                        value:avenir
                        range:[message rangeOfString:message]];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[color colorWithAlphaComponent:0.5f]
                        range:[message rangeOfString:message]];
    return placeholder;
}

- (void)hideCategoriesCollection {
    [UIView animateWithDuration:0.2 animations:^{
        [self.categoriesCollection setAlpha:0.f];
        [self.doneWithExpenseButton setAlpha:1.f];
        [self makeCardViewShorter];
    } completion:^(BOOL finished) {
        [self.categoriesCollection removeFromSuperview];
        self.categoriesCollection = 0;
        [self setPickingCategory:false];
    }];
}

@end
