//
//  ViewController.m
//  ContactManager
//
//  Created by rakhmatc on 11/12/17.
//  Copyright © 2017 rakhmatc. All rights reserved.
//

#import "ViewController.h"

#import "ContactManager.h"
#import "ContactViewParam.h"
#import "ContactManagerFactory.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *contactList;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ContactManager *contactManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak ViewController *weakSelf = self;
    
    self.contactManager = [ContactManagerFactory createContactManager];
    
    [self.contactManager fetchContactWithCompletionBlock:^(NSArray<ContactViewParam *> *contacts, NSError *error) {
        if (contacts) {
            weakSelf.contactList = contacts;
            [weakSelf.tableView reloadData];
        } else {
            [weakSelf showAlert];
        }
    }];
}

-(void)dealloc {
    NSLog(@"dealloc called");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Contact *contact = (Contact *)self.contactList[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Contact *contact = (Contact *)self.contactList[indexPath.row];
    NSLog(@">>> contact %@", contact.phoneNumbers);
}


#pragma mark -

- (void)showAlert {
    __weak ViewController *weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:@"Allow App to access contacts"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *openSettingAction = [UIAlertAction actionWithTitle:@"Settings"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
                                                                  [weakSelf openSetting];
                                                              }];
    [alertController addAction:cancelAction];
    [alertController addAction:openSettingAction];
    [alertController setPreferredAction:openSettingAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)openSetting {
    NSURL *settingUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:settingUrl];
}

@end
