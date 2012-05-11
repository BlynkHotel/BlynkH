//
//  Template1.h
//  Eye4
//
//  Created by Blynk Systems on 28/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Template1 : UIViewController{
    
    IBOutlet UITextView *txtDetail;
    IBOutlet UILabel *lblTitle;
    
//    NSString *textDetail;
//    NSString *title1;
    
}
//@property(nonatomic,retain) NSString *textDetail;
//@property(nonatomic,retain) NSString *title1;
-(IBAction)removeMenuView:(id)sender;
-(void)setLabelText:(NSString*)txt;
-(void)setTextViewText:(NSString*)txt;
@end
