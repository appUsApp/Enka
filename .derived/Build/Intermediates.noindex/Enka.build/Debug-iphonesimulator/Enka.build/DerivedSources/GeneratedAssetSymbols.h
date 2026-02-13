#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "campaign" asset catalog image resource.
static NSString * const ACImageNameCampaign AC_SWIFT_PRIVATE = @"campaign";

/// The "clab" asset catalog image resource.
static NSString * const ACImageNameClab AC_SWIFT_PRIVATE = @"clab";

/// The "clam" asset catalog image resource.
static NSString * const ACImageNameClam AC_SWIFT_PRIVATE = @"clam";

/// The "oyster01" asset catalog image resource.
static NSString * const ACImageNameOyster01 AC_SWIFT_PRIVATE = @"oyster01";

/// The "oyster02" asset catalog image resource.
static NSString * const ACImageNameOyster02 AC_SWIFT_PRIVATE = @"oyster02";

/// The "shrimp" asset catalog image resource.
static NSString * const ACImageNameShrimp AC_SWIFT_PRIVATE = @"shrimp";

#undef AC_SWIFT_PRIVATE
