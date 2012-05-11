//
//  AsyncDownloader.m
//  BlynkHotel
//
//  Created by iMac2 on 12/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import "AsyncDownloader.h"
#import "EyeAppDelegate.h"

@implementation AsyncDownloader

@synthesize theConnection, theRequest, methodName, delegate, receivedData, responseDataFormat;


-(void)startDownloading
{
	if(self.theRequest != nil)
	{
        EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
        if(appDel.isNetworkAvailable == NO)
        {
            [appDel showNetworkUnavailableError];
            return;
        }
		self.theConnection = [NSURLConnection connectionWithRequest:self.theRequest delegate:self];
	
		if(self.theConnection != nil)
		{		
				self.receivedData = [NSMutableData data];  //init data object to receive data
		}
		else
		{
			NSLog(@"AsyncDownloader-startDownloading- Failed to create theConnection");
			return;
		}		
	}
}

-(id)initWithRequest:(NSURLRequest*)req delegate:(id)del methodName:(NSString*)mName responseDataFormat:(NSString*)dataFormat
{
	self = [super init];
	
	if(self)
	{
		if(req != nil && del != nil && mName != nil && mName != nil)
		{
			self.delegate = del;
			self.theRequest = req;
			self.methodName = mName;	
			self.responseDataFormat = dataFormat;
			return self;
		}
		else 
		{
			return nil;
		}
	}
	else 
	{
		return nil;
	}

}

#pragma mark -
#pragma mark Connection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
	//reset mutable data object to zero length
	//if ([connection isEqual:self.homeAdConnection] && connection.hash == self.homeAdConnection.hash)
	//{
		if(self.receivedData != nil)
		{
			[self.receivedData setLength:0];
			return;
		}
	//}
	
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	
	//if ([connection isEqual:self.homeAdConnection] && connection.hash == self.homeAdConnection.hash)
	//{
		[self.receivedData appendData:data];
	//}
	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	
	//release connections
	//if ([connection isEqual:self.homeAdConnection] && connection.hash == self.homeAdConnection.hash)
	//{
//		[self.theConnection release];
//		[self.receivedData release];
    self.theConnection = nil;
    self.receivedData = nil;
		//inform to delegate
		[self notifyToDelegateFailureWithError:error];
	//}
	
	NSLog(@"AsyncDownloader-startDownloading: Connection Failed. Error - %@, %@", [error localizedDescription], [[error userInfo] objectForKey:NSURLErrorFailingURLErrorKey]);
	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	//release connections
	//if ([connection isEqual:self.homeAdConnection] && connection.hash == self.homeAdConnection.hash)
	//{
//		[self.theConnection release];
    self.theConnection = nil;
		//inform to delegate
		[self notifyToDelegateSuccess];
	//}
	
}

-(void)notifyToDelegateSuccess
{
	/*
	if (self.receivedData != nil) 
	{
		if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didFinishDownloadingAsyncDownloader:ForMethod:)])
		{
			[self.delegate didFinishDownloadingAsyncDownloader:self.receivedData ForMethod:self.methodName];
		}
		[self.receivedData release];
	}
	*/
	if (self.receivedData != nil) 
	{
		if(self.responseDataFormat == nil || [self.responseDataFormat isEqualToString:@"JSON"]) //If response data format is specified as JSON then return json string
		{
			if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didFinishDownloadingAsyncDownloaderInJson:ForMethod:)])
			{
				NSString *jsonString = [[[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding] autorelease];
				if(jsonString)
				{
					[self.delegate didFinishDownloadingAsyncDownloaderInJson:jsonString ForMethod:self.methodName];
				}			
			}
		}
		else if (self.responseDataFormat != nil && [self.responseDataFormat isEqualToString:@"IMAGE"]) //in this case return mutable data
		{
			if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didFinishDownloadingAsyncDownloader:ForMethod:)])
			{
				[self.delegate didFinishDownloadingAsyncDownloader:self.receivedData ForMethod:self.methodName];
			}
		}
		
//		[self.receivedData release];
        self.receivedData = nil;
	}	
	
}

-(void)notifyToDelegateFailureWithError:(NSError*) error
{
	if(self.delegate != nil && [self.delegate respondsToSelector:@selector(didFailAsyncDownloader:WithError:ForMethod:)])
	{
		[self.delegate didFailAsyncDownloaderWithError:error ForMethod:self.methodName];
	}
}


- (void)dealloc 
{	
//	if(self.theRequest != nil)
//		[self.theRequest release];
//	if(self.methodName != nil)
//		[self.methodName release];
    self.theRequest = nil;
    self.methodName = nil;
    [super dealloc];
}

@end
