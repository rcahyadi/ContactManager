//
//  ContactManagerFactory.h
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContactManager.h"


@interface ContactManagerFactory : NSObject

+ (ContactManager *)createContactManager;

@end
