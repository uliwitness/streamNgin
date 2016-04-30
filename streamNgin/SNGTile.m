//
//  SNGTile.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGTile.h"
#import "SNGChunk.h"


@interface SNGTile ()

@property (copy) NSString*	imageName;

@end


@implementation SNGTile

-(instancetype)	initWithPList: (NSDictionary*)inPList
{
	self = [super init];
	if( self )
	{
		self.imageName = inPList[@"SNGImage"];
		self.image = [UIImage imageNamed: self.imageName];
		self.obstacle = [inPList[@"SNGIsObstacle"] boolValue];
		self.name = inPList[@"SNGName"];
		if( !self.name )
			self.name = self.imageName;
	}
	return self;
}

-(IBAction) select
{
	[self.owner selectTile: self];
}


-(NSDictionary*)	dictionaryRepresentation
{
	return @{ @"SNGImage": self.imageName, @"SNGIsObstacle": @(self.isObstacle),
			  @"SNGName": self.name };
}


-(NSString*)	description
{
	return [NSString stringWithFormat: @"<%@: %p \"%@\">", self.class, self, self.name];
}

@end
