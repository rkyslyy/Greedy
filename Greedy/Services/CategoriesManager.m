//
//  CategoriesManager.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "CategoriesManager.h"
#import "ExpensesManager.h"

@implementation CategoriesManager

+ (NSArray<Category *> *)getAllCategories {
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = delegate.persistentContainer.viewContext;
    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"Category"];
    
    NSArray <Category*> * categories = [context executeFetchRequest:request error:nil];
    return categories;
}

+ (NSArray<Category *> *)getAllNonZeroCategories {
    NSArray* nonZeroCategories = [[self getAllCategories] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Category* category = evaluatedObject;
        return [ExpensesManager getTotalCostOf:category] != 0;
    }]];
    return [nonZeroCategories sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        float total1 = [ExpensesManager getTotalCostOf:obj1];
        float total2 = [ExpensesManager getTotalCostOf:obj2];
        return total1 < total2;
    }];
}

+ (NSArray<Category *> *)getMonthNonZeroCategories {
    NSArray* nonZeroCategories = [[self getAllCategories] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Category* category = evaluatedObject;
        return [ExpensesManager getMonthCostOf:category] != 0;
    }]];
    return [nonZeroCategories sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        float total1 = [ExpensesManager getTotalCostOf:obj1];
        float total2 = [ExpensesManager getTotalCostOf:obj2];
        return total1 < total2;
    }];
}

+ (NSArray<Category *> *)getTodayNonZeroCategories {
    NSArray* nonZeroCategories = [[self getAllCategories] filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Category* category = evaluatedObject;
        return [ExpensesManager getTodayCostOf:category] != 0;
    }]];
    return [nonZeroCategories sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        float total1 = [ExpensesManager getTotalCostOf:obj1];
        float total2 = [ExpensesManager getTotalCostOf:obj2];
        return total1 < total2;
    }];
}

+ (nullable Category *)getCategoryByName:(NSString *)name {
    NSArray <Category*> * allCategories = [self getAllCategories];
    for (Category * category in allCategories) {
        if ([category.title isEqualToString:name])
            return category;
    }
    return nil;
}

+ (void)createDefaultCategories {
    NSLog(@"Created default categories");
    [self createNewCategoryWithName:@"Health" color:0 andIcon:0];
    [self createNewCategoryWithName:@"Food" color:1 andIcon:1];
    [self createNewCategoryWithName:@"Clothes" color:2 andIcon:2];
    [self createNewCategoryWithName:@"Household" color:3 andIcon:3];
    [self createNewCategoryWithName:@"Entertainment" color:4 andIcon:4];
    [self createNewCategoryWithName:@"Transport" color:5 andIcon:5];
    [self createNewCategoryWithName:@"Travel" color:6 andIcon:6];
}

+ (void)createNewCategoryWithName:(NSString *)title
                              color:(NSInteger)colorIndex
                            andIcon:(NSInteger)iconIndex {
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = delegate.persistentContainer.viewContext;
    
    Category * newCategory = [[Category alloc] initWithContext:context];
    newCategory.title = title;
    NSArray <UIColor*> * colors = [ColorsManager getAllColors];
    newCategory.colorIndex = colorIndex > colors.count - 1 ? 0 : colorIndex;
    newCategory.iconIndex = iconIndex;
    [delegate saveContext];
}

+ (void)delete:(Category *)category {
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext * context = delegate.persistentContainer.viewContext;
    
    [context deleteObject:category];
    
    NSArray <Expense*>* expensesOfDeletedCategory = [ExpensesManager getAllExpensesOfCategory:category.title];
    for (Expense* expense in expensesOfDeletedCategory)
        [context deleteObject:expense];
    [delegate saveContext];
}

+ (void)deleteAllCategories {
    AppDelegate * delegate = (AppDelegate*)UIApplication.sharedApplication.delegate;
    NSArray * categories = [self getAllCategories];
    for (Category * category in categories) {
        [CategoriesManager delete:category];
    }
    [delegate saveContext];
}

@end
