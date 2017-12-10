//
//  ContactManagerFactory.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "ContactManagerFactory.h"

#import "ABContactProvider.h"
#import "ABContactProviderAuthorization.h"

#import "CNContactProvider.h"
#import "CNContactAuthorization.h"

#import "ContactProvider.h"
#import "ContactProviderAuthorization.h"


@implementation ContactManagerFactory

+ (ContactManager *)createContactManager {
    
    id<ContactProvider> contactProvider;
    id<ContactProviderAuthorization> contactProviderAuthorization;

    if([CNContactStore class]) {
        CNContactStore *contactStore = [CNContactStore new];
        contactProviderAuthorization = [[CNContactAuthorization alloc] initWithContactStore:contactStore];
        contactProvider = [[CNContactProvider alloc] initWithContactStore:contactStore];
    } else {
        ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
        contactProviderAuthorization = [[ABContactProviderAuthorization alloc] initWithAddressBookReference:addressBookRef];
        contactProvider = [[ABContactProvider alloc] initWithAddressBookReference:addressBookRef];
    }

    return [[ContactManager alloc] initWithContactProvider:contactProvider
                              contactProviderAuthorization:contactProviderAuthorization];
    
}

@end
