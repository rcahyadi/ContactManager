//
//  ContactViewParam.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactViewParam : NSObject

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *nickName;

@property(nonatomic, strong) NSString *email;

@property(nonatomic, strong) NSArray<NSString *> *phoneNumbers;

+ (instancetype)create:(Contact *)contact;

@end
