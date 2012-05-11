//
//  HotelReservation.h
//  Eye4
//
//  Created by Blynk Systems on 27/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelReservation : UIViewController <UIWebViewDelegate>{

       IBOutlet UIWebView *aWebView;
    
}

-(IBAction)backToHome;

@end
