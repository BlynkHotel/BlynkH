//
//  Template3.m
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Template3.h"

@implementation Template3

//@synthesize weblink,title1;

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    
//    lblTitle.text = title1;
//    
//	[aWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weblink]]];
}
-(void)setLabelTxt:(NSString*)txt
{
    lblTitle.text = txt;
}
-(void)loadWebViewWith:(NSString*)webLink
{
    [aWebView setScalesPageToFit:YES];  
    [aWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:webLink]]];
}

-(IBAction)removeMenuView:(id)sender{
    
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
    
//    [title1 release];
//    [weblink release];
    [aWebView release];
}


@end
