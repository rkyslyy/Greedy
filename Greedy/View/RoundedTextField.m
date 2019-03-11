//
//  RoundedTextField.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "RoundedTextField.h"

@implementation RoundedTextField

- (void)drawRect:(CGRect)rect {
  [self.layer setMasksToBounds:true];
  [self.layer setCornerRadius:self.layer.frame.size.height / 2];
  self.leftViewMode = UITextFieldViewModeAlways;
  [super drawRect:rect];
}

- (void)setLeftOffset:(BOOL)leftOffset {
  if (leftOffset) {
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 57, 0)];
  }
  else {
    self.leftView = nil;
  }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
  [self.layer setBorderWidth:borderWidth];
}

- (void)setBorderColor:(UIColor *)borderColor {
  self.layer.borderColor = borderColor.CGColor;
}

@end
