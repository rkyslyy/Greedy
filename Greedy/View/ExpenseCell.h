//
//  ExpensesByDatesTableCell.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/1/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Services/ColorsManager.h"
#import "../Services/CategoriesManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExpenseCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel	*title;
@property (weak, nonatomic) IBOutlet UILabel	*date;
@property (weak, nonatomic) IBOutlet UILabel	*cost;

- (void) paintSelfFor:(Category*)category;

@end

NS_ASSUME_NONNULL_END
