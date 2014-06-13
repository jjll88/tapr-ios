//
//  UINavigationItem+Additions.h
//  RedRover
//
//  Created by David Regatos on 20/02/14.
//
// DESCRIPTION: Category created to modify the default position of
// the left and right bar button in iOS7. We can use UIBarButtonItem
// tag property to control the inset value.

#import <UIKit/UIKit.h>

@interface UINavigationItem (Additions)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;

@end
