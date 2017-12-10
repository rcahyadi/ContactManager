//
//  CNContactAuthorization.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "CNContactAuthorization.h"
#import <Contacts/CNContactStore.h>

@interface CNContactAuthorization()

@property(nonatomic, strong) CNContactStore *contactStore;

@end

@implementation CNContactAuthorization

- (instancetype)initWithContactStore:(CNContactStore *)contactStore {
    self = [super init];
    if (self) {
        _contactStore = contactStore;
    }
    return self;
}

- (ContactProviderAuthorizationStatus)authorizationStatus {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusDenied:
            return kAuthorizationStatusDenied;
        case CNAuthorizationStatusNotDetermined:
            return kAuthorizationStatusNotDetermined;
        case CNAuthorizationStatusRestricted:
            return kAuthorizationStatusRestricted;
        case CNAuthorizationStatusAuthorized:
        return kAuthorizationStatusAuthorized;
    }
}

- (void)authorizeWithCompletionBlock:(ContactProviderAuthorizationCompletionBlock)completionBlock {
    [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted && completionBlock) {
                completionBlock(kAuthorizationStatusAuthorized, nil);
        } else if (completionBlock) {
            completionBlock(kAuthorizationStatusNotDetermined, error);
        }
    }];
}

@end
