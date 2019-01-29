//
//  RoundedTextField.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface RoundedTextField : UITextField

@property (assign, nonatomic) IBInspectable BOOL        leftOffset;
@property (assign, nonatomic) IBInspectable CGFloat     borderWidth;
@property (assign, nonatomic) IBInspectable UIColor*    borderColor;

@end

NS_ASSUME_NONNULL_END
