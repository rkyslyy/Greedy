//
//  ExpensesDetails.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "ExpensesDetails.h"

@implementation ExpensesDetails

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self customInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self customInit];
    }
    return self;
}

- (void) customInit {
    [[NSBundle mainBundle] loadNibNamed:@"ExpenseDetailsXIB"
                                  owner:self
                                options:nil];
    self.contentView.frame = self.bounds;
    [self.contentView.layer setMasksToBounds:true];
    [self.contentView.layer setCornerRadius:25.f];
    [self addSubview:self.contentView];
}

@end
