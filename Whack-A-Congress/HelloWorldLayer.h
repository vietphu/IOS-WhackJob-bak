//
//  HelloWorldLayer.h
//  Whack-A-Congress
//
//  Created by Steven Turner on 8/6/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
	NSMutableArray *moles;
	
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
