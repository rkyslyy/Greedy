//
//  ExpensesManager.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "../AppDelegate.h"
#import "../Model/Expense+CoreDataClass.h"
#import "../Model/Category+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpensesManager : NSObject

+ (NSArray<Expense*>*)  getAllExpenses;
+ (NSArray<Expense*>*)  getAllExpensesOfCategory:(NSString*)category;
+ (NSArray<Expense*>*)  getAllExpensesBy:(NSDate*)date;
+ (NSArray<NSDate*>*)   getExpensesDates;
+ (NSArray<NSString*>*) getExpensesDatesStrings;
+ (float)               getTotalCostBy:(NSDate*)date;
+ (float)               getTotalCostOf:(Category*)category;
+ (float)               getMonthCostOf:(Category*)category;
+ (float)               getTodayCostOf:(Category*)category;
+ (float)               getAllMonthExpenses;
+ (void)                createNewExpenseWith:(NSString*)title
                                    category:(NSString*)category
                                        cost:(NSString*)cost
                                        date:(NSDate*)date;
+ (void)                delete:(Expense*)expense;
+ (void)                deleteAllExpenses;

@end

NS_ASSUME_NONNULL_END
