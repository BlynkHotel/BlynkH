//
//  Template1.m
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Template1.h"

@implementation Template1
//@synthesize textDetail,title1;
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

- (void)viewWillAppear:(BOOL)animated
{
    
//    lblTitle.text = title1;
//    txtDetail.text = [NSString stringWithFormat:@"%@",textDetail];
}
-(void)setLabelText:(NSString*)txt
{
    lblTitle.text = txt;
}
-(void)setTextViewText:(NSString*)txt
{
    txtDetail.text = txt;
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
    
//    [textDetail release];
//    [title1 release];
}

@end
