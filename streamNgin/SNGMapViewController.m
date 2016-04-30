//
//  ViewController.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGMapViewController.h"
#import "SNGChunk.h"
#import "SNGTile.h"


#define TILE_SIZE		128
#define TILE_OVERLAP_H	45
#define ROW_OFFSET		44
#define TILE_OVERLAP_V	84


@interface SNGMapViewController ()
{
	NSUInteger		rowLength;
}


@property (strong) SNGChunk*	currentChunk;

@end

@implementation SNGMapViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.map = [SNGMap new];
	SNGChunk*	chunk = [self.map chunkObjectForPath: [[NSBundle mainBundle] pathForResource: @"1" ofType: @"plist"]];
	rowLength = sqrt(chunk.tiles.count);
	
	self.currentChunk = chunk;
	[self reloadMap];
}

-(void)	reloadMap
{
	NSArray*		subviews = self.view.subviews;
	for( UIView* aView in subviews )
	{
		[aView removeFromSuperview];
	}
	
	CGRect		box = { { 0,0 }, { TILE_SIZE, TILE_SIZE } };
	box.origin.x = trunc((self.view.bounds.size.width -((TILE_SIZE -TILE_OVERLAP_H) * rowLength)) / 2);
	box.origin.y = trunc((self.view.bounds.size.height -((TILE_SIZE -TILE_OVERLAP_V) * rowLength)) / 2);
	self.currentChunk.generation ++;
	[self createViewsForChunkObject: self.currentChunk withTopLeftRect: box];
}


-(void)	createViewsForChunkObject: (SNGChunk*)chunk withTopLeftRect: (CGRect)box
{
	NSLog(@"===== %@ =====", chunk.filePath.lastPathComponent);
	if( CGRectGetMinX(box) > 0 )
	{
		SNGChunk	*	nextChunk = chunk.westChunk;
		if( nextChunk && nextChunk.generation != chunk.generation )	// Have chunk next to us and we didn't already create it this time through?
		{
			NSLog(@"\tWest <<");
			CGRect	nextTopLeftRect = box;
			nextTopLeftRect.origin.x -= (TILE_SIZE -TILE_OVERLAP_H) * rowLength;
			nextChunk.generation = chunk.generation;
			NSLog(@"\t\tGeneration: %lu", (unsigned long)chunk.generation);
			[self createViewsForChunkObject: nextChunk withTopLeftRect: nextTopLeftRect];
			NSLog(@">>");
		}
		else if( nextChunk )
			NSLog(@"\tWest already exists.");
		else
			NSLog(@"\tWest not given.");
	}
	else
		NSLog(@"\tWest offscreen.");
	
	if( CGRectGetMinY(box) > 0 )
	{
		SNGChunk	*	nextChunk = chunk.northChunk;
		if( nextChunk && nextChunk.generation != chunk.generation )	// Have chunk next to us and we didn't already create it this time through?
		{
			NSLog(@"\tNorth <<");
			CGRect	nextTopLeftRect = box;
			nextTopLeftRect.origin.x += ROW_OFFSET * rowLength;
			nextTopLeftRect.origin.y -= (TILE_SIZE -TILE_OVERLAP_V) * rowLength;
			nextChunk.generation = chunk.generation;
			NSLog(@"\t\tGeneration: %lu", (unsigned long)chunk.generation);
			[self createViewsForChunkObject: nextChunk withTopLeftRect: nextTopLeftRect];
			NSLog(@">>");
		}
		else if( nextChunk )
			NSLog(@"\tNorth already exists.");
		else
			NSLog(@"\tNorth not given.");
	}
	else
		NSLog(@"\tNorth offscreen.");
	
	NSUInteger	x = 1;
	NSUInteger	row = 0;
	CGRect		currBox = box;
	for( SNGTile* currTile in chunk.tiles )
	{
		UIImageView*	tileView = [[UIImageView alloc] initWithFrame: currBox];
		tileView.image = currTile.image;
		[self.view addSubview: tileView];
		
		if( (x % rowLength) == 0 )	// End of row? Wrap!
		{
			row++;
			currBox.origin.x = box.origin.x -(ROW_OFFSET * row);
			currBox.origin.y += TILE_SIZE -TILE_OVERLAP_V;
		}
		else
			currBox.origin.x += TILE_SIZE -TILE_OVERLAP_H;
		x++;
	}
	
	if( (CGRectGetMinX(box) +(box.size.width * rowLength)) < self.view.bounds.size.width )
	{
		SNGChunk	*	nextChunk = chunk.eastChunk;
		if( nextChunk && nextChunk.generation != chunk.generation )	// Have chunk next to us and we didn't already create it this time through?
		{
			NSLog(@"\tEast <<");
			CGRect	nextTopLeftRect = box;
			nextTopLeftRect.origin.x += (TILE_SIZE -TILE_OVERLAP_H) * rowLength;
			nextChunk.generation = chunk.generation;
			NSLog(@"\t\tGeneration: %lu", (unsigned long)chunk.generation);
			[self createViewsForChunkObject: nextChunk withTopLeftRect: nextTopLeftRect];
			NSLog(@">>");
		}
		else if( nextChunk )
			NSLog(@"\tEast already exists.");
		else
			NSLog(@"\tEast not given.");
	}
	else
		NSLog(@"\tEast offscreen.");
	
	if( (CGRectGetMinY(box) +(box.size.height * rowLength)) < self.view.bounds.size.height )
	{
		SNGChunk	*	nextChunk = chunk.southChunk;
		if( nextChunk && nextChunk.generation != chunk.generation )	// Have chunk next to us and we didn't already create it this time through?
		{
			NSLog(@"\tSouth <<");
			CGRect	nextTopLeftRect = box;
			nextTopLeftRect.origin.x -= ROW_OFFSET * rowLength;
			nextTopLeftRect.origin.y += (TILE_SIZE -TILE_OVERLAP_V) * rowLength;
			nextChunk.generation = chunk.generation;
			NSLog(@"\t\tGeneration: %lu", (unsigned long)chunk.generation);
			[self createViewsForChunkObject: nextChunk withTopLeftRect: nextTopLeftRect];
			NSLog(@">>");
		}
		else if( nextChunk )
			NSLog(@"\tSouth already exists.");
		else
			NSLog(@"\tSouth not given.");
	}
	else
		NSLog(@"\tSouth offscreen.");
}

@end
