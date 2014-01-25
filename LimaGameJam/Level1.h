#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Level1 : CCScene {
    
}
@property int levelNumber;

+ (Level1 *)scene;
- (id)initWithLevelNumber :(int)levelNumber;

@end
