//
//  HotelReservation.m
//  Eye4
//
//  Created by Blynk Systems on 27/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotelReservation.h"
#import "BKAPIClient.h"
@implementation HotelReservation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    NSMutableDictionary *response1 = [BKAPIClient hotelReservation];
    NSString *weblink = [response1 valueForKey:@"hreserve_link"];
    [aWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weblink]]];
    aWebView.scalesPageToFit=YES;
    
   //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:weblink]];
    self.navigationItem.backBarButtonItem =
    [[[UIBarButtonItem alloc] initWithTitle:@"Back"
                                      style:UIBarButtonItemStyleBordered
                                     target:self
                                     action:@selector(backToHome)] autorelease];

}

- (IBAction)backToHome{
    
	[self.view removeFromSuperview];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)dealloc {
    
    [super dealloc];
    [aWebView release];
}

@end
