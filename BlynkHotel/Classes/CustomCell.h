//
//  CustomCell.h
//  Eye
//
//  Created by Blynk Systems on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomCell : UITableViewCell {
	
	UILabel *primaryLabel;
	UILabel *secondaryLabel;
	UILabel *priceLabel;
}
@property(nonatomic,retain)UILabel *primaryLabel;
@property(nonatomic,retain)UILabel *secondaryLabel;
@property(nonatomic,retain)UILabel *priceLabel;


@end
