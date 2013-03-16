//
//  BackGround.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "BackGroundLayer.h"

static float const SCROLL_Y = 1.0f;

@implementation BackGroundLayer

-(id)init {
    if (self = [super init]) {
        _tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"scrollSample.tmx"];
        _map =  [_tileMap layerNamed:@"map"];
        
        [self addChild:_tileMap];
        _current = ccp(0, 0);
        [self schedule:@selector(update:)];
    }
    return self;
}

-(CGPoint)getPlayerSpawnPoint {
    return [self getCGPointFromObjectLayerName:@"position" objectName:@"SpawnPoint"];
}

-(CGPoint)getCGPointFromObjectLayerName:(NSString*)objectLayerName objectName:(NSString*)objectName {
    CCTMXObjectGroup *objects = [_tileMap objectGroupNamed:objectLayerName];
    NSMutableDictionary *point = [objects objectNamed:objectName];
    int x = [[point valueForKey:@"x"] intValue];
    int y = [[point valueForKey:@"y"] intValue];
    /// CC_CONTENT_SCALE_FACTOR return 2.0 at retina display
    return ccp(x/CC_CONTENT_SCALE_FACTOR(), y/CC_CONTENT_SCALE_FACTOR());
}

-(void)update:(ccTime)delta {
    _current = ccp(_current.x, _current.y - SCROLL_Y);
    _map.position = _current;
//    NSLog(@"current position y : %f", _current.y);
//    CCMoveTo* moveTo = [CCMoveTo actionWithDuration:delta position:_current];
//    CCEaseIn* ease = [CCEaseIn actionWithAction:moveTo rate:0.0f];
//    [self runAction:ease];
}

@end
