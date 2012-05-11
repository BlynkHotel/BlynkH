//
//  AsyncDownloader.h
//  BlynkHotel
//
//  Created by iMac2 on 12/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 AsyncDownloader *d1 = [[AsyncDownloader alloc] initwithRequest:req delegate:self methodName:@"displayAddImage"];
 [d1 startDownloading];
 
 AsyncDownloader
 {
 NSMutableData *receivedData;
 NSUrlConnection *theConnection;
 NSUrlRequest *theRequest;
 NSString *methodName;
 
 initwithRequest:req delegate:del methodName:mthdString
 {
 self.theRequest = req;
 self.methodName = mthdString;
 self.theConnection = [NSURLConnection alloc] initwithRequest:req cachePolicy delegate:self];			
 }
 startDownloading
 {
 if(theConnection != nil)
 {
 [theConnection start];
 }
 }
 }
 */

@protocol AsyncDownloaderDelegate

@required
-(void)didFinishDownloadingAsyncDownloaderInJson:(NSString*)jsonString ForMethod:(NSString*)methodName; //at present all response in json so required
-(void)didFailAsyncDownloaderWithError:(NSError*)error ForMethod:(NSString*)methodName;
@optional
-(void)didFinishDownloadingAsyncDownloader:(NSMutableData*)receivedData ForMethod:(NSString*)methodName;

@end


@interface AsyncDownloader : NSObject {
	
	NSURLConnection *theConnection;	//one coonection to download url
	NSURLRequest *theRequest;	// Url request
	NSString *methodName;	//Method name which invoked it
	NSMutableData *receivedData;	//received response data
	NSString *responseDataFormat;	//server respons data format type
	id delegate;
}

@property(nonatomic, retain) NSURLConnection *theConnection;
@property(nonatomic, retain) NSURLRequest *theRequest;
@property(nonatomic, retain) NSString *methodName;
@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, assign) id delegate;
@property(nonatomic, retain) NSString *responseDataFormat;

-(void)startDownloading;
-(id)initWithRequest:(NSURLRequest*)req delegate:(id)del methodName:(NSString*)mName responseDataFormat:(NSString*)dataFormat;
-(void)notifyToDelegateSuccess;
-(void)notifyToDelegateFailureWithError:(NSError*) error;

@end
