//
//  Template4.h
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Template4 : UIViewController{
    
    IBOutlet UIScrollView *aScrollView;
    IBOutlet UIPageControl* pageControl;
    IBOutlet UILabel *lblTitle;
    NSMutableArray *imageArray;
    BOOL pageControlBeingUsed;
    
//    NSString *amentyId;
//    NSString *title1;
}

//@property(nonatomic,retain)NSString *title1;
//@property(nonatomic,retain)NSString *amentyId;
@property(nonatomic,retain)NSMutableArray *imageArray;

-(IBAction)changePage;
-(IBAction)removeMenuView:(id)sender;
- (void)layoutScrollImages;
-(void)setLabelText:(NSString*)txt;
-(void)loadImageWithAmentyId:(NSString*)amentyId;
@end
