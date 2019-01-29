//
//  CategoryCell.m
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "CategoryTableCell.h"
#import "../Controller/ExpensesVC/ExpensesVC+Tables.h"

@implementation CategoryTableCell

- (void)setupButton {
    [self.plusButton addTarget:self action:@selector(openDetailsInParent) forControlEvents:UIControlEventTouchUpInside];
}

- (void) openDetailsInParent {
    [UIView transitionWithView:self.plusButton.imageView
                      duration:0.15f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self.plusButton setImage:[UIImage imageNamed:@"active_plus"] forState:UIControlStateNormal];
                    } completion:^(BOOL finished){
                        [UIView transitionWithView:self.plusButton.imageView
                                          duration:0.15f
                                           options:UIViewAnimationOptionTransitionCrossDissolve
                                        animations:^{
                                            [self.plusButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
                                        } completion:^(BOOL finished){}];
                    }];
    [self.parent openDetailsWithCategory:self.category];
}

@end
