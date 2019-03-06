//
//  CategoryDetailsVC+ColorsCollection.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/13/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "CategoryDetailsVC+Collection.h"
#import "CategoryDetailsVC+FrameManipulations.h"
#import "../../Services/ColorsManager.h"
#import "../../Services/IconsManager.h"
#import "../../View/ColorsCollectionCell.h"
#import "../../View/IconsCollectionCell.h"

@implementation CategoryDetailsVC (Collection)

- (void)showCollection {
    CGFloat collectionY = self.cardView.frame.size.height - 75;
    BOOL needToMoveUp = true;
    if (self.keyboardShown || self.pickingIcon || self.pickingColor) {
        [self.view endEditing:true];
        [self setKeyboardShown:false];
        collectionY -= 170;
        needToMoveUp = false;
    }
    CGRect collectionFrame = CGRectMake(50, collectionY, self.cardView.frame.size.width - 100, 200);
    [self.collection removeFromSuperview];
    self.collection = [[UICollectionView alloc] initWithFrame:collectionFrame
                                         collectionViewLayout:[[UICollectionViewFlowLayout alloc]
                                                               init]];
    [self.collection setShowsVerticalScrollIndicator:false];
    self.collection.backgroundColor = UIColor.clearColor;
    [self.cardView addSubview:self.collection];
    if (needToMoveUp)
        [UIView animateWithDuration:0.2f animations:^{
            [self makeCardViewTaller];
            [self.doneWithCategoryButton setAlpha:0.f];
        }];
}

- (void)hideCollection {
    [UIView animateWithDuration:0.2 animations:^{
        [self.collection setAlpha:0.f];
        [self.doneWithCategoryButton setAlpha:1.f];
        [self makeCardViewShorter];
    } completion:^(BOOL finished) {
        [self.collection removeFromSuperview];
        self.collection = 0;
        [self setPickingColor:false];
        [self setPickingIcon:false];
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (self.pickingColor) {
        ColorsCollectionCell *cell = [collectionView
                                      dequeueReusableCellWithReuseIdentifier:@"colorsCollectionCell"
                                                                forIndexPath:indexPath];
        [cell.colorView setBackgroundColor:[[ColorsManager getAllColors]
                                            objectAtIndex:[[ColorsManager
                                                            getFreeColorsIndexes]
                                                           objectAtIndex:indexPath.item].integerValue]];
        return cell;
    } else {
        IconsCollectionCell *cell = [collectionView
                                     dequeueReusableCellWithReuseIdentifier:@"iconsCollectionCell"
                                                               forIndexPath:indexPath];
        [cell.iconView setBackgroundColor:self.pickColorButton.backgroundColor];
        [cell.iconImage setImage:[IconsManager getIconForIndex:[[IconsManager
                                                                 getFreeIconsIndexes]
                                                                objectAtIndex:indexPath.item].integerValue]];
        return cell;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    if (self.pickingColor) return [[ColorsManager getFreeColorsIndexes] count];
    else {
        NSLog(@"%zu", [[IconsManager getFreeIconsIndexes] count]);
        return [[IconsManager getFreeIconsIndexes] count];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pickingColor) {
        [self paintSelfWith:[[ColorsManager getAllColors]
                             objectAtIndex:[[ColorsManager
                                             getFreeColorsIndexes]
                                            objectAtIndex:indexPath.item].integerValue]];
        [self setSelectedColorIndex:[[ColorsManager
                                      getFreeColorsIndexes]
                                     objectAtIndex:indexPath.item].integerValue];
        [self setColorSelected:true];
    }
    else {
        [self.iconImage removeFromSuperview];
        UIImage* iconImage = [IconsManager getIconForIndex:[[IconsManager
                                                             getFreeIconsIndexes]
                                                            objectAtIndex:indexPath.item].integerValue];
        self.iconImage = [[UIImageView alloc] initWithImage:iconImage];
        [self.iconImage setContentMode:UIViewContentModeScaleAspectFit];
        [self.iconImage setFrame:CGRectMake(5, 5, 20, 20)];
        [self.pickIconButton addSubview:self.iconImage];
        [self setIconSelected:true];
        [self setSelectedIconIndex:[[IconsManager
                                     getFreeIconsIndexes]
                                    objectAtIndex:indexPath.item].integerValue];
    }
    [self hideCollection];
}


- (void)paintSelfWith:(UIColor*)color {
    [self.categoryName.layer setBorderColor:color.CGColor];
    [self.categoryName setTextColor:color];
    [self.categoryName setAttributedPlaceholder:[self getPlaceholderPaintedWith:color
                                                                     andMessage:@"Category name"]];
    [self.pickColorButton setBackgroundColor:color];
    [self.pickIconButton setBackgroundColor:color];
    [self.doneWithCategoryButton setBackgroundColor:color];
}

- (void)setupColorsCollection {
    if (self.pickingColor)
        return;
    [self showCollection];
    [self setPickingColor:true];
    [self setPickingIcon:false];
    [self.collection registerNib:[UINib
                                  nibWithNibName:@"ColorsCollectionCellXIB" bundle:nil]
      forCellWithReuseIdentifier:@"colorsCollectionCell"];
    self.collection.delegate = self;
    self.collection.dataSource = self;
}

- (void)setupIconsCollection {
    if (self.pickingIcon)
        return;
    [self showCollection];
    [self setPickingIcon:true];
    [self setPickingColor:false];
    [self.collection registerNib:[UINib
                                  nibWithNibName:@"IconsCollectionCellXIB" bundle:nil]
      forCellWithReuseIdentifier:@"iconsCollectionCell"];
    self.collection.delegate = self;
    self.collection.dataSource = self;
}

- (NSMutableAttributedString*)getPlaceholderPaintedWith:(UIColor*)color
                                             andMessage:(NSString*)message {
    NSMutableAttributedString * placeholder = [[NSMutableAttributedString alloc] initWithString:message];
    NSInteger fontSize = 16;
    if (self.view.frame.size.width < 375)
        fontSize = 14;
    else if (self.view.frame.size.width > 375)
        fontSize = 18;
    UIFont * avenir = [UIFont fontWithName:@"AvenirNext-Medium" size:fontSize];
    [placeholder addAttribute:NSFontAttributeName value:avenir
                        range:[message rangeOfString:message]];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[color colorWithAlphaComponent:0.5f]
                        range:[message rangeOfString:message]];
    return placeholder;
}

@end
