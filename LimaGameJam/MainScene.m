#import "MainScene.h"
#import "LevelSelectionScene.h"

//
#import "HelloWorldScene.h"
#import "NewtonScene.h"


@implementation MainScene


+ (MainScene *)scene
{
    return [[self alloc] init];
}


- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Doc's World" fontName:@"Chalkduster" fontSize:60.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor whiteColor];
    label.position = ccp(0.5f, 0.75f); // Middle of screen
    [self addChild:label];
    
    // Start Game Scene Button
    CCButton *startButton = [CCButton buttonWithTitle:@"Start Game" fontName:@"Chalkduster" fontSize:30.0f];
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.5f, 0.35f);
    [startButton setColor:[CCColor blueColor]];
    [startButton setTarget:self selector:@selector(startGame:)];
    [self addChild:startButton];
    
    // Settings Button
    CCButton *settingsButton = [CCButton buttonWithTitle:@"Settings" fontName:@"Chalkduster" fontSize:30.0f];
    settingsButton.positionType = CCPositionTypeNormalized;
    settingsButton.position = ccp(0.5f, 0.20f);
    [settingsButton setTarget:self selector:@selector(goToSettings:)];
    [self addChild:settingsButton];
	
    // done
	return self;
}

#pragma mark - Buttons

- (void)startGame:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[LevelSelectionScene scene]
                               withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
}

- (void)goToSettings:(id)sender
{
    // start newton scene with transition
    // the current scene is pushed, and thus needs popping to be brought back. This is done in the newton scene, when pressing back (upper left corner)
    [[CCDirector sharedDirector] pushScene:[NewtonScene scene]
                            withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
}

@end