//
//  Category+CoreDataProperties.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//
//

#import "Category+CoreDataProperties.h"

@implementation Category (CoreDataProperties)

+ (NSFetchRequest<Category *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Category"];
}

@dynamic title;
@dynamic iconIndex;
@dynamic color;

@end
