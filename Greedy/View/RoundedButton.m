//
//  RoundedButton.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton

- (void)drawRect:(CGRect)rect {
  [self.layer setMasksToBounds:true];
  [self.layer setCornerRadius:self.layer.frame.size.height / 2];
  [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
  [super drawRect:rect];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
  [self.layer setBorderWidth:borderWidth];
}

- (void)setBorderColor:(UIColor *)borderColor {
  [self.layer setBorderColor:borderColor.CGColor];
}

@end
