//
//  SNGMap.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGMap.h"
#import "SNGChunk.h"


@interface SNGMap ()

@property (strong) NSMutableDictionary*	actualChunks;

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

@end
