//
//  SNGTile.h
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SNGChunk;


@interface SNGTile : NSObject

@property (readonly) UIImage *					image;
@property (assign,getter=isObstacle) BOOL		obstacle;
@property (weak) SNGChunk *						owner;
@property (copy) NSString *						name;
@property (readonly,getter=isSelected) BOOL 	selected;
@property (strong) id							viewObject;

-(instancetype)		initWithPList: (NSDictionary*)inPList;
-(NSDictionary*)	PListRepresentation;

-(IBAction) select;
-(void)		mapDidDeselect;

@end
