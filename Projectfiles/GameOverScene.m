//
//  GameOverScene.m
//  ShootingGame
//
//  Created by KazukiKubo on 2013/03/03.
//  Copyright 2013年 __MyCompanyName__. All rights reserved.
//

#import "GameOverScene.h"
#import "MainScene.h"


@implementation GameOverScene

-(id)init {
    if (self = [super init]) {
        [CCMenuItemFont setFontSize:20];
		[CCMenuItemFont setFontName:@"Helvetica"];
		CCMenuItem *start = [CCMenuItemFont itemWithString:@"Game Over"
                                                    target:self selector:@selector(backToTitle:)];
        CCMenu *menu = [CCMenu menuWithItems:start, nil];
		[menu alignItemsVertically];
		[self addChild:menu];
    }
    return self;
}

- (void)backToTitle:(id)sender {
    CCTransitionFade *tran = [CCTransitionFade transitionWithDuration:1.0 scene:[MainScene nodeWithScene] withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector] replaceScene:tran];
}



@end
