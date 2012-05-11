//
//  ImageDownloader.m
//  BlynkHotel
//
//  Created by ISPL_159 on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageDownloader.h"

@implementation ImageDownloader
- (void)loadImageFromURL:(NSURL*)url forUIButton:(UIButton*)btn andModel:(SubMenuServiceModel*)mod
{
    if (connection!=nil) { [connection release]; }
    if (data!=nil) { [data release]; }
    btn.backgroundColor = [UIColor blackColor];
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(110.0,110.0, 20.0, 20.0)];
	activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
	activityIndicator.hidesWhenStopped = YES;
	[activityIndicator startAnimating];
	
	[btn addSubview:activityIndicator];
    NSURLRequest* request = [NSURLRequest requestWithURL:url
											 cachePolicy:NSURLRequestUseProtocolCachePolicy
										 timeoutInterval:60.0];
    connection = [[NSURLConnection alloc]
				  initWithRequest:request delegate:self];
    button = btn;
    model = mod;
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

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection 
{
	
    [connection release];
    connection=nil;
    UIImage *img = [[UIImage alloc]initWithData:data];
	model.img = img;
    [button setBackgroundImage:img forState:UIControlStateNormal];
	[activityIndicator removeFromSuperview];
    [data release];
    data=nil;
    [img release];
}
- (void)dealloc {
	
    [connection cancel];
    [connection release];
    [data release];
  	[activityIndicator release];
    [super dealloc];

}
@end
