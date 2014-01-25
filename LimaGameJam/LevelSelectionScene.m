#import "LevelSelectionScene.h"
#import "Level1.h"


@implementation LevelSelectionScene

+ (LevelSelectionScene *)scene {
    return [[self alloc] init];
}


- (id)init
{
    self = [super init];
    if (!self) return(nil);
    
    
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:@"Chapter 1: Doctor's dream" fontName:@"Chalkduster" fontSize:60.0f];
    titleLabel.positionType = CCPositionTypeNormalized;
    titleLabel.color = [CCColor whiteColor];
    titleLabel.position = CGPointMake(0.5f, 0.90f);
    [self addChild:titleLabel];
    
    [self showLevelButtons];
    
	return self;
}

- (void) showLevelButtons {
    
    [self createLevelButtonWithNumber:1 :CGPointMake(0.2f, 0.65f)]; // Level 1
    [self createLevelButtonWithNumber:1 :CGPointMake(0.4f, 0.65f)]; // Level 2
    [self createLevelButtonWithNumber:1 :CGPointMake(0.6f, 0.65f)]; // Level 3
    [self createLevelButtonWithNumber:1 :CGPointMake(0.8f, 0.65f)]; // Level 4
    [self createLevelButtonWithNumber:1 :CGPointMake(0.2f, 0.30f)]; // Level 5
    [self createLevelButtonWithNumber:1 :CGPointMake(0.4f, 0.30f)]; // Level 6
    
}

- (void) createLevelButtonWithNumber:(int)_levelNumber :(CGPoint)_tilePosition {
    
    // LEVEL BUTTON
    CCButton *levelButton = [CCButton buttonWithTitle:@""
                                          spriteFrame:[CCSpriteFrame frameWithImageNamed:[NSString stringWithFormat:@"TileLevel%i.png",_levelNumber]]];
    levelButton.positionType = CCPositionTypeNormalized;
    levelButton.position = ccp(_tilePosition.x, _tilePosition.y);
    levelButton.name = [NSString stringWithFormat:@"%i",_levelNumber];
    [levelButton setTarget:self selector:@selector(goToLevel:)];
    [self addChild:levelButton];
    
    // LEVEL NUMBER
    CCLabelTTF *titleLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i",_levelNumber] fontName:@"Chalkduster" fontSize:24.0f];
    titleLabel.positionType = CCPositionTypeNormalized;
    titleLabel.color = [CCColor whiteColor];
    titleLabel.position = CGPointMake(_tilePosition.x, _tilePosition.y-0.15f);
    [self addChild:titleLabel];
}

- (void)goToLevel:(id)sender {
    CCButton *buttonTapped = (CCButton *)sender;
    NSLog(@"Se irá al nivel es %@",buttonTapped.name);
    int levelSelected = [buttonTapped.name integerValue];
    switch (levelSelected) {
        case 1:
            [[CCDirector sharedDirector] replaceScene:[Level1 scene] withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
            break;
        case 2:
            [[CCDirector sharedDirector] replaceScene:[Level1 scene] withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
            break;
        case 3:
            [[CCDirector sharedDirector] replaceScene:[Level1 scene] withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
            break;
        case 4:
            [[CCDirector sharedDirector] replaceScene:[Level1 scene] withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
            break;
        case 5:
            [[CCDirector sharedDirector] replaceScene:[Level1 scene] withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
            break;
        default:
            break;
    }
}

@end
