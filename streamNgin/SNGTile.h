//
//  SNGTile.h
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SNGTile : NSObject

@property (strong) UIImage *				image;
@property (assign,getter=isObstacle) BOOL	obstacle;

-(instancetype)	initWithPList: (NSDictionary*)inPList;

@end
