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

@end
