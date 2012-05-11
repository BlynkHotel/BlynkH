//
//  AsyncImageView.m
//  XMLParserDemo
//
//  Created by Brijesh J on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AsyncImageView.h"
#import "EyeAppDelegate.h"

@implementation AsyncImageView


- (id)initWithFrame:(CGRect)frame 
{
    if ((self = [super initWithFrame:frame])) 
    {
        // Initialization code
    }
    return self;
}

- (void)loadImageFromURL:(NSURL*)url
{
    if (connection!=nil) { [connection release]; }
    if (data!=nil) { [data release]; }
	
	//if ([EyeAppDelegate isDeviceAniPad]) {
		
		scrollingWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(110.0,110.0, 20.0, 20.0)];
	//}
    /*
	else{
	
	scrollingWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(40.0, 35.0, 20.0, 20.0)];
		
	}
     */
	scrollingWheel.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	scrollingWheel.hidesWhenStopped = YES;
	[scrollingWheel startAnimating];
	
	[self addSubview:scrollingWheel];


    NSURLRequest* request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:60.0];
    connection = [[NSURLConnection alloc]
				  initWithRequest:request delegate:self];
    //TODO error handling, what if connection is nil?
  

}

- (void)connection:(NSURLConnection *)theConnection
	didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
		data =
		[[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	
    [connection release];
    connection=nil;
	
	if ([[self subviews] count]>0) {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
	
		
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
	
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = ( UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight );
	
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    [imageView setNeedsLayout];
    [self setNeedsLayout];
    [data release];
     data=nil;
	
	[scrollingWheel stopAnimating];
}

- (UIImage*) image {
	
	
//    imageView = [[self subviews] objectAtIndex:0];
    return [imageView image];
	
}

- (void)dealloc {
	
    [connection cancel];
    [connection release];
    [data release];
    [super dealloc];
	[imageView release];
}


@end
