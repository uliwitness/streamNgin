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
	
}


-(NSString*)	description
{
	return [NSString stringWithFormat: @"<%@: %p \"%@\">", self.class, self, self.filePath.lastPathComponent];
}

@end
