//
//  BackGround.h
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackGroundLayer : CCLayer {
    CGPoint _current;
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_map;
}

-(CGPoint)getPlayerSpawnPoint;

@end
