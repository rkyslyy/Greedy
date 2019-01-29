//
//  Category+CoreDataProperties.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//
//

#import "Category+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Category (CoreDataProperties)

+ (NSFetchRequest<Category *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString  *title;
@property (nonatomic) int16_t                   iconIndex;
@property (nonatomic) int16_t                   colorIndex;

@end

NS_ASSUME_NONNULL_END
