//
//  AsyncImageView.h
//  XMLParserDemo
//
//  Created by Brijesh J on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AsyncImageView : UIView 
{
	NSURLConnection* connection;
    NSMutableData* data;
	UIImageView *imageView;
	UIActivityIndicatorView *scrollingWheel;
    
}

- (void)loadImageFromURL:(NSURL*)url;
- (UIImage*) image;


@end
