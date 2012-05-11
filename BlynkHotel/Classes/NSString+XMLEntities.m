#import "NSString+XMLEntities.h"

@implementation NSString (XMLEntities)

- (NSString *)stringByDecodingXMLEntities {
	return [self stringByDecodingHTMLEntities];
}

- (NSString *)stringByEncodingXMLEntities {
	return [self stringByEncodingHTMLEntities];
}

@end
