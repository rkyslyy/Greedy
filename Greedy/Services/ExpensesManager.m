//
//  ExpensesManager.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "ExpensesManager.h"

@implementation ExpensesManager

+ (NSArray<Expense *> *)getAllExpenses {
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = delegate.persistentContainer.viewContext;
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
    NSArray <Expense*> * expenses = [context executeFetchRequest:request error:nil];
    
    return expenses;
}

+ (NSArray<Expense *> *)getAllExpensesOfCategory:(NSString *)category {
    NSArray <Expense*> * allExpenses = [self getAllExpenses];
    
    allExpenses = [allExpenses filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Expense * expense = evaluatedObject;
        return [expense.category isEqualToString:category];
    }]];
    
    return allExpenses;
}

+ (NSArray<Expense *> *)getAllExpensesBy:(NSDate *)date {
    NSArray <Expense*> * allExpenses = [self getAllExpenses];
    
    return [allExpenses filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Expense * expense = evaluatedObject;
        
        return [expense.date isEqualToDate:date];
    }]];
}

+ (NSArray<NSDate *> *)getExpensesDates {
    NSArray <Expense*> * expenses = [self getAllExpenses];
    
    NSMutableArray <NSDate*> * dates = [NSMutableArray array];
    for (Expense * expense in expenses) {
        if (![dates containsObject:expense.date])
            [dates addObject:expense.date];
    }
    [dates sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSDate* one = obj1;
        NSDate* two = obj2;
        return [one compare:two] != NSOrderedDescending;
    }];
    return dates;
}

+ (NSArray<NSString *> *)getExpensesDatesStrings {
    NSArray <NSDate*> * dates = [self getExpensesDates];
    NSMutableArray <NSString*>* datesStrings = [NSMutableArray array];
    for (NSDate* date in dates) {
        NSString * dateString = [NSDateFormatter localizedStringFromDate:date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
        if (![datesStrings containsObject:dateString])
            [datesStrings addObject:dateString];
    }
    return datesStrings;
}

+ (float)getTotalCostBy:(NSDate *)date {
    float total = 0;
    NSArray <Expense*> * expenses = [self getAllExpenses];
    for (Expense * expense in expenses) {
        if ([expense.date isEqualToDate:date])
            total += expense.cost;
    }
    return total;
}

+ (float)getAllMonthExpenses {
    NSDate* monthBack = [NSDate.date dateByAddingTimeInterval:-2592000];
    float total = 0;
    NSArray <Expense*> * expenses = [self getAllExpenses];
    for (Expense * expense in expenses) {
        if ([expense.date compare:monthBack] == NSOrderedDescending) {
            total += expense.cost;
        }
    }
    return total;
}

+ (float)getMonthCostOf:(Category *)category {
    NSDate* monthBack = [NSDate.date dateByAddingTimeInterval:-2592000];
    float total = 0;
    NSArray <Expense*> * expenses = [self getAllExpensesOfCategory:category.title];
    for (Expense * expense in expenses) {
        if ([expense.date compare:monthBack] == NSOrderedDescending) {
            total += expense.cost;
        }
    }
    return total;
}

+ (float)getTodayCostOf:(Category *)category {
    NSString* today = [NSDateFormatter localizedStringFromDate:NSDate.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    float total = 0;
    NSArray <Expense*> * expenses = [self getAllExpensesOfCategory:category.title];
    for (Expense * expense in expenses) {
        if ([[NSDateFormatter localizedStringFromDate:expense.date dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle] isEqualToString:today]) {
            total += expense.cost;
        }
    }
    return total;
}

+ (float)getTotalCostOf:(Category *)category {
    float total = 0;
    NSArray <Expense*>* expenses = [self getAllExpensesOfCategory:category.title];
    for (Expense * expense in expenses) {
        total += expense.cost;
    }
    return total;
}

+ (void)createNewExpenseWith:(NSString *)title category:(NSString *)category cost:(NSString *)cost date:(NSDate *)date {
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = delegate.persistentContainer.viewContext;
    
    Expense * newExpense = [[Expense alloc] initWithContext:context];
    newExpense.title = title;
    newExpense.category = category;
    newExpense.cost = cost.floatValue;
    newExpense.date = date;
    
    [delegate saveContext];
}

+ (void)delete:(Expense *)expense {
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = delegate.persistentContainer.viewContext;
    
    [context deleteObject:expense];
    [delegate saveContext];
}

+ (void)deleteAllExpenses {
    NSArray <Expense*> * expenses = [self getAllExpenses];
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = delegate.persistentContainer.viewContext;
    for (Expense * expense in expenses) {
        [context deleteObject:expense];
    }
    [delegate saveContext];
}

@end
