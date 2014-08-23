//
//  PXViewController.h
//  PXAlertViewDemo
//
//  Created by Alex Jarvis on 25/09/2013.
//  Copyright (c) 2013 Panaxiom Ltd. All rights reserved.
//
//  Expanded to include ActivityIndicator views (pie, spinner)
//  and allow for no button (activity) views
//  (c) 2014, Philipp Kuecuekyan and phi & co. LLC
//

#import <UIKit/UIKit.h>

@interface PXViewController : UIViewController

- (IBAction)showSimpleAlertView:(id)sender;
- (IBAction)showLargeAlertView:(id)sender;
- (IBAction)showTwoButtonAlertView:(id)sender;
- (IBAction)showMultiButtonAlertView:(id)sender;
- (IBAction)showAlertViewWithContentView:(id)sender;
- (IBAction)show5StackedAlertViews:(id)sender;
- (IBAction)showAlertInsideAlertCompletion:(id)sender;

- (IBAction)showLargeUIAlertView:(id)sender;

@end
