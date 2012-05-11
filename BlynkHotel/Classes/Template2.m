//
//  Template2.m
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Template2.h"
#import "DSActivityView.h"
#import "EyeAppDelegate.h"

@implementation Template2
//@synthesize title1,weblink;
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
    aWebView.delegate = self;
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)removeMenuView:(id)sender{
    
    [self.view removeFromSuperview];
}


- (void)viewWillAppear:(BOOL)animated
{
    
//    lblTitle.text = title1;
    
  //  NSLog([NSString stringWithFormat:@"%@",weblink]);
    
    // NSString *youTubeVideoHTML = [NSString stringWithFormat:selectedVideo];
    //[aWebView loadHTMLString:youTubeVideoHTML baseURL:nil];
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //[DSBezelActivityView removeViewAnimated:YES];   
    //[appDel stopStandardActivityLoadingView];
    [NSThread detachNewThreadSelector:@selector(stopAct) toTarget:self withObject:nil];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
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

-(void)setLabelTxt:(NSString*)txt
{
    lblTitle.text = txt;
}
-(void)loadWebViewWith:(NSString*)webLink
{
    [NSThread detachNewThreadSelector:@selector(startAct) toTarget:self withObject:nil];            
    NSString *embedHTML = @"\
    <html><head>\
    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/>\
    <style type=\"text/css\">\
    body {\
    background-color: transparent;\
    color: red;\
    }\
    </style>\
    </head><body style=\"margin:0\">%@ </body></html>";
    NSString *html = [NSString stringWithFormat:embedHTML, webLink];
    // NSLog([NSString stringWithFormat:@"",html]);
    [aWebView loadHTMLString:html baseURL:nil];
}
-(void)startAct
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    //[DSBezelActivityView newActivityViewForView:aWebView];
    EyeAppDelegate *appDel = (EyeAppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDel startStandardActivityLoadingView:aWebView];
    [pool release];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [aWebView loadHTMLString:nil baseURL:nil];
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
