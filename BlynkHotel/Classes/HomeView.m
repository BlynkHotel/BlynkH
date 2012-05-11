    //
//  HomeView.m
//  Eye
//
//  Created by Blynk Systems on 08/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HomeView.h"
#import "RoomServiceView.h"
#import "HouseKeepingView.h"
#import "InRoomServiceView.h"
#import "TravelDeskView.h"
#import "HotelInformationView.h"
#import "LaundryView.h"
#import "ShoppingView.h"
#import "MessageView.h"
#import "EyeAppDelegate.h"
#import "HelpView.h"
#import "CustomBadge.h"
#import "DSActivityView.h"
#import "BKAPIClient.h"
#import "AsyncImageView.h"
#import "proAlertView.h"
#import "URLRequestGenerator.h"
#import "NotificationNames.h"

@implementation HomeView
@synthesize menuNameArray,menuImageArray,addImageArray,smallTextArray,bigTextArray,menuIdArray;
@synthesize templateTypeArray,requestArray;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [self loadHomeView];
}

-(void)loadHomeView
{
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    
	menuNameArray = [[NSMutableArray alloc]init];
	menuImageArray = [[NSMutableArray alloc]init];
    menuIdArray = [[NSMutableArray alloc]init];
    addImageArray = [[NSMutableArray alloc]init];
    templateTypeArray = [[NSMutableArray alloc]init];
    requestArray = [[NSMutableArray alloc]init];
    
    //    aAlertView = [[UIView alloc]initWithFrame:CGRectMake(294,12,713,702)];
    lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(100,100,550,250)];
    
    [backImageView setImage:[UIImage imageWithData:appDelegate.data]]; //data == himage, loaded in appdel -> loadWebService
    [logoView setImage:[UIImage imageWithData:appDelegate.data1]];	//data1 == hlogo, loaded in appdel -> loadWebService
    
	[self displayHomeView];
    [self displayBottomAdd];
    [self displaySideAdd];
    //    [self displayLogout];
    
    //    helpBtn.hidden=YES;
    //    logOutBtn.hidden=YES;
    //    loginBtn.hidden=NO;
    //    self.navigationController.navigationBarHidden = YES;
    
    self.title = @"Home";
    //    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate displayGuestDetail];
//    [self setCustomBadge];
//    [self displayGuestDetail];
    [self displayAddImage];
    
}
/*
- (void)displayGuestDetail {
    
    appDelegate = [[UIApplication sharedApplication]delegate];
    
    if (appDelegate.isGuest == YES) 
	{         
        //NSMutableDictionary *response = [BKAPIClient loadGuestDetail:appDelegate.appLoginId]; //instead moved to app del, so each class can use common method
		[appDelegate getGuestDetails];
		
		//moved to app del in didFinishLoading del method
//        appDelegate.guestNameArray = [response valueForKey:@"guest_name"];
//        appDelegate.guestIdArray = [response valueForKey:@"room_no"];
//        appDelegate.guestStatusArray = [response valueForKey:@"guest_active"];
        
		
		 //moved to receivedGuestDetails
        if ([appDelegate.guestNameArray count]>0) {
            
            lblGuestName.text = [appDelegate.guestNameArray objectAtIndex:0]; 
            lblGuestId.text = [appDelegate.guestIdArray objectAtIndex:0]; 
            
            if ([[NSString stringWithFormat:@"%@",[appDelegate.guestStatusArray objectAtIndex:0]] isEqualToString:@"Yes"]) {
                
                appDelegate.isActive = YES;
                logOutBtn.hidden = NO;
                [self setCustomBadge];
                
            }else{
                
                appDelegate.isActive = NO;
                loginBtn.enabled=YES;
                logOutBtn.hidden = YES;
                lblGuestName.text =@"Welcome, Guest"; 
                lblGuestId.text =@"";
            }
        }else{
            
            loginBtn.enabled=YES;
            logOutBtn.hidden = YES;
            lblGuestName.text =@"Welcome, Guest"; 
            lblGuestId.text =@"";
        }
		 
    }
	else
	{
        
        lblGuestName.text =@"Welcome, Guest"; 
        lblGuestId.text =@"";
    }
}


-(void)dateAndtimeSetup{
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm a"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    lblTime.text = theTime;
    [timeFormat release];
    [now release];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"dd-mmm-yyy"];
   
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:date];
    NSInteger year = [components year];
 //   NSInteger month=[components month];       // if necessary
    NSInteger day = [components day];
 // NSInteger weekday = [components weekday]; // if necessary
    
    NSDateFormatter *weekDay = [[[NSDateFormatter alloc] init] autorelease];
    [weekDay setDateFormat:@"EEE"];
    
    NSDateFormatter *calMonth = [[[NSDateFormatter alloc] init] autorelease];
    [calMonth setDateFormat:@"MMM"];
    
    NSLog(@"%@ %02i %@ %i",[weekDay stringFromDate:date], day, [calMonth stringFromDate:date], year );
    
    lblDate.text = [NSString stringWithFormat:@"%@ %02i %@ %i",[weekDay stringFromDate:date], day, [calMonth stringFromDate:date], year];
}

- (void)displayLoginView{
    
    loginView = [[UIView alloc]initWithFrame:CGRectMake(294,56,713,702)];
    
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,loginView.frame.size.width,loginView.frame.size.height)];
    loginView.backgroundColor = [UIColor clearColor];
    [backImage setImage:[UIImage imageNamed:@"commonpopup.png"]];
    [loginView addSubview:backImage];
   
    txtloginId = [[UITextField alloc] initWithFrame:CGRectMake(207,73,300,47)];
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
    
	UILabel *loadingMessage = [[UILabel alloc] initWithFrame:CGRectMake(80,264,550,21)];
	loadingMessage.font = [UIFont boldSystemFontOfSize:20];
	loadingMessage.textAlignment = UITextAlignmentCenter;
	loadingMessage.text = @"Guest ID will be provided by Hotel at the time of Check-In";
	loadingMessage.textColor = [UIColor whiteColor];
	loadingMessage.backgroundColor = [UIColor clearColor];
	[loginView addSubview:loadingMessage];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(removeLoginView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(680,0,33, 36);
    closeBtn.backgroundColor = [UIColor clearColor];
    [loginView addSubview:closeBtn];
    [self.view addSubview:loginView];
    
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

- (IBAction)removeLoginView:(id)sender{
    
    loginBtn.enabled=YES;
    [self displayGuestDetail];
    [loginView removeFromSuperview];
}


- (IBAction)LoginBtnAction {
    
    loginBtn.enabled=NO;
   //txtloginId.text = source.text;
    appDelegate.appLoginId = txtloginId.text;
    appDelegate.isGuest = YES;
	
	[appDelegate doLogin]; //call displayLoginDetails synchronously
   //[self displayGuestDetail]; //instead of this called doLogin
    
	if ([txtloginId.text length] == 0) {
		
		UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"" message:@"Enter Guest ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
        
	}
    else if ([appDelegate.guestNameArray count] == 0) {
        
        UIAlertView *alert1 = [[UIAlertView alloc]initWithTitle:@"" message:@"Please enter correct Guest ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert1 show];
		[alert1 release];
        
    }
    else{
        
        [DSBezelActivityView newActivityViewForView:self.view];
        [self performSelector:@selector(stopActivityIndicator) withObject:nil afterDelay:2];
	}
    
}

-(void)stopActivityIndicator{
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.appLoginId = txtloginId.text;
    appDelegate.isGuest = YES;
    [self displayGuestDetail];
    [loginView removeFromSuperview];
    [DSBezelActivityView removeViewAnimated:YES];
}

- (void)displayLogout {
    
    loginBtn.hidden = YES;
    logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    logOutBtn.frame = CGRectMake(80,0,46,46);
    [logOutBtn setImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
    [logOutBtn addTarget:self action:@selector(logOutButtonClick:) forControlEvents:UIControlEventTouchUpInside]; 
    [self.view addSubview:logOutBtn];
}

- (IBAction)logOutButtonClick:(id)sender {
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:@"Message" message:@"Do you want to log out?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release];    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
        if (buttonIndex == 1)
        {
            logOutBtn.hidden = YES;
            loginBtn.enabled = YES;
            loginBtn.hidden = NO;
            appDelegate.isGuest = NO;
            lblGuestName.text =@"Welcome, Guest"; 
            lblGuestId.text =@"";
        }else{
            
        }
}

#pragma mark -
#pragma mark Received Notifications

-(void)receivedGuestDetails
{
	NSLog(@"received notification: receivedGuestDetails");
	if ([appDelegate.guestNameArray count]>0) {
		
		lblGuestName.text = [appDelegate.guestNameArray objectAtIndex:0]; 
		lblGuestId.text = [appDelegate.guestIdArray objectAtIndex:0]; 
		
		if ([[NSString stringWithFormat:@"%@",[appDelegate.guestStatusArray objectAtIndex:0]] isEqualToString:@"Yes"]) {
			
			appDelegate.isActive = YES;
			logOutBtn.hidden = NO;
			[self setCustomBadge];
			
		}else{
			
			appDelegate.isActive = NO;
			loginBtn.enabled=YES;
			logOutBtn.hidden = YES;
			lblGuestName.text =@"Welcome, Guest"; 
			lblGuestId.text =@"";
		}
	}else{
		
		loginBtn.enabled=YES;
		logOutBtn.hidden = YES;
		lblGuestName.text =@"Welcome, Guest"; 
		lblGuestId.text =@"";
	}
}

-(void)customBadgeUpdated
{
	NSLog(@"received notification: customBadgeUpdated");
	customBadge1.hidden = YES;			
	if ([appDelegate.unreadArray count] > 0) 
	{
        
		customBadge1 = [CustomBadge customBadgeWithString:
						[NSString stringWithFormat:@"%d",[appDelegate.unreadArray count]] 
										  withStringColor:[UIColor whiteColor] 
										   withInsetColor:[UIColor redColor] 
										   withBadgeFrame:YES 
									  withBadgeFrameColor:[UIColor whiteColor] 
												withScale:1.0
											  withShining:YES];
		[customBadge1 setFrame:CGRectMake(940,0, customBadge1.frame.size.width, customBadge1.frame.size.height)];
		[self.view addSubview:customBadge1];
	}
}

#pragma mark -
#pragma mark Other Methods

- (void)setCustomBadge{
    
    if(appDelegate.isGuest == YES && appDelegate.isActive == YES) 
	{ 
		appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
		[appDelegate messageService];

		//moved to customBadgeUpdate
		
		customBadge1.hidden = YES;			
		if ([appDelegate.unreadArray count] > 0) 
		{
        
			customBadge1 = [CustomBadge customBadgeWithString:
										[NSString stringWithFormat:@"%d",[appDelegate.unreadArray count]] 
														withStringColor:[UIColor whiteColor] 
														withInsetColor:[UIColor redColor] 
                                                        withBadgeFrame:YES 
                                                   withBadgeFrameColor:[UIColor whiteColor] 
                                                             withScale:1.0
                                                           withShining:YES];
			[customBadge1 setFrame:CGRectMake(940,0, customBadge1.frame.size.width, customBadge1.frame.size.height)];
			[self.view addSubview:customBadge1];
		} 
		

    }
	else
	{
         customBadge1.hidden = YES;
    }    
}
*/
-  (void)displayBottomAdd{
    if (appDelegate.isNetworkAvailable)
    {
        AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetBottomAdDetails:@"4"] delegate:self methodName:@"displayBottomAdd"  responseDataFormat:nil]; // nil == JSON by default
        [dataDownloader startDownloading];
        [dataDownloader release];
    }
    /*
    else 
    {
        [appDelegate showNetworkUnavailableError];
    }
    */
}

- (void)displaySideAdd{
    
  //  NSMutableDictionary *response = [BKAPIClient bottomAdd:@"2"];
	if (appDelegate.isNetworkAvailable)
    {
        AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetBottomAdDetails:@"2"] delegate:self methodName:@"displaySideAdd"  responseDataFormat:nil]; // nil == JSON by default
        [dataDownloader startDownloading];
        [dataDownloader release];
        
    }
    /*
    else 
    {
        [appDelegate showNetworkUnavailableError];
    }
    */
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [myTimer invalidate];
}

- (void)displayAddImage
{
    if (appDelegate.isNetworkAvailable)
    {
        AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[URLRequestGenerator requestToGetAdImageOnHomePage] delegate:self methodName:@"displayAddImage"  responseDataFormat:nil]; // nil == JSON by default
        [dataDownloader startDownloading];
        [dataDownloader release];
    }
    /*
	else 
    {
        [appDelegate showNetworkUnavailableError];
    }
    */
    
	NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    myTimer = theTimer;
}

- (void)changeImage {
    
    if (t<[addImageArray count]) {
    
   // NSLog([NSString stringWithFormat:@"tot:%t",[addImageArray count]]);
    NSURL *url = [NSURL URLWithString:[addImageArray objectAtIndex:t]];
		if (appDelegate.isNetworkAvailable)
        {
            AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self methodName:@"changeImage"  responseDataFormat:@"IMAGE"]; // nil == JSON by default
            [dataDownloader startDownloading];
            [dataDownloader release];
        }
        /*
        else 
        {
            [appDelegate showNetworkUnavailableError];
        }
        */
   }
}

- (void)displayHomeView{
	
	NSMutableDictionary *response = [BKAPIClient loadMainHomeMenuView];
	self.menuNameArray  = [response valueForKey:@"menu_name"];
	self.menuImageArray = [response valueForKey:@"image"];
    self.menuIdArray = [response valueForKey:@"menu_id"];
    self.templateTypeArray = [response valueForKey:@"template_type"];
    self.requestArray = [response valueForKey:@"request_text"];

	for (int b = 0; b < [menuIdArray count]; b++) 
	{
		
		iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
		//iconButton.frame = CGRectMake(315 + 232 * (b % 3) + 768 * (b /10),28+230 * ((b / 3) % 5),220,218);
        iconButton.frame = CGRectMake(315 + 232 * (b % 3) + 768 * (b /10),23+230 * ((b / 3) % 5),220,218);
		
        //UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,220,218)];
        UIImageView *img = [[[UIImageView alloc] initWithFrame:CGRectMake(0,0,220,218)] autorelease];
        CGRect frame;
        frame.size.width=220; frame.size.height=218;
        frame.origin.x=0; frame.origin.y=0;
        AsyncImageView *asyncImage = [[[AsyncImageView alloc]
                                       initWithFrame:frame] autorelease];
        
        asyncImage.tag = [[menuIdArray objectAtIndex:b]intValue];
        
        NSURL *url = [NSURL URLWithString:[menuImageArray objectAtIndex:b]];  
        [asyncImage loadImageFromURL:url];
        [img addSubview:asyncImage];
        [iconButton addSubview:img];

        itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
		itemButton.frame = CGRectMake(0,0,220,218);
        itemButton.tag = [[menuIdArray objectAtIndex:b]intValue];
        [itemButton setImage:[UIImage imageWithData:appDelegate.data2] forState:UIControlStateNormal];
        [itemButton setBackgroundImage:[UIImage imageNamed:@"hover.png"] forState:UIControlStateHighlighted];
       
    
		lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,5,200,25)];
		lblTitle.text = [NSString stringWithFormat:@"%@",[menuNameArray objectAtIndex:b]]; 
		lblTitle.textAlignment = UITextAlignmentLeft;
		lblTitle.font = [UIFont fontWithName:@"FUTURAN" size:20];
        lblTitle.font = [UIFont boldSystemFontOfSize:20];
		lblTitle.lineBreakMode = UILineBreakModeMiddleTruncation;
		lblTitle.backgroundColor = [UIColor clearColor];
		lblTitle.textColor = [UIColor whiteColor];
		[itemButton addSubview:lblTitle];
		iconButton.tag=[[menuIdArray objectAtIndex:i]intValue];
		iconButton.backgroundColor=[UIColor clearColor];
        [iconButton addSubview:itemButton];
        [itemButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];   
        [iconButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];  
		[self.view addSubview:iconButton];
	}
	
}
/*
- (IBAction)weatherAction {
    
    weatherBtn.enabled=NO;
    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(loadWeatherView:) withObject:nil afterDelay:2];
}

- (void)loadWeatherView:(id)sender {
    
    weatherView= [[UIView alloc]initWithFrame:CGRectMake(294, 56, 713, 702)];
    
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,weatherView.frame.size.width,weatherView.frame.size.height)];
    weatherView.backgroundColor = [UIColor clearColor];
    [backImage setImage:[UIImage imageNamed:@"commonpopup.png"]];
    [weatherView addSubview:backImage];
    
    UILabel *titleMessage = [[UILabel alloc] initWithFrame:CGRectMake(20,10,213,21)];
	titleMessage.text = @"Local Weather";
	titleMessage.textColor = [UIColor whiteColor];
    titleMessage.font = [UIFont boldSystemFontOfSize:22];
    titleMessage.textAlignment = UITextAlignmentLeft;
	titleMessage.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:titleMessage];
    
	UILabel *loadingMessage = [[UILabel alloc] initWithFrame:CGRectMake(402,63,287,42)];
	loadingMessage.font = [UIFont boldSystemFontOfSize:35];
	loadingMessage.textAlignment = UITextAlignmentLeft;
	loadingMessage.text = @"London, England";
	loadingMessage.textColor = [UIColor whiteColor];
	loadingMessage.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:loadingMessage];
    
    UILabel *todaylbl = [[UILabel alloc] initWithFrame:CGRectMake(503,121,91,27)];
	todaylbl.font = [UIFont boldSystemFontOfSize:22];
	todaylbl.textAlignment = UITextAlignmentRight;
	todaylbl.text = @"Today at";
	todaylbl.textColor = [UIColor whiteColor];
	todaylbl.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:todaylbl];
    
    UILabel *timelbl = [[UILabel alloc] initWithFrame:CGRectMake(598,122,86,27)];
	timelbl.font = [UIFont fontWithName:@"" size:22];
	timelbl.textAlignment = UITextAlignmentRight;
	timelbl.textColor = [UIColor lightGrayColor];
    timelbl.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:timelbl];
    
    UIImageView *todayImg =[[UIImageView alloc]initWithFrame:CGRectMake(460,180,70,70)];
    todayImg.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:todayImg];
    
    UILabel *maxTodayWeather = [[UILabel alloc] initWithFrame:CGRectMake(555,180,135,70)];
	maxTodayWeather.font = [UIFont boldSystemFontOfSize:60];
	maxTodayWeather.textAlignment = UITextAlignmentLeft;
	maxTodayWeather.textColor = [UIColor whiteColor];
	maxTodayWeather.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:maxTodayWeather];
    
    UILabel *dayFirst = [[UILabel alloc] initWithFrame:CGRectMake(70,344,65,30)];
	dayFirst.font = [UIFont boldSystemFontOfSize:22];
	dayFirst.textAlignment = UITextAlignmentLeft;
    dayFirst.text = @"Today";
	dayFirst.textColor = [UIColor whiteColor];
	dayFirst.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayFirst];
    
    UILabel *daySecond = [[UILabel alloc] initWithFrame:CGRectMake(180,344,120,30)];
	daySecond.font = [UIFont boldSystemFontOfSize:22];
	daySecond.textAlignment = UITextAlignmentLeft;
	daySecond.textColor = [UIColor whiteColor];
	daySecond.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:daySecond];
    
    UILabel *dayThird = [[UILabel alloc] initWithFrame:CGRectMake(315,344,120,30)];
	dayThird.font = [UIFont boldSystemFontOfSize:22];
	dayThird.textAlignment = UITextAlignmentLeft;
	dayThird.textColor = [UIColor whiteColor];
	dayThird.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayThird];
    
    UILabel *dayFour = [[UILabel alloc] initWithFrame:CGRectMake(450,344,120,30)];
	dayFour.font = [UIFont boldSystemFontOfSize:22];
	dayFour.textAlignment = UITextAlignmentLeft;
	dayFour.textColor = [UIColor whiteColor];
	dayFour.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayFour];
    
    UILabel *dayFive = [[UILabel alloc] initWithFrame:CGRectMake(585,344,120,30)];
	dayFive.font = [UIFont boldSystemFontOfSize:22];
	dayFive.textAlignment = UITextAlignmentLeft;
	dayFive.textColor = [UIColor whiteColor];
	dayFive.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:dayFive];
    
    UIImageView *firstImage =[[UIImageView alloc]initWithFrame:CGRectMake(70,383,70,70)];
    firstImage.backgroundColor = [UIColor clearColor];
    [firstImage setImage:[UIImage imageNamed:@""]];
    [weatherView addSubview:firstImage];
    
    UIImageView *secondImage =[[UIImageView alloc]initWithFrame:CGRectMake(205,383,70,70)];
    secondImage.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:secondImage];

    UIImageView *thirdImage =[[UIImageView alloc]initWithFrame:CGRectMake(340,383,70,70)];
    thirdImage.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:thirdImage];
    
    UIImageView *fourthImage =[[UIImageView alloc]initWithFrame:CGRectMake(475,383,70,70)];
    fourthImage.backgroundColor = [UIColor clearColor];
    [fourthImage setImage:[UIImage imageNamed:@""]];
    [weatherView addSubview:fourthImage];

    UIImageView *fifthImage =[[UIImageView alloc]initWithFrame:CGRectMake(610,383,70,70)];
    fifthImage.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:fifthImage];
    
    UILabel *firstMaxC = [[UILabel alloc] initWithFrame:CGRectMake(70,460,70,31)];
  	firstMaxC.font = [UIFont boldSystemFontOfSize:26];
	firstMaxC.textAlignment = UITextAlignmentLeft;
	firstMaxC.textColor = [UIColor whiteColor];
	firstMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:firstMaxC];
    
    UILabel *secondMaxC = [[UILabel alloc] initWithFrame:CGRectMake(205,460,70,31)];
	secondMaxC.font = [UIFont boldSystemFontOfSize:26];
	secondMaxC.textAlignment = UITextAlignmentLeft;
	secondMaxC.textColor = [UIColor whiteColor];
	secondMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:secondMaxC];
    
    UILabel *thirdMaxC = [[UILabel alloc] initWithFrame:CGRectMake(340,460,70,31)];
	thirdMaxC.font = [UIFont boldSystemFontOfSize:26];
	thirdMaxC.textAlignment = UITextAlignmentLeft;
	thirdMaxC.textColor = [UIColor whiteColor];
	thirdMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:thirdMaxC];
    
    UILabel *fourthMaxC = [[UILabel alloc] initWithFrame:CGRectMake(475,460,70,31)];
	fourthMaxC.font = [UIFont boldSystemFontOfSize:26];
	fourthMaxC.textAlignment = UITextAlignmentLeft;
	fourthMaxC.textColor = [UIColor whiteColor];
	fourthMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fourthMaxC];
    
    UILabel *fifthMaxC = [[UILabel alloc] initWithFrame:CGRectMake(610,460,70,31)];
	fifthMaxC.font = [UIFont boldSystemFontOfSize:26];
	fifthMaxC.textAlignment = UITextAlignmentLeft;
	fifthMaxC.textColor = [UIColor whiteColor];
	fifthMaxC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fifthMaxC];
    
    UILabel *firstMinC = [[UILabel alloc] initWithFrame:CGRectMake(70,500,70,31)];
  	firstMinC.font = [UIFont boldSystemFontOfSize:26];
	firstMinC.textAlignment = UITextAlignmentLeft;
	firstMinC.textColor = [UIColor whiteColor];
	firstMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:firstMinC];
    
    UILabel *secondMinC = [[UILabel alloc] initWithFrame:CGRectMake(205,500,70,31)];
	secondMinC.font = [UIFont boldSystemFontOfSize:26];
	secondMinC.textAlignment = UITextAlignmentLeft;
	secondMinC.textColor = [UIColor whiteColor];
	secondMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:secondMinC];
    
    UILabel *thirdMinC = [[UILabel alloc] initWithFrame:CGRectMake(340,500,70,31)];
	thirdMinC.font = [UIFont boldSystemFontOfSize:26];
	thirdMinC.textAlignment = UITextAlignmentLeft;
	thirdMinC.textColor = [UIColor whiteColor];
	thirdMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:thirdMinC];
    
    UILabel *fourthMinC = [[UILabel alloc] initWithFrame:CGRectMake(475,500,70,31)];
	fourthMinC.font = [UIFont boldSystemFontOfSize:26];
	fourthMinC.textAlignment = UITextAlignmentLeft;
	fourthMinC.textColor = [UIColor whiteColor];
	fourthMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fourthMinC];
    
    UILabel *fifthMinC = [[UILabel alloc] initWithFrame:CGRectMake(610,500,70,31)];
	fifthMinC.font = [UIFont boldSystemFontOfSize:26];
	fifthMinC.textAlignment = UITextAlignmentLeft;
	fifthMinC.textColor = [UIColor whiteColor];
	fifthMinC.backgroundColor = [UIColor clearColor];
	[weatherView addSubview:fifthMinC];

    
    UIImageView *upArrayImage =[[UIImageView alloc]initWithFrame:CGRectMake(20,465,36,28)];
    upArrayImage.backgroundColor = [UIColor clearColor];
    [upArrayImage setImage:[UIImage imageNamed:@"maxweather.png"]];
    [weatherView addSubview:upArrayImage];
    
    UIImageView *downArrayImage =[[UIImageView alloc]initWithFrame:CGRectMake(20,505,36,28)];
    downArrayImage.backgroundColor = [UIColor clearColor];
    [downArrayImage setImage:[UIImage imageNamed:@"minweather.png"]];
    [weatherView addSubview:downArrayImage];
     
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(removeWeatherView:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(680,0,33, 36);
    closeBtn.backgroundColor = [UIColor clearColor];
    [weatherView addSubview:closeBtn];
    [self.view addSubview:weatherView];
    
    UILabel *lblline1 = [[UILabel alloc] initWithFrame:CGRectMake(170,344,1,182)];
	lblline1.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline1];
    
    UILabel *lblline2 = [[UILabel alloc] initWithFrame:CGRectMake(305,344,1,182)];
	lblline2.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline2];
    
    UILabel *lblline3 = [[UILabel alloc] initWithFrame:CGRectMake(440,344,1,182)];
	lblline3.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline3];
    
    UILabel *lblline4 = [[UILabel alloc] initWithFrame:CGRectMake(575,344,1,182)];
	lblline4.backgroundColor = [UIColor lightGrayColor];
	[weatherView addSubview:lblline4];
    
    appDelegate = (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm:a"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    timelbl.text = theTime;
    [timeFormat release];
    [now release];
    
    NSMutableDictionary *dict1 = [appDelegate.currentArray objectAtIndex:0];
    NSArray *tweets1 = [[dict1 objectForKey:@"weatherIconUrl"] valueForKey:@"value"];
    
    maxTodayWeather.text = [NSString stringWithFormat:@"%@°C",[dict1 valueForKey:@"temp_C"]];
    
    NSURL *url1 = [NSURL URLWithString:[tweets1 objectAtIndex:0]];  
    NSData *data1 = [NSData dataWithContentsOfURL:url1];  
    [todayImg setImage:[UIImage imageWithData:data1]];
    
   // NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDictionary *dict;
    
    for (int b=0; b<[appDelegate.dataArray count]; b++) {
        
        dict = [appDelegate.dataArray objectAtIndex:b];
        
        NSArray *tweets = [[dict objectForKey:@"weatherIconUrl"] valueForKey:@"value"];
        
        switch (b) {
            case 0:
                
                firstMaxC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMaxC"]];
                firstMinC.text = [NSString stringWithFormat:@"%@°C",[dict valueForKey:@"tempMinC"]];
                
                NSURL *url1 = [NSURL URLWithString:[tweets objectAtIndex:0]];  
                NSData *data1 = [NSData dataWithContentsOfURL:url1];  
                [firstImage setImage:[UIImage imageWithData:data1]];
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
                NSData *data2 = [NSData dataWithContentsOfURL:url2];  
                [secondImage setImage:[UIImage imageWithData:data2]];
                
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
                NSData *data3 = [NSData dataWithContentsOfURL:url3];  
                [thirdImage setImage:[UIImage imageWithData:data3]];
                
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
    
    [DSBezelActivityView removeViewAnimated:YES];

}

-(void)removeWeatherView:(id)sender {
    
    weatherBtn.enabled=YES;
    [weatherView removeFromSuperview];
}


- (IBAction)messageAction{
    
    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(loadMessageView:) withObject:nil afterDelay:2];
}

- (void)loadMessageView:(id)sender{
    
    MessageView *aMessageView = [[MessageView alloc]initWithNibName:@"MessageView" bundle:nil];
    [self.navigationController pushViewController:aMessageView animated:YES];
    [DSBezelActivityView removeViewAnimated:YES];

}

- (IBAction)loginView:(id)sender{
    
    [self displayLoginView];
    
}
*/
-(void)alertMessage
{
//    aAlertView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"commonpopup.png"]];
     
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    if (!aAlertView)
    {
        
        aAlertView = [[UIView alloc]initWithFrame:CGRectMake(294,12,713,702)];
        UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,aAlertView.frame.size.width,aAlertView.frame.size.height)];
        aAlertView.backgroundColor = [UIColor clearColor];
        [backImage setImage:[UIImage imageNamed:@"commonpopup.png"]];
        [aAlertView addSubview:backImage ];
        [backImage release];
        
        lblMessage.textColor = [UIColor whiteColor];
        lblMessage.numberOfLines = 4;
        
        lblMessage.textAlignment = UITextAlignmentCenter;
        lblMessage.font = [UIFont systemFontOfSize:40];
        lblMessage.backgroundColor = [UIColor clearColor];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn addTarget:self action:@selector(removeAlert:) forControlEvents:UIControlEventTouchUpInside];
        closeBtn.frame = CGRectMake(690,0,34, 35);
        closeBtn.backgroundColor = [UIColor clearColor];
        [aAlertView addSubview:closeBtn]; 
        
        UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.tag = 555;
        UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        noBtn.tag = 666;
        yesBtn.frame = CGRectMake(222,350,110,40);
        noBtn.frame = CGRectMake(371,350,110,40);
        
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"yes_butan.png"] forState:UIControlStateNormal];
        [noBtn setBackgroundImage:[UIImage imageNamed:@"No_butan.png"] forState:UIControlStateNormal];
        [yesBtn setTitle:@"Yes" forState:UIControlStateNormal];
        [noBtn setTitle:@"No" forState:UIControlStateNormal];
        
               [aAlertView addSubview:lblMessage];
        [aAlertView addSubview:yesBtn];
        [aAlertView addSubview:noBtn];
        aAlertView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
        
    }
    
    
    UIButton *yesBtn = (UIButton*)[aAlertView viewWithTag:555];
    UIButton *noBtn = (UIButton*)[aAlertView viewWithTag:666];
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        yesBtn.enabled = YES;
        noBtn.enabled = YES;
        [yesBtn addTarget:self action:@selector(yesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [noBtn addTarget:self action:@selector(noBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }else {
        
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"no_button.png"] forState:UIControlStateNormal];
        [noBtn setBackgroundImage:[UIImage imageNamed:@"no_button.png"] forState:UIControlStateNormal];
        yesBtn.enabled = NO;
        noBtn.enabled = NO;
    }    
    [self.view addSubview:aAlertView];           
    //[self.navigationController.view addSubview:aAlertView];
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

-(IBAction)yesBtnAction:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
    
        [aAlertView removeFromSuperview];
//        [DSBezelActivityView newActivityViewForView:self.view];
        //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
        [self performSelector:@selector(confirmMesssage:)];
     }
}
-(void)startAct
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    //[DSBezelActivityView newActivityViewForView:self.view];
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDel startStandardActivityLoadingView:self.view];
    [pool release];
}

- (void)confirmMesssage:(id)sender{
   // EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    
    NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"1" guestId:appDelegate.appLoginId serviceId:@"0" info:@"Reception"];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 
    
    [appDelegate setCustomBadge];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

-(IBAction)noBtnAction:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
	
	     [aAlertView removeFromSuperview];
    }
}

- (IBAction)removeAlert:(id)sender
{    
    [aAlertView removeFromSuperview];    
}

- (IBAction)dsiplayHelpView{
    
    HelpView *aHelpView = [[HelpView alloc]initWithNibName:@"HelpView" bundle:nil];
    aHelpView.view.frame = CGRectMake(294,56,713,702);
	[self.view addSubview:aHelpView.view];  
    
}

- (IBAction)iconButtonClick:(id)sender{
	
	switch ([sender tag]) {
		case 1: 
        {
            lblMessage.text = [requestArray objectAtIndex:[sender tag]-1];
            [self performSelector:@selector(displayMenu1:)];
		}
		break;
		case 2: 
        {
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
            [self performSelector:@selector(displayMenu2:)];
        }
		break; 
		case 3: 
        {
//            [DSBezelActivityView newActivityViewForView:self.view];
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
            [self performSelector:@selector(displayMenu3:)];
		}
		break;
		case 4: 
        {
//            [DSBezelActivityView newActivityViewForView:self.view];
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
            [self performSelector:@selector(displayMenu4:)];
		}
		break;
		case 5: 
        {
//            [DSBezelActivityView newActivityViewForView:self.view];
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];            
            [self performSelector:@selector(displayMenu5:)];
		}
		break;
		case 6: 
        {
//			[DSBezelActivityView newActivityViewForView:self.view];
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];            
            [self performSelector:@selector(displayMenu6:)];
		}
			break;
		case 7: 
        {
//			[DSBezelActivityView newActivityViewForView:self.view];
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];            
            [self performSelector:@selector(displayMenu7:)];
		}
			break;
		case 8: 
        {
//			[DSBezelActivityView newActivityViewForView:self.view];
            //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];            
            [self performSelector:@selector(displayMenu8:)];
		}
			break;
		case 9: 
        {
//            [DSBezelActivityView newActivityViewForView:self.view];
//            [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];            
            [self performSelector:@selector(displayMenu9:)];			    
		}
		break;
		default:
			break;
	}
	
}

- (void)displayMenu1:(id)sender{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];  
    //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }    
    [self alertMessage];
    //[appDel stopStandardActivityLoadingView];
    //[DSBezelActivityView removeViewAnimated:YES];
   
}
- (void)displayMenu2:(id)sender
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    
    aRoomServiceView = [[RoomServiceView alloc]initWithNibName:@"RoomServiceView" bundle:nil];
    aRoomServiceView.menuId = @"2";
    int menuIndex = [aRoomServiceView.menuId intValue];
    if(menuIndex <= 0)
    {
        NSLog(@"displayMenu2 = Menu is < 0");
        return;
    }
    menuIndex--;
    
    aRoomServiceView.menuTitle = [self.menuNameArray objectAtIndex:menuIndex];
    [self.navigationController pushViewController:aRoomServiceView animated:YES];	
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
- (void)displayMenu3:(id)sender{
    
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    aHouseKeepingView = [[HouseKeepingView alloc]initWithNibName:@"HouseKeepingView" bundle:nil];
    aHouseKeepingView.menuId = @"3";
    int menuIndex = [aHouseKeepingView.menuId intValue];
    if(menuIndex <= 0)
    {
        NSLog(@"displayMenu3 = Menu is < 0");
        return;
    }
    menuIndex--;
    
    aHouseKeepingView.menuTitle = [self.menuNameArray objectAtIndex:menuIndex];
    [self.navigationController pushViewController:aHouseKeepingView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
- (void)displayMenu4:(id)sender {
    
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    aInRoomServiceView = [[InRoomServiceView alloc]initWithNibName:@"InRoomServiceView" bundle:nil];
    aInRoomServiceView.menuId = @"4";
    int menuIndex = [aInRoomServiceView.menuId intValue];
    if(menuIndex <= 0)
    {
        NSLog(@"displayMenu4 = Menu is < 0");
        return;
    }
    menuIndex--;
    aInRoomServiceView.menuTitle = [self.menuNameArray objectAtIndex:menuIndex];
    [self.navigationController pushViewController:aInRoomServiceView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (void)displayMenu5:(id)sender{
    
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    aTravelDeskView = [[TravelDeskView alloc]initWithNibName:@"TravelDeskView" bundle:nil];
    aTravelDeskView.menuId = @"5";
    int menuIndex = [aTravelDeskView.menuId intValue];
    if(menuIndex <= 0)
    {
        NSLog(@"displayMenu5 = Menu is < 0");
        return;
    }
    menuIndex--;
    aTravelDeskView.menuTitle = [self.menuNameArray objectAtIndex:menuIndex];
    [self.navigationController pushViewController:aTravelDeskView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
    
}
- (void)displayMenu6:(id)sender{
    
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    aHotelInformationView = [[HotelInformationView alloc]initWithNibName:@"HotelInformationView" bundle:nil];
    aHotelInformationView.menuId = @"6";
    int menuIndex = [aHotelInformationView.menuId intValue];
    if(menuIndex <= 0)
    {
        NSLog(@"displayMenu6 = Menu is < 0");
        return;
    }
    menuIndex--;
    aHotelInformationView.menuTitle = [self.menuNameArray objectAtIndex:menuIndex];
    
    [self.navigationController pushViewController:aHotelInformationView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];

}
- (void)displayMenu7:(id)sender{
    
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    aLaundryView = [[LaundryView alloc]initWithNibName:@"LaundryView" bundle:nil];
    aLaundryView.menuId = @"7";
    int menuIndex = [aLaundryView.menuId intValue];
    if(menuIndex <= 0)
    {
        NSLog(@"displayMenu7 = Menu is < 0");
        return;
    }
    menuIndex--;
    aLaundryView.menuTitle = [self.menuNameArray objectAtIndex:menuIndex];
    
    [self.navigationController pushViewController:aLaundryView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
- (void)displayMenu8:(id)sender {
    
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    
    aShoppingView = [[ShoppingView alloc]initWithNibName:@"ShoppingView" bundle:nil];
    aShoppingView.menuId = @"8";
    int menuIndex = [aShoppingView.menuId intValue];
    if(menuIndex <= 0)
    {
        NSLog(@"displayMenu7 = Menu is < 0");
        return;
    }
    menuIndex--;
    aShoppingView.menuTitle = [self.menuNameArray objectAtIndex:menuIndex];
    
    [self.navigationController pushViewController:aShoppingView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
    
}
- (void)displayMenu9:(id)sender {
    
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];    
    if(appDel.isNetworkAvailable == NO)
    {
        [appDel showNetworkUnavailableError];
        return;
    }
   [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDel startStandardActivityLoadingView:self.view];
    [self displayExpressCheckOut];
   // [DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
   
}

-(void)receivedLoggedInNotification
{
    if(expressCheckOutView == nil)
        return;
    UIButton *fiveBtn = (UIButton*)[expressCheckOutView viewWithTag:5000];
    UIButton *tenBtn = (UIButton*)[expressCheckOutView viewWithTag:10000];
    UIButton *fifteenBtn = (UIButton*)[expressCheckOutView viewWithTag:15000];
    UIButton *twentyBtn = (UIButton*)[expressCheckOutView viewWithTag:20000];
    UIButton *twentyFiveBtn = (UIButton*)[expressCheckOutView viewWithTag:25000];
    UIButton *thirtyBtn = (UIButton*)[expressCheckOutView viewWithTag:30000];    
                                    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        if(fiveBtn != nil)
            fiveBtn.enabled = YES;
        
        if(tenBtn != nil)
            tenBtn.enabled = YES;
        
        if(fifteenBtn != nil)
            fifteenBtn.enabled = YES;
        
        if(twentyBtn != nil)
            twentyBtn.enabled = YES;
        
        if(twentyFiveBtn != nil)
            twentyFiveBtn.enabled = YES;
        
        if(thirtyBtn != nil)
            thirtyBtn.enabled = YES;
        
        
    }else {
        
        if(fiveBtn != nil)
        {
            fiveBtn.enabled = NO;
            [fiveBtn setImage:[UIImage imageNamed:@"5min1.png"] forState:UIControlStateNormal];
        }
        
        if(tenBtn != nil)
        {
            tenBtn.enabled = NO;
            [tenBtn setImage:[UIImage imageNamed:@"10min1.png"] forState:UIControlStateNormal];
        }
        
        if(fifteenBtn != nil)
        {
            fifteenBtn.enabled = NO;
            [fifteenBtn setImage:[UIImage imageNamed:@"15min1.png"] forState:UIControlStateNormal];
        }
        
        if(twentyBtn != nil)
        {
            twentyBtn.enabled = NO;
            [twentyBtn setImage:[UIImage imageNamed:@"20min1.png"] forState:UIControlStateNormal];
        }
        
        if(twentyFiveBtn != nil)
        {
            twentyFiveBtn.enabled = NO;
            [twentyFiveBtn setImage:[UIImage imageNamed:@"25min1.png"] forState:UIControlStateNormal];
        }
        
        if(thirtyBtn != nil)
        {
            thirtyBtn.enabled = NO;
            [thirtyBtn setImage:[UIImage imageNamed:@"30min1.png"] forState:UIControlStateNormal];
        }  
    }
}

- (void)displayExpressCheckOut{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedLoggedInNotification) name:[NotificationNames notificationNameForLoggedin] object:nil];

   
    expressCheckOutView= [[UIView alloc]initWithFrame:CGRectMake(294, 12, 713, 702)];
    
    UIImageView *backImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,expressCheckOutView.frame.size.width,expressCheckOutView.frame.size.height)];
    expressCheckOutView.backgroundColor = [UIColor clearColor];
    [backImage setImage:[UIImage imageNamed:@"commonpopup.png"]];
    [expressCheckOutView addSubview:backImage];
    
    /*
    UILabel *titleMessage = [[UILabel alloc] initWithFrame:CGRectMake(20,10,205,27)];
	titleMessage.text = @"Express Check-Out";
	titleMessage.textColor = [UIColor whiteColor];
    titleMessage.font = [UIFont boldSystemFontOfSize:22];
    titleMessage.textAlignment = UITextAlignmentLeft;
	titleMessage.backgroundColor = [UIColor clearColor];
	[expressCheckOutView addSubview:titleMessage];
    */
    
    UIButton *btnfive = [UIButton buttonWithType:UIButtonTypeCustom];
    btnfive.tag = 5000;
    [btnfive addTarget:self action:@selector(five:) forControlEvents:UIControlEventTouchUpInside];
    btnfive.frame = CGRectMake(31,168,300,100);
    [btnfive setImage:[UIImage imageNamed:@"5min.png"] forState:UIControlStateNormal];
    btnfive.backgroundColor = [UIColor clearColor];
    [expressCheckOutView addSubview:btnfive];
   
    UIButton *btnten = [UIButton buttonWithType:UIButtonTypeCustom];
    btnten.tag = 10000;
    [btnten addTarget:self action:@selector(ten:) forControlEvents:UIControlEventTouchUpInside];
    btnten.frame = CGRectMake(362,168,300,100);
    [btnten setImage:[UIImage imageNamed:@"10min.png"] forState:UIControlStateNormal];
    btnten.backgroundColor = [UIColor clearColor];
    [expressCheckOutView addSubview:btnten];
    
    UIButton *btnfifteen = [UIButton buttonWithType:UIButtonTypeCustom];
    btnfifteen.tag = 15000;
    [btnfifteen addTarget:self action:@selector(fifteen:) forControlEvents:UIControlEventTouchUpInside];
    btnfifteen.frame = CGRectMake(31,302,300,100);
    [btnfifteen setImage:[UIImage imageNamed:@"15min.png"] forState:UIControlStateNormal];
    btnfifteen.backgroundColor = [UIColor clearColor];
    [expressCheckOutView addSubview:btnfifteen];
    
    UIButton *btntwenty = [UIButton buttonWithType:UIButtonTypeCustom];
    btntwenty.tag = 20000;
    [btntwenty addTarget:self action:@selector(twenty:) forControlEvents:UIControlEventTouchUpInside];
    btntwenty.frame = CGRectMake(362,302,300,100);
    [btntwenty setImage:[UIImage imageNamed:@"20min.png"] forState:UIControlStateNormal];
    btntwenty.backgroundColor = [UIColor clearColor];
    [expressCheckOutView addSubview:btntwenty];
   
    UIButton *btntwentyfive = [UIButton buttonWithType:UIButtonTypeCustom];
    btntwentyfive.tag = 25000;
    [btntwentyfive addTarget:self action:@selector(twentyfive:) forControlEvents:UIControlEventTouchUpInside];
    btntwentyfive.frame = CGRectMake(31,433,300,100);
    [btntwentyfive setImage:[UIImage imageNamed:@"25min.png"] forState:UIControlStateNormal];
    btntwentyfive.backgroundColor = [UIColor clearColor];
    [expressCheckOutView addSubview:btntwentyfive];
    
    UIButton *btnthirty = [UIButton buttonWithType:UIButtonTypeCustom];
    btnthirty.tag = 30000;
    [btnthirty addTarget:self action:@selector(thirty:) forControlEvents:UIControlEventTouchUpInside];
    btnthirty.frame = CGRectMake(362,433,300,100);
    [btnthirty setImage:[UIImage imageNamed:@"30min.png"] forState:UIControlStateNormal];
    btnthirty.backgroundColor = [UIColor clearColor];
    [expressCheckOutView addSubview:btnthirty];
   
    CGRect chkOutLblFrame = CGRectMake(btntwentyfive.frame.origin.x + 135,(btnthirty.frame.origin.y + btnthirty.frame.size.height + 60) , 400, 30);
    //UILabel *titleMessage = [[UILabel alloc] initWithFrame:CGRectMake(20,10,205,27)];
    UILabel *titleMessage = [[UILabel alloc] initWithFrame:chkOutLblFrame];
	titleMessage.text = @"Select expected check-out duration";
	titleMessage.textColor = [UIColor whiteColor];
    titleMessage.font = [UIFont boldSystemFontOfSize:22];
    titleMessage.textAlignment = UITextAlignmentLeft;
	titleMessage.backgroundColor = [UIColor clearColor];
	[expressCheckOutView addSubview:titleMessage];
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        
        btnfive.enabled = YES;
        btnten.enabled = YES;
        btnfifteen.enabled = YES;
        btntwenty.enabled = YES;
        btntwentyfive.enabled = YES;
        btnthirty.enabled = YES;
        
    }else {
        
        [btnfive setImage:[UIImage imageNamed:@"5min1.png"] forState:UIControlStateNormal];
        [btnten setImage:[UIImage imageNamed:@"10min1.png"] forState:UIControlStateNormal];
        [btnfifteen setImage:[UIImage imageNamed:@"15min1.png"] forState:UIControlStateNormal];
        [btntwenty setImage:[UIImage imageNamed:@"20min1.png"] forState:UIControlStateNormal];
        [btntwentyfive setImage:[UIImage imageNamed:@"25min1.png"] forState:UIControlStateNormal];
        [btnthirty setImage:[UIImage imageNamed:@"30min1.png"] forState:UIControlStateNormal];
        
        btnfive.enabled = NO;
        btnten.enabled = NO;
        btnfifteen.enabled = NO;
        btntwenty.enabled = NO;
        btntwentyfive.enabled = NO;
        btnthirty.enabled = NO;
        
    }
	
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn addTarget:self action:@selector(removeExpressCheckOut:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(680,0,33, 36);
    closeBtn.backgroundColor = [UIColor clearColor];
    [expressCheckOutView addSubview:closeBtn];
    [self.view addSubview:expressCheckOutView];
}


- (IBAction)five:(id)sender{
	//[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(fiveMessage:)];
}

- (void)fiveMessage:(id)sender{
    
    tempMessage = @"After 5 Minutes";
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDelegate startStandardActivityLoadingView:self.view];
	NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"9" guestId:appDelegate.appLoginId serviceId:@"0" info:tempMessage];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setCustomBadge];
    [expressCheckOutView removeFromSuperview];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}


- (IBAction)ten:(id)sender
{
	//[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(tenMessage:)];
}

- (void)tenMessage:(id)sender{
    
    tempMessage = @"After 10 Minutes";
	appDelegate =(EyeAppDelegate*) [[UIApplication sharedApplication]delegate];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDelegate startStandardActivityLoadingView:self.view];
	NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"9" guestId:appDelegate.appLoginId serviceId:@"0" info:tempMessage];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 

    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setCustomBadge];
    [expressCheckOutView removeFromSuperview];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)fifteen:(id)sender{
	//[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(fifteenMessage:)];
}

- (void)fifteenMessage:(id)sender{
    
    tempMessage = @"After 15 Minutes";
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDelegate startStandardActivityLoadingView:self.view];
	NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"9" guestId:appDelegate.appLoginId serviceId:@"0" info:tempMessage];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 
	
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setCustomBadge];
    [expressCheckOutView removeFromSuperview];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)twenty:(id)sender
{
    //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(twentyMessage:)];	
}

- (void)twentyMessage:(id)sender{
    
    tempMessage = @"After 20 Minutes";
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    //[appDelegate startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
	NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"9" guestId:appDelegate.appLoginId serviceId:@"0" info:tempMessage];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setCustomBadge];
    [expressCheckOutView removeFromSuperview];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)twentyFive:(id)sender{
    //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(twentyFiveMessage:)];
}

- (void)twentyFiveMessage:(id)sender{
    
    tempMessage = @"After 25 Minutes";
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    //[appDelegate startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
	NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"9" guestId:appDelegate.appLoginId serviceId:@"0" info:tempMessage];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 

    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setCustomBadge];
    [expressCheckOutView removeFromSuperview];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)thirty:(id)sender{
	//[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(thirtyMessage:)];
}

- (void)thirtyMessage:(id)sender{
    
    tempMessage = @"After 30 Minutes";
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    //[appDelegate startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
	NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"9" guestId:appDelegate.appLoginId serviceId:@"0" info:tempMessage];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 

    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate messageService];
    [expressCheckOutView removeFromSuperview];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];    
}


-(void)removeExpressCheckOut:(id)sender {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[NotificationNames notificationNameForLoggedin] object:nil];
    [expressCheckOutView removeFromSuperview];
}

- (IBAction)controlSwitched:(id)sender{
	
	if (segmentedControl.selectedSegmentIndex == 0) {
		
		[alert dismissWithClickedButtonIndex:0 animated:YES];
		
	}else {
		
		[alert dismissWithClickedButtonIndex:0 animated:YES];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {  
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	[super viewDidUnload];  
	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	myTimer = nil;

}

#pragma mark -
#pragma mark AsyncDownloader Delegate Methods

-(void)didFinishDownloadingAsyncDownloaderInJson:(NSString *)jsonString ForMethod:(NSString *)methodName
{
	//Process for displayAddImage
	if([methodName isEqualToString:@"displayAddImage"])
	{
		if(jsonString != nil)
		{
			NSMutableDictionary *response = (NSMutableDictionary *)[jsonString JSONValue];
			self.addImageArray = [response valueForKey:@"adv_image"];
			self.bigTextArray = [response valueForKey:@"adv_text_main"];
			self.smallTextArray = [response valueForKey:@"adv_text_small"];
		}
	}
	else if([methodName isEqualToString:@"displayBottomAdd"])
	{
		if(jsonString != nil)
		{
			NSMutableDictionary *response = (NSMutableDictionary *)[jsonString JSONValue];
			appDelegate.adImageArray = [response valueForKey:@"adv_image"];
			appDelegate.firstTextArray = [response valueForKey:@"adv_text_main"];
			appDelegate.secondTextArray = [response valueForKey:@"adv_text_small"]; 			
			
		}
	}
	else if([methodName isEqualToString:@"displaySideAdd"])
	{
		if(jsonString != nil)
		{
			NSMutableDictionary *response = (NSMutableDictionary *)[jsonString JSONValue];
			appDelegate.adImageArray1 = [response valueForKey:@"adv_image"];
			appDelegate.firstTextArray1 = [response valueForKey:@"adv_text_main"];
			appDelegate.secondTextArray1 = [response valueForKey:@"adv_text_small"]; 
			
		}
	}
	
}

-(void)didFinishDownloadingAsyncDownloader:(NSMutableData *)receivedData ForMethod:(NSString *)methodName
{
	
	if([methodName isEqualToString:@"changeImage"])
	{
		if(receivedData != nil)
		{
			[addImageView setImage:[UIImage imageWithData:receivedData]];
			mainText.text = [bigTextArray objectAtIndex:t];
			smallText.text = [smallTextArray objectAtIndex:t];	
			t++;
		}
		if (t >= [addImageArray count]) 
		{
			t=0;
		} 
	}
}

-(void)didFailAsyncDownloaderWithError:(NSError *)error ForMethod:(NSString *)methodName
{
	//Process for displayAddImage
	if([methodName isEqualToString:@"displayAddImage"])
	{
                [appDelegate showTimeOutAlert];
		NSLog(@"HomeView-didFailAsyncDownloaderWithError- Request Failed for Method = %@",methodName);
	}
	
}

- (void)dealloc {
	
	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    [aRoomServiceView release];
    [aHouseKeepingView release];
    [aInRoomServiceView release];
    [aTravelDeskView release];
    [aHotelInformationView release];
    [aLaundryView release];
    [aShoppingView release];
        
	[segmentedControl release];  
	[menuNameArray release];
    [menuIdArray release];
    [requestArray release];
    [templateTypeArray release];
	[menuImageArray release];
	[addImageArray release];
    [smallTextArray release];
    [bigTextArray release];
	[myTimer release];
    [lblMessage release];
    [aAlertView release];
//    [txtloginId release];
//    [loginView release];
//    [logOutBtn release];
//    [weatherView release];
    [expressCheckOutView release];
    [tempMessage release];
	
    [super dealloc];
      
}


@end
