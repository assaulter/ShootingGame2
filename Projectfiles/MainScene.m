//
//  MainScene.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/01.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "MainScene.h"
#import "GameScene.h"
#import "SecondGameScene.h"

@implementation MainScene

-(id)init {
    if (self = [super init]) {
        [CCMenuItemFont setFontSize:20];
		[CCMenuItemFont setFontName:@"Helvetica"];
		CCMenuItem *start = [CCMenuItemFont itemWithString:@"Start Game"
												target:self selector:@selector(startGame:)];
        CCMenuItem *startSecondStage = [CCMenuItemFont itemWithString:@"Second Stage"
                                                               target:self selector:@selector(startSecondStage:)];
        CCMenu *menu = [CCMenu menuWithItems:start, startSecondStage, nil];
		[menu alignItemsVertically];
		[self addChild:menu];
    }
    return self;
}

- (void)startGame:(id)sender {
    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:[GameScene nodeWithScene] withColor:ccc3(255, 255, 255)];
    //GameSceneから頻繁に行き来することはないので、replaceScene(メモリから破棄する。)
    [[CCDirector sharedDirector] replaceScene:tran];
}

-(void)startSecondStage:(id)sender {
    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:[SecondGameScene nodeWithScene] withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector] replaceScene:tran];
}

@end
