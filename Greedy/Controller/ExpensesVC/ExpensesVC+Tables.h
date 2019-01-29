//
//  ExpensesVC+Tables.h
//  Greedy
//
//  Created by Roman Kyslyy on 12/30/18.
//  Copyright © 2018 Roman Kyslyy. All rights reserved.
//

#import "ExpensesVC.h"
#import "../../View/CategoryExpenses.h"
#import "../CategoryDetails/CategoryDetailsVC.h"


NS_ASSUME_NONNULL_BEGIN

@interface ExpensesVC (Tables) <UITableViewDelegate,
                                UITableViewDataSource>


// DataSource methods
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath;
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;


- (void) showCategories;
- (void) showExpensesByDates;
- (void) openDetailsWithCategory:(NSString*)categoryTitle;

@end

NS_ASSUME_NONNULL_END
