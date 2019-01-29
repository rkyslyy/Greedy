//
//  StatisticsVC+PieChart.h
//  Greedy
//
//  Created by Roman Kyslyy on 1/11/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "StatisticsVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface StatisticsVC (PieChart) <XYPieChartDelegate,
                                    XYPieChartDataSource>

@end

NS_ASSUME_NONNULL_END
