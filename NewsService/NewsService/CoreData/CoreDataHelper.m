//
//  CoreDataHelper.m
//  NewsService
//
//  Created by Oxana Lobysheva on 03/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "CoreDataHelper.h"
#import "News.h"
#import "CloudKit/CloudKit.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end

@implementation CoreDataHelper

CKContainer *container;
CKDatabase *publicDatabase;

+ (instancetype)sharedInstance
{
    container = [CKContainer defaultContainer];
    publicDatabase = [container publicCloudDatabase];
    
    static CoreDataHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CoreDataHelper alloc] init];
        [instance setup];
    });
    return instance;
}

- (void)setup {
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Favorites" withExtension:@"momd"];
    self.managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    NSURL *docsURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [docsURL URLByAppendingPathComponent:@"base.sqlite"];
    self.persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    NSPersistentStore* store = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    if (!store) {
        abort();
    }
    
    self.managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    self.managedObjectContext.persistentStoreCoordinator = _persistentStoreCoordinator;
}

- (void)save {
    NSError *error;
    [self.managedObjectContext save: &error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
}

- (void)saveRecordInCloud:(News *)recordNews {
    CKRecordID *publicationRecordID = [[CKRecordID alloc] initWithRecordName:recordNews.news_title];
    CKRecord *publicationRecord = [[CKRecord alloc] initWithRecordType:@"Publication" recordID:publicationRecordID];
    publicationRecord[@"newsTitle"] = recordNews.news_title;
    publicationRecord[@"newsContent"] = recordNews.news_content;
    publicationRecord[@"newsImage"] = recordNews.news_urlToImage;
    publicationRecord[@"newsSource"] = recordNews.news_source;
    [publicDatabase saveRecord:publicationRecord completionHandler:^(CKRecord * _Nullable record, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        NSLog(@"%@", record);
    }];
}

- (void)deleteRecordInCloud:(News *)recordNews {
    CKRecordID *publicationRecordID = [[CKRecordID alloc] initWithRecordName:recordNews.news_title];
    [publicDatabase deleteRecordWithID:publicationRecordID completionHandler:^(CKRecordID * _Nullable recordID, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            return;
        }
        NSLog(@"%@", recordID);
    }];
}

- (FavoriteNews *)favoriteFromTicket:(News *)news {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
    request.predicate = [NSPredicate predicateWithFormat:@"title == %@", news.news_title];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(News *)news {
    return [self favoriteFromTicket:news] != nil;
}

- (void)addToFavorite:(News *)news {
    FavoriteNews *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteNews" inManagedObjectContext:_managedObjectContext];
    favorite.title = news.news_title;
    favorite.content = news.news_content;
    if (![news.news_urlToImage isEqual:[NSNull null]]) {
        favorite.urlToImage = news.news_urlToImage;
    }
    if (![news.news_source isEqual:[NSNull null]]) {
        favorite.source = news.news_source;
    }
    
    [self save];
    [self saveRecordInCloud:news];
}

- (void)removeFromFavorite:(News *)news {
    FavoriteNews *favorite = [self favoriteFromTicket:news];
    if (favorite) {
        [_managedObjectContext deleteObject:favorite];
        [self save];
        [self deleteRecordInCloud:news];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    return [_managedObjectContext executeFetchRequest:request error:nil];
}

@end
