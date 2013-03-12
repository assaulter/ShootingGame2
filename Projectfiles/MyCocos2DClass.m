//
//  MyCocos2DClass.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/12.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MyCocos2DClass.h"


@implementation MyCocos2DClass

-(id)init {
    if (self = [super init]) {
        self.tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"stage1.tmx"];
        self.background =  [_tileMap layerNamed:@"map"];
        
        [self addChild:_tileMap];
        
        //プレイヤー初期位置
        CCTMXObjectGroup *oLayer;
        oLayer = [_tileMap objectGroupNamed:@"start"];
        NSDictionary *properties = [[oLayer objects] objectAtIndex:0];
        _current = ccp([[properties valueForKey:@"x"] intValue], [[properties valueForKey:@"y"] intValue]);
        glClearColor(0.3f, 0.6f, 0.7f, 1.0f);
        // 画面のスクロール量
        _move = ccp(1.0f, 1.0f);
        
        [self schedule:@selector(update:)];
    }
    return self;
}

-(void)update:(ccTime)delta {
    _current = ccp(_current.x, _current.y - _move.y);
    NSLog(@"current position y : %f", _current.y);
    CCMoveTo* moveTo = [CCMoveTo actionWithDuration:delta position:_current];
    CCEaseIn* ease = [CCEaseIn actionWithAction:moveTo rate:0.0f];
    [self runAction:ease];
}

@end
