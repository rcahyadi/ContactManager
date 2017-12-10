//
//  ContactListViewParam.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactViewParam.h"
#import "Contact.h"

@interface ContactListViewParam : NSObject

+ (NSArray<ContactViewParam *> *)create:(NSArray<Contact *> *)contacts;

@end
