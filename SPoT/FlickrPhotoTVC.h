//
//  FlickrPhotoTVC.h
//  SPoT
//
//  Created by Manners Oshafi on 20/10/2013.
//  Copyright (c) 2013 Gotomanners. All rights reserved.
//
// Will call setImageURL: as part of any "Show Image" segue.

#import <UIKit/UIKit.h>

@interface FlickrPhotoTVC : UITableViewController

@property (nonatomic, strong) NSArray *photos;// of NSDisctionary

@end
