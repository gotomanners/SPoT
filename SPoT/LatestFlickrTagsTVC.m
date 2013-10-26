//
//  LatestFlickrTags.m
//  SPoT
//
//  Created by Manners Oshafi on 22/10/2013.
//  Copyright (c) 2013 Gotomanners. All rights reserved.
//

#import "LatestFlickrTagsTVC.h"
#import "FlickrFetcher.h"

@interface LatestFlickrTagsTVC ()

@end

@implementation LatestFlickrTagsTVC

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.photos = [FlickrFetcher latestGeoreferencedPhotos];
}

@end
