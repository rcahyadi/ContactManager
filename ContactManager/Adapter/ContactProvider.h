//
//  ContactProvider.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@protocol ContactProvider <NSObject>

- (NSArray<Contact *> *)fetchContacts;

@end