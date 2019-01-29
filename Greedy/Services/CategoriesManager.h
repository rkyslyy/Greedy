//
//  CategoriesManager.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "../AppDelegate.h"
#import "../Model/Category+CoreDataClass.h"
#import "ExpensesManager.h"
#import "ColorsManager.h"
#import "IconsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoriesManager : NSObject

+ (NSArray <Category*> *)   getAllCategories;
+ (NSArray <Category*> *)   getAllNonZeroCategories;
+ (NSArray <Category*> *)   getMonthNonZeroCategories;
+ (NSArray <Category*> *)   getTodayNonZeroCategories;
+ (nullable Category*)      getCategoryByName:(NSString*)name;
+ (void)                    createDefaultCategories;
+ (void)                    createNewCategoryWithName:(NSString*)title
                                                color:(NSInteger)colorIndex
                                              andIcon:(NSInteger)iconIndex;
+ (void)                    delete:(Category*)category;
+ (void)                    deleteAllCategories;

@end

NS_ASSUME_NONNULL_END
