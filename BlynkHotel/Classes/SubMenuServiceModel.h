//
//  RoomServiceModel.h
//  BlynkHotel
//
//  Created by ISPL_159 on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubMenuServiceModel : NSObject
{
    NSString *serviceName;
    NSString *serviceId;
    NSString *imgUrl;
    NSString *requestText;
    UIImage *img;
}
@property(nonatomic,retain) NSString *serviceName;
@property(nonatomic,retain) NSString *serviceId;
@property(nonatomic,retain) NSString *imgUrl;
@property(nonatomic,retain) NSString *requestText;
@property(nonatomic,retain) UIImage *img;
@end
