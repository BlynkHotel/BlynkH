#import <Foundation/Foundation.h>

/// Utilities for NSStrings containing HTML
@interface NSString (GTMNSStringHTMLAdditions)

- (NSString *)gtm_stringByEscapingForHTML;
- (NSString *)gtm_stringByEscapingForAsciiHTML;
- (NSString *)gtm_stringByUnescapingFromHTML;

@end