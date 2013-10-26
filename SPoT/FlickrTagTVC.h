//
//  FlickrTagTVC.h
//  SPoT
//
//  Created by Manners Oshafi on 20/10/2013.
//  Copyright (c) 2013 Gotomanners. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrTagTVC : UITableViewController

@property (nonatomic, strong) NSArray *photos; // of NSDictionary
@property (nonatomic, strong) NSDictionary *photosByTag; // of NSArray

@end
