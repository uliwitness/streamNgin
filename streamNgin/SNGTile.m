//
//  SNGTile.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGTile.h"

@implementation SNGTile

-(instancetype)	initWithPList: (NSDictionary*)inPList
{
	self = [super init];
	if( self )
	{
		self.image = [UIImage imageNamed: inPList[@"SNGImage"]];
		self.obstacle = [inPList[@"SNGIsObstacle"] boolValue];
	}
	return self;
}

@end
