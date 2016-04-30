//
//  SNGTileView.h
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

/*
	Tile view that does hit-testing based on the parallelogram
	shape of the isometric projection of the floor tiles,
	not on the entire graphic's rectangle, as that would overlap
	other tiles and make them unclickable.
	
	This means you have to tap at someone's feet, not at their
	head.
	
	We could probably hit-test based on the image by examining
	the pixel corresponding to the tapped coordinate, but that
	would require we either make all tappable objects large enough
	to be good hit targets, or create dedicated mask images that
	are colored in the tappable areas. Maybe we'll do that later.
*/

#import <UIKit/UIKit.h>


#define TILE_SIZE		128
#define TILE_OVERLAP_H	45
#define ROW_OFFSET		44
#define TILE_OVERLAP_V	84


@class SNGTile;


@interface SNGTileView : UIButton

@property (weak) SNGTile*	owner;

@end
