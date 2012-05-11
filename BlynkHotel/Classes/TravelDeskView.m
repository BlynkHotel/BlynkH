    //
//  TravelDeskView.m
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TravelDeskView.h"
#import "MessageView.h"
#import "EyeAppDelegate.h"
#import "BKAPIClient.h"
#import "HelpView.h"
#import "DSActivityView.h"
#import "CustomBadge.h"
#import "AsyncImageView.h"
#import "proAlertView.h"
#import "SubMenuServiceModel.h"
#import "ImageDownloader.h"
@implementation TravelDeskView

@synthesize menuId,serviceId,menuTitle;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)viewDidLoad {
    [super viewDidLoad];
	
	//register for custombadge updated notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customBadgeUpdated) name:[NotificationNames notificationNameForCustomBadgeUpdate] object:nil];
//	//register for received guest details notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGuestDetails) name:[NotificationNames notificationNameForGuestDetails] object:nil];
//    aAlertView = [[UIView alloc]initWithFrame:CGRectMake(294,12,713,702)];
	lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(100,100,550,250)];

	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [backImageView setImage:[UIImage imageWithData:appDelegate.data]];
    [logoView setImage:[UIImage imageWithData:appDelegate.data1]];
    
//    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
    if ([appDelegate.travelDeskArray count]==0)
    {
        NSArray *response = [BKAPIClient loadSubMenuView:@"5"];
        for (int i = 0; i<[response count]; i++)
        {
            SubMenuServiceModel *model = [[SubMenuServiceModel alloc]init];
            model.serviceName = [[response objectAtIndex:i] valueForKey:@"services_name"];
            model.serviceId = [[response objectAtIndex:i] valueForKey:@"services_id"];
            model.imgUrl = [[response objectAtIndex:i] valueForKey:@"image"];
            model.requestText = [[response objectAtIndex:i] valueForKey:@"request_text"];
            
            [appDelegate.travelDeskArray addObject:model];
            [model release];
        }
    }

    [self displaySubMenu];
//    [self displayLogout];
//    logOutBtn.hidden=YES;
//    loginBtn.hidden=NO;
//    helpBtn.hidden=YES;
//	
//	[self receivedGuestDetails];
    self.title = self.menuTitle;
}

- (void)displaySubMenu{
	
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
	
    for (int i = 0; i < [appDelegate.travelDeskArray count]; i++) 
	{
        SubMenuServiceModel *model = (SubMenuServiceModel*)[appDelegate.travelDeskArray objectAtIndex:i];
        
		iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
		iconButton.frame = CGRectMake(308 + 232 * (i % 3) + 768 * (i /10),28+230 * ((i / 3) % 5),220,218);
		
        if (model.img==nil)
        {
            ImageDownloader *downloader = [[ImageDownloader alloc]init];
            [downloader loadImageFromURL:[NSURL URLWithString:model.imgUrl] forUIButton:iconButton andModel:model];
            [downloader release];
        }
        else
        {
            [iconButton setBackgroundImage:model.img forState:UIControlStateNormal];
        }
        
        /*
         NSURL *url = [NSURL URLWithString:[appDelegate.menuImageArray2 objectAtIndex:i]];  
         NSData *data1 = [NSData dataWithContentsOfURL:url];  
         [iconButton setImage:[UIImage imageWithData:data1] forState:UIControlStateNormal];
         */
        
        itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
		itemButton.frame = CGRectMake(0,0,220,218);
        [itemButton setImage:[UIImage imageWithData:appDelegate.data2]forState:UIControlStateNormal];
        [itemButton setBackgroundImage:[UIImage imageNamed:@"hover.png"] forState:UIControlStateHighlighted];
		
		lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(10,5,200,25)];
		lblTitle.text = model.serviceName;
		lblTitle.textAlignment = UITextAlignmentLeft;
        
		lblTitle.font = [UIFont fontWithName:@"FUTURAN" size:20];
        lblTitle.font = [UIFont boldSystemFontOfSize:20];
		lblTitle.lineBreakMode = UILineBreakModeMiddleTruncation;
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lblTitle.textColor = [UIColor whiteColor];
		[itemButton addSubview:lblTitle];
        
        itemButton.tag = i;
        iconButton.tag = i;
		iconButton.backgroundColor=[UIColor clearColor];
        
        [itemButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];  
		[iconButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];   
		[iconButton addSubview:itemButton];
		[self.view addSubview:iconButton];
		
	}
	
}
-  (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
       
//    [self setCustomBadge]; 
	[appDelegate displayGuestDetail];

    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeBottomAdd) userInfo:nil repeats:YES];
    myTimer = theTimer;
     
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];

}

- (void)viewWillDisappear:(BOOL)animated{
        
    [myTimer invalidate];
}

- (void)changeBottomAdd {
    
    appDelegate =(EyeAppDelegate*) [[UIApplication sharedApplication]delegate];
    
   // NSLog([NSString stringWithFormat:@"%t",[appDelegate.adImageArray1 count]]);
    
    if ( t<[appDelegate.adImageArray1 count]) {
        if (appDelegate.isNetworkAvailable)
        {
            NSURL *url = [NSURL URLWithString:[appDelegate.adImageArray1 objectAtIndex:t]];
            AsyncDownloader *dataDownloader = [[AsyncDownloader alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self methodName:@"changeBottomAdd"  responseDataFormat:@"IMAGE"]; // nil == JSON by default
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


#pragma mark -
#pragma mark AsyncDownloading Methods
-(void)didFinishDownloadingAsyncDownloader:(NSMutableData *)receivedData ForMethod:(NSString *)methodName
{
	if([methodName isEqualToString:@"changeBottomAdd"])
	{
		if(receivedData != nil)
		{
			[addImage setImage:[UIImage imageWithData:receivedData]];
			mainText.text = [appDelegate.firstTextArray1 objectAtIndex:t];
			smallText.text = [appDelegate.secondTextArray1 objectAtIndex:t];
			t++;
		}
		if (t==[appDelegate.adImageArray1 count]) {
			
			t=0;
		} 
	}
}

-(void)didFailAsyncDownloaderWithError:(NSError *)error ForMethod:(NSString *)methodName
{
	//Process for displayAddImage
	if([methodName isEqualToString:@"changeBottomAdd"])
	{
                [appDelegate showTimeOutAlert];
		NSLog(@"didFailAsyncDownloaderWithError- Request Failed for Method = %@",methodName);
	}
	
}

#pragma mark -
#pragma mark Other Methods

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
    
    for (int i=0; i<[appDelegate.dataArray count]; i++) {
        
        dict = [appDelegate.dataArray objectAtIndex:i];
        
        NSArray *tweets = [[dict objectForKey:@"weatherIconUrl"] valueForKey:@"value"];
        
        switch (i) {
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

*/
- (IBAction)displayHelpView{
    
    HelpView *aHelpView = [[HelpView alloc]initWithNibName:@"HelpView" bundle:nil];
    aHelpView.view.frame = CGRectMake(294,56,713,702);
	[self.view addSubview:aHelpView.view];  
    
}

-(void)alertMessage{
    
//    aAlertView.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"commonpopup.png"]];
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
        yesBtn.tag=777;
        UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        noBtn.tag = 888;
        yesBtn.frame = CGRectMake(222,350,110,40);
        noBtn.frame = CGRectMake(371,350,110,40);
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"yes_butan.png"] forState:UIControlStateNormal];
        [noBtn setBackgroundImage:[UIImage imageNamed:@"No_butan.png"] forState:UIControlStateNormal];
        [yesBtn setTitle:@"Yes" forState:UIControlStateNormal];
        [noBtn setTitle:@"No" forState:UIControlStateNormal];
        
        [yesBtn addTarget:self action:@selector(yesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [noBtn addTarget:self action:@selector(noBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [aAlertView addSubview:lblMessage];
        [aAlertView addSubview:yesBtn];
        [aAlertView addSubview:noBtn];

    }
    UIButton *yesBtn = (UIButton*)[aAlertView viewWithTag:777];
    UIButton *noBtn = (UIButton*)[aAlertView viewWithTag:888];    
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        yesBtn.enabled = YES;
        noBtn.enabled = YES;
    }else {
        
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"no_button.png"] forState:UIControlStateNormal];
        [noBtn setBackgroundImage:[UIImage imageNamed:@"no_button.png"] forState:UIControlStateNormal];
        yesBtn.enabled = NO;
        noBtn.enabled = NO;
    }

    [self.view addSubview:aAlertView];
    
}

- (IBAction)removeAlert:(id)sender{
    
    [aAlertView removeFromSuperview];
}


-(IBAction)yesBtnAction:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
    [aAlertView removeFromSuperview];
        //[NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
       
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(confirmMesssage:)];
    }
}
-(void)startAct
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    //[DSBezelActivityView newActivityViewForView:self.view];
    [appDelegate startStandardActivityLoadingView:self.view];
    [pool release];
}

- (void)confirmMesssage:(id)sender{
     //[appDelegate startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"5" guestId:appDelegate.appLoginId serviceId:serviceId info:@"no"];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	
	NSString *message = [response valueForKey:@"notification_name"];
    
    proAlertView *popAlert = [[proAlertView alloc]initWithTitle:message message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [popAlert setBackgroundColor:[UIColor colorWithRed:0.129 green:0.129 blue:0.129 alpha:1.0] withStrokeColor:[UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:0.8]];
    [popAlert show];
    [popAlert release]; 
    
    [appDelegate setCustomBadge]; 
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
-(void)stopAct
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate]; 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [appDel stopStandardActivityLoadingView];
    [pool release];
}

-(IBAction)noBtnAction:(id)sender{
    
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
	    [aAlertView removeFromSuperview];
    }
}


- (IBAction)iconButtonClick:(id)sender{
    SubMenuServiceModel *model = (SubMenuServiceModel*)[appDelegate.travelDeskArray objectAtIndex:[sender tag]];
    serviceId  = model.serviceId;
    lblMessage.text = model.requestText;
//    [DSBezelActivityView newActivityViewForView:self.view];
    [self performSelector:@selector(displayMenu1:)];
    			
}

- (void)displayMenu1:(id)sender{
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    //[appDelegate startStandardActivityLoadingView:self.view];
    [self alertMessage];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDelegate stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)backToHome{
	
	[self.navigationController popViewControllerAnimated:YES];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc {
	//remove from notification
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    [serviceId release];
	[lblMessage release];
	[menuId release];
    [menuTitle release];
    [serviceName release];
    [aAlertView release];
//    [txtloginId release];
//    [loginView release];
//    [weatherView release];
//    [logOutBtn release];
//	
	[super dealloc];
}


@end
