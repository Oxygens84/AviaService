//
//  CoreDataHelper.m
//  AviaService
//
//  Created by Oxana Lobysheva on 03/04/2019.
//  Copyright © 2019 Oxana Lobysheva. All rights reserved.
//

#import "CoreDataHelper.h"

@interface CoreDataHelper ()
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@end

@implementation CoreDataHelper

+ (instancetype)sharedInstance
{
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

- (FavoriteNews *)favoriteFromTicket:(NSString *)news_title {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
    request.predicate = [NSPredicate predicateWithFormat:@"title == %@", news_title];
    return [[_managedObjectContext executeFetchRequest:request error:nil] firstObject];
}

- (BOOL)isFavorite:(NSString *)news_title {
    return [self favoriteFromTicket:news_title] != nil;
}

- (void)addToFavorite:(NSString *)news_title {
    FavoriteNews *favorite = [NSEntityDescription insertNewObjectForEntityForName:@"FavoriteNews" inManagedObjectContext:_managedObjectContext];
    favorite.title = news_title;
    //favorite.created = [NSDate date];
    [self save];
}

- (void)removeFromFavorite:(NSString *)news_title {
    FavoriteNews *favorite = [self favoriteFromTicket:news_title];
    if (favorite) {
        [_managedObjectContext deleteObject:favorite];
        [self save];
    }
}

- (NSArray *)favorites {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FavoriteNews"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    return [_managedObjectContext executeFetchRequest:request error:nil];
}

@end
