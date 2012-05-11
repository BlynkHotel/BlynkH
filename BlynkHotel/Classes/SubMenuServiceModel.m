//
//  RoomServiceModel.m
//  BlynkHotel
//
//  Created by ISPL_159 on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SubMenuServiceModel.h"

@implementation SubMenuServiceModel
@synthesize requestText,serviceId,serviceName,img,imgUrl;
-(id)init
{
    self = [super init];
    if (self!=nil)
    {
        self.requestText = [NSString string];
        self.serviceId = [NSString string];
        self.serviceName = [NSString string];
        self.imgUrl = [NSString string];        
//        self.img = [[[UIImage alloc] init] autorelease];
    }
    return self;
}
-(void)dealloc
{
    self.requestText = nil;
    self.serviceId=nil;
    self.serviceName=nil;
    self.img=nil;
    self.imgUrl=nil;
    [super dealloc];
}
@end
