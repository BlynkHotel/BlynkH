//
//  HelpView.h
//  Eye4
//
//  Created by Blynk Systems on 09/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpView : UIViewController <UIWebViewDelegate>{

    IBOutlet UIWebView *aWebView;
}

- (IBAction)RemoveView;

@end
