
#import <Foundation/Foundation.h>

@interface BKAPIResponse : NSObject {

	BOOL					status;
	NSMutableDictionary		* data;
	
}

@property (nonatomic) BOOL status;
@property (nonatomic, retain) NSMutableDictionary *data;

+ (BKAPIResponse *)responseWithStatus:(BOOL)vStatus andData:(NSMutableDictionary *)vData;
+ (BKAPIResponse *)responseWithDictionary:(NSMutableDictionary *)dict;
- (id)initWithStatus:(BOOL)vStatus andData:(NSMutableDictionary *)vData;
- (id)initWithDictionary:(NSMutableDictionary *)dict;	

@end
