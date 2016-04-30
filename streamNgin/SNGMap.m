//
//  SNGMap.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGMap.h"
#import "SNGChunk.h"
#import "SNGTile.h"


@interface SNGMap ()

@property (strong) NSMutableDictionary*	actualChunks;
@property (weak) SNGTile*				selectedTile;
@property (weak) SNGChunk*				selectedChunk;

@end


@implementation SNGMap

-(instancetype)	init
{
	self = [super init];
	if( self )
	{
		self.actualChunks = [NSMutableDictionary dictionary];
	}
	return self;
}


-(instancetype) initWithNumberOfColumns: (NSUInteger)cols rows: (NSUInteger)rows mapFolderPath: (NSString*)inBasePath tilePrototypePList: (NSDictionary*)tilePrototype
{
	self = [self init];
	if( self )
	{
		for( NSUInteger y = 0; y < rows; y++ )
		{
			for( NSUInteger x = 0; x < cols; x++ )
			{
				NSString	*	chunkPath = [inBasePath stringByAppendingPathComponent: [NSString stringWithFormat: @"%lu_%lu.plist", (unsigned long)x, (unsigned long)y]];
				SNGChunk	*	chunk = [self chunkObjectForPath: chunkPath];
				[chunk makeTiles: 9 withPrototypePList: tilePrototype];
				
				if( x > 0 )
				{
					chunkPath = [inBasePath stringByAppendingPathComponent: [NSString stringWithFormat: @"%lu_%lu.plist", (unsigned long)x -1, (unsigned long)y]];
					chunk.westChunk = [self chunkObjectForPath: chunkPath];
					chunk.westChunk.eastChunk = chunk;
				}
				if( y > 0 )
				{
					chunkPath = [inBasePath stringByAppendingPathComponent: [NSString stringWithFormat: @"%lu_%lu.plist", (unsigned long)x, (unsigned long)y -1]];
					chunk.northChunk = [self chunkObjectForPath: chunkPath];
					chunk.northChunk.southChunk = chunk;
				}
			}
		}
	}
	return self;
}


-(SNGChunk*)	chunkObjectForPath: (NSString*)inPath
{
	SNGChunk*	theChunk = self.actualChunks[inPath];
	if( !theChunk )
	{
		theChunk = [[SNGChunk alloc] init];
		theChunk.filePath = inPath;
		[self.actualChunks setObject: theChunk forKey: inPath];
		theChunk.owner = self;
	}
	
	return theChunk;
}


-(NSArray*)	chunks
{
	return self.actualChunks.allValues;
}

-(void)	selectTile: (SNGTile*)inTile
{
	SNGChunk	*	chunk = inTile.owner;
	
	if( self.selectedChunk )
		[self.selectedChunk mapDidDeselectTile: self.selectedTile];
	self.selectedChunk = chunk;
	self.selectedTile = inTile;
	
	NSLog( @"Selected tile %@ in %@", inTile, chunk );
}


-(BOOL)	save
{
	BOOL	success = YES;
	for( SNGChunk* currChunk in self.actualChunks.allValues )
	{
		success &= [currChunk save];
	}
	return success;
}

@end
