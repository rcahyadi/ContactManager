//
//  ContactManager.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "ContactManager.h"
#import "ContactListViewParam.h"
#import "Contact.h"

@interface ContactManager()

@property(nonatomic, strong) id<ContactProvider> contactProvider;
@property(nonatomic, strong) id<ContactProviderAuthorization> contactProviderAuthorization;

@end

@implementation ContactManager

- (instancetype)initWithContactProvider:(id<ContactProvider>)contactProvider
           contactProviderAuthorization:(id<ContactProviderAuthorization>)contactProviderAuthorization {
    
    self = [super init];
    
    if (self) {
        _contactProvider = contactProvider;
        _contactProviderAuthorization = contactProviderAuthorization;
    }
    
    return self;
    
}

- (void)fetchContactWithCompletionBlock:(ContactManagerFetchCompletionBlock)completionBlock {
    __weak ContactManager *weakSelf = self;
    
    [self.contactProviderAuthorization
     authorizeWithCompletionBlock:^(ContactProviderAuthorizationStatus authorizationStatus, NSError *error) {
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             NSArray<ContactViewParam *> *contactViewParams;
             if (authorizationStatus == kAuthorizationStatusAuthorized && completionBlock) {
                 NSArray<Contact *> *contacts = [weakSelf.contactProvider fetchContacts];
                 contactViewParams = [ContactListViewParam create:contacts];
             }
             
             if(completionBlock) {
              dispatch_async(dispatch_get_main_queue(), ^{
                  completionBlock(contactViewParams, error);
              });
             }
         });
     }];
}

@end
