#import "LoadingView.h"
//#import "NSString+Utils.h"
#import <QuartzCore/QuartzCore.h>


/*
CGPathRef NewPathWithRoundRect(CGRect rect, CGFloat cornerRadius)
{
	// Create the boundary path
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height - cornerRadius);
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		cornerRadius);
	// Top right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
        cornerRadius);
	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		cornerRadius);
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y,
		cornerRadius);
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;
}*/


@implementation LoadingView

@synthesize loadingLabel;

+ (id) loadingViewInView:(UIView *)aSuperview rect:(CGRect)aRect messageText:(NSString *)labelText;
{
	LoadingView *loadingView = [[[LoadingView alloc] initWithFrame:aRect] autorelease];
    [[NSNotificationCenter defaultCenter] addObserver:loadingView selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
	if (!loadingView) {
		return nil;
	}
	
	loadingView.opaque = NO;
	loadingView.layer.cornerRadius = 10.0;
	loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75];
	//loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	loadingView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin 
	| UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
	[aSuperview addSubview:loadingView];

	//const CGFloat DEFAULT_LABEL_WIDTH = 200.0;
	const CGFloat DEFAULT_LABEL_HEIGHT = 70.0;
	CGRect labelFrame = CGRectMake(0, 0, aRect.size.width, DEFAULT_LABEL_HEIGHT);
	UILabel *aLoadingLabel = [[UILabel alloc] initWithFrame:labelFrame];
	aLoadingLabel.text = labelText;
	aLoadingLabel.textColor = [UIColor whiteColor];
	aLoadingLabel.backgroundColor = [UIColor clearColor];
	aLoadingLabel.textAlignment = UITextAlignmentCenter;
	aLoadingLabel.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
	aLoadingLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                     UIViewAutoresizingFlexibleRightMargin |
                                     UIViewAutoresizingFlexibleTopMargin |
                                     UIViewAutoresizingFlexibleBottomMargin;
	aLoadingLabel.numberOfLines =2;
	[loadingView addSubview:aLoadingLabel];
    loadingView.loadingLabel = aLoadingLabel;
    [aLoadingLabel release];
    
	UIActivityIndicatorView *activityIndicatorView = [[[UIActivityIndicatorView alloc]
                                                       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]
                                                        autorelease];
	[loadingView addSubview:activityIndicatorView];
	activityIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                             UIViewAutoresizingFlexibleRightMargin |
                                             UIViewAutoresizingFlexibleTopMargin |
                                             UIViewAutoresizingFlexibleBottomMargin;
	[activityIndicatorView startAnimating];
	
	CGFloat totalHeight = loadingView.loadingLabel.frame.size.height + activityIndicatorView.frame.size.height;
	labelFrame.origin.x = floor(0.5 * (loadingView.frame.size.width - aRect.size.width));
	labelFrame.origin.y = floor(0.5 * (loadingView.frame.size.height - totalHeight));
	loadingView.loadingLabel.frame = labelFrame;
	
	CGRect activityIndicatorRect = activityIndicatorView.frame;
	activityIndicatorRect.origin.x = 0.5 * (loadingView.frame.size.width - activityIndicatorRect.size.width);
	activityIndicatorRect.origin.y = loadingView.loadingLabel.frame.origin.y + loadingView.loadingLabel.frame.size.height - 10;
	activityIndicatorView.frame = activityIndicatorRect;
	
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	if([aSuperview class] == [UIWindow class])
	{
		// added by kuldeep to support orientation in case of loading view is added in window
		loadingView.center = aSuperview.center;
        
		//UPNPAppDelegate *appDel = (UPNPAppDelegate *)[[UIApplication sharedApplication] delegate];
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
		switch (orientation) 
		{
			case UIInterfaceOrientationPortraitUpsideDown:
				loadingView.transform = CGAffineTransformMakeRotation(M_PI);
				break;
			case UIInterfaceOrientationLandscapeRight:
				loadingView.transform = CGAffineTransformMakeRotation(M_PI_2);
				break;
			case UIInterfaceOrientationLandscapeLeft:
				loadingView.transform = CGAffineTransformMakeRotation(-M_PI_2);
				break;
			default:
				break;
		}       
        
	}
	return loadingView;
}

-(void)orientationChanged:(NSNotification *)notification{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    switch (orientation) 
    {
        case UIInterfaceOrientationPortraitUpsideDown:
            self.transform = CGAffineTransformMakeRotation(M_PI);
            break;
        case UIInterfaceOrientationLandscapeRight:
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
            break;
        default:
            break;
    }
}
- (void) removeView
{
	UIView *aSuperview = [self superview];
	[super removeFromSuperview];

	// Set up the animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}

/*
- (void) drawRect:(CGRect)rect
{
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	const CGFloat RECT_PADDING = 8.0;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;
	CGPathRef roundRectPath = NewPathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
	
	CGContextRef context = UIGraphicsGetCurrentContext();

	const CGFloat BACKGROUND_OPACITY = 0.85;
	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);

	const CGFloat STROKE_OPACITY = 0.25;
	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
}
 */


//- (void) setMessageText:(NSString *)labelText
//{
//    if ([labelText isNotEmpty]) {
//        self.loadingLabel.text = labelText;
//        [self setNeedsDisplay];
//    }
//}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObject:self];
	[self.loadingLabel release];
    [super dealloc];
}

@end
