
#import "BKAPIResponse.h"

@implementation BKAPIResponse

@synthesize status, data;

+ (BKAPIResponse *)responseWithStatus:(BOOL)vStatus andData:(NSMutableDictionary *)vData{
	
	return [[BKAPIResponse alloc] initWithStatus:vStatus andData:vData];
	
}

+ (BKAPIResponse *)responseWithDictionary:(NSMutableDictionary *)dict {
	
	return [[BKAPIResponse alloc] initWithDictionary:dict];
	
}

- (id)initWithStatus:(BOOL)vStatus andData:(NSMutableDictionary *)vData {
	
	if (self = [super init]) {
		// Custom initialization
		self.status = vStatus;
		self.data = vData;
	}
	return self;
	
}


- (id)initWithDictionary:(NSMutableDictionary *)dict {

	if (self = [super init]) {
		self.data = dict;
		if ([[self.data objectForKey:@"success"] isEqualToString:@"Login Success"]) {
			self.status = YES;
		} else {
			self.status = NO;
		}
	}
	return self;
	
}

@end