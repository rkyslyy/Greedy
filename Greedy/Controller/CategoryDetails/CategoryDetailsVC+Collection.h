//
//  CategoryDetailsVC+ColorsCollection.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/13/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "CategoryDetailsVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryDetailsVC (Collection) <UICollectionViewDelegate, UICollectionViewDataSource>

- (void) setupIconsCollection;
- (void) setupColorsCollection;
- (void) showCollection;
- (void) hideCollection;
- (void) paintSelfWith:(UIColor*)color;


@end

NS_ASSUME_NONNULL_END
