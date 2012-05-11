    //
//  HotelInformationView.m
//  Eye
//
//  Created by Blynk Systems on 10/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HotelInformationView.h"
#import "MessageView.h"
#import "EyeAppDelegate.h"
#import "BKAPIClient.h"
#import	"ShowMapView.h"
#import "HotelReservation.h"
#import "HelpView.h"
#import "DisplayView.h"
#import "DSActivityView.h"
#import "CustomBadge.h"
#import "AsyncImageView.h"
#import "proAlertView.h"
#import "SubMenuServiceModel.h"
#import "ImageDownloader.h"

@implementation HotelInformationView
@synthesize serviceId,menuId,menuTitle;


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
	
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [backImageView setImage:[UIImage imageWithData:appDelegate.data]];
    [logoView setImage:[UIImage imageWithData:appDelegate.data1]];  
    
    if ([appDelegate.hotelInformationArray count]==0)
    {
        NSArray *response = [BKAPIClient loadSubMenuView:@"6"];
        for (int i = 0; i<[response count]; i++)
        {
            SubMenuServiceModel *model = [[SubMenuServiceModel alloc]init];
            model.serviceName = [[response objectAtIndex:i] valueForKey:@"services_name"];
            model.serviceId = [[response objectAtIndex:i] valueForKey:@"services_id"];
            model.imgUrl = [[response objectAtIndex:i] valueForKey:@"image"];
            model.requestText = [[response objectAtIndex:i] valueForKey:@"request_text"];
            
            [appDelegate.hotelInformationArray addObject:model];
            [model release];
        }
    }

    [self displaySubMenu];
//    [self displayLogout];
//    logOutBtn.hidden=YES;
//    loginBtn.hidden=NO;
    helpBtn.hidden=YES;
    aDisplayView = [[DisplayView alloc]initWithNibName:@"DisplayView" bundle:nil];
    
//		[self receivedGuestDetails];
	
//    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dateAndtimeSetup) userInfo:nil repeats:YES];
    self.title = self.menuTitle;
}

-  (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    appDelegate= (EyeAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate displayGuestDetail];
//    [self setCustomBadge];
//	[self displayGuestDetail];

    
    NSTimer *theTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(changeBottomAdd) userInfo:nil repeats:YES];
    myTimer = theTimer;
     
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];

}

- (void)displaySubMenu{
	
	appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
	
    for (int i = 0; i < [appDelegate.hotelInformationArray count]; i++) 
	{
        SubMenuServiceModel *model = (SubMenuServiceModel*)[appDelegate.hotelInformationArray objectAtIndex:i];
        
		iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
		//iconButton.frame = CGRectMake(308 + 232 * (i % 3) + 768 * (i /10),28+230 * ((i / 3) % 5),220,218);
		iconButton.frame = CGRectMake(315 + 232 * (i % 3) + 768 * (i /10),23+230 * ((i / 3) % 5),220,218);
        
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
        
        NSString *sId = model.serviceId;
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

- (void)changeBottomAdd {
    
    appDelegate = (EyeAppDelegate*)[[UIApplication sharedApplication]delegate];
    
  //  NSLog([NSString stringWithFormat:@"%t",[appDelegate.adImageArray1 count]]);
    
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

- (IBAction)iconButtonClick:(id)sender{
	
    int j = [sender tag] -19;
	
	switch (j) {
		case 0: {
			
			aDisplayView.serviceId = [NSString stringWithFormat:@"%i",j+19];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu1:)];
					
		}
			break;
		case 1: {
			
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu2:)];
		}
			break; 
		case 2: {
			
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu3:)];
		}
			break;
		case 3: {
			
			aDisplayView.serviceId = [NSString stringWithFormat:@"%i",j+19];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu4:)];			
		}
			break;
		case 4: {
			
            aDisplayView.serviceId = [NSString stringWithFormat:@"%i",j+19];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu5:)];
			
		}
			break;
		case 5: {
			
			aDisplayView.serviceId = [NSString stringWithFormat:@"%i",j+19];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu6:)];	
			
		}
			break;
		case 6: {
			
            aDisplayView.serviceId = [NSString stringWithFormat:@"%i",j+19];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu7:)];	
		
		}
			break;
		case 7: {
			
            aDisplayView.serviceId = [NSString stringWithFormat:@"%i",j+19];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu8:)];		
            
		}
			break;
		case 8: {
			
			aDisplayView.serviceId = [NSString stringWithFormat:@"%i",j+19];
//            [DSBezelActivityView newActivityViewForView:self.view];
            [self performSelector:@selector(displayMenu9:)];	
            
		}
			break;
		default:
			break;
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

- (void)displayMenu1:(id)sender{
   // EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    
    [self.navigationController pushViewController:aDisplayView animated:YES];
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

- (void)displayMenu2:(id)sender{
    //EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    aShowMapView = [[ShowMapView alloc]initWithNibName:@"ShowMapView" bundle:nil];
    aShowMapView.view.frame = CGRectMake(294,12,713,702);
    aShowMapView.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aShowMapView.view];	
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (void)displayMenu3:(id)sender{
    //EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    
    aHotelReservation = [[HotelReservation alloc]initWithNibName:@"HotelReservation" bundle:nil];
    aHotelReservation.view.frame = CGRectMake(294,12,713,702);
    aHotelReservation.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:aHotelReservation.view];	
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (void)displayMenu4:(id)sender{
    //EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self.navigationController pushViewController:aDisplayView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (void)displayMenu5:(id)sender{
   // EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    
    [self.navigationController pushViewController:aDisplayView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (void)displayMenu6:(id)sender{
   // EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self.navigationController pushViewController:aDisplayView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (void)displayMenu7:(id)sender{
   // EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self.navigationController pushViewController:aDisplayView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
- (void)displayMenu8:(id)sender{
   // EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self.navigationController pushViewController:aDisplayView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
- (void)displayMenu9:(id)sender{
    //EyeAppDelegate *appDel = (EyeAppDelegate*)[[UIApplication sharedApplication] delegate];
    //[appDel startStandardActivityLoadingView:self.view];
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];
    [self.navigationController pushViewController:aDisplayView animated:YES];
    //[DSBezelActivityView removeViewAnimated:YES];
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}

- (IBAction)displayHelpView{
    
    HelpView *aHelpView = [[HelpView alloc]initWithNibName:@"HelpView" bundle:nil];
    aHelpView.view.frame = CGRectMake(294,56,713,702);
	[self.view addSubview:aHelpView.view];  
    [aHelpView release];
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
//	[appDelegate. menuNameArray6 release];
//	[appDelegate. menuImageArray6 release];
//    [appDelegate. serviceId6 release];
    [serviceId release];
	[menuId release];
    [menuTitle release];
    [serviceName release];
    [aShowMapView release];
    [aHotelReservation release];
//    [txtloginId release];
//    [loginView release];
//    [weatherView release];
//    [logOutBtn release];
	
    [super dealloc];
      
}


@end
