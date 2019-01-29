//
//  CategoryCollectionCell.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/1/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RoundedView.h"

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface CategoryCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet RoundedView*   icon;
@property (weak, nonatomic) IBOutlet UILabel*       title;

@end

NS_ASSUME_NONNULL_END
