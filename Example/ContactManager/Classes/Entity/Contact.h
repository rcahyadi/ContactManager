//
//  Contact.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;
@property(nonatomic, strong) NSString *nickName;

@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) NSString *address;

@property(nonatomic, strong) NSArray<NSString *> *phoneNumbers;

@end
