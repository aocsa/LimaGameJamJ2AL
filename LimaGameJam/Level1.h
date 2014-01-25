#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Level1 : CCScene {
    
}
@property int levelNumber;
@property CGRect worldRect;

+ (Level1 *) scene;
- (id) init;

@end
