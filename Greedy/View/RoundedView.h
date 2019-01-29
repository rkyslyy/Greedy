//
//  RoundedView.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface RoundedView : UIView

@property (assign, nonatomic) IBInspectable BOOL    manualCornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
