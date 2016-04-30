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

@property (copy) NSString*						imageName;
@property (readwrite,getter=isSelected) BOOL 	selected;
@property (strong) UIImage *					unselectedImage;
@property (strong) UIImage *					selectedImage;

@end


@implementation SNGTile

-(instancetype)	initWithPList: (NSDictionary*)inPList
{
	self = [super init];
	if( self )
	{
		self.imageName = inPList[@"SNGImage"];
		self.unselectedImage = [UIImage imageNamed: self.imageName];
		self.selectedImage = [UIImage imageNamed: [self.imageName stringByReplacingOccurrencesOfString: @".tiff" withString: @"_selected.tiff"]];
		self.obstacle = [inPList[@"SNGIsObstacle"] boolValue];
		self.name = inPList[@"SNGName"];
		if( !self.name )
			self.name = self.imageName;
	}
	return self;
}


-(UIImage *)image
{
	return (self.selected && self.selectedImage != nil) ? self.selectedImage : self.unselectedImage;
}


-(IBAction) select
{
	self.selected = YES;
	[self.owner selectTile: self];
}


-(void)		mapDidDeselect
{
	self.selected = NO;
}


-(NSDictionary*)	PListRepresentation
{
	return @{ @"SNGImage": self.imageName, @"SNGIsObstacle": @(self.isObstacle),
			  @"SNGName": self.name };
}


-(NSString*)	description
{
	return [NSString stringWithFormat: @"<%@: %p \"%@\">", self.class, self, self.name];
}

@end
