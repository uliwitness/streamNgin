//
//  SNGChunk.h
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SNGTile;
@class SNGMap;


@interface SNGChunk : NSObject

@property (copy) NSString*				filePath;
@property (assign,getter=isLoaded) BOOL	loaded;
@property (assign) NSUInteger			generation;
@property (weak) SNGMap*				owner;

@property (weak) SNGChunk*				northChunk;
@property (weak) SNGChunk*				eastChunk;
@property (weak) SNGChunk*				southChunk;
@property (weak) SNGChunk*				westChunk;

@property (strong,readonly) NSArray<SNGTile *>*	tiles;

-(void)	selectTile: (SNGTile*)inTile;
-(void)	mapDidDeselectTile: (SNGTile*)inTile;

@end
