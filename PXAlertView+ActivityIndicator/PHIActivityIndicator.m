//
//  PHIActivityIndicator.h
//
//
//  Created by Philipp Kuecuekyan on 8/5/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
//

#import "PHIActivityIndicator.h"

@interface PHIActivityIndicator()
@property (nonatomic, assign) BOOL shouldShowPieIndicator;
@end

@implementation PHIActivityIndicator

#pragma mark - Initializers 

- (instancetype)init {
	return [self initWithFrame:CGRectMake(0.f, 0.f, 37.f, 37.f) withIndicatorType:PHISpinActivityIndicator];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame withIndicatorType:PHISpinActivityIndicator];
}

- (instancetype)initWithIndicatorType:(PHIActivityIndicatorType)indicatorType {
    return [self initWithFrame:CGRectMake(0.f, 0.f, 37.f, 37.f) withIndicatorType:indicatorType];
}

- (instancetype)initWithFrame:(CGRect)frame withIndicatorType:(PHIActivityIndicatorType)indicatorType {
	self = [super initWithFrame:frame];
	if (self) {
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		_progressValue = 0.f;
		_shouldShowPieIndicator = (indicatorType == PHIPieActivityIndicator) ? YES : NO;
		_progressTintColor = [[UIColor alloc] initWithWhite:1.f alpha:1.f];
		_backgroundTintColor = [[UIColor alloc] initWithWhite:1.f alpha:.1f];
		[self registerObservers];
	}
	return self;
}

#pragma mark - Destructor

- (void)dealloc {
	[self unregisterObservers];
    [_timer invalidate];
}

#pragma mark - Indicator trigger and handling methods

- (void)startSpinning {
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(increaseProgressValue:) userInfo:nil repeats:YES];
    
}

- (void)stopSpinning {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)increaseProgressValue:(NSTimer*)timer {
    if (self.progressValue >= 1.0f) {
        self.progressValue = 0.0f;
    } else {
        self.progressValue += 0.02f;
    }
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {
	
	CGRect allRect = self.bounds;
	CGRect circleRect = CGRectInset(allRect, 2.0f, 2.0f);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	if (!self.shouldShowPieIndicator) {
        
		// Draw background
        
		CGFloat lineWidth = 5.f;
		UIBezierPath *processBackgroundPath = [UIBezierPath bezierPath];
		processBackgroundPath.lineWidth = lineWidth;
		processBackgroundPath.lineCapStyle = kCGLineCapRound;
		CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
		CGFloat radius = (self.bounds.size.width - lineWidth)/2;
		CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
		CGFloat endAngle = (2 * (float)M_PI) + startAngle;
		[processBackgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
		[_backgroundTintColor set];
		[processBackgroundPath stroke];
        
		// Draw progress spinner
        
		UIBezierPath *processPath = [UIBezierPath bezierPath];
		processPath.lineCapStyle = kCGLineCapRound;
		processPath.lineWidth = lineWidth;
		endAngle = (self.progressValue * 2 * (float)M_PI) + startAngle;
		[processPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
		[_progressTintColor set];
		[processPath stroke];
        
	} else {
        
		// Draw background
        
		[_progressTintColor setStroke];
		[_backgroundTintColor setFill];
		CGContextSetLineWidth(context, 2.0f);
		CGContextFillEllipseInRect(context, circleRect);
		CGContextStrokeEllipseInRect(context, circleRect);
        
		// Draw pie progress indicator
        
		CGPoint center = CGPointMake(allRect.size.width / 2, allRect.size.height / 2);
		CGFloat radius = (allRect.size.width - 4) / 2;
		CGFloat startAngle = - ((float)M_PI / 2); // 90 degrees
		CGFloat endAngle = (self.progressValue * 2 * (float)M_PI) + startAngle;
		CGContextSetRGBFillColor(context, 1.0f, 1.0f, 1.0f, 1.0f); // white
		CGContextMoveToPoint(context, center.x, center.y);
		CGContextAddArc(context, center.x, center.y, radius, startAngle, endAngle, 0);
		CGContextClosePath(context);
		CGContextFillPath(context);
	}
}

#pragma mark - KVO of color, progress

- (void)registerObservers {
	for (NSString *keyPath in [self observableKeypaths]) {
		[self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:NULL];
	}
}

- (void)unregisterObservers {
	for (NSString *keyPath in [self observableKeypaths]) {
		[self removeObserver:self forKeyPath:keyPath];
	}
}

- (NSArray *)observableKeypaths {
	return [NSArray arrayWithObjects:@"progressTintColor", @"backgroundTintColor", @"progressValue", nil];
}

/*
 *
 *  Redraw if properties have been observed
 *
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	[self setNeedsDisplay];
}

@end
