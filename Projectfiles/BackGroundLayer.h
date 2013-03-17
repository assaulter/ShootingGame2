//
//  BackGround.h
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@protocol BackGroundLayerDelegate <NSObject>

@required
-(void)addBossWithPoint:(CGPoint)point;
@end


@interface BackGroundLayer : CCLayer {
    CGPoint _current;
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_map;
    CCTMXLayer *_event;
    BOOL _isMovable;
}

@property (nonatomic,assign) id<BackGroundLayerDelegate> delegate;
-(CGPoint)getPlayerSpawnPoint;
-(CGPoint)convertToBasicLayerPoint:(CGPoint)point;
@end
