//
//  SecondGameScene.h
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/17.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerLayer.h"
#import "SecondBackGroundLayer.h"

@interface SecondGameScene : CCLayer<SecondBackGroundLayerDelegate> {
    PlayerLayer* _playerLayer;
    SecondBackGroundLayer* _backGroundLayer;
    CGPoint _touchLocation;
}

@end
