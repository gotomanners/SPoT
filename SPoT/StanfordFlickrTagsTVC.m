//
//  StanfordFlickrTagsTVC.m
//  SPoT
//
//  Created by Manners Oshafi on 20/10/2013.
//  Copyright (c) 2013 Gotomanners. All rights reserved.
//

#import "StanfordFlickrTagsTVC.h"
#import "FlickrFetcher.h"


@interface StanfordFlickrTagsTVC ()

@end

@implementation StanfordFlickrTagsTVC

- (void)loadPhotosFromFlickr {
    [self.refreshControl beginRefreshing];
    dispatch_queue_t loaderQ = dispatch_queue_create("Flickr Loader", NULL);
    dispatch_async(loaderQ, ^{
        NSArray *stanfordPhotos = [FlickrFetcher stanfordPhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photos = stanfordPhotos;
            [self.refreshControl endRefreshing];
        });
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(loadPhotosFromFlickr) forControlEvents:UIControlEventValueChanged];
    [self loadPhotosFromFlickr];
}

- (NSArray *) getAndSortTagDataFromPhotos:(NSArray *) photos {
    NSMutableSet *tagsDataSet = [[NSMutableSet alloc] init];
    //    NSDictionary *photoTagData = {
    //        tagTitle: "lovely",
    //        tagCount: 12,
    //        photos: [array]
    //    };
    
    for (NSDictionary *sPhoto in photos) {
        if ([sPhoto objectForKey:FLICKR_TAGS]) {
            NSMutableDictionary *photoTagDataDict = [[NSMutableDictionary alloc] init];
            NSMutableSet *photosForTagSet = [[NSMutableSet alloc] init];
            
            // filter tags
            NSString *tagString = [sPhoto objectForKey:FLICKR_TAGS];
            if (tagString) {
                NSMutableSet *tagSet = [[NSMutableSet alloc] initWithArray:[tagString componentsSeparatedByString:@" "]];
                if ([tagSet count] > 0) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", @[@"cs193pSPoT", @"portrait", @"landscape"]];
                    [tagSet filterUsingPredicate:predicate];
                    
                    //count photos for each tag
                    for (NSString *tag in tagSet) {
                        if ([[tagsDataSet valueForKey:@"tagTitle"] containsObject:tag] == NO) {
                            for (NSDictionary *sPhoto2 in photos) {
                                NSString *tagString2 = [sPhoto2 objectForKey:FLICKR_TAGS];
                                NSArray *tagArray2 = [tagString2 componentsSeparatedByString:@" "];
                                if ([tagArray2 containsObject:tag]) {
                                    [photosForTagSet addObject:sPhoto2];
                                }
                            }
                            
                            [photoTagDataDict setValue:[tag capitalizedString] forKey:@"tagTitle"];
                            
                            int tagCount = [photosForTagSet count];
                            [photoTagDataDict setValue:[NSString stringWithFormat:@"%d Photo%@", tagCount, tagCount > 1 ? @"s" : @""] forKey:@"tagCount"];
                            
                            NSArray *sortedPhotos = [photosForTagSet sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:FLICKR_PHOTO_TITLE ascending:YES]]];
                            [photoTagDataDict setValue:sortedPhotos forKey:@"photos"];
                            
                            [tagsDataSet addObject:photoTagDataDict];
                        }
                    }
                }
                
            }
        }
    }
    
    NSArray *sortedTagData = [tagsDataSet sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"tagTitle" ascending:YES]]];
    
    return sortedTagData;
}

@end
