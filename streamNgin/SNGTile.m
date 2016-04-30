//
//  SNGTile.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGTile.h"
#import "SNGChunk.h"

@implementation SNGTile

-(instancetype)	initWithPList: (NSDictionary*)inPList
{
	self = [super init];
	if( self )
	{
		self.image = [UIImage imageNamed: inPList[@"SNGImage"]];
		self.obstacle = [inPList[@"SNGIsObstacle"] boolValue];
		self.name = inPList[@"SNGName"];
		if( !self.name )
			self.name = inPList[@"SNGImage"];
	}
	return self;
}

-(IBAction) select
{
	[self.owner selectTile: self];
}


-(NSString*)	description
{
	return [NSString stringWithFormat: @"<%@: %p \"%@\">", self.class, self, self.name];
}

@end
