//
//  RecentFlickrPhotosTVC.m
//  SPoT
//
//  Created by Manners Oshafi on 21/10/2013.
//  Copyright (c) 2013 Gotomanners. All rights reserved.
//

#import "RecentFlickrPhotosTVC.h"
#import "RecentFlickrPhotos.h"

@interface RecentFlickrPhotosTVC ()

@end

@implementation RecentFlickrPhotosTVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	self.photos = [RecentFlickrPhotos allPhotos];
}

@end
