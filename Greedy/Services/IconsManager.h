//
//  IconsManager.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/31/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IconsManager : NSObject

+ (UIImage*)                getIconForIndex:(NSInteger)index;
+ (NSArray <UIImage*>*)     getFreeIcons;
+ (NSArray <NSNumber*>*)    getFreeIconsIndexes;

@end

NS_ASSUME_NONNULL_END
