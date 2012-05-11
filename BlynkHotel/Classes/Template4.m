//
//  Template4.m
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Template4.h"
#import "BKAPIClient.h"
#import "AsyncImageView.h"

@implementation Template4
@synthesize imageArray;

const CGFloat kScrollObjHeight	= 490.0;
const CGFloat kScrollObjWidth	= 650.0;

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
    
    imageArray = [[NSMutableArray alloc] init];
    
    [aScrollView setCanCancelContentTouches:NO];
	aScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
	aScrollView.clipsToBounds = YES;		
	aScrollView.scrollEnabled = YES;
    aScrollView.pagingEnabled = YES;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
//    lblTitle.text = title1;
    
//    NSMutableDictionary *response = [BKAPIClient loadPhotoGalleryImages:amentyId];
//    self.imageArray = [response objectForKey:@"photoes"];
//    
//    pageControl.numberOfPages = [imageArray count];
//    
//	for (int i = 0; i < [imageArray count]; i++)
//	{
//        
//
//        /*
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.contentMode = UIViewContentModeScaleToFill;
//        
//        AsyncImageView *asyncImage = [[[AsyncImageView alloc]
//                                       init] autorelease];
//       
//        asyncImage.frame =  CGRectMake(28, 70,650 ,490);
//        asyncImage.tag = i+1 ;
//        
//        NSURL *url = [NSURL URLWithString:[imageArray objectAtIndex:i]];  
//        [asyncImage loadImageFromURL:url];
//        [imageView addSubview:asyncImage];
//         */
//        
//       	NSURL *url = [NSURL URLWithString:[imageArray objectAtIndex:i]];  
//		NSData *data = [NSData dataWithContentsOfURL:url];  
//		UIImage *image = [UIImage imageWithData:data];
//		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//         
//        imageView.frame = aScrollView.frame;
//		imageView.tag = i+1;
//        [aScrollView addSubview:imageView];
//        [imageView release];
//        
//    }
//  
//	[self layoutScrollImages];	
 
}
-(void)setLabelText:(NSString*)txt
{
    lblTitle.text = txt;
}
-(void)loadImageWithAmentyId:(NSString*)amentyId
{
    NSMutableDictionary *response = [BKAPIClient loadPhotoGalleryImages:amentyId];
    self.imageArray = [response objectForKey:@"photoes"];
    
    pageControl.numberOfPages = [imageArray count];
    
	for (int i = 0; i < [imageArray count]; i++)
	{
       	NSURL *url = [NSURL URLWithString:[imageArray objectAtIndex:i]];  
		NSData *data = [NSData dataWithContentsOfURL:url];  
		UIImage *image = [UIImage imageWithData:data];
		UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.frame = aScrollView.frame;
		imageView.tag = i+1;
        [aScrollView addSubview:imageView];
        [imageView release];
        
    }
    
	[self layoutScrollImages];	
}
- (void)layoutScrollImages
{
	UIImageView *view = nil;
	NSArray *subviews = [aScrollView subviews];
    
	// reposition all image subviews in a horizontal serial fashion
	CGFloat curXLoc = 0;
	for (view in subviews)
	{
		if ([view isKindOfClass:[UIImageView class]] && view.tag > 0)
		{
			CGRect frame = CGRectMake(28, 70, 650, 490);
			frame.origin = CGPointMake(curXLoc,0);
			view.frame = frame;
			curXLoc += (kScrollObjWidth);
		}
	}
	// set the content size so it can be scrollable
	[aScrollView setContentSize:CGSizeMake(([imageArray count] * kScrollObjWidth),500)];
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = aScrollView.frame.size.width;
    int page = floor((aScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
}

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = aScrollView.frame.size.width * pageControl.currentPage;
    frame.origin.y = self.view.frame.origin.y+70;
    frame.size = aScrollView.frame.size;
    [aScrollView scrollRectToVisible:frame animated:YES];
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlBeingUsed = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlBeingUsed = YES;
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
    
//    [amentyId release];
//    [title1 release];
    [aScrollView release];
    [imageArray release];
}


@end
