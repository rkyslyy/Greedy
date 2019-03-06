//
//  ExpensesDetails.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Model/Expense+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpensesDetails : UIView

// Outlets
@property (strong, nonatomic) IBOutlet  UIView           *contentView;
@property (weak, nonatomic) IBOutlet    UITextField      *titleTextField;
@property (weak, nonatomic) IBOutlet    UITextField      *costTextField;
@property (weak, nonatomic) IBOutlet    UIButton         *dateButton;
@property (weak, nonatomic) IBOutlet    UIButton         *pickCategoryButton;
@property (weak, nonatomic) IBOutlet    UIButton         *doneWithExpenseButton;
//
@property (strong, nonatomic)           UIDatePicker     *datePicker;
@property (strong, nonatomic)           UIButton         *doneWithDateButton;
@property (strong, nonatomic)           UICollectionView *categoriesCollection;
@property (strong, nonatomic)           Expense          *selectedExpense;
@property (assign, nonatomic)           BOOL             expenseDeleted;

@end

NS_ASSUME_NONNULL_END
