//
//  SNGChunk.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGChunk.h"
#import "SNGTile.h"
#import "SNGMap.h"


@interface SNGChunk ()
{
	NSArray<SNGTile*>*	_tiles;
	__weak SNGChunk*	_northChunk;
	__weak SNGChunk*	_eastChunk;
	__weak SNGChunk*	_southChunk;
	__weak SNGChunk*	_westChunk;
}

@property (strong,readwrite) NSArray<SNGTile *>*	tiles;

@end


@implementation SNGChunk

-(void)	loadIfNeeded
{
	if( !self.isLoaded )
	{
		NSDictionary	*	plist = [NSDictionary dictionaryWithContentsOfFile: self.filePath];
		if( plist == nil )	// If the file doesn't exist, don't empty out this object or makeTiles:withPrototypePList: will never work.
		{
			self.loaded = YES;
			return;
		}
		NSArray			*	tilesPListArray = plist[@"SNGTiles"];
		NSMutableArray	*	array = [NSMutableArray array];
		for( NSDictionary* currTilePList in tilesPListArray )
		{
			SNGTile	*	theTile = [[SNGTile alloc] initWithPList: currTilePList];
			theTile.owner = self;
			[array addObject: theTile];
		}
		self.tiles = array;
		
		SNGChunk	*	theChunk = nil;
		NSString	*	theChunkFileName = plist[@"SNGNorth"];
		if( theChunkFileName )
		{
			theChunk = [self.owner chunkObjectForPath: [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent: theChunkFileName]];
			self.northChunk = theChunk;
		}
		theChunkFileName = plist[@"SNGEast"];
		if( theChunkFileName )
		{
			theChunk = [self.owner chunkObjectForPath: [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent: theChunkFileName]];
			self.eastChunk = theChunk;
		}
		theChunkFileName = plist[@"SNGSouth"];
		if( theChunkFileName )
		{
			theChunk = [self.owner chunkObjectForPath: [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent: theChunkFileName]];
			self.southChunk = theChunk;
		}
		theChunkFileName = plist[@"SNGWest"];
		if( theChunkFileName )
		{
			theChunk = [self.owner chunkObjectForPath: [[self.filePath stringByDeletingLastPathComponent] stringByAppendingPathComponent: theChunkFileName]];
			self.westChunk = theChunk;
		}
		
		self.loaded = YES;
	}
}


-(NSArray<SNGTile *> *)tiles
{
	[self loadIfNeeded];
	
	return _tiles;
}


-(void)setTiles:(NSArray<SNGTile *> *)tiles
{
	_tiles = tiles;
}


-(SNGChunk*)	northChunk
{
	[self loadIfNeeded];
	
	return _northChunk;
}


-(void)setNorthChunk:(SNGChunk *)northChunk
{
	_northChunk = northChunk;
}


-(SNGChunk*)	eastChunk
{
	[self loadIfNeeded];
	
	return _eastChunk;
}


-(void)setEastChunk:(SNGChunk *)eastChunk
{
	_eastChunk = eastChunk;
}


-(SNGChunk*)	southChunk
{
	[self loadIfNeeded];
	
	return _southChunk;
}


-(void)setSouthChunk:(SNGChunk *)southChunk
{
	_southChunk = southChunk;
}


-(SNGChunk*)	westChunk
{
	[self loadIfNeeded];
	
	return _westChunk;
}


-(void)setWestChunk:(SNGChunk *)westChunk
{
	_westChunk = westChunk;
}


-(void)	selectTile: (SNGTile*)inTile
{
	[self.owner selectTile: inTile];
}


-(void)	mapDidDeselectTile: (SNGTile*)inTile;
{
	[inTile mapDidDeselect];
}


-(void)	makeTiles: (NSUInteger)inNumberOfTiles withPrototypePList: (NSDictionary*)dict;
{
	[self loadIfNeeded];
	
	NSMutableArray	*	array = [NSMutableArray array];
	for( NSUInteger x = 0; x < inNumberOfTiles; x++ )
	{
		SNGTile	*	theTile = [[SNGTile alloc] initWithPList: dict];
		theTile.owner = self;
		[array addObject: theTile];
	}
	self.tiles = array;
}


-(BOOL)	save
{
	NSMutableDictionary	*	chunkFileDict = [NSMutableDictionary dictionary];
	
	if( self.northChunk )
	{
		[chunkFileDict setObject: self.northChunk.filePath.lastPathComponent forKey: @"SNGNorth"];
	}
	if( self.eastChunk )
	{
		[chunkFileDict setObject: self.eastChunk.filePath.lastPathComponent forKey: @"SNGEast"];
	}
	if( self.southChunk )
	{
		[chunkFileDict setObject: self.southChunk.filePath.lastPathComponent forKey: @"SNGSouth"];
	}
	if( self.westChunk )
	{
		[chunkFileDict setObject: self.westChunk.filePath.lastPathComponent forKey: @"SNGWest"];
	}
	NSMutableArray	*	array = [NSMutableArray array];
	for( SNGTile* currTile in self.tiles )
	{
		[array addObject: [currTile PListRepresentation]];
	}
	[chunkFileDict setObject: array forKey: @"SNGTiles"];
	
	return [chunkFileDict writeToFile: self.filePath atomically: YES];
}


-(NSString*)	description
{
	return [NSString stringWithFormat: @"<%@: %p \"%@\" %lu>", self.class, self, self.filePath.lastPathComponent, (unsigned long)self.tiles.count];
}

@end
