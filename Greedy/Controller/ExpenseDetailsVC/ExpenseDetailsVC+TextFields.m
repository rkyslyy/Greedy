//
//  ExpenseDetailsVC+TextFields.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC+TextFields.h"
#import "ExpenseDetailsVC+FrameManipulations.h"
#import "ExpenseDetailsVC+CategoriesCollection.h"

@implementation ExpenseDetailsVC (TextFields)

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  if (self.keyboardShown) {
    return;
  }
  if (self.pickingCategory) {
    [self hideCategoriesCollection];
  }
  [self setKeyboardShown:true];
  [UIView animateWithDuration:0.2 animations:^{
    [self makeCardViewTaller];
    [self.doneWithExpenseButton setAlpha:0.f];
  }];
}

- (void) controlCost {
  if (self.costTextField.text.length == 0) {
    return;
  }
  UITextField *textField = self.costTextField;
  if (textField.text.length > 10) {
    textField.text = [textField.text substringToIndex:textField.text.length - 1];
    return;
  }
  NSString *lastSymbol = [textField.text substringFromIndex:textField.text.length - 1];
  if ([lastSymbol isEqualToString:@"."] && [[textField.text
                                             substringToIndex:textField.text.length - 1]
                                               containsString:@"."]) {
    textField.text = [textField.text substringToIndex:textField.text.length - 1];
  }
  NSArray *components = [textField.text componentsSeparatedByString:@"."];
  if (components.count > 1) {
    NSString *coins = [components objectAtIndex:1];
    if (coins.length > 2) {
      textField.text = [textField.text substringToIndex:textField.text.length - 1];
    }
  }
}

- (void) controlPoint {
  if (self.costTextField.text.length == 0) {
    return;
  }
  UITextField *textField = self.costTextField;
  if ([textField.text floatValue] == 0) {
    return [textField setText:@""];
  }
  NSString *lastSymbol = [textField.text substringFromIndex:textField.text.length - 1];
  if ([lastSymbol isEqualToString:@"."]) {
    textField.text = [textField.text substringToIndex:textField.text.length - 1];
  }
  if ([textField.text containsString:@"."]) {
    NSString *coins = [[textField.text componentsSeparatedByString:@"."] objectAtIndex:1];
    if ([coins isEqualToString:@"0"]) {
      textField.text = [textField.text substringToIndex:textField.text.length - 2];
    }
    else if ([coins isEqualToString:@"00"]) {
      textField.text = [textField.text substringToIndex:textField.text.length - 3];
    }
  }
}

@end
