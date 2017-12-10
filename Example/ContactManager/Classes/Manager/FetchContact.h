//
//  FetchContact.h
//  ContactProvider
//
//  Created by rakhmatc on 11/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ContactViewParam;

typedef void (^ContactManagerFetchCompletionBlock)(NSArray <ContactViewParam *> *contacts, NSError *error);

@protocol FetchContact <NSObject>

- (void)fetchContactWithCompletionBlock:(ContactManagerFetchCompletionBlock) completionBlock;

@end
