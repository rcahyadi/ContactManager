//
//  ContactProviderAuthorization.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kAuthorizationStatusNotDetermined = 0,
    kAuthorizationStatusRestricted,
    kAuthorizationStatusDenied,
    kAuthorizationStatusAuthorized
} ContactProviderAuthorizationStatus;

typedef void (^ContactProviderAuthorizationCompletionBlock)(ContactProviderAuthorizationStatus authorizationStatus, NSError *error);


@protocol ContactProviderAuthorization <NSObject>

- (ContactProviderAuthorizationStatus)authorizationStatus;
- (void)authorizeWithCompletionBlock:(ContactProviderAuthorizationCompletionBlock)completionBlock;

@end
