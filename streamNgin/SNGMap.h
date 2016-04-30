//
//  SNGMap.h
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SNGChunk;
@class SNGTile;


@protocol SNGMapDelegate;



@interface SNGMap : NSObject

@property (strong,readonly) NSArray*	chunks;
@property (weak) id<SNGMapDelegate>		delegate;

-(instancetype) init;	// Default constructor for an empty map that you fill by adding the first chunk to it, relative to which all others will be loaded.
-(instancetype) initWithNumberOfColumns: (NSUInteger)cols rows: (NSUInteger)rows mapFolderPath: (NSString*)inBasePath tilePrototypePList: (NSDictionary*)tilePrototype;	// For creating a new, empty map.
-(BOOL)	save;

/*!
	Since chunks point forth and back between each other,
	we keep a central list of chunks in the map. This serves
	both to avoid retain circles (the map owns the chunks,
	each chunk can reference the other weakly) but also
	means that we know whether we've already created an
	object for a certain chunk file on disk, and can just
	return that same object again.
*/
-(SNGChunk*)	chunkObjectForPath: (NSString*)inPath;

-(void)	selectTile: (SNGTile*)inTile;

@end


@protocol SNGMapDelegate <NSObject>

-(void)	map: (SNGMap*)sender didDeselectTile: (SNGTile*)inTile;
-(void)	map: (SNGMap*)sender didSelectTile: (SNGTile*)inTile;

@end