//
//  CustomCell.m
//  Eye
//
//  Created by Blynk Systems on 12/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize primaryLabel,secondaryLabel,priceLabel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) {
		
		// Initialization code
		primaryLabel = [[UILabel alloc]init];
		primaryLabel.textAlignment = UITextAlignmentLeft;
		primaryLabel.font = [UIFont systemFontOfSize:18];

		secondaryLabel = [[UILabel alloc]init];
		secondaryLabel.textAlignment = UITextAlignmentLeft;
		secondaryLabel.font = [UIFont systemFontOfSize:14];
		priceLabel = [[UILabel alloc]init];
		priceLabel.textAlignment = UITextAlignmentRight;
		priceLabel.font = [UIFont systemFontOfSize:18];
        
		[self.contentView addSubview:primaryLabel];
		[self.contentView addSubview:secondaryLabel];
		[self.contentView addSubview:priceLabel];
		
	}
	return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		// Initialization code
		primaryLabel = [[UILabel alloc]init];
		primaryLabel.textAlignment = UITextAlignmentLeft;
		primaryLabel.font = [UIFont systemFontOfSize:18];
        
		secondaryLabel = [[UILabel alloc]init];
		secondaryLabel.textAlignment = UITextAlignmentLeft;
		secondaryLabel.font = [UIFont systemFontOfSize:14];
		priceLabel = [[UILabel alloc]init];
		priceLabel.textAlignment = UITextAlignmentRight;
		priceLabel.font = [UIFont systemFontOfSize:18];
        
		[self.contentView addSubview:primaryLabel];
		[self.contentView addSubview:secondaryLabel];
		[self.contentView addSubview:priceLabel];
		
	}
	return self;

}

- (void)layoutSubviews {
    
	[super layoutSubviews];
	CGRect contentRect = self.contentView.bounds;
	CGFloat boundsX = contentRect.origin.x;
	CGRect frame;
	
	frame= CGRectMake(boundsX+10 ,5,335, 25);
	primaryLabel.frame = frame;
	
	frame= CGRectMake(boundsX+10 ,30,335, 15);
	secondaryLabel.frame = frame;
	
	frame= CGRectMake(boundsX+340,10,120,30);
	priceLabel.frame = frame;
	
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	// Configure the view for the selected state
}

@end
