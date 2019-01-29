//
//  ExpenseDetailsVC.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../Model/Expense+CoreDataClass.h"
#import "../../Model/Category+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpenseDetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet UIVisualEffectView*    blurredMask;
@property (weak, nonatomic) IBOutlet UIView*                cardView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    cardViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint*    cardViewHeightConstraint;

@property (weak, nonatomic) IBOutlet    UITextField*        titleTextField;
@property (weak, nonatomic) IBOutlet    UIButton*           dateButton;
@property (weak, nonatomic) IBOutlet    UITextField*        costTextField;
@property (weak, nonatomic) IBOutlet    UIButton*           pickCategoryButton;
@property (weak, nonatomic) IBOutlet    UIButton*           doneWithExpenseButton;

@property (strong, nonatomic)       UIDatePicker* _Nullable datePicker;
@property (strong, nonatomic) UIButton* _Nullable           doneWithDateButton;
@property (strong, nonatomic)   UICollectionView* _Nullable categoriesCollection;

@property (assign, nonatomic)           BOOL                keyboardShown;
@property (assign, nonatomic)           BOOL                pickingCategory;
@property (assign, nonatomic)           BOOL                shaking;
@property (strong, nonatomic)           Expense* _Nullable  selectedExpense;
@property (strong, nonatomic)           Category* _Nullable selectedCategory;
@property (assign, nonatomic)           BOOL                expenseDeleted;

@property (strong, nonatomic)           UITableView*        tableToReload;
@property (assign, nonatomic)           BOOL                needDarkenStatusBar;

@end

NS_ASSUME_NONNULL_END
