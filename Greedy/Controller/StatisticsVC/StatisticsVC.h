//
//  StatisticsVC.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/9/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../XYPieChart/XYPieChart.h"
#import "../../Services/CategoriesManager.h"
#import "../../Services/ExpensesManager.h"
#import "../../View/StatisticsCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    Total,
    Today,
    Month
}           DateType;

@interface StatisticsVC : UIViewController

@property (weak, nonatomic) IBOutlet    UIButton*               showTotal;
@property (weak, nonatomic) IBOutlet    UIButton*               showMonth;
@property (weak, nonatomic) IBOutlet    UIButton*               showToday;
@property (weak, nonatomic) IBOutlet    UILabel*                categoryName;
@property (weak, nonatomic) IBOutlet    UILabel*                categoryTotal;
@property (weak, nonatomic) IBOutlet    XYPieChart*             pieChart;
@property (weak, nonatomic) IBOutlet    UITableView*            categoriesTable;

@property (strong, nonatomic)           NSArray <Category*>*    categories;
@property (assign, nonatomic)           float                   total;
@property (strong, nonatomic)           UIView*                 noExpensesLabel;
@property (assign, nonatomic)           NSInteger               selectedSliceIndex;
@property (assign, nonatomic)           DateType                selectedDateOption;

- (NSMutableAttributedString*)getTotalString:(nullable Category*)cat;

@end

NS_ASSUME_NONNULL_END
