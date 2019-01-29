//
//  IconsManager.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/31/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "IconsManager.h"
#import "CategoriesManager.h"

@implementation IconsManager

+ (UIImage *)getIconForIndex:(NSInteger)index {
    NSString* indexStr = [[NSNumber numberWithInteger:index] stringValue];
    NSString* iconName = [@"icon" stringByAppendingString:indexStr];
    return [UIImage imageNamed:iconName];
}

+ (NSArray<UIImage *> *)getFreeIcons {
    NSMutableArray <UIImage*>* icons = [NSMutableArray array];
    for (NSInteger i = 0; i < 35; ++i) {
        [icons addObject:[UIImage imageNamed:[@"icon" stringByAppendingString:[NSNumber numberWithInteger:i].stringValue]]];
    }
    NSMutableArray <NSNumber*>* takenIndexes = [NSMutableArray array];
    NSArray <Category*>* categories = [CategoriesManager getAllCategories];
    for (Category* category in categories)
        [takenIndexes addObject:[NSNumber numberWithInteger:category.iconIndex]];
    NSMutableArray <UIImage*>* freeIcons = [NSMutableArray array];
    for (NSInteger i = 0; i < 35; ++i) {
        NSNumber* x = [NSNumber numberWithInteger:i];
        if (![takenIndexes containsObject:x])
            [freeIcons addObject:[icons objectAtIndex:i]];
    }
    return freeIcons;
}

+ (NSArray<NSNumber *> *)getFreeIconsIndexes {
    NSMutableArray <NSNumber*> * takenIndexes = [NSMutableArray array];
    NSArray <Category*>* categories = [CategoriesManager getAllCategories];
    for (Category* category in categories)
        [takenIndexes addObject:[NSNumber numberWithInteger:category.iconIndex]];
    NSMutableArray <NSNumber*>* freeIndexes = [NSMutableArray array];
    for (NSInteger i = 0; i < 35; ++i)
        if (![takenIndexes containsObject:[NSNumber numberWithInteger:i]])
            [freeIndexes addObject:[NSNumber numberWithInteger:i]];
    return freeIndexes;
}

@end
