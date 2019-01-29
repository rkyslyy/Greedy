//
//  RoundedLabel.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/1/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "RoundedLabel.h"

@implementation RoundedLabel

- (void)drawRect:(CGRect)rect {
    [self.layer setMasksToBounds:true];
    [self.layer setCornerRadius:self.frame.size.height / 2];
    [super drawRect:rect];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    [self.layer setBorderWidth:borderWidth];
}

@end
