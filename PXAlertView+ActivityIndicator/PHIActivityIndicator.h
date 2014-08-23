//
//  PHIActivityIndicator.h
//
//
//  Created by Philipp Kuecuekyan on 8/5/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PHIActivityIndicatorType) {
    PHIPieActivityIndicator,
    PHISpinActivityIndicator
};

@interface PHIActivityIndicator : UIView

@property (nonatomic, assign) float progressValue;
@property (nonatomic, strong) UIColor *progressTintColor;
@property (nonatomic, strong) UIColor *backgroundTintColor;

@property (nonatomic, strong) NSTimer *timer;

- (instancetype)initWithIndicatorType:(PHIActivityIndicatorType)indicatorType;
- (instancetype)initWithFrame:(CGRect)frame withIndicatorType:(PHIActivityIndicatorType)indicatorType;

- (void)startSpinning;
- (void)stopSpinning;

@end
