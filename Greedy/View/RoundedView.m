//
//  RoundedView.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (void)drawRect:(CGRect)rect {
    [self.layer setMasksToBounds:true];
    if (!self.manualCornerRadius) {
        [self.layer setCornerRadius:self.frame.size.height / 2];
        [super drawRect:rect];
    }
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    [self.layer setCornerRadius:cornerRadius];
}

@end
