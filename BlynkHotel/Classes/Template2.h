//
//  Template2.h
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Template2 : UIViewController<UIWebViewDelegate>{
    
    IBOutlet UIWebView *aWebView;
    IBOutlet UILabel *lblTitle;
    
//    NSString *title1;
//    NSString *weblink;
}
//@property(nonatomic,retain) NSString *title1;
//@property(nonatomic,retain) NSString *weblink;
-(IBAction)removeMenuView:(id)sender;
-(void)setLabelTxt:(NSString*)txt;
-(void)loadWebViewWith:(NSString*)webLink;
@end
