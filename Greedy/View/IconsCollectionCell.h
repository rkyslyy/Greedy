//
//  IconsCollectionCell.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/13/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IconsCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView*        iconView;
@property (weak, nonatomic) IBOutlet UIImageView*   iconImage;

@end

NS_ASSUME_NONNULL_END
