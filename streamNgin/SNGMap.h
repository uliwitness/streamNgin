//
//  SNGMap.h
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SNGChunk;


@interface SNGMap : NSObject

@property (strong,readonly) NSArray*	chunks;

-(SNGChunk*)	chunkObjectForPath: (NSString*)inPath;

@end
