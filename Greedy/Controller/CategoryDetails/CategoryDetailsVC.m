//
//  CategoryDetailsVC.m
//  Greedy
//
//  Created by Roman Kyslyy on 1/12/19.
//  Copyright © 2019 Roman Kyslyy. All rights reserved.
//

#import "CategoryDetailsVC.h"
#import "../../Services/CategoriesManager.h"
#import "CategoryDetailsVC+FrameManipulations.h"
#import "CategoryDetailsVC+Collection.h"
#import "../../View/RoundedTextField.h"

@interface CategoryDetailsVC ()

@property (strong, nonatomic) UIRefreshControl* refreshControl;

@end

@implementation CategoryDetailsVC

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.categoryName setDelegate:self];
  [_categoryName addTarget:self
                    action:@selector(controlLength)
          forControlEvents:UIControlEventEditingChanged];
  [_pickIconButton addTarget:self
                      action:@selector(setupIconsCollection)
            forControlEvents:UIControlEventTouchUpInside];
  [_pickColorButton addTarget:self
                       action:@selector(setupColorsCollection)
             forControlEvents:UIControlEventTouchUpInside];
  [_doneWithCategoryButton addTarget:self
                              action:@selector(commitChanges)
                    forControlEvents:UIControlEventTouchUpInside];
  [self mutateFontsIfNecessary];
}

- (void)viewWillAppear:(BOOL)animated {
  [self hideMaskAndCardview];
}

- (void)viewDidAppear:(BOOL)animated {
  if (self.selectedCategory) {
    [self paintSelfWith:[[ColorsManager getAllColors] objectAtIndex:_selectedCategory.colorIndex]];
    [self.categoryName setText:_selectedCategory.title];
    UIImage *iconImage = [IconsManager getIconForIndex:_selectedCategory.iconIndex];
    self.iconImage = [[UIImageView alloc] initWithImage:iconImage];
    [self.iconImage setContentMode:UIViewContentModeScaleAspectFit];
    [self.iconImage setFrame:CGRectMake(5, 5, 20, 20)];
    [self.pickIconButton addSubview:self.iconImage];
    [self setIconSelected:true];
    [self setSelectedIconIndex:_selectedCategory.iconIndex];
    [self setColorSelected:true];
    [self setSelectedColorIndex:_selectedCategory.colorIndex];
    [self.doneWithCategoryButton setImage:[UIImage imageNamed:@"rubbish-bin"]
                                 forState:UIControlStateNormal];
  }
  [self showMaskAndCardview];
}

- (void) hideMaskAndCardview {
  [self.blurredMask setAlpha:0.f];
  [self.view setBackgroundColor:UIColor.clearColor];
  self.cardViewBottomConstraint.constant -= 300;
  [self.cardView setFrame:CGRectOffset(self.cardView.frame, 0, 300)];
}

- (void) showMaskAndCardview {
  [UIView animateWithDuration:0.2f animations:^{
    [self.blurredMask setAlpha:1.f];
    [self.cardView setFrame:CGRectOffset(self.cardView.frame, 0, -300)];
    self.cardViewBottomConstraint.constant += 300;
    UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
  } completion:^(BOOL finished) {
    UITapGestureRecognizer *maskTap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(dismissSelf)];
    [self.blurredMask addGestureRecognizer:maskTap];
    UITapGestureRecognizer *cardTap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                               action:@selector(hideKeyboardAndMoveDown:)];
    [cardTap setCancelsTouchesInView:false];
    [self.cardView addGestureRecognizer:cardTap];
  }];
}

- (BOOL)categoryExists {
  NSArray <Category *> *categories = [CategoriesManager getAllCategories];
  for (Category *category in categories) {
    if ([_categoryName.text isEqualToString:category.title] &&
        ![_categoryName.text isEqualToString:_selectedCategory.title]) {
      return true;
    }
  }
  return false;
}

- (void)dismissSelf {
  if (_keyboardShown) {
    return [self hideKeyboardAndMoveDown:nil];
  }
  if (_pickingColor || _pickingIcon) {
    return [self hideCollection];
  }
  if (!_categoryDeleted && _selectedCategory) {
    NSMutableArray <UIView *> *viewsToShake = [NSMutableArray array];
    if (_categoryName.text.length == 0) {
      [viewsToShake addObject:_categoryName];
    }
    if (!_iconSelected) {
      [viewsToShake addObject:_iconLabel];
    }
    if (!_colorSelected) {
      [viewsToShake addObject:_colorLabel];
    }
    if (viewsToShake.count) {
      return [self shake:viewsToShake];
    }
    _selectedCategory.title = _categoryName.text;
    _selectedCategory.colorIndex = _selectedColorIndex;
    _selectedCategory.iconIndex = _selectedIconIndex;
    AppDelegate *delegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    [delegate saveContext];
    [self.headerToReload
     setBackgroundColor:[[ColorsManager getAllColors] objectAtIndex:_selectedColorIndex]];
    [self.titleToReload setText:_categoryName.text];
    [self.iconToReload setImage:[IconsManager getIconForIndex:_selectedIconIndex]];
  }
  [UIView animateWithDuration:0.2f animations:^{
    [self.blurredMask setAlpha:0.f];
    [self.cardView setFrame:CGRectOffset(self.cardView.frame, 0, 300)];
    self.cardViewBottomConstraint.constant -= 300;
    if (self.needDarkenStatusBar) {
      UIApplication.sharedApplication.statusBarStyle = UIStatusBarStyleDefault;
      [self setNeedsStatusBarAppearanceUpdate];
    }
  } completion:^(BOOL finished) {
    [self.presentingViewController dismissViewControllerAnimated:false completion:nil];
  }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  [self setKeyboardShown:true];
  [UIView animateWithDuration:0.2f animations:^{
    [self makeCardViewTaller];
    [self.doneWithCategoryButton setAlpha:0.f];
  }];
}

- (void) controlLength {
  if (self.categoryName.text.length > 20) {
    [self.categoryName
     setText:[self.categoryName.text substringToIndex:self.categoryName.text.length - 1]];
  }
}

- (void) commitChanges {
  if (_selectedCategory) {
    NSString *message = @"If you delete this category all it's expenses also will be deleted";
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Warning"
                                message:message
                                preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok"
                                              style:UIAlertActionStyleDestructive
                                            handler:^(UIAlertAction * _Nonnull action) {
                                              [CategoriesManager delete:self.selectedCategory];
                                              [self setCategoryDeleted:true];
                                              [self.parent performSegueWithIdentifier:@"myUnwind"
                                                                               sender:nil];
                                              [self.tableToReload reloadData];
                                              [self dismissSelf];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                              style:UIAlertActionStyleCancel
                                            handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
  } else {
    NSMutableArray <UIView *> *viewsToShake = [NSMutableArray array];
    if (_categoryName.text.length == 0 || [self categoryExists]) {
      [viewsToShake addObject:_categoryName];
    }
    if (!_iconSelected) {
      [viewsToShake addObject:_iconLabel];
    }
    if (!_colorSelected) {
      [viewsToShake addObject:_colorLabel];
    }
    if (viewsToShake.count) {
      return [self shake:viewsToShake];
    }
    [CategoriesManager createNewCategoryWithName:_categoryName.text
                                           color:_selectedColorIndex
                                         andIcon:_selectedIconIndex];
    [_tableToReload reloadData];
    [self dismissSelf];
  }
}

- (void) shake:(NSMutableArray*)views {
  if (self.shaking) {
    return;
  }
  for (UIView *view in views) {
    self.shaking = YES;
    UIColor *viewColor = [UIColor colorWithCGColor:view.layer.borderColor];
    [view.layer setBorderColor:[UIColor.redColor CGColor]];
    view.transform = CGAffineTransformMakeTranslation(20, 0);
    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:0.2
          initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                       view.transform = CGAffineTransformIdentity;
                     } completion:^(BOOL finished) {
                       [UIView transitionWithView:view duration:0.2
                                          options:UIViewAnimationOptionTransitionCrossDissolve
                                       animations:^{
                                         view.layer.borderColor = viewColor.CGColor;
                                       } completion:^(BOOL finished) {
                                         self.shaking = NO;
                                       }];
                     }];
  }
}

- (void) mutateFontsIfNecessary {
  if (self.view.frame.size.width < 375) {
    UIFont *font = self.categoryName.font;
    [self.categoryName setFont:[font fontWithSize:14]];
  } else if (self.view.frame.size.width > 375) {
    UIFont *font = self.categoryName.font;
    [self.categoryName setFont:[font fontWithSize:18]];
  }
}

@end
