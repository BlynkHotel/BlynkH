
//
//  EyeAppDelegate.m
//  Eye
//
//  Created by Blynk Systems on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EyeAppDelegate.h"
#import "BKAPIClient.h"
#import "AsyncDownloader.h"
#import "URLRequestGenerator.h"
#import "URLGenerator.h"
#import "DSActivityView.h"
#import "MessageView.h"
#import "proAlertView.h"
#import "CustomBadge.h"
#import "SubMenuServiceModel.h"
/*
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
*/
#import "HomeView.h"
@implementation EyeAppDelegate

NSMutableDictionary *globalInfo;

@synthesize window;
@synthesize navigationController;
@synthesize appLoginId,guestNameArray,guestIdArray,guestStatusArray,isGuest,isActive,data,data1,data2;
@synthesize adImageArray,firstTextArray,secondTextArray;
@synthesize adImageArray1,firstTextArray1,secondTextArray1,totalArray1,totalArray2,totalArray;
@synthesize nameArray,sortDetailArray,longDetailArray,rateArray,imageArray,quantityArray,serviceIdArray;
@synthesize nameArray1,sortDetailArray1,longDetailArray1,rateArray1,imageArray1,quantityArray1,serviceIdArray1;
@synthesize nameArray2,sortDetailArray2,longDetailArray2,rateArray2,imageArray2,quantityArray2,serviceIdArray2;
@synthesize unreadArray,messageArray,detailArray,cTimeArray,rTimeArray,statusArray,readUnreadArray,tIdArray;
@synthesize deviceId,deviceName,systemName,systemVersion,systemModel,localizedModel;
@synthesize backgroundArray,logoArray,lastMenuTitles;
//@synthesize menuNameArray2,menuImageArray2,serviceId2,requestArray2;
//@synthesize menuNameArray3,menuImageArray3,serviceId3,requestArray3;
//@synthesize menuNameArray5,menuImageArray5,serviceId5,requestArray5;
//@synthesize menuNameArray6,menuImageArray6,serviceId6;
@synthesize dataArray,currentArray,currency;
@synthesize isNetworkAvailable, networkErrorAlert,gregorian;

@synthesize roomServiceArray,houseKeepingArray,travelDeskArray,hotelInformationArray,laundryMenuArray,inRoomMenuArray,shoppingMenuArray;
@synthesize defaultActIndicator,sharedActivitiView;
#pragma mark -
#pragma mark Application lifecycle

+(NSMutableDictionary*)getGlobalInfo{
	return globalInfo;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
	
	//[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES];
	//Register for rechability notifications
    [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
#if TARGET_IPAD_SIMULATOR
	if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)])
		[[UIDevice currentDevice] performSelector:@selector(setOrientation:) withObject:(id)UIInterfaceOrientationLandscapeLeft];
#endif
    
    NetworkStatus netStatus;
    BOOL isWiFi = NO; 
    BOOL isInternet = NO;
    BOOL conRequired = YES;
	
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
    netStatus = [internetReach currentReachabilityStatus];    
    conRequired = [internetReach connectionRequired];
    if(netStatus != NotReachable && conRequired == NO)
    {
        isInternet = YES;
    }
	[internetReach startNotifier];
	    
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
    netStatus = [wifiReach currentReachabilityStatus];
    if(netStatus != NotReachable)
    {
        isWiFi = YES;
    }
    [wifiReach startNotifier];
    
    if(isInternet == YES || isWiFi == YES)
    {
        isNetworkAvailable = YES;
    }
    else
    {
        isNetworkAvailable = NO;
    }
    
    /*
    hostReach = [[Reachability reachabilityWithHostName:[URLGenerator urlBase]] retain];
    netStatus = [hostReach currentReachabilityStatus];
	[hostReach startNotifier];
	
    if(netStatus == NotReachable)
    {
        isNetworkAvailable = NO;
    }
    else
    {
        isNetworkAvailable = YES;
    }
    */
    self.defaultActIndicator = [[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
    self.defaultActIndicator.hidesWhenStopped = YES;
    
    self.roomServiceArray = [[[NSMutableArray alloc]init]autorelease];
    self.houseKeepingArray= [[[NSMutableArray alloc]init]autorelease]; 
    self.travelDeskArray= [[[NSMutableArray alloc]init]autorelease]; 
    self.hotelInformationArray = [[[NSMutableArray alloc]init]autorelease]; 
    self.laundryMenuArray = [[[NSMutableArray alloc]init]autorelease]; 
    self.inRoomMenuArray = [[[NSMutableArray alloc]init]autorelease]; 
    self.shoppingMenuArray = [[[NSMutableArray alloc]init]autorelease];  
	guestNameArray = [[NSMutableArray alloc]init];
	guestIdArray = [[NSMutableArray alloc]init];
    
    backgroundArray = [[NSMutableArray alloc]init];
   	logoArray = [[NSMutableArray alloc]init];
    
    dataArray = [[NSMutableArray alloc]init];
    currentArray = [[NSMutableArray alloc]init];
    
    adImageArray = [[NSMutableArray alloc]init];
    firstTextArray = [[NSMutableArray alloc]init];
    secondTextArray = [[NSMutableArray alloc]init];
    
    adImageArray1 = [[NSMutableArray alloc]init];
    firstTextArray1 = [[NSMutableArray alloc]init];
    secondTextArray1 = [[NSMutableArray alloc]init];
    
    serviceIdArray = [[NSMutableArray alloc]init];
    nameArray = [[NSMutableArray alloc]init];
    rateArray = [[NSMutableArray alloc]init];
    sortDetailArray = [[NSMutableArray alloc]init];
    longDetailArray = [[NSMutableArray alloc]init];
    imageArray = [[NSMutableArray alloc]init];
    quantityArray = [[NSMutableArray alloc]init];
    
    serviceIdArray1 = [[NSMutableArray alloc]init];
    nameArray1 = [[NSMutableArray alloc]init];
    rateArray1 = [[NSMutableArray alloc]init];
    sortDetailArray1 = [[NSMutableArray alloc]init];
    longDetailArray1 = [[NSMutableArray alloc]init];
    imageArray1 = [[NSMutableArray alloc]init];
    quantityArray1 = [[NSMutableArray alloc]init];
    
    serviceIdArray2 = [[NSMutableArray alloc]init];
    nameArray2 = [[NSMutableArray alloc]init];
    rateArray2 = [[NSMutableArray alloc]init];
    sortDetailArray2 = [[NSMutableArray alloc]init];
    longDetailArray2 = [[NSMutableArray alloc]init];
    imageArray2 = [[NSMutableArray alloc]init];
    quantityArray2 = [[NSMutableArray alloc]init];
    
    totalArray = [[NSMutableArray alloc]init];
    totalArray1 = [[NSMutableArray alloc]init];
    totalArray2 = [[NSMutableArray alloc]init];
    unreadArray = [[NSMutableArray alloc]init];
    
    globalInfo = [[NSMutableDictionary alloc]init];    
    NSLog(@"uniqueIdentifier: %@", [[UIDevice currentDevice] uniqueIdentifier]);
    NSLog(@"name: %@", [[UIDevice currentDevice] name]);
    NSLog(@"systemName: %@", [[UIDevice currentDevice] systemName]);
    NSLog(@"systemVersion: %@", [[UIDevice currentDevice] systemVersion]);
    NSLog(@"model: %@", [[UIDevice currentDevice] model]);
    NSLog(@"localizedModel: %@", [[UIDevice currentDevice] localizedModel]);
    
        
    isGuest = NO;
    isActive = NO;
    
    if (isNetworkAvailable)
    {
         [self loadWebService];
    }
    else
    {
        [self showNetworkUnavailableError];
    }
   
    //Javal 18/4/12
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidTimeout:) name:kApplicationDidTimeoutNotification object:nil];
    */
     
    // Override point for customization after application launch.
	self.window.rootViewController = self.navigationController;
    [self addViewsToNavBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customBadgeUpdated) name:[NotificationNames notificationNameForCustomBadgeUpdate] object:nil];
	//register for received guest details notification
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGuestDetails) name:[NotificationNames notificationNameForGuestDetails] object:nil];
	
    [self.window makeKeyAndVisible];
    NSLog(@"returning from appdidfinishlaunch");
    
    //self.sharedActivitiView = [DSBezelActivityView newActivityViewForView:self.window];    
    self.sharedActivitiView = [LoadingView loadingViewInView:self.window rect:CGRectMake(100,50,150,120) messageText:@"Loading..."];
    self.sharedActivitiView.hidden = YES;
    
    return YES;
}

-(void)customBadgeUpdated
{
	NSLog(@"received notification: customBadgeUpdated");
//    customBadge1.hidden = YES;			
    [[self.navigationController.navigationBar viewWithTag:CUSTOM_BADGE_TAG] removeFromSuperview];
	if ([self.unreadArray count] > 0) 
	{
        
        CustomBadge *customBadge1 = [CustomBadge customBadgeWithString:
						[NSString stringWithFormat:@"%d",[self.unreadArray count]] 
										  withStringColor:[UIColor whiteColor] 
										   withInsetColor:[UIColor redColor] 
										   withBadgeFrame:YES 
									  withBadgeFrameColor:[UIColor whiteColor] 
												withScale:1.0
											  withShining:YES];
		[customBadge1 setFrame:CGRectMake(940,0, customBadge1.frame.size.width, customBadge1.frame.size.height)];
        customBadge1.tag = CUSTOM_BADGE_TAG;
		[self.navigationController.navigationBar addSubview:customBadge1];
	}
}

-(void)receivedGuestDetails
{
	NSLog(@"received notification: receivedGuestDetails");
	if ([self.guestNameArray count]>0) {
		
        [(UILabel*)[self.navigationController.navigationBar viewWithTag:GUEST_LABEL_TAG] setText:[self.guestNameArray objectAtIndex:0]];
        [(UILabel*)[self.navigationController.navigationBar viewWithTag:ID_LABEL_TAG] setText:[self.guestIdArray objectAtIndex:0]];

		if ([[NSString stringWithFormat:@"%@",[self.guestStatusArray objectAtIndex:0]] isEqualToString:@"Yes"])
        {
            [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGOUT_BUTTON_TAG] setHidden:NO];
			self.isActive = YES;
			[self setCustomBadge];
		}
        else
        {
			self.isActive = NO;
            [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setEnabled:YES];
            [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGOUT_BUTTON_TAG] setHidden:YES];
            
            [(UILabel*)[self.navigationController.navigationBar viewWithTag:GUEST_LABEL_TAG] setText:@"Welcome, Guest"];
            [(UILabel*)[self.navigationController.navigationBar viewWithTag:ID_LABEL_TAG] setText:@""];
		}
	}
    else
    {
		
        [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setEnabled:YES];
        [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGOUT_BUTTON_TAG] setHidden:YES];
        
        [(UILabel*)[self.navigationController.navigationBar viewWithTag:GUEST_LABEL_TAG] setText:@"Welcome, Guest"];
        [(UILabel*)[self.navigationController.navigationBar viewWithTag:ID_LABEL_TAG] setText:@""];
        
	}
}

- (void)setCustomBadge
{
    
    if(self.isGuest == YES && self.isActive == YES) 
	{ 
		[self messageService];
        
    }
	else
	{
        [[self.navigationController.navigationBar viewWithTag:CUSTOM_BADGE_TAG] removeFromSuperview];
    }    
}

//Javal 18/4/12
-(void)addViewsToNavBar
{
    //login button
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.tag = LOGIN_BUTTON_TAG;
    loginBtn.frame = CGRectMake(80, 0, 46, 46);
    [loginBtn setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(displayLoginView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:loginBtn];  
    
    //login button
    UIButton *logoutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logoutBtn.tag = LOGOUT_BUTTON_TAG;
    logoutBtn.frame = CGRectMake(80, 0, 46, 46);
    [logoutBtn setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [logoutBtn addTarget:self action:@selector(logOutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    logoutBtn.hidden = TRUE;
    [self.navigationController.navigationBar addSubview:logoutBtn];  
    
    //weather button
    UIButton *weatherBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    weatherBtn.tag = WEATHER_BUTTON_TAG;
    weatherBtn.frame = CGRectMake(848, 0, 46, 46);
    [weatherBtn setImage:[UIImage imageNamed:@"wather_icon.png"] forState:UIControlStateNormal];
    [weatherBtn addTarget:self action:@selector(weatherAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:weatherBtn];  
   
    //message notification button
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.tag = MESSAGE_BUTTON_TAG;
    messageBtn.frame = CGRectMake(908, 0, 46, 46);
    [messageBtn setImage:[UIImage imageNamed:@"message.png"] forState:UIControlStateNormal];
    [messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:messageBtn];  
    
    //Guest label
    UILabel *lblGuestName = [[UILabel alloc]initWithFrame:CGRectMake(140, 1, 143, 21)];
    lblGuestName.tag = GUEST_LABEL_TAG;
    lblGuestName.backgroundColor = [UIColor clearColor];
    lblGuestName.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:lblGuestName];
    [lblGuestName release];
    
    //Guest label
    UILabel *lblGuestID = [[UILabel alloc]initWithFrame:CGRectMake(140, 22, 143, 21)];
    lblGuestID.tag = ID_LABEL_TAG;
    lblGuestID.backgroundColor = [UIColor clearColor];
    lblGuestID.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:lblGuestID];
    [lblGuestID release];

    
    //date label
    UILabel *lbldate = [[UILabel alloc]initWithFrame:CGRectMake(684, 0, 150, 21)];
    lbldate.tag = DATE_LABEL_TAG;
    lbldate.backgroundColor = [UIColor clearColor];
    lbldate.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:lbldate];
    [lbldate release];
    
    //time label
    UILabel *lbltime = [[UILabel alloc]initWithFrame:CGRectMake(684, 22, 150, 21)];
    lbltime.tag = TIME_LABEL_TAG;
    lbltime.backgroundColor = [UIColor clearColor];
    lbltime.textColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:lbltime];
    [lbltime release];

    [self setCustomBadge];
    [self displayGuestDetail];
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
}
- (void)displayLoginView
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    
    UIView *loginView = [[UIView alloc]initWithFrame:CGRectMake(294,56,713,702)];
    loginView.tag = LOGIN_VIEW_TAG;
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,loginView.frame.size.width,loginView.frame.size.height)];
    loginView.backgroundColor = [UIColor clearColor];
    [backImage setImage:[UIImage imageNamed:@"commonpopup.png"]];
    [loginView addSubview:backImage];
    [backImage release];
    
    UITextField *txtloginId = [[UITextField alloc] initWithFrame:CGRectMake(207,73,300,47)];
    txtloginId.tag = LOGIN_TEXTFIELD_TAG;
    txtloginId.placeholder = @"Enter Guest-Id";
    txtloginId.font = [UIFont boldSystemFontOfSize:25];
    txtloginId.borderStyle = UITextBorderStyleBezel;
    txtloginId.background = [UIImage imageNamed:@"logintext.png"];
    txtloginId.textColor = [UIColor blackColor];
    txtloginId.returnKeyType = UIReturnKeyGo;
    txtloginId.textAlignment = UITextAlignmentCenter;
    txtloginId.autocorrectionType = UITextAutocorrectionTypeNo;
    txtloginId.delegate = self;
    txtloginId.keyboardType=UIKeyboardTypeNumberPad;
    [txtloginId becomeFirstResponder];
    [txtloginId addTarget:self action:@selector(LoginBtnAction) forControlEvents:UIControlEventEditingDidEndOnExit];
    [loginView addSubview:txtloginId];
    [txtloginId release];
    
	UILabel *loadingMessage = [[UILabel alloc] initWithFrame:CGRectMake(80,264,550,21)];
	loadingMessage.font = [UIFont boldSystemFontOfSize:20];
	loadingMessage.textAlignment = UITextAlignmentCenter;
	loadingMessage.text = @"Guest ID will be provided by Hotel at the time of Check-In";
	loadingMessage.textColor = [UIColor whiteColor];
	loadingMessage.backgroundColor = [UIColor clearColor];
	[loginView addSubview:loadingMessage];
    [loadingMessage release];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(removeLoginView) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(680,0,33, 36);
    closeBtn.backgroundColor = [UIColor clearColor];
    [loginView addSubview:closeBtn];
    
    
    [self.navigationController.view addSubview:loginView];
    [loginView release];
    [self.navigationController.view bringSubviewToFront:loginView];
    
}
- (IBAction)LoginBtnAction 
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    
    UIView *loginView = [self.navigationController.view viewWithTag:LOGIN_VIEW_TAG];
    UITextField *txtloginId = (UITextField*)[loginView viewWithTag:LOGIN_TEXTFIELD_TAG];
    
    // txtloginId.text = source.text;
    self.appLoginId = txtloginId.text;
    self.isGuest = YES;
	
	[self doLogin]; //call displayLoginDetails synchronously
	//[self displayGuestDetail]; //instead of this called doLogin
    
	if ([txtloginId.text length] == 0) {
		
		UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter Guest ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
        
	}
    else if ([self.guestNameArray count] == 0) {
        
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter correct Guest ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
        
        
    }
    else
    {
        
        //[DSBezelActivityView newActivityViewForView:self.navigationController.view];
        [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
        [self performSelector:@selector(stopActivityIndicator)];
        
	}
    
}

-(void)startStandardActivityLoadingView:(UIView*)parentView
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    
    if(self.sharedActivitiView != nil)
    {
        self.sharedActivitiView.hidden = NO;
    }
    //DSActivityView *tempView =  [DSBezelActivityView newActivityViewForView:parentView];
    //[DSBezelActivityView newActivityViewForView:self.window];
    [pool release];
}

-(void)stopStandardActivityLoadingView
{
     NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    //[DSBezelActivityView removeViewAnimated:YES];
    if(self.sharedActivitiView != nil)
    {
        self.sharedActivitiView.hidden = YES;
    }
    [pool release];
}

-(void)startAct
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    //[DSBezelActivityView newActivityViewForView:self.navigationController.view];
    [self startStandardActivityLoadingView:self.navigationController.view];
    [pool release];
}

-(void)dateAndtimeSetup
{
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm a"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *theTime = [timeFormat stringFromDate:now];
 
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:TIME_LABEL_TAG] setText:theTime];
    [timeFormat release];
    [now release];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"dd-MMM-yyy"];
    // date = [formatter dateFromString:@"Apr 7, 2011"];
    // NSLog(@"%@", [formatter stringFromDate:date]);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
    //  NSInteger month=[components month];       // if necessary
    NSInteger day = [components day];
    //  NSInteger weekday = [components weekday]; // if necessary
    
    NSDateFormatter *weekDay = [[[NSDateFormatter alloc] init] autorelease];
    [weekDay setDateFormat:@"EEE"];
    
    NSDateFormatter *calMonth = [[[NSDateFormatter alloc] init] autorelease];
    [calMonth setDateFormat:@"MMM"];
    
    NSLog(@"%@ %i %@ %i", [weekDay stringFromDate:date], day, [calMonth stringFromDate:date], year );
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:DATE_LABEL_TAG] setText:
     [NSString stringWithFormat:@"%@ %02i %@ %i",[weekDay stringFromDate:date], day, [calMonth stringFromDate:date], year]];    
}

-(void)stopActivityIndicator
{
    self.appLoginId =[(UITextField*)[[self.navigationController.view viewWithTag:LOGIN_VIEW_TAG] viewWithTag:LOGIN_TEXTFIELD_TAG] text];
    self.isGuest = YES;
    [self displayGuestDetail];
    [[self.navigationController.view viewWithTag:LOGIN_VIEW_TAG] removeFromSuperview];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[self stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
-(void)removeLoginView
{
    [self displayGuestDetail];
    [[self.navigationController.view viewWithTag:LOGIN_VIEW_TAG] removeFromSuperview];
}

- (void)weatherAction
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:WEATHER_BUTTON_TAG] setEnabled:NO];
//    [DSBezelActivityView newActivityViewForView:self.navigationController.view];
    //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];    
    [self performSelector:@selector(loadWeatherView:)];
}

- (void)loadWeatherView:(id)sender 
{
    // EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];  
    //[appDel startStandardActivityLoadingView:self.navigationController.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    
    UIView *weatherView= [[UIView alloc]initWithFrame:CGRectMake(294, 56, 713, 702)];
    weatherView.tag = WEATHER_VIEW_TAG;
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,weatherView.frame.size.width,weatherView.frame.size.height)];
    weatherView.backgroundColor = [UIColor clearColor];
    [backImage setImage:[UIImage imageNamed:@"commonpopup.png"]];
    [weatherView addSubview:backImage];
    [backImage release];
    
    UILabel *titleMessage = [[UILabel alloc] initWithFrame:CGRectMake(20,10,213,21)];
	titleMessage.text = @"Local Weather";
	titleMessage.textColor = [UIColor whiteColor];
    titleMessage.font = [UIFont boldSystemFontOfSize:22];
    titleMessage.textAlignment = UITextAlignmentLeft;
	titleMessage.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:titleMessage];
    [titleMessage release];
    
	UILabel *loadingMessage = [[UILabel alloc] initWithFrame:CGRectMake(402,63,287,42)];
	loadingMessage.font = [UIFont boldSystemFontOfSize:35];
	loadingMessage.textAlignment = UITextAlignmentLeft;
	loadingMessage.text = @"London, England";
	loadingMessage.textColor = [UIColor whiteColor];
	loadingMessage.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:loadingMessage];
    [loadingMessage release];
    
    UILabel *todaylbl = [[UILabel alloc] initWithFrame:CGRectMake(503,121,91,27)];
	todaylbl.font = [UIFont boldSystemFontOfSize:22];
	todaylbl.textAlignment = UITextAlignmentRight;
	todaylbl.text = @"Today at";
	todaylbl.textColor = [UIColor whiteColor];
	todaylbl.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:todaylbl];
    [todaylbl release];
    
    UILabel *timelbl = [[UILabel alloc] initWithFrame:CGRectMake(598,122,86,27)];
	timelbl.font = [UIFont fontWithName:@"" size:22];
	timelbl.textAlignment = UITextAlignmentRight;
	timelbl.textColor = [UIColor lightGrayColor];
    timelbl.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:timelbl];
    [timelbl release];
    
    UIImageView *todayImg =[[UIImageView alloc]initWithFrame:CGRectMake(460,180,70,70)];
    todayImg.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:todayImg];
    [todayImg release];
    
    UILabel *maxTodayWeather = [[UILabel alloc] initWithFrame:CGRectMake(555,180,135,70)];
	maxTodayWeather.font = [UIFont boldSystemFontOfSize:60];
	maxTodayWeather.textAlignment = UITextAlignmentLeft;
	maxTodayWeather.textColor = [UIColor whiteColor];
	maxTodayWeather.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:maxTodayWeather];
    [maxTodayWeather release];
    
    UILabel *dayFirst = [[UILabel alloc] initWithFrame:CGRectMake(70,344,65,30)];
	dayFirst.font = [UIFont boldSystemFontOfSize:22];
	dayFirst.textAlignment = UITextAlignmentLeft;
    dayFirst.text = @"Today";
	dayFirst.textColor = [UIColor whiteColor];
	dayFirst.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayFirst];
    [dayFirst release];
    
    UILabel *daySecond = [[UILabel alloc] initWithFrame:CGRectMake(180,344,120,30)];
	daySecond.font = [UIFont boldSystemFontOfSize:22];
	daySecond.textAlignment = UITextAlignmentLeft;
	daySecond.textColor = [UIColor whiteColor];
	daySecond.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:daySecond];
    [daySecond release];
    
    UILabel *dayThird = [[UILabel alloc] initWithFrame:CGRectMake(315,344,120,30)];
	dayThird.font = [UIFont boldSystemFontOfSize:22];
	dayThird.textAlignment = UITextAlignmentLeft;
	dayThird.textColor = [UIColor whiteColor];
	dayThird.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayThird];
    [dayThird release];
    
    UILabel *dayFour = [[UILabel alloc] initWithFrame:CGRectMake(450,344,120,30)];
	dayFour.font = [UIFont boldSystemFontOfSize:22];
	dayFour.textAlignment = UITextAlignmentLeft;
	dayFour.textColor = [UIColor whiteColor];
	dayFour.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayFour];
    [dayFour release];
    
    UILabel *dayFive = [[UILabel alloc] initWithFrame:CGRectMake(585,344,120,30)];
	dayFive.font = [UIFont boldSystemFontOfSize:22];
	dayFive.textAlignment = UITextAlignmentLeft;
	dayFive.textColor = [UIColor whiteColor];
	dayFive.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayFive];
    [dayFive release];
    
    UIImageView *firstImage =[[UIImageView alloc]initWithFrame:CGRectMake(70,383,70,70)];
    firstImage.backgroundColor = [UIColor clearColor];
    [firstImage setImage:[UIImage imageNamed:@""]];
    [weatherView addSubview:firstImage];
    [firstImage release];
    
    UIImageView *secondImage =[[UIImageView alloc]initWithFrame:CGRectMake(205,383,70,70)];
    secondImage.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:secondImage];
    [secondImage release];
    
    UIImageView *thirdImage =[[UIImageView alloc]initWithFrame:CGRectMake(340,383,70,70)];
    thirdImage.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:thirdImage];
    [thirdImage release];
    
    UIImageView *fourthImage =[[UIImageView alloc]initWithFrame:CGRectMake(475,383,70,70)];
    fourthImage.backgroundColor = [UIColor clearColor];
    [fourthImage setImage:[UIImage imageNamed:@""]];
    [weatherView addSubview:fourthImage];
    [fourthImage release];
    
    UIImageView *fifthImage =[[UIImageView alloc]initWithFrame:CGRectMake(610,383,70,70)];
    fifthImage.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:fifthImage];
    [fifthImage release];
    
    UILabel *firstMaxC = [[UILabel alloc] initWithFrame:CGRectMake(70,460,70,31)];
  	firstMaxC.font = [UIFont boldSystemFontOfSize:26];
	firstMaxC.textAlignment = UITextAlignmentLeft;
	firstMaxC.textColor = [UIColor whiteColor];
	firstMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:firstMaxC];
    [firstMaxC release];
    
    UILabel *secondMaxC = [[UILabel alloc] initWithFrame:CGRectMake(205,460,70,31)];
	secondMaxC.font = [UIFont boldSystemFontOfSize:26];
	secondMaxC.textAlignment = UITextAlignmentLeft;
	secondMaxC.textColor = [UIColor whiteColor];
	secondMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:secondMaxC];
    [secondMaxC release];
    
    UILabel *thirdMaxC = [[UILabel alloc] initWithFrame:CGRectMake(340,460,70,31)];
	thirdMaxC.font = [UIFont boldSystemFontOfSize:26];
	thirdMaxC.textAlignment = UITextAlignmentLeft;
	thirdMaxC.textColor = [UIColor whiteColor];
	thirdMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:thirdMaxC];
    [thirdMaxC release];
    
    UILabel *fourthMaxC = [[UILabel alloc] initWithFrame:CGRectMake(475,460,70,31)];
	fourthMaxC.font = [UIFont boldSystemFontOfSize:26];
	fourthMaxC.textAlignment = UITextAlignmentLeft;
	fourthMaxC.textColor = [UIColor whiteColor];
	fourthMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fourthMaxC];
    [fourthMaxC release];
    
    UILabel *fifthMaxC = [[UILabel alloc] initWithFrame:CGRectMake(610,460,70,31)];
	fifthMaxC.font = [UIFont boldSystemFontOfSize:26];
	fifthMaxC.textAlignment = UITextAlignmentLeft;
	fifthMaxC.textColor = [UIColor whiteColor];
	fifthMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fifthMaxC];
    [fifthMaxC release];
    
    UILabel *firstMinC = [[UILabel alloc] initWithFrame:CGRectMake(70,500,70,31)];
  	firstMinC.font = [UIFont boldSystemFontOfSize:26];
	firstMinC.textAlignment = UITextAlignmentLeft;
	firstMinC.textColor = [UIColor whiteColor];
	firstMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:firstMinC];
    [firstMinC release];
    
    UILabel *secondMinC = [[UILabel alloc] initWithFrame:CGRectMake(205,500,70,31)];
	secondMinC.font = [UIFont boldSystemFontOfSize:26];
	secondMinC.textAlignment = UITextAlignmentLeft;
	secondMinC.textColor = [UIColor whiteColor];
	secondMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:secondMinC];
    [secondMinC release];
    
    UILabel *thirdMinC = [[UILabel alloc] initWithFrame:CGRectMake(340,500,70,31)];
	thirdMinC.font = [UIFont boldSystemFontOfSize:26];
	thirdMinC.textAlignment = UITextAlignmentLeft;
	thirdMinC.textColor = [UIColor whiteColor];
	thirdMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:thirdMinC];
    [thirdMinC release];
    
    UILabel *fourthMinC = [[UILabel alloc] initWithFrame:CGRectMake(475,500,70,31)];
	fourthMinC.font = [UIFont boldSystemFontOfSize:26];
	fourthMinC.textAlignment = UITextAlignmentLeft;
	fourthMinC.textColor = [UIColor whiteColor];
	fourthMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fourthMinC];
    [fourthMinC release];
    
    UILabel *fifthMinC = [[UILabel alloc] initWithFrame:CGRectMake(610,500,70,31)];
	fifthMinC.font = [UIFont boldSystemFontOfSize:26];
	fifthMinC.textAlignment = UITextAlignmentLeft;
	fifthMinC.textColor = [UIColor whiteColor];
	fifthMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fifthMinC];
    [fifthMinC release];
    /*
     UIImageView *upArrayImage =[[UIImageView alloc]initWithFrame:CGRectMake(20,465,36,28)];
     upArrayImage.backgroundColor = [UIColor clearColor];
     [upArrayImage setImage:[UIImage imageNamed:@"maxweather.png"]];
     [weatherView addSubview:upArrayImage];
     
     UIImageView *downArrayImage =[[UIImageView alloc]initWithFrame:CGRectMake(20,505,36,28)];
     downArrayImage.backgroundColor = [UIColor clearColor];
     [downArrayImage setImage:[UIImage imageNamed:@"minweather.png"]];
     [weatherView addSubview:downArrayImage];
     */
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(removeWeatherView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(680,0,33, 36);
    closeBtn.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:closeBtn];
    [self.navigationController.view addSubview:weatherView];
    
    UILabel *lblline1 = [[UILabel alloc] initWithFrame:CGRectMake(170,344,1,182)];
	lblline1.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline1];
    [lblline1 release];
    
    UILabel *lblline2 = [[UILabel alloc] initWithFrame:CGRectMake(305,344,1,182)];
	lblline2.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline2];
    [lblline2 release];
    
    UILabel *lblline3 = [[UILabel alloc] initWithFrame:CGRectMake(440,344,1,182)];
	lblline3.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline3];
    [lblline3 release];
    
    UILabel *lblline4 = [[UILabel alloc] initWithFrame:CGRectMake(575,344,1,182)];
	lblline4.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline4];
    [lblline4 release];
    
    [weatherView release];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm:a"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    timelbl.text = theTime;
    [timeFormat release];
    [now release];
    
    NSMutableDictionary *dict1 = [self.currentArray objectAtIndex:0];
    NSArray *tweets1 = [[dict1 objectForKey:@"weatherIconUrl"] valueForKey:@"value"];
    
    maxTodayWeather.text = [NSString stringWithFormat:@"%@°C",[dict1 valueForKey:@"temp_C"]];
    
    NSURL *url1 = [NSURL URLWithString:[tweets1 objectAtIndex:0]];  
    NSData *dt = [NSData dataWithContentsOfURL:url1];  
    [todayImg setImage:[UIImage imageWithData:dt]];
    
    // NSDate *today = [NSDate date];
    self.gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
    NSDictionary *dict;
    
    for (int b=0; b<[self.dataArray count]; b++) {
        
        dict = [self.dataArray objectAtIndex:b];
        
        NSArray *tweets = [[dict objectForKey:@"weatherIconUrl"] valueForKey:@"value"];
        
        switch (b) 
        {
            case 0:
                
                firstMaxC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMaxC"]];
                firstMinC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMinC"]];
                
                NSURL *url1 = [NSURL URLWithString:[tweets objectAtIndex:0]];  
                NSData *dt1 = [NSData dataWithContentsOfURL:url1];  
                [firstImage setImage:[UIImage imageWithData:dt1]];
                break;
                
            case 1:
                
                secondMaxC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMaxC"]];
                secondMinC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMinC"]];
                
                NSDateComponents *componentsToAdd = [gregorian components:NSDayCalendarUnit fromDate:[NSDate date]];
                [componentsToAdd setDay:1];
                NSDate *endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
                
                NSDateFormatter *theDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
                [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
                [theDateFormatter setDateFormat:@"EEEE"];
                NSString *weekDay = [theDateFormatter stringFromDate:endOfWeek];
                daySecond.text = weekDay;
                
                NSURL *url2 = [NSURL URLWithString:[tweets objectAtIndex:0]];  
                NSData *dt2 = [NSData dataWithContentsOfURL:url2];  
                [secondImage setImage:[UIImage imageWithData:dt2]];
                
                break;
            case 2:
                
                thirdMaxC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMaxC"]];
                thirdMinC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMinC"]];  
                
                componentsToAdd = [gregorian components:NSDayCalendarUnit fromDate:[NSDate date]];
                [componentsToAdd setDay:2];
                endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
                
                theDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
                [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
                [theDateFormatter setDateFormat:@"EEEE"];
                weekDay =  [theDateFormatter stringFromDate:endOfWeek];
                dayThird.text = weekDay;
                
                NSURL *url3 = [NSURL URLWithString:[tweets objectAtIndex:0]];  
                NSData *dt3 = [NSData dataWithContentsOfURL:url3];  
                [thirdImage setImage:[UIImage imageWithData:dt3]];
                
                break;
                
            case 3:
                
                fourthMaxC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMaxC"]];
                fourthMinC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMinC"]]; 
                
                componentsToAdd = [gregorian components:NSDayCalendarUnit fromDate:[NSDate date]];
                [componentsToAdd setDay:3];
                endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
                
                theDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
                [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
                [theDateFormatter setDateFormat:@"EEEE"];
                weekDay =  [theDateFormatter stringFromDate:endOfWeek];
                dayFour.text = weekDay;
                
                NSURL *url4 = [NSURL URLWithString:[tweets objectAtIndex:0]];  
                NSData *data4 = [NSData dataWithContentsOfURL:url4];  
                [fourthImage setImage:[UIImage imageWithData:data4]];                
                break;
            case 4:
                
                fifthMaxC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMaxC"]];
                fifthMinC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMinC"]]; 
                
                componentsToAdd = [gregorian components:NSDayCalendarUnit fromDate:[NSDate date]];
                [componentsToAdd setDay:4];
                endOfWeek = [gregorian dateByAddingComponents:componentsToAdd toDate:[NSDate date] options:0];
                
                theDateFormatter = [[[NSDateFormatter alloc] init] autorelease];
                [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
                [theDateFormatter setDateFormat:@"EEEE"];
                weekDay =  [theDateFormatter stringFromDate:endOfWeek];
                dayFive.text = weekDay;
                
                NSURL *url5 = [NSURL URLWithString:[tweets objectAtIndex:0]];  
                NSData *data5 = [NSData dataWithContentsOfURL:url5];  
                [fifthImage setImage:[UIImage imageWithData:data5]];
                break;
                
            default:
                break;
        }
        
    }
    
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

-(void)stopAct
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate]; 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [appDel stopStandardActivityLoadingView];
    [pool release];
}

-(void)removeWeatherView:(id)sender 
{   
    self.gregorian = nil;
    
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:WEATHER_BUTTON_TAG] setEnabled:YES];
    [[self.navigationController.view viewWithTag:WEATHER_VIEW_TAG] removeFromSuperview];
}


- (void)messageAction
{
//    [DSBezelActivityView newActivityViewForView:self.navigationController.view];    
    [self performSelector:@selector(loadMessageView:)];
}

- (void)loadMessageView:(id)sender{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    //[appDel startStandardActivityLoadingView:self.navigationController.view];
    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    
     if(self.isActive == NO)
     {
         UIAlertView *alrtView = [[UIAlertView alloc] initWithTitle:@"Notification Alert" message:@"Please login to check your notifications." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [alrtView show];
         [alrtView release];
         
         return;
     }
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self.navigationController popToRootViewControllerAnimated:NO];
    MessageView *aMessageView = [[MessageView alloc]initWithNibName:@"MessageView" bundle:nil];
    [self.navigationController pushViewController:aMessageView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];	
}

- (void)displayGuestDetail
{
     if (self.isGuest == YES) 
     {
         [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setEnabled:NO];
    	[self getGuestDetails];
     }
     else
     {
        [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setEnabled:YES];
        [(UILabel*)[self.navigationController.navigationBar viewWithTag:GUEST_LABEL_TAG] setText:@"Welcome, Guest"];
        [(UILabel*)[self.navigationController.navigationBar viewWithTag:ID_LABEL_TAG] setText:@""];
       
    }
}
- (void)logOutButtonClick
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:@"Message" message:@"Do you want to log out?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release];    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{        
    if (buttonIndex == 1)
    {
        [self doLogOutStuff];
    }
}

-(void)doLogOutStuff
{
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGOUT_BUTTON_TAG] setHidden:YES];
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setEnabled:YES];
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setHidden:NO];
    self.isGuest = NO;
    self.isActive = NO;
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:GUEST_LABEL_TAG] setText:@"Welcome, Guest"];
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:ID_LABEL_TAG] setText:@""];     
    
    //post notification			
    NSNotification *loggedOut = [NSNotification notificationWithName:[NotificationNames notificationNameForLoggedin] object:nil];
    
    [[NSNotificationQueue defaultQueue] enqueueNotification:loggedOut postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil]; 
    
    
    if([self.navigationController.topViewController isKindOfClass:[MessageView class]] == YES)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    [self setCustomBadge];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	
	NSString *resultingString = [textField.text stringByReplacingCharactersInRange: range withString: string];
	
	// The user deleting all input is perfectly acceptable.
	if ([resultingString length] == 0) {
		return true;
	}
	
	NSInteger holder;
	
	NSScanner *scan = [NSScanner scannerWithString: resultingString];
	
	return [scan scanInteger: &holder] && [scan isAtEnd];
}

- (void) applicationDidTimeout:(NSNotification *) notif 
{
    //Logout code
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGOUT_BUTTON_TAG] setHidden:YES];
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setEnabled:YES];
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setHidden:NO];
    self.isGuest = NO;
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:GUEST_LABEL_TAG] setText:@"Welcome, Guest"];
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:ID_LABEL_TAG] setText:@""];
    
    [self setCustomBadge];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Session TimeOut" message:@"You have been logged out due to session time out." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}
//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    BOOL connectionRequired= [curReach connectionRequired];
    //NSString* statusString= @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            //statusString = @"Access Not Available";
            //imageView.image = [UIImage imageNamed: @"stop-32.png"] ;
            //Minor interface detail- connectionRequired may return yes, even when the host is unreachable.  We cover that up here...
            connectionRequired= NO;  
            isNetworkAvailable = NO;
            break;
        }
            
        case ReachableViaWWAN:
        {
            //statusString = @"Reachable WWAN";
            //imageView.image = [UIImage imageNamed: @"WWAN5.png"];
            isNetworkAvailable = YES;
            break;
        }
        case ReachableViaWiFi:
        {
            //statusString= @"Reachable WiFi";
            //imageView.image = [UIImage imageNamed: @"Airport.png"];
            isNetworkAvailable = YES;
            break;
        }
    }
    if(connectionRequired)
    {
        isNetworkAvailable = NO;
        //statusString= [NSString stringWithFormat: @"%@, Connection Required", statusString];
    }
    
    if(isNetworkAvailable == NO)
    {
        self.isActive = NO;
        [self doProcessWhenNetworkGoesDown];
    }
}

-(void)doLogin //this method is introdiced to replace redudant login code
{    
    if (isGuest == YES) 
	{        
        //loginBtn.enabled=NO;
        NSMutableDictionary *response = [BKAPIClient loadGuestDetail:self.appLoginId];
	
        self.guestNameArray = [response valueForKey:@"guest_name"];
        self.guestIdArray = [response valueForKey:@"room_no"];
        self.guestStatusArray = [response valueForKey:@"guest_active"];

        //now get guest details
        //[self getGuestDetails];    
              
	}
}

-(void)getGuestDetails //this will be called when each screen appears, mainly to check if guest is active or not
{    
    
   //NSMutableDictionary *response = [BKAPIClient loadGuestDetail:appDelegate.appLoginId];
    if (isNetworkAvailable)
    {
        AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetGuestDetails:appLoginId] delegate:self methodName:@"getGuestDetails"  responseDataFormat:nil]; // nil == JSON by default
        [dataDownloader startDownloading];
        [dataDownloader release];		
    }
}

- (void)messageService {
    
    if (isGuest == YES && isActive == YES) {
        
        //[unreadArray removeAllObjects]; //moved to didFinishLoading
        if (isNetworkAvailable)
        {
            AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetGuestMessageNotificationForGuestId:appLoginId] delegate:self methodName:@"messageService"  responseDataFormat:nil]; // nil == JSON by default
            [dataDownloader startDownloading];
            [dataDownloader release];
        }
    }
	else
	{
        NSMutableDictionary *response1 = [BKAPIClient guestMessageNotification:@"No"];
        self.messageArray = [response1 valueForKey:@"message_title"];
        self.detailArray = [response1 valueForKey:@"message_detail"];
    }
    
}

#pragma mark -
#pragma mark AsyncDownloader Delegate Methods

-(void)didFinishDownloadingAsyncDownloaderInJson:(NSString *)jsonString ForMethod:(NSString *)methodName
{
	//Process for displayAddImage
	if([methodName isEqualToString:@"messageService"])
	{
		if(jsonString != nil)
		{
			NSMutableDictionary *response = (NSMutableDictionary *)[jsonString JSONValue];
			
			[unreadArray removeAllObjects];
			self.tIdArray = [response valueForKey:@"tid"];
			self.messageArray = [response valueForKey:@"menu_name"];
			self.detailArray = [response valueForKey:@"message_detail"];
			self.rTimeArray = [response valueForKey:@"requested_time"];
			self.cTimeArray = [response valueForKey:@"completed_time"];
			self.statusArray = [response valueForKey:@"status"];
			self.readUnreadArray = [response valueForKey:@"read_status"];
			
			for (int i=0; i<[readUnreadArray count]; i++) {
				
				NSString *mgsStatus = [readUnreadArray objectAtIndex:i];
				
				if ([mgsStatus isEqualToString:@"u"]) {
					
					[unreadArray addObject:[readUnreadArray objectAtIndex:i]];
				}
			}
			//post notification			
			NSNotification *badgeNotification = [NSNotification notificationWithName:[NotificationNames notificationNameForCustomBadgeUpdate] object:nil];
            
			[[NSNotificationQueue defaultQueue] enqueueNotification:badgeNotification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes:nil];
		}
	}
	else if([methodName isEqualToString:@"getGuestDetails"])
	{
		if(jsonString != nil)
		{
			NSMutableDictionary *response = (NSMutableDictionary *)[jsonString JSONValue];
			
			self.guestNameArray = [response valueForKey:@"guest_name"];
			self.guestIdArray = [response valueForKey:@"room_no"];
			self.guestStatusArray = [response valueForKey:@"guest_active"];
			self.isActive = YES;
            
            //post notification			
            NSNotification *loggedIn = [NSNotification notificationWithName:[NotificationNames notificationNameForLoggedin] object:nil];
            
            [[NSNotificationQueue defaultQueue] enqueueNotification:loggedIn postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil]; 
            
			//post notification			
			NSNotification *guestDetailsNotification = [NSNotification notificationWithName:[NotificationNames notificationNameForGuestDetails] object:nil];
			[[NSNotificationQueue defaultQueue] enqueueNotification:guestDetailsNotification postingStyle:NSPostWhenIdle coalesceMask:NSNotificationCoalescingOnName forModes:nil];            

		}
	}
    /*
	else if([methodName isEqualToString:@"loadSubMenuWebService2"])
	{
		if(jsonString != nil)
		{
			NSArray *response = (NSArray *)[jsonString JSONValue];
            NSLog(@"%@",[response description]);
            
            for (int i = 0; i<[response count]; i++)
            {
                SubMenuServiceModel *model = [[SubMenuServiceModel alloc]init];
                model.serviceName = [[response objectAtIndex:i] valueForKey:@"services_name"];
                model.serviceId = [[response objectAtIndex:i] valueForKey:@"services_id"];
                model.imgUrl = [[response objectAtIndex:i] valueForKey:@"image"];
                model.requestText = [[response objectAtIndex:i] valueForKey:@"request_text"];
                
                [roomServiceArray addObject:model];
                [model release];
            }
           		}
	}
	else if([methodName isEqualToString:@"loadSubMenuWebService3"])
	{
		if(jsonString != nil)
		{
            NSArray *response = (NSArray *)[jsonString JSONValue];
            NSLog(@"%@",[response description]);
            
            for (int i = 0; i<[response count]; i++)
            {
                SubMenuServiceModel *model = [[SubMenuServiceModel alloc]init];
                model.serviceName = [[response objectAtIndex:i] valueForKey:@"services_name"];
                model.serviceId = [[response objectAtIndex:i] valueForKey:@"services_id"];
                model.imgUrl = [[response objectAtIndex:i] valueForKey:@"image"];
                model.requestText = [[response objectAtIndex:i] valueForKey:@"request_text"];
                
                [houseKeepingArray addObject:model];
                [model release];
            }

            		}
	}
	else if([methodName isEqualToString:@"loadSubMenuWebService5"])
	{
		if(jsonString != nil)
		{
            NSArray *response = (NSArray *)[jsonString JSONValue];
            NSLog(@"%@",[response description]);
            
            for (int i = 0; i<[response count]; i++)
            {
                SubMenuServiceModel *model = [[SubMenuServiceModel alloc]init];
                model.serviceName = [[response objectAtIndex:i] valueForKey:@"services_name"];
                model.serviceId = [[response objectAtIndex:i] valueForKey:@"services_id"];
                model.imgUrl = [[response objectAtIndex:i] valueForKey:@"image"];
                model.requestText = [[response objectAtIndex:i] valueForKey:@"request_text"];
                
                [travelDeskArray addObject:model];
                [model release];
            }

            		}
	}
	else if([methodName isEqualToString:@"loadSubMenuWebService6"])
	{
		if(jsonString != nil)
		{
           
            NSArray *response = (NSArray *)[jsonString JSONValue];
            NSLog(@"%@",[response description]);
            
            for (int i = 0; i<[response count]; i++)
            {
                SubMenuServiceModel *model = [[SubMenuServiceModel alloc]init];
                model.serviceName = [[response objectAtIndex:i] valueForKey:@"services_name"];
                model.serviceId = [[response objectAtIndex:i] valueForKey:@"services_id"];
                model.imgUrl = [[response objectAtIndex:i] valueForKey:@"image"];
                             
                [hotelInformationArray addObject:model];
                [model release];
            }

		}
	}
     */
	
}

-(void)didFailAsyncDownloaderWithError:(NSError *)error ForMethod:(NSString *)methodName
{
	//Process for messageService
	if([methodName isEqualToString:@"messageService"])
	{
                [self showTimeOutAlert];
		NSLog(@"HomeView-didFailAsyncDownloaderWithError- Request Failed for Method = %@",methodName);
	}
	
}

- (void)loadSubMenuWebService{
    
	
	/*
    dictionary2 = [BKAPIClient loadSubMenuView:@"2"];
    dictionary3 = [BKAPIClient loadSubMenuView:@"3"];
    dictionary5 = [BKAPIClient loadSubMenuView:@"5"]; 
    dictionary6 = [BKAPIClient loadSubMenuView:@"6"];
   
	 //Moved to didFinishLoading
    self.menuNameArray2  = [dictionary2 valueForKey:@"services_name"];
	self.menuImageArray2 = [dictionary2 valueForKey:@"image"];
    self.serviceId2 = [dictionary2 valueForKey:@"services_id"];
    self.requestArray2 = [dictionary2 valueForKey:@"request_text"]; 
    
    self.menuNameArray3  = [dictionary3 valueForKey:@"services_name"];
	self.menuImageArray3 = [dictionary3 valueForKey:@"image"];
    self.serviceId3 = [dictionary3 valueForKey:@"services_id"];
    self.requestArray3 = [dictionary3 valueForKey:@"request_text"]; 
    
    self.menuNameArray5  = [dictionary5 valueForKey:@"services_name"];
	self.menuImageArray5 = [dictionary5 valueForKey:@"image"];
    self.serviceId5 = [dictionary5 valueForKey:@"services_id"];
    self.requestArray5 = [dictionary5 valueForKey:@"request_text"]; 
    
    self.menuNameArray6  = [dictionary6 valueForKey:@"services_name"];
	self.menuImageArray6 = [dictionary6 valueForKey:@"image"];
    self.serviceId6 = [dictionary6 valueForKey:@"services_id"];
	*/
	/*
	AsyncDownloader *dataDownloader2 = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetSubMenuDetails:@"2"] delegate:self methodName:@"loadSubMenuWebService2"  responseDataFormat:nil]; // nil == JSON by default
	[dataDownloader2 startDownloading];
	[dataDownloader2 release];
	
	AsyncDownloader *dataDownloader3 = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetSubMenuDetails:@"3"] delegate:self methodName:@"loadSubMenuWebService3"  responseDataFormat:nil]; // nil == JSON by default
	[dataDownloader3 startDownloading];
	[dataDownloader3 release];
	
	AsyncDownloader *dataDownloader5 = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetSubMenuDetails:@"5"] delegate:self methodName:@"loadSubMenuWebService5"  responseDataFormat:nil]; // nil == JSON by default
	[dataDownloader5 startDownloading];
	[dataDownloader5 release];
	
	AsyncDownloader *dataDownloader6 = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetSubMenuDetails:@"6"] delegate:self methodName:@"loadSubMenuWebService6"  responseDataFormat:nil]; // nil == JSON by default
	[dataDownloader6 startDownloading];
	[dataDownloader6 release];
*/
}

- (void)loadWebService{
    
    NSMutableDictionary *response1 = [BKAPIClient loadBackgroundImage];
	//NSLog([NSString stringWithFormat:@"%@",response1]);
	NSURL *url1 = [NSURL URLWithString:[response1 objectForKey:@"himage"]];  
    self.data = [NSData dataWithContentsOfURL:url1];  
    
    NSMutableDictionary *response = [BKAPIClient loadHetelLogo];
	//NSLog([NSString stringWithFormat:@"%@",response]);
    NSURL *url = [NSURL URLWithString:[response objectForKey:@"hlogo"]];  
    self.data1 = [NSData dataWithContentsOfURL:url]; 
    
    NSMutableDictionary *response2 = [BKAPIClient loadgradientImage];
   // NSLog([NSString stringWithFormat:@"%@",response2]);
    NSURL *url2 = [NSURL URLWithString:[response2 objectForKey:@"gimage"]];  
    self.data2 = [NSData dataWithContentsOfURL:url2]; 
    
    NSMutableDictionary *response3 = [[BKAPIClient loadWeatherAPI] objectForKey:@"data"];
    self.dataArray = [response3 objectForKey:@"weather"];
    self.currentArray = [response3 objectForKey:@"current_condition"];
    
    NSMutableDictionary *response4 = [BKAPIClient setCurrenncy];
    self.currency = [response4 objectForKey:@"currency"];
    [currency retain];
    
  // NSLog([NSString stringWithFormat:@"%@",currency]);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
    

               
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    if (isNetworkAvailable)
    {
        if(!(data != nil && data1 != nil && data2 != nil && self.dataArray != nil && self.currentArray != nil && currency != nil))
        {
            [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
            //if all above are nil, try to load data again
            [self loadWebService];
            [self.navigationController popToRootViewControllerAnimated:YES];
           [(HomeView*)[self.navigationController.viewControllers objectAtIndex:0] loadHomeView];
           [(HomeView*)[self.navigationController.viewControllers objectAtIndex:0] displayAddImage];  
            [NSThread detachNewThreadSelector:@selector(stopActivityIndicator) toTarget:self withObject:nil];
        }
    }    
}

-(void)doProcessWhenNetworkGoesDown
{
    //doLogOutStuff
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGOUT_BUTTON_TAG] setHidden:YES];
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setEnabled:YES];
    [(UIButton*)[self.navigationController.navigationBar viewWithTag:LOGIN_BUTTON_TAG] setHidden:NO];
    self.isGuest = NO;
    self.isActive = NO;
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:GUEST_LABEL_TAG] setText:@"Welcome, Guest"];
    [(UILabel*)[self.navigationController.navigationBar viewWithTag:ID_LABEL_TAG] setText:@""];     
    [self setCustomBadge];       
    
    //post notification			
    NSNotification *loggedOut = [NSNotification notificationWithName:[NotificationNames notificationNameForLoggedin] object:nil];
    
    [[NSNotificationQueue defaultQueue] enqueueNotification:loggedOut postingStyle:NSPostNow coalesceMask:NSNotificationCoalescingOnName forModes:nil]; 
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self showNetworkUnavailableError];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

-(void)showNetworkUnavailableError
{
    if(self.networkErrorAlert != nil)
    {
        if(self.networkErrorAlert.isVisible)
            return;
        [self.networkErrorAlert show];
    }
    else
    {
        self.networkErrorAlert = [[[UIAlertView alloc] initWithTitle:@"Network Error" message:@"Could not connect to server. Please check your network availability." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [self.networkErrorAlert show];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }    
}
-(void)startDefaultActIndicatorForView:(UIView*)view
{
    self.defaultActIndicator.frame = CGRectMake(view.frame.size.width/2, view.frame.size.height/2, 30, 30);
    [view addSubview:self.defaultActIndicator];
    [self.defaultActIndicator startAnimating];
    [view bringSubviewToFront:self.defaultActIndicator];
}
-(void)stopDefaultActIndicator
{
    [self.defaultActIndicator stopAnimating];
    [self.defaultActIndicator removeFromSuperview];
}
-(void)showTimeOutAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Request Timeout" message:@"Unable to connect to the server." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    [alert release];
}
- (void)dealloc {
    
    [window release];
	[guestNameArray release];
	[guestIdArray release];
    [guestStatusArray release];
    [logoArray release];
    [backgroundArray release];

    [adImageArray release];
    [firstTextArray release];
    [secondTextArray release];
    
    [adImageArray1 release];
    [firstTextArray1 release];
    [secondTextArray1 release];
	[appLoginId release];
    
    [deviceName release];
    [systemName release];
    [systemVersion release];
    [systemModel release];
    [localizedModel release];
   
    [serviceIdArray release];
    [nameArray release];
    [sortDetailArray release];
    [longDetailArray release];
    [imageArray release];
    [rateArray release];
    [quantityArray release];
    
    [serviceIdArray1 release];
    [nameArray1 release];
    [sortDetailArray1 release];
    [longDetailArray1 release];
    [imageArray1 release];
    [rateArray1 release];
    [quantityArray1 release];
    
    [serviceIdArray2 release];
    [nameArray2 release];
    [sortDetailArray2 release];
    [longDetailArray2 release];
    [imageArray2 release];
    [rateArray2 release];
    [quantityArray2 release];
    
    [totalArray release];
    [totalArray1 release];
    [totalArray2 release];
    
    [unreadArray release];
    [messageArray release];
	[detailArray release];
    [cTimeArray release];
    [rTimeArray release];
    [statusArray release];
    [readUnreadArray release];
    [tIdArray release];
    /*
    [menuNameArray2 release];
    [serviceId2 release];
    [menuImageArray2 release];
    [requestArray2 release];
    
    [menuNameArray3 release];
    [serviceId3 release];
    [menuImageArray3 release];
    [requestArray3 release];
    
    [menuNameArray5 release];
    [serviceId5 release];
    [menuImageArray5 release];
    [requestArray5 release];
    
    [menuNameArray6 release];
    [serviceId6 release];
    [menuImageArray6 release];
    */
    [dataArray release];
    [currentArray release];
    [currency release];
    
    [data release];
    [data1 release];
    [data2 release];
    
    [dictionary2 release];
    [dictionary3 release];
    [dictionary4 release];
    [dictionary5 release];
    [dictionary6 release];
    [dictionary7 release];
    [dictionary8 release];
   
    self.roomServiceArray = nil;
    self.houseKeepingArray = nil;
    self.travelDeskArray = nil;
    self.hotelInformationArray = nil;
    self.laundryMenuArray = nil;
    self.inRoomMenuArray = nil;
    self.shoppingMenuArray = nil;
    self.defaultActIndicator = nil;
    [super dealloc];
    
}


@end
