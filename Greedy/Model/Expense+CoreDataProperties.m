//
//  Expense+CoreDataProperties.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//
//

#import "Expense+CoreDataProperties.h"

@implementation Expense (CoreDataProperties)

+ (NSFetchRequest<Expense *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Expense"];
}

@dynamic category;
@dynamic title;
@dynamic cost;
@dynamic date;

@end
