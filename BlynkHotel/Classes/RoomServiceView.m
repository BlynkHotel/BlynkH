    //
//  RoomServiceView.m
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RoomServiceView.h"
#import "WakeUpCallView.h"
#import "MessageView.h"
#import "EyeAppDelegate.h"
#import "BKAPIClient.h"
#import "HelpView.h"
#import "CustomBadge.h"
#import "DSActivityView.h"
#import "AsyncImageView.h"
#import "proAlertView.h"
#import "SubMenuServiceModel.h"
#import "ImageDownloader.h"
@implementation RoomServiceView
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


- (void)viewDidLoad 
{
    [super viewDidLoad];
    
	//register for custombadge updated notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customBadgeUpdated) name:[NotificationNames notificationNameForCustomBadgeUpdate] object:nil];
//	//register for received guest details notification
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGuestDetails) name:[NotificationNames notificationNameForGuestDetails] object:nil];
	
//    aAlertView = [[UIView alloc]initWithFrame:CGRectMake(294,12,713,702)];
    
	lblMessage = [[UILabel alloc] initWithFrame:CGRectMake(100,100,550,250)];
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [backImageView setImage:[UIImage imageWithData:appDelegate.data]];
    [logoView setImage:[UIImage imageWithData:appDelegate.data1]];
//    [self alertMessage];
    
//    [self displayLogout];
    
//    helpBtn.hidden=YES;
//    logOutBtn.hidden=YES;
//    loginBtn.hidden=NO;
    
//	[self receivedGuestDetails];
	
//     NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
    if ([appDelegate.roomServiceArray count]==0)
    {
        NSArray *response = [BKAPIClient loadSubMenuView:@"2"];
        for (int i = 0; i<[response count]; i++)
        {
            SubMenuServiceModel *model = [[SubMenuServiceModel alloc]init];
            model.serviceName = [[response objectAtIndex:i] valueForKey:@"services_name"];
            model.serviceId = [[response objectAtIndex:i] valueForKey:@"services_id"];
            model.imgUrl = [[response objectAtIndex:i] valueForKey:@"image"];
            model.requestText = [[response objectAtIndex:i] valueForKey:@"request_text"];
            
            [appDelegate.roomServiceArray addObject:model];
            [model release];
        }
    }
    
    [self displaySubMenu];
    
    self.title = self.menuTitle;
}
 
-  (void)viewWillAppear:(BOOL)animated 
{
       [super viewWillAppear:animated];
    
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSTimer *theTimer1 = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeBottomAdd) userInfo:nil repeats:YES];
    myTimer = theTimer1;
     
    [appDelegate displayGuestDetail];
    
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];

//    [self setCustomBadge];
     
}

- (IBAction)displayHelpView{
    
    HelpView *aHelpView = [[HelpView alloc]initWithNibName:@"HelpView" bundle:nil];
    aHelpView.view.frame = CGRectMake(294,56,713,702);
	[self.view addSubview:aHelpView.view];  
    
}

- (void)displaySubMenu{
	
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
	
//	for (int i = 0; i < [appDelegate.serviceId2 count]; i++) 
    for (int i = 0; i < [appDelegate.roomServiceArray count]; i++) 
	{
        SubMenuServiceModel *model = (SubMenuServiceModel*)[appDelegate.roomServiceArray objectAtIndex:i];
        
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
		lblTitle.text = model.serviceName;//[NSString stringWithFormat:@"%@",[appDelegate.menuNameArray2 objectAtIndex:i]]; 
		lblTitle.textAlignment = UITextAlignmentLeft;
        
		lblTitle.font = [UIFont fontWithName:@"FUTURAN" size:20];
        lblTitle.font = [UIFont boldSystemFontOfSize:20];
		lblTitle.lineBreakMode = UILineBreakModeMiddleTruncation;
		
		lblTitle.backgroundColor = [UIColor clearColor];
		lblTitle.textColor = [UIColor whiteColor];
		[itemButton addSubview:lblTitle];
        
        NSString *sId = model.serviceId;//[appDelegate.serviceId2 objectAtIndex:i];
        NSLog(@"sId : %d",[sId intValue]);
        itemButton.tag = [[NSString stringWithFormat:@"%@", sId] intValue];
        iconButton.tag = [[NSString stringWithFormat:@"%@", sId] intValue];
		iconButton.backgroundColor=[UIColor clearColor];
        
        [itemButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];  
		[iconButton addTarget:self action:@selector(iconButtonClick:) forControlEvents:UIControlEventTouchUpInside];   
		[iconButton addSubview:itemButton];
		[self.view addSubview:iconButton];
		
	}
	
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [myTimer invalidate];
}
- (void)changeBottomAdd 
{
    
    appDelegate =(EyeAppDelegate*) [[UIApplication sharedApplication]delegate];
    
   // NSLog([NSString stringWithFormat:@"%t",[appDelegate.adImageArray1 count]]);
    
    if ( t<[appDelegate.adImageArray1 count]) {
        
        NSURL *url = [NSURL URLWithString:[appDelegate.adImageArray1 objectAtIndex:t]];
		if (appDelegate.isNetworkAvailable)
        {
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

-(void)loadHotelLogo{
    
    NSMutableDictionary *response = [BKAPIClient loadHetelLogo];
	//NSLog([NSString stringWithFormat:@"%@",response]);
	NSURL *url = [NSURL URLWithString:[response objectForKey:@"hlogo"]];  
    NSData *data = [NSData dataWithContentsOfURL:url];  
    [logoView setImage:[UIImage imageWithData:data]];
    
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
        yesBtn.tag = 777;
        UIButton *noBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        yesBtn.frame = CGRectMake(222,350,110,40);
        noBtn.frame = CGRectMake(371,350,110,40);
        noBtn.tag = 888;
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"yes_butan.png"] forState:UIControlStateNormal];
        [noBtn setBackgroundImage:[UIImage imageNamed:@"No_butan.png"] forState:UIControlStateNormal];
        [yesBtn setTitle:@"Yes" forState:UIControlStateNormal];
        [noBtn setTitle:@"No" forState:UIControlStateNormal];
        
        [yesBtn addTarget:self action:@selector(yesBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [noBtn addTarget:self action:@selector(noBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [aAlertView addSubview:lblMessage];
        [aAlertView addSubview:yesBtn];
        [aAlertView addSubview:noBtn];
        

    }
    UIButton *yesBtn = (UIButton*)[aAlertView viewWithTag:777];
    UIButton *noBtn = (UIButton*)[aAlertView viewWithTag:888];
    if (appDelegate.isGuest == YES && appDelegate.isActive == YES) {
        yesBtn.enabled = YES;
        noBtn.enabled = YES;
    }
    else 
    {
        
        [yesBtn setBackgroundImage:[UIImage imageNamed:@"no_button.png"] forState:UIControlStateNormal];
        [noBtn setBackgroundImage:[UIImage imageNamed:@"no_button.png"] forState:UIControlStateNormal];
        
        yesBtn.enabled = NO;
        noBtn.enabled = NO;
        
    }
    [self.view addSubview:aAlertView];
    
}

- (IBAction)removeAlert:(id)sender
{
    
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
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDel startStandardActivityLoadingView:self.view];
    [pool release];
}

- (void)confirmMesssage:(id)sender{

 // NSLog([NSString stringWithFormat:@"%@",serviceId]);
   // EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    
    NSMutableDictionary *response = [BKAPIClient sendMenuResponce:@"2" guestId:appDelegate.appLoginId serviceId:serviceId info:@"no"];
 //	NSLog([NSString stringWithFormat:@"%@",response]);
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

-(void)stopAct
{
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate]; 
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [appDel stopStandardActivityLoadingView];
    [pool release];
}

-(IBAction)noBtnAction{
    
	[aAlertView removeFromSuperview];
}


- (IBAction)iconButtonClick:(id)sender{
	
    
    int j = [sender tag]-1;
	SubMenuServiceModel *model = (SubMenuServiceModel*)[appDelegate.roomServiceArray objectAtIndex:j];
	switch (j) {
		case 0: {
            
            serviceId = [NSString stringWithFormat:@"%i",j+1];
            [serviceId retain];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu1:)];
          
        }
			break;
		case 1: {
			
            [serviceId release];
            serviceId = [NSString stringWithFormat:@"%i",j+1];
            [serviceId retain];
//            lblMessage.text = [appDelegate.requestArray2 objectAtIndex:j];
            lblMessage.text =model.requestText;
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu2:)];
         	
		}
			break; 
		case 2: {
			
            [serviceId release];
            serviceId = [NSString stringWithFormat:@"%i",j+1];
            [serviceId retain];
//            lblMessage.text = [appDelegate.requestArray2 objectAtIndex:j];
            lblMessage.text =model.requestText;            
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu2:)];
            
		}
			break;
		case 3: {
			
            [serviceId release];
            serviceId = [NSString stringWithFormat:@"%i",j+1];
            [serviceId retain];
//            lblMessage.text = [appDelegate.requestArray2 objectAtIndex:j];
            lblMessage.text =model.requestText;            
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu2:)];
			
		}
			break;
		case 4: {
			
             [serviceId release];
             serviceId = [NSString stringWithFormat:@"%i",j+1];
             [serviceId retain];
//             lblMessage.text = [appDelegate.requestArray2 objectAtIndex:j];
            lblMessage.text =model.requestText;            
//             [DSBezelActivityView newActivityViewForView:self.view];
             [self performSelector:@selector(displayMenu2:)];

		}
			break;
		case 5: {
			
             [serviceId release];
             serviceId = [NSString stringWithFormat:@"%i",j+1];
             [serviceId retain];
//             lblMessage.text = [appDelegate.requestArray2 objectAtIndex:j];
            lblMessage.text =model.requestText;            
//             [DSBezelActivityView newActivityViewForView:self.view];
             [self performSelector:@selector(displayMenu2:)];
              
		}
			break;
		default:
			break;
	}
	
}

- (void)displayMenu1:(id)sender{
    //EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    WakeUpCallView *aWakeUpCallView=[[WakeUpCallView alloc]initWithNibName:@"WakeUpCallView" bundle:nil];
    aWakeUpCallView.serviceId = serviceId;
    aWakeUpCallView.view.frame = CGRectMake(294,12,713,702);
    [self.view addSubview:aWakeUpCallView.view]; 
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
- (void)displayMenu2:(id)sender{
   // EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self alertMessage];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)backToHome{
	
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)WakeUpCallView{
	
	WakeUpCallView *aWakeUpCallView = [[WakeUpCallView alloc]initWithNibName:@"WakeUpCallView" bundle:nil];
	[self.navigationController pushViewController:aWakeUpCallView animated:YES];	
	
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
   
    [lblMessage release];
    [aAlertView release];
//    [logOutBtn release];
	[menuId release];
    [menuTitle release];
    [serviceId release];
    [serviceName release];
//    [txtloginId release];
//    [loginView release];
//    [weatherView release];
	
	 [super dealloc];
}


@end
