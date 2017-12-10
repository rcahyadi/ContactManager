//
//  ContactViewParam.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "ContactViewParam.h"

@implementation ContactViewParam

+ (instancetype)create:(Contact *)contact {
    ContactViewParam *contactViewParam = [ContactViewParam new];
    
    contactViewParam.firstName = contact.firstName;
    contactViewParam.lastName = contact.lastName;
    contactViewParam.email = contact.email;
    contactViewParam.phoneNumbers = contact.phoneNumbers;
    
    return contactViewParam;
}

@end
