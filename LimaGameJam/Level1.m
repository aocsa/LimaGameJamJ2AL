#import "Level1.h"


@implementation Level1

+ (Level1 *)scene
{
    return [[self alloc] init];
}


- (id)init{
    self = [super init];
    if (!self) return(nil);
    self.levelNumber = 1;
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    [self addChild:background];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Level %i",self.levelNumber] fontName:@"Chalkduster" fontSize:60.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor whiteColor];
    label.position = ccp(0.5f, 0.80f);
    [self addChild:label];
    
    // Background
    [self setBackground];
    
	return self;
}

- (void) setBackground {
    CCSprite *backgroundSprite = [CCSprite spriteWithImageNamed:[NSString stringWithFormat:@"backgroundLevel%i.jpg",self.levelNumber]];
    backgroundSprite.positionType = CCPositionTypeNormalized;
    backgroundSprite.position = ccp(0.5f, 0.5f);
    [self addChild:backgroundSprite];
}


@end
