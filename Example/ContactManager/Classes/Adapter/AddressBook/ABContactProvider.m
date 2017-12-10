//
//  ABContactProvider.m
//  ContactProvider
//
//  Created by rakhmatc on 10/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "ABContactProvider.h"

@interface ABContactProvider()

@property(nonatomic) ABAddressBookRef addressBookReference;

@end

@implementation ABContactProvider


-(instancetype)initWithAddressBookReference:(ABAddressBookRef)addressBook {
    self = [super init];
    if (self) {
        _addressBookReference = addressBook;
    }
    
    return self;
    
}

- (NSArray<Contact *> *)fetchContacts {
    NSMutableArray *contactList = [[NSMutableArray alloc] init];
    CFArrayRef contacts = ABAddressBookCopyArrayOfAllPeople(self.addressBookReference);
    CFIndex numberOfContacts = ABAddressBookGetPersonCount(self.addressBookReference);
    
    for (int index = 0; index < numberOfContacts; index++) {
        Contact *contact = [Contact new];
        ABRecordRef addressBookRecordReference = CFArrayGetValueAtIndex(contacts,index);
        
        NSArray *emails = [self extractEmails:addressBookRecordReference];
        if (emails.count) {
            contact.email = emails.firstObject;
        }

        contact.phoneNumbers = [self extractPhoneNumbers:addressBookRecordReference];
        contact.firstName = [self extractPropertyWithId:kABPersonFirstNameProperty
                                   addressbookReference:addressBookRecordReference];
        contact.lastName = [self extractPropertyWithId:kABPersonLastNameProperty
                                  addressbookReference:addressBookRecordReference];
        contact.nickName = [self extractPropertyWithId:kABPersonNicknameProperty
                                 addressbookReference:addressBookRecordReference];
        
        [contactList addObject:contact];
        
    }

    NSLog(@"Contacts = %@",contactList);
    
    return contactList;
}


#pragma mark -

- (NSString *)extractPropertyWithId:(ABPropertyID) propertyId
               addressbookReference:(ABRecordRef) addressBookRecordReference {
    CFStringRef stringReference;
    stringReference = ABRecordCopyValue(addressBookRecordReference, propertyId);

    if (stringReference) {
        return [NSString stringWithFormat:@"%@", stringReference];
    }
    
    return @"";
}

- (NSArray<NSString *> *)extractPhoneNumbers:(ABRecordRef) addressBookRecordReference {
    NSMutableArray *phoneNumbers = [NSMutableArray new];
    ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(addressBookRecordReference, kABPersonPhoneProperty));
    for(CFIndex index = 0; index < ABMultiValueGetCount(phones); index++) {
        NSString *phoneNumber = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, index) ;
        [phoneNumbers addObject:phoneNumber];
    }
    
    return phoneNumbers;
}

- (NSArray<NSString *> *)extractEmails:(ABRecordRef) addressBookRecordReference {
    NSMutableArray *emails = [NSMutableArray new];
    ABMutableMultiValueRef eMail  = ABRecordCopyValue(addressBookRecordReference, kABPersonEmailProperty);
    if(ABMultiValueGetCount(eMail) > 0) {
        NSString *email = (__bridge NSString *)ABMultiValueCopyValueAtIndex(eMail, 0);
        [emails addObject:email];
    }
    
    return emails;
}

@end
