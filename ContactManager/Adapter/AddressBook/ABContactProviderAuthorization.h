//
//  ABContactProviderAuthorization.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "ContactProviderAuthorization.h"


@interface ABContactProviderAuthorization : NSObject <ContactProviderAuthorization>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithAddressBookReference:(ABAddressBookRef) addressBook;

@end
