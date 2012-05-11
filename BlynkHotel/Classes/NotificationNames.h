//
//  NotificationNames.h
//  BlynkHotel
//
//  Created by iMac2 on 13/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NotificationNames : NSObject {
	
	

}
+(NSString*)notificationNameForCustomBadgeUpdate;
+(NSString*)notificationNameForGuestDetails;
+(NSString*)notificationNameForLoggedin;
+(NSString*)notificationNameForLoggedout;

@end
