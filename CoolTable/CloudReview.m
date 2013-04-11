#import "CloudReview.h"

@implementation CloudReview
static CloudReview* _sharedReview = nil;
+(CloudReview*)sharedReview
{
    @synchronized([CloudReview class])
    {
        if (!_sharedReview)
        {
            return [[self alloc] init];
        }
    }
    
    return nil;
}
+(id)alloc
{
    @synchronized([CloudReview class])
    {
        NSAssert(_sharedReview == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedReview = [super alloc];
        return _sharedReview;
    }
    
    return nil;
}
-(void)reviewFor:(int)appleID
{
    m_appleID = appleID;
    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:@"请评价我的程序~"
                                       message:@"花点时间评价一下哦~谢谢啦~"
                                      delegate: self
                             cancelButtonTitle:@"取消"
                             otherButtonTitles:@"评价", nil];
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"neverRate"];
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%d",
                         m_appleID ];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
@end