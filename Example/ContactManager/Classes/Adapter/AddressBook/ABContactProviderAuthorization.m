//
//  ABContactProviderAuthorization.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "ABContactProviderAuthorization.h"

@interface ABContactProviderAuthorization()

@property(nonatomic) ABAddressBookRef addressBookReference;

@end

@implementation ABContactProviderAuthorization

-(instancetype)initWithAddressBookReference:(ABAddressBookRef)addressBook {
    self = [super init];
    if (self) {
        _addressBookReference = addressBook;
    }
    return self;
}

- (ContactProviderAuthorizationStatus)authorizationStatus {
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    switch (authorizationStatus) {
        case kABAuthorizationStatusDenied:
            return kAuthorizationStatusDenied;
        case kABAuthorizationStatusNotDetermined:
            return kAuthorizationStatusNotDetermined;
        case kABAuthorizationStatusRestricted:
            return kAuthorizationStatusRestricted;
        case kABAuthorizationStatusAuthorized:
            return kAuthorizationStatusAuthorized;
    }
}

- (void)authorizeWithCompletionBlock:(ContactProviderAuthorizationCompletionBlock)completionBlock {
    ABAddressBookRequestAccessWithCompletion(self.addressBookReference, ^(bool granted, CFErrorRef error) {
        if (granted) {
            if (completionBlock) {
                completionBlock(kAuthorizationStatusAuthorized, nil);
            }
        } else if (completionBlock) {
            NSError *nsError = (__bridge NSError *)error;
            completionBlock(kAuthorizationStatusNotDetermined, nsError);
        }
    });
}


@end
