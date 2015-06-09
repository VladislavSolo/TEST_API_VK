//
//  ViewController.m
//  API_VK_TEST
//
//  Created by Владислав Станишевский on 6/8/15.
//  Copyright (c) 2015 Vlad Stanishevskij. All rights reserved.
//
#import "ViewController.h"
#import "VSServerManager.h"
#import "VSUserFriend.h"
#import  <UIImageView+AFNetworking.h>

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.friendsArray = [[NSMutableArray alloc] init];
    
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
                                                          
                                                          self.friendsArray = [NSMutableArray arrayWithArray:friends];
                                                          [self.tableView reloadData];
                                                          
                                                      } onFailure:^(NSError *error, NSInteger statusCode) {
                                                          NSLog(@"Error - %@, Status code - %ld ", [error localizedDescription], (long)statusCode);
                                                      }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    VSUserFriend *user = [self.friendsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:user.imgURL];
    
    __weak UITableViewCell *weakCell = cell;
    
    cell.imageView.image = nil;
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       
                                       weakCell.imageView.image = image;
                                       [weakCell layoutSubviews];
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                   
                                   
                                   }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
