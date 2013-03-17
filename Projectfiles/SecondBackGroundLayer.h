//
//  SecondBackGroundLayer.h
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol SecondBackGroundLayerDelegate <NSObject>

@required
-(void)goToNextStage;

@end

@interface SecondBackGroundLayer : CCLayer {
    CGPoint _current;
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_background;
    CCTMXLayer *_event;
    CCTMXLayer *_foreground;
}

@property(nonatomic, assign) id<SecondBackGroundLayerDelegate> delegate;
-(CGPoint)getPlayerSpawnPoint;
/// マップに対する当たり判定など
- (CGPoint)tileCoordForPosition:(CGPoint)position;
-(int)getEventTileIDWithTileCoord:(CGPoint)coord;
-(void)removeTileWithTileCoord:(CGPoint)coord tileGid:(int)tileGid;

@end
