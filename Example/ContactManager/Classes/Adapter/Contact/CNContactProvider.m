//
//  CNContactProvider.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "CNContactProvider.h"

#import <Contacts/Contacts.h>

#import <Contacts/CNContainer.h>
#import <Contacts/CNContactFetchRequest.h>
#import <Contacts/CNPostalAddressFormatter.h>

@interface CNContactProvider()

@property(nonatomic, strong) CNContactStore *contactStore;

@end

@implementation CNContactProvider

- (instancetype)initWithContactStore:(CNContactStore *)contactStore {
    self = [super init];
    if (self) {
        _contactStore = contactStore;
    }
    return self;
}

- (NSArray *)fetchContacts {
    __block NSMutableArray *mutableArray  = [NSMutableArray new];
    
    NSError* contactError;
    NSPredicate *containerPredicate = [CNContainer predicateForContainersWithIdentifiers: @[self.contactStore.defaultContainerIdentifier]];
    [self.contactStore containersMatchingPredicate:containerPredicate error:&contactError];
    NSArray * keysToFetch =@[CNContactEmailAddressesKey, CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPostalAddressesKey];
    CNContactFetchRequest * request = [[CNContactFetchRequest alloc]initWithKeysToFetch:keysToFetch];
    [self.contactStore enumerateContactsWithFetchRequest:request
                                                                  error:&contactError
                                                             usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop){
                                                                 [mutableArray addObject:[self parseContact:contact]];
                                                             }];
    return mutableArray;
}

- (Contact *)parseContact :(CNContact* )cnContact
{
    Contact *contact = [Contact new];
    contact.firstName =  cnContact.givenName;
    contact.lastName =  cnContact.familyName;
    contact.email = [cnContact.emailAddresses valueForKey:@"value"];
    
    __block NSMutableArray *phoneNumbers = [NSMutableArray new];
    [cnContact.phoneNumbers enumerateObjectsUsingBlock:^(CNLabeledValue<CNPhoneNumber *> * _Nonnull phoneNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        [phoneNumbers addObject: phoneNumber.value.stringValue];
    }];
    contact.phoneNumbers = phoneNumbers;
    
    return contact;
}


@end
