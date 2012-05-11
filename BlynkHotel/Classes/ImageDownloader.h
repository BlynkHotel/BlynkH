//
//  ImageDownloader.h
//  BlynkHotel
//
//  Created by ISPL_159 on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubMenuServiceModel.h"
@interface ImageDownloader : NSObject
{
    NSURLConnection* connection;
    NSMutableData* data;
	UIButton *button;
	UIActivityIndicatorView *activityIndicator;
    SubMenuServiceModel *model;
}
- (void)loadImageFromURL:(NSURL*)url forUIButton:(UIButton*)btn andModel:(SubMenuServiceModel*)mod;
@end
