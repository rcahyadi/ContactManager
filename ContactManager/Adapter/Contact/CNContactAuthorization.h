//
//  CNContactAuthorization.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/CNContactStore.h>
#import "ContactProviderAuthorization.h"

@interface CNContactAuthorization : NSObject <ContactProviderAuthorization>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithContactStore:(CNContactStore *) contactStore;


@end
