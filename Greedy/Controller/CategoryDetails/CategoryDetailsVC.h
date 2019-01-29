//
//  CategoryDetailsVC.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/12/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../CategoryExpensesVC/CategoryExpensesVC.h"
#import "../../Model/Category+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryDetailsVC : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIVisualEffectView*    blurredMask;
@property (weak, nonatomic) IBOutlet UIView*                cardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    cardViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    cardViewHeightConstraint;

@property (weak, nonatomic) IBOutlet UITextField*           categoryName;
@property (weak, nonatomic) IBOutlet UIButton*              pickColorButton;
@property (weak, nonatomic) IBOutlet UIButton*              pickIconButton;
@property (weak, nonatomic) IBOutlet UILabel*               colorLabel;
@property (weak, nonatomic) IBOutlet UILabel*               iconLabel;
@property (strong, nonatomic)        UIImageView*           iconImage;
@property (weak, nonatomic) IBOutlet UIButton*              doneWithCategoryButton;

@property (strong, nonatomic) UICollectionView* _Nullable   collection;

@property (assign, nonatomic)        BOOL                   keyboardShown;
@property (assign, nonatomic)        BOOL                   pickingColor;
@property (assign, nonatomic)        BOOL                   colorSelected;
@property (assign, nonatomic)        BOOL                   pickingIcon;
@property (assign, nonatomic)        BOOL                   iconSelected;
@property (assign, nonatomic)        NSInteger              selectedColorIndex;
@property (assign, nonatomic)        NSInteger              selectedIconIndex;
@property (strong, nonatomic)        Category* _Nullable    selectedCategory;
@property (assign, nonatomic)        BOOL                   shaking;
@property (strong, nonatomic)        UITableView*           tableToReload;
@property (assign, nonatomic)        BOOL                   needDarkenStatusBar;
@property (assign, nonatomic)        BOOL                   categoryDeleted;

@property (strong, nonatomic)        UIView* _Nullable      headerToReload;
@property (strong, nonatomic)        UILabel* _Nullable     titleToReload;
@property (strong, nonatomic)        UIImageView* _Nullable iconToReload;

@property (strong, nonatomic)        CategoryExpensesVC*    parent;

@end

NS_ASSUME_NONNULL_END
