//
//  SNGTileView.m
//  streamNgin
//
//  Created by Uli Kusterer on 30/04/16.
//  Copyright © 2016 Uli Kusterer. All rights reserved.
//

#import "SNGTileView.h"


float sign (CGPoint p1, CGPoint p2, CGPoint p3)
{
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

bool PointInTriangle (CGPoint pt, CGPoint v1, CGPoint v2, CGPoint v3)
{
    bool b1, b2, b3;

    b1 = sign(pt, v1, v2) < 0.0f;
    b2 = sign(pt, v2, v3) < 0.0f;
    b3 = sign(pt, v3, v1) < 0.0f;

    return ((b1 == b2) && (b2 == b3));
}


@implementation SNGTileView

-(BOOL)	pointInside: (CGPoint)point withEvent: (UIEvent *)event
{
    if( !self.enabled || self.hidden )
	{
        return [super pointInside: point withEvent: event];
    }

	/*
		Split up the parallelogram into 2 triangles and a rectangle
		to hit-test:
		
		    +-----+--+
		   /|     | /
		  / |     |/
		 +--+-----+
	*/
	
	/*
		First, calculate the surrounding rectangle of the whole
		parallelogram, on which we'll base our other calculations:
	*/
	CGRect	box = self.bounds;
	box.size.height -= TILE_OVERLAP_V;
	box.origin.y += TILE_OVERLAP_V;
	
	/*
		Now calculate the box between the triangles, it's
		fastest to hit-test:
	*/
	CGRect	centerBox = box;
	centerBox.origin.x += TILE_OVERLAP_H;
	centerBox.size.width -= TILE_OVERLAP_H * 2;
	if( CGRectContainsPoint( centerBox, point ) )
		return YES;
	
	// Left triangle points (counterclockwise):
	CGPoint	p1 = (CGPoint){ CGRectGetMinX(box), CGRectGetMaxY(box) };
	CGPoint	p2 = (CGPoint){ CGRectGetMinX(centerBox), CGRectGetMaxY(centerBox) };
	CGPoint	p3 = (CGPoint){ CGRectGetMinX(centerBox), CGRectGetMinY(centerBox) };
	if( PointInTriangle( point, p1, p2, p3 ) )
		return YES;

	// Right triangle points (counterclockwise):
	p1 = (CGPoint){ CGRectGetMaxX(centerBox), CGRectGetMaxY(box) };
	p2 = (CGPoint){ CGRectGetMaxX(box), CGRectGetMinY(box) };
	p3 = (CGPoint){ CGRectGetMaxX(centerBox), CGRectGetMinY(centerBox) };
	if( PointInTriangle( point, p1, p2, p3 ) )
		return YES;
	
    return NO;
}

@end
