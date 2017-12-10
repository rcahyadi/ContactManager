//
//  ContactListViewParam.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "ContactListViewParam.h"

@implementation ContactListViewParam

+ (NSArray<ContactViewParam *> *)create:(NSArray<Contact *> *)contacts {
    __block NSMutableArray *contactList = [NSMutableArray new];

    [contacts enumerateObjectsUsingBlock:^(Contact * _Nonnull contact, NSUInteger idx, BOOL * _Nonnull stop) {
        ContactViewParam *contactViewParam = [ContactViewParam create:contact];
        [contactList addObject:contactViewParam];
    }];
    
    return contactList;
}

@end
