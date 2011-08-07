//
//  HelloWorldLayer.m
//  Whack-A-Congress
//
//  Created by Steven Turner on 8/6/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (CGPoint)convertPoint:(CGPoint)point {    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return ccp(32 + point.x*2, 64 + point.y*2);
    } else {
        return point;
    }    
}

- (void)tryPopMoles:(ccTime)dt {
    for (CCSprite *mole in moles) {            
        if (arc4random() % 3 == 0) {
            if (mole.numberOfRunningActions == 0) {
                [self popMole:mole];
            }
        }
    }     
}

- (void) popMole:(CCSprite *)mole {          
    CCMoveBy *moveUp = [CCMoveBy actionWithDuration:0.7 position:ccp(0, mole.contentSize.height)]; // 1
    CCEaseInOut *easeMoveUp = [CCEaseInOut actionWithAction:moveUp rate:1.0]; // 2
    CCAction *easeMoveDown = [easeMoveUp reverse]; // 3
    CCDelayTime *delay = [CCDelayTime actionWithDuration:1]; // 4
	
    [mole runAction:[CCSequence actions:easeMoveUp, delay, easeMoveDown, nil]]; // 5
}
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
		// Determine names of sprite sheets and plists to load
		NSString *bgSheet = @"background.pvr.ccz";
		NSString *bgPlist = @"background.plist";
		NSString *fgSheet = @"foreground.pvr.ccz";
		NSString *fgPlist = @"foreground.plist";
		NSString *sSheet = @"sprites.pvr.ccz";
		NSString *sPlist = @"sprites.plist";
		if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
			bgSheet = @"background-hd.pvr.ccz";
			bgPlist = @"background-hd.plist";
			fgSheet = @"foreground-hd.pvr.ccz";
			fgPlist = @"foreground-hd.plist";
			sSheet = @"sprites-hd.pvr.ccz";
			sPlist = @"sprites-hd.plist";            
		}
		
		// Load background and foreground
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:bgPlist];       
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:fgPlist];
		
		// Add background
		CGSize winSize = [CCDirector sharedDirector].winSize;
		CCSprite *dirt = [CCSprite spriteWithSpriteFrameName:@"bg_dirt.png"];
		dirt.scale = 2.0;
		dirt.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:dirt z:-5]; 
		
		// Add foreground
		CCSprite *lower = [CCSprite spriteWithSpriteFrameName:@"whitehousebottom.png"];
		lower.anchorPoint = ccp(0.5, 0);
		lower.position = ccp(winSize.width/2, 0);
		[self addChild:lower z:1];
		
		
		CCSprite *middle2 = [CCSprite spriteWithSpriteFrameName:@"whitehousemiddle2.png"];
		middle2.anchorPoint = ccp(0.5, 0);
		middle2.position = ccp(winSize.width/2, [lower boundingBox].size.height-3);
		[self addChild:middle2 z:-1];
		
		CCSprite *middle1 = [CCSprite spriteWithSpriteFrameName:@"whitehousemiddle1.png"];
		middle1.anchorPoint = ccp(0.5, 0);
		middle1.position = ccp(winSize.width/2, [middle2 boundingBox].size.height+30);
		[self addChild:middle1 z:-2];
		
		CCSprite *top = [CCSprite spriteWithSpriteFrameName:@"whitehousetop.png"];
		top.anchorPoint = ccp(0.5, 0);
		top.position = ccp(winSize.width/2, [middle1 boundingBox].size.height+89);
		[self addChild:top z:-3];
		
		CCSprite *sky = [CCSprite spriteWithSpriteFrameName:@"blue_sky_upper.png"];
		sky.anchorPoint = ccp(0.5, 0);
		sky.position = ccp(winSize.width/2, winSize.height/2);
		[self addChild:sky z:-4];

	
		
		// Load sprites
		CCSpriteBatchNode *spriteNode = [CCSpriteBatchNode batchNodeWithFile:sSheet];
		[self addChild:spriteNode z:0];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:sPlist];      
		
		moles = [[NSMutableArray alloc] init];
	
		CCSprite *mole1 = [CCSprite spriteWithSpriteFrameName:@"OH-Kucinich.png"];
		mole1.position = [self convertPoint:ccp(85, -30)];
		[spriteNode addChild:mole1];
		[moles addObject:mole1];
		
		CCSprite *mole2 = [CCSprite spriteWithSpriteFrameName:@"Duffy-WI.png"];
		mole2.position = [self convertPoint:ccp(240, -30)];
		[spriteNode addChild:mole2];
		[moles addObject:mole2];
		
		CCSprite *mole3 = [CCSprite spriteWithSpriteFrameName:@"Chabot-OH.png"];
		mole3.position = [self convertPoint:ccp(395, -30)];
		[spriteNode addChild:mole3];
		[moles addObject:mole3];
		
		[self schedule:@selector(tryPopMoles:) interval:0.5];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[moles release];
	moles = nil;
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
