//
//  Template6.m
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Template6.h"

@implementation Template6
//@synthesize title1,textDetail,photo,webLink;

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

-(IBAction)removeMenuView:(id)sender{
    
    [self.view removeFromSuperview];
}

- (void)viewWillAppear:(BOOL)animated{
    
//    lblTitle.text = title1;
//    
//    NSURL *url = [NSURL URLWithString:photo];  
//    NSData *data = [NSData dataWithContentsOfURL:url]; 
//    [photoImage setImage:[UIImage imageWithData:data]];
//    txtDetail.text = textDetail;
//    
//  //  NSLog([NSString stringWithFormat:@"%@",webLink]);
//    
//    // NSString *youTubeVideoHTML = [NSString stringWithFormat:selectedVideo];
//    //[aWebView loadHTMLString:youTubeVideoHTML baseURL:nil];
//    
//    NSString *embedHTML = @"\
//    <html><head>\
//    <meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no, width = 212\"/>\
//    <style type=\"text/css\">\
//    body {\
//    background-color: transparent;\
//    color: red;\
//    }\
//    </style>\
//    </head><body style=\"margin:0\">%@ </body></html>";
//    NSString *html = [NSString stringWithFormat:embedHTML, webLink];
//  //  NSLog([NSString stringWithFormat:@"",html]);
//    [aWebView loadHTMLString:html baseURL:nil];

}

-(void)setLabelText:(NSString*)txt
{
    lblTitle.text = txt;
}
-(void)setTextViewText:(NSString*)txt
{
    txtDetail.text = txt;
}
-(void)setPhotoUrlString:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];  
    NSData *data = [NSData dataWithContentsOfURL:url]; 
    [photoImage setImage:[UIImage imageWithData:data]];
}
-(void)loadWebViewWith:(NSString*)webLink
{
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
    //  NSLog([NSString stringWithFormat:@"",html]);
    [aWebView loadHTMLString:html baseURL:nil];
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
//    [textDetail release];
//    [photo release];
//    [webLink release];
    [aWebView release];
    [photoImage release];
    [txtDetail release];
}

@end
