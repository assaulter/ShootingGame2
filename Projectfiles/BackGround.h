//
//  BackGround.h
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface BackGround : CCLayer {
    CGPoint _current;
    CGPoint _move;
    CCTMXTiledMap *_tileMap;
    CCTMXLayer *_map;
}

@end
