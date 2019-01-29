//
//  Expense+CoreDataProperties.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//
//

#import "Expense+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Expense (CoreDataProperties)

+ (NSFetchRequest<Expense *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString  *category;
@property (nullable, nonatomic, copy) NSString  *title;
@property (nonatomic) float                     cost;
@property (nullable, nonatomic, copy) NSDate    *date;

@end

NS_ASSUME_NONNULL_END
