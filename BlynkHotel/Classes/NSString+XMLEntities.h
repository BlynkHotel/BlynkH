#import <Foundation/Foundation.h>

// Import new HTML category
#import "NSString+HTML.h"

@interface NSString (XMLEntities)

// Old Instance Methods
- (NSString *)stringByDecodingXMLEntities;
- (NSString *)stringByEncodingXMLEntities;

@end
