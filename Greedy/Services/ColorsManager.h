//
//  ColorsManager.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ColorsManager : NSObject

+ (NSArray <UIColor *> *)   getAllColors;
+ (NSArray <UIColor *> *)   getFreeColors;
+ (NSArray <NSNumber *> *)  getFreeColorsIndexes;

@end

NS_ASSUME_NONNULL_END
