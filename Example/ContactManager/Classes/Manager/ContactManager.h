//
//  ContactManager.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactProvider.h"
#import "ContactProviderAuthorization.h"

#import "FetchContact.h"

@interface ContactManager : NSObject<FetchContact>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithContactProvider:(id<ContactProvider>) contactProvider
           contactProviderAuthorization:(id<ContactProviderAuthorization>) contactProviderAuthorization;


@end