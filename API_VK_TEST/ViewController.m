//
//  ViewController.m
//  API_VK_TEST
//
//  Created by Владислав Станишевский on 6/8/15.
//  Copyright (c) 2015 Vlad Stanishevskij. All rights reserved.
//
#import "ViewController.h"
#import "VSServerManager.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getFriendsFromServer];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (void) getFriendsFromServer {
    
    [[VSServerManager sharedManager] getFriendsNumberWithOffset:[self.friendsArray count]
                                                          count:20
                                                      onSuccess:^(NSArray *friends) {
                                                          
                                                          [self.friendsArray addObjectsFromArray:friends];
                                                          [self.tableView reloadData];
                                                          
                                                      } onFailure:^(NSError *error, NSInteger statusCode) {
                                                          NSLog(@"Error - %@, Status code - %ld ", [error localizedDescription], (long)statusCode);
                                                      }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

@end
