#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CloudReview : NSObject {
    int m_appleID;
}
+(CloudReview*)sharedReview;
-(void) reviewFor:(int)appleID;
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end