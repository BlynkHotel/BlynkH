//
//  NotificationNames.m
//  BlynkHotel
//
//  Created by iMac2 on 13/04/12.
//  Copyright 2012 Hemlines. All rights reserved.
//

#import "NotificationNames.h"


static NSString *customBadgeUpdatedNotification = @"CustomBadgeUpdatedNoification";
static NSString *receivedGuestDetailsNotification = @"ReceivedGuestDetailsNoification";
static NSString *loggedInSuccesfullyNotification = @"LoggedInSuccessfullyDetailsNoification";
static NSString *loggedOutSuccesfullyNotification = @"LoggedOutSuccessfullyDetailsNoification";

@implementation NotificationNames

+(NSString*)notificationNameForCustomBadgeUpdate
{
	return customBadgeUpdatedNotification;
}

+(NSString*)notificationNameForGuestDetails
{
	return receivedGuestDetailsNotification;
}

+(NSString*)notificationNameForLoggedin
{
	return loggedInSuccesfullyNotification;
}

+(NSString*)notificationNameForLoggedout
{
	return loggedOutSuccesfullyNotification;
}

@end
