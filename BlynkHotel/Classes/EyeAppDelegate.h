//
//  EyeAppDelegate.h
//  Eye
//
//  Created by Blynk Systems on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NotificationNames.h"
#import "AsyncDownloader.h"
#import "Reachability.h"
#import "MessageView.h"
#import "DSActivityView.h"
#import "LoadingView.h"

#define LOGIN_BUTTON_TAG 111
#define MESSAGE_BUTTON_TAG 112
#define WEATHER_BUTTON_TAG 113
#define GUEST_LABEL_TAG 114
#define DATE_LABEL_TAG 115
#define TIME_LABEL_TAG 116
#define LOGIN_VIEW_TAG 117
#define LOGIN_TEXTFIELD_TAG 118
#define ID_LABEL_TAG 119
#define WEATHER_VIEW_TAG 120
#define MESSAGE_VIEW_TAG 121
#define LOGOUT_BUTTON_TAG 122
#define CUSTOM_BADGE_TAG 123

@interface EyeAppDelegate : NSObject <UIApplicationDelegate,UITextFieldDelegate> {
	
    UIWindow *window;
	UINavigationController *navigationController;
	NSString *appLoginId;
    NSString *currency;
   
    NSString *deviceId;
    NSString *deviceName;
    NSString *systemName;
    NSString *systemModel;
    NSString *localizedModel;
    NSString *systemVersion;

	NSMutableArray *guestNameArray;
	NSMutableArray *guestIdArray;
    NSMutableArray *guestStatusArray;

    NSMutableArray *adImageArray;
    NSMutableArray *firstTextArray;
    NSMutableArray *secondTextArray;
    
    NSMutableArray *adImageArray1;
    NSMutableArray *firstTextArray1;
    NSMutableArray *secondTextArray1;
    
    NSMutableArray *serviceIdArray;
    NSMutableArray *nameArray;
    NSMutableArray *rateArray;
    NSMutableArray *sortDetailArray;
    NSMutableArray *longDetailArray;
    NSMutableArray *imageArray;
    NSMutableArray *quantityArray;
    NSMutableArray *totalArray;
    
    NSMutableArray *serviceIdArray1;
    NSMutableArray *nameArray1;
    NSMutableArray *rateArray1;
    NSMutableArray *sortDetailArray1;
    NSMutableArray *longDetailArray1;
    NSMutableArray *imageArray1;
    NSMutableArray *quantityArray1;
    NSMutableArray *totalArray1;
    
    NSMutableArray *serviceIdArray2;
    NSMutableArray *nameArray2;
    NSMutableArray *rateArray2;
    NSMutableArray *sortDetailArray2;
    NSMutableArray *longDetailArray2;
    NSMutableArray *imageArray2;
    NSMutableArray *quantityArray2;
    NSMutableArray *totalArray2;
   
    NSMutableArray *messageArray;
	NSMutableArray *detailArray;
    NSMutableArray *rTimeArray;
    NSMutableArray *cTimeArray;
    NSMutableArray *statusArray;
    NSMutableArray *readUnreadArray;
    NSMutableArray *tIdArray;
    NSMutableArray *unreadArray;
    
    NSMutableDictionary *dictionary2;
    NSMutableDictionary *dictionary3;
    NSMutableDictionary *dictionary4;
    NSMutableDictionary *dictionary5;
    NSMutableDictionary *dictionary6; 
    NSMutableDictionary *dictionary7;
    NSMutableDictionary *dictionary8;
    /*
    NSMutableArray *menuNameArray2;
	NSMutableArray *menuImageArray2;
    NSMutableArray *serviceId2;
    NSMutableArray *requestArray2;
    
    NSMutableArray *menuNameArray3;
	NSMutableArray *menuImageArray3;
    NSMutableArray *serviceId3;
    NSMutableArray *requestArray3;
    
    NSMutableArray *menuNameArray5;
	NSMutableArray *menuImageArray5;
    NSMutableArray *serviceId5;
    NSMutableArray *requestArray5;
    
    NSMutableArray *menuNameArray6;
	NSMutableArray *menuImageArray6;
    NSMutableArray *serviceId6;
    */
    NSMutableArray *dataArray;
    NSMutableArray *currentArray;

    NSData *data;
    NSData *data1;
    NSData *data2;
    
    NSMutableArray *logoArray;
    NSMutableArray *backgroundArray;
    
    BOOL isGuest;
    BOOL isActive;    
    BOOL isNetworkAvailable;
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    
    UIAlertView *networkErrorAlert;

    NSMutableArray *roomServiceArray;
    NSMutableArray *houseKeepingArray;
    NSMutableArray *travelDeskArray;
    NSMutableArray *hotelInformationArray;
    NSMutableArray *laundryMenuArray;
    NSMutableArray *shoppingMenuArray;
    NSMutableArray *inRoomMenuArray;
    
    UIActivityIndicatorView *defaultActIndicator;
    LoadingView *sharedActivitiView;
    NSMutableDictionary *lastMenuTitles;
    NSCalendar *gregorian;
}
@property (nonatomic, retain) UIActivityIndicatorView *defaultActIndicator;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic,retain) NSString *appLoginId;
@property(nonatomic,retain) NSString *deviceId;
@property (nonatomic,retain) NSString *deviceName;
@property (nonatomic,retain) NSString *systemName;
@property(nonatomic,retain)  NSString *systemVersion;
@property (nonatomic,retain) NSString *systemModel;
@property (nonatomic,retain) NSString *localizedModel;

@property(nonatomic,retain)NSMutableArray *guestNameArray;
@property(nonatomic,retain)NSMutableArray *guestIdArray;
@property(nonatomic,retain)NSMutableArray *guestStatusArray;

@property(nonatomic,retain)NSMutableArray *logoArray;
@property(nonatomic,retain)NSMutableArray *backgroundArray;

@property(nonatomic,retain)NSMutableArray *adImageArray;
@property(nonatomic,retain)NSMutableArray *firstTextArray;
@property(nonatomic,retain)NSMutableArray *secondTextArray;

@property(nonatomic,retain)NSMutableArray *adImageArray1;
@property(nonatomic,retain)NSMutableArray *firstTextArray1;
@property(nonatomic,retain)NSMutableArray *secondTextArray1;

@property(nonatomic,retain)NSMutableArray *serviceIdArray;
@property(nonatomic,retain)NSMutableArray *nameArray;
@property(nonatomic,retain)NSMutableArray *rateArray;
@property(nonatomic,retain)NSMutableArray *sortDetailArray;
@property(nonatomic,retain)NSMutableArray *longDetailArray;
@property(nonatomic,retain)NSMutableArray *imageArray;
@property(nonatomic,retain)NSMutableArray *quantityArray;
@property(nonatomic,retain)NSMutableArray *totalArray;

@property(nonatomic,retain)NSMutableArray *serviceIdArray1;
@property(nonatomic,retain)NSMutableArray *nameArray1;
@property(nonatomic,retain)NSMutableArray *rateArray1;
@property(nonatomic,retain)NSMutableArray *sortDetailArray1;
@property(nonatomic,retain)NSMutableArray *longDetailArray1;
@property(nonatomic,retain)NSMutableArray *imageArray1;
@property(nonatomic,retain)NSMutableArray *quantityArray1;
@property(nonatomic,retain)NSMutableArray *totalArray1;

@property(nonatomic,retain)NSMutableArray *serviceIdArray2;
@property(nonatomic,retain)NSMutableArray *nameArray2;
@property(nonatomic,retain)NSMutableArray *rateArray2;
@property(nonatomic,retain)NSMutableArray *sortDetailArray2;
@property(nonatomic,retain)NSMutableArray *longDetailArray2;
@property(nonatomic,retain)NSMutableArray *imageArray2;
@property(nonatomic,retain)NSMutableArray *quantityArray2;
@property(nonatomic,retain)NSMutableArray *totalArray2;

@property(nonatomic,retain)NSMutableArray *messageArray;
@property(nonatomic,retain)NSMutableArray *detailArray;
@property(nonatomic,retain)NSMutableArray *rTimeArray;
@property(nonatomic,retain)NSMutableArray *cTimeArray;
@property(nonatomic,retain)NSMutableArray *statusArray;
@property(nonatomic,retain)NSMutableArray *readUnreadArray;
@property(nonatomic,retain)NSMutableArray *tIdArray;
@property(nonatomic,retain) NSMutableArray *unreadArray;
@property(nonatomic,retain) LoadingView *sharedActivitiView;
@property(nonatomic,retain) NSMutableDictionary *lastMenuTitles;

/*
@property(nonatomic,retain)NSMutableArray *menuNameArray2;
@property(nonatomic,retain)NSMutableArray *menuImageArray2;
@property(nonatomic,retain)NSMutableArray *serviceId2;
@property(nonatomic,retain)NSMutableArray *requestArray2;

@property(nonatomic,retain)NSMutableArray *menuNameArray3;
@property(nonatomic,retain)NSMutableArray *menuImageArray3;
@property(nonatomic,retain)NSMutableArray *serviceId3;
@property(nonatomic,retain)NSMutableArray *requestArray3;

@property(nonatomic,retain)NSMutableArray *menuNameArray5;
@property(nonatomic,retain)NSMutableArray *menuImageArray5;
@property(nonatomic,retain)NSMutableArray *serviceId5;
@property(nonatomic,retain)NSMutableArray *requestArray5;

@property(nonatomic,retain)NSMutableArray *menuNameArray6;
@property(nonatomic,retain)NSMutableArray *menuImageArray6;
@property(nonatomic,retain)NSMutableArray *serviceId6;
*/
@property(nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,retain)NSMutableArray *currentArray;
@property(nonatomic,retain)NSString *currency;

@property(nonatomic,retain)NSData *data;
@property(nonatomic,retain)NSData *data1;
@property(nonatomic,retain)NSData *data2;
@property(nonatomic,retain)UIAlertView *networkErrorAlert;

@property(nonatomic,assign)BOOL isGuest;
@property(nonatomic,assign)BOOL isActive;
@property(nonatomic) BOOL isNetworkAvailable;

@property(nonatomic,retain) NSMutableArray *roomServiceArray;
@property(nonatomic,retain) NSMutableArray *houseKeepingArray;
@property(nonatomic,retain) NSMutableArray *travelDeskArray;
@property(nonatomic,retain) NSMutableArray *hotelInformationArray;
@property(nonatomic,retain) NSMutableArray *laundryMenuArray;
@property(nonatomic,retain) NSMutableArray *inRoomMenuArray;
@property(nonatomic,retain) NSMutableArray *shoppingMenuArray;
@property(nonatomic,retain) NSCalendar *gregorian;

- (void)loadSubMenuWebService;
- (void)loadWebService;
- (void)messageService;
+(NSMutableDictionary*)getGlobalInfo;
-(void)getGuestDetails;
-(void)doLogin;
-(void)showNetworkUnavailableError;
- (void) reachabilityChanged: (NSNotification* )note;

- (void)weatherAction;
- (void)messageAction;
- (void)displayLoginView;
-(void)customBadgeUpdated;
-(void)receivedGuestDetails;
- (void)setCustomBadge;
-(void)addViewsToNavBar;
- (IBAction)LoginBtnAction;
-(void)dateAndtimeSetup;
-(void)stopActivityIndicator;
-(void)removeLoginView;
- (void)loadWeatherView:(id)sender ;
-(void)removeWeatherView:(id)sender ;
- (void)loadMessageView:(id)sender;
- (void)displayGuestDetail;
- (void)logOutButtonClick;
-(void)doLogOutStuff;
-(void)doProcessWhenNetworkGoesDown;
-(void)startDefaultActIndicatorForView:(UIView*)view;
-(void)stopDefaultActIndicator;
-(void)showTimeOutAlert;
-(void)startStandardActivityLoadingView:(UIView*)parentView;
-(void)stopStandardActivityLoadingView;
@end


