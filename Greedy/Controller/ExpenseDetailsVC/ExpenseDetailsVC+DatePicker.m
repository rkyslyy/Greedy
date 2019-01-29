//
//  ExpenseDetailsVC+DatePicker.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/3/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "ExpenseDetailsVC+DatePicker.h"
#import "ExpenseDetailsVC+FrameManipulations.h"

@implementation ExpenseDetailsVC (DatePicker)

- (void)showDatePicker {
    if (self.pickingCategory || self.keyboardShown)
        [self hideKeyboardAndMoveDown:nil];
    [self createDatePicker];
    [self createDoneWithDateButton];
    [self animateStuff];
}

- (void) createDatePicker {
    CGRect datePickerFrame = CGRectMake(0, 60, self.cardView.frame.size.width, 150);
    self.datePicker = [[UIDatePicker alloc] initWithFrame:datePickerFrame];
    [self.datePicker setMaximumDate:NSDate.date];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker setAlpha:0.f];
    NSDateFormatter * dF = [[NSDateFormatter alloc] init];
    [dF setDateFormat:@"MMM dd, yyyy"];
    [dF setLocale:NSLocale.currentLocale];
    NSDate * date = [dF dateFromString:self.dateButton.titleLabel.text];
    [self.datePicker setDate:date];
    [self.cardView addSubview:self.datePicker];
}

- (void) createDoneWithDateButton {
    CGRect doneWithDateButtonFrame = CGRectMake(self.cardView.frame.size.width / 2 - 15,
                                                self.cardView.frame.size.height - 90,
                                                30, 30);
    self.doneWithDateButton = [[UIButton alloc] initWithFrame:doneWithDateButtonFrame];
    [self.doneWithDateButton setImage:[UIImage imageNamed:@"check_mark"] forState:UIControlStateNormal];
    [self.doneWithDateButton setAlpha:0.f];
    [self.doneWithDateButton addTarget:self action:@selector(hideDatePickerAndSetNewDate) forControlEvents:UIControlEventTouchUpInside];
    [self.cardView addSubview:self.doneWithDateButton];
}

- (void) animateStuff {
    [UIView animateWithDuration:0.2 animations:^{
        [self.titleTextField setAlpha:0.f];
        [self.dateButton setAlpha:0.f];
        [self.costTextField setAlpha:0.f];
        [self.pickCategoryButton setAlpha:0.f];
        [self.doneWithExpenseButton setAlpha:0.f];
        [self.datePicker setAlpha:1.f];
        [self.doneWithDateButton setAlpha:1.f];
    }];
}

- (void) hideDatePickerAndSetNewDate {
    [self setNewDate];
    [self hideDatePicker];
}

- (void) hideDatePicker {
    [UIView animateWithDuration:0.2 animations:^{
        [self.titleTextField setAlpha:1.f];
        [self.dateButton setAlpha:1.f];
        [self.costTextField setAlpha:1.f];
        [self.pickCategoryButton setAlpha:1.f];
        [self.doneWithExpenseButton setAlpha:1.f];
        [self.datePicker setAlpha:0.f];
        [self.doneWithDateButton setAlpha:0.f];
    } completion:^(BOOL finished) {
        self.datePicker = nil;
        self.doneWithDateButton = nil;
    }];
}

- (void) setNewDate {
    NSString * dateString = [NSDateFormatter localizedStringFromDate:self.datePicker.date
                                                           dateStyle:NSDateFormatterMediumStyle
                                                           timeStyle:NSDateFormatterNoStyle];
    [self.dateButton setTitle:dateString forState:UIControlStateNormal];
}


@end
