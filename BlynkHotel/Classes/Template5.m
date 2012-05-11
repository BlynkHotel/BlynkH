//
//  Template5.m
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Template5.h"

@implementation Template5
//@synthesize title1,textDetail,photo;


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

- (void)viewWillAppear:(BOOL)animated{
    
//    lblTitle.text = title1;
//    
//    NSURL *url = [NSURL URLWithString:photo];  
//    NSData *data = [NSData dataWithContentsOfURL:url]; 
//    [photoImage setImage:[UIImage imageWithData:data]];
//    txtDetail.text = textDetail;
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
-(IBAction)removeMenuView:(id)sender{
    
    [self.view removeFromSuperview];
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    [photoImage release];
    [txtDetail release];
}


@end
