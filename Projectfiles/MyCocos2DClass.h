//
//  MyCocos2DClass.h
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MyCocos2DClass : CCLayer {
    CGPoint _current;
    CGPoint _move;
}

@property (nonatomic, strong) CCTMXTiledMap *tileMap;
@property (nonatomic, strong) CCTMXLayer *background;

@end
