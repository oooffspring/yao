//
//  AibangApi.h
//  AibangApi
//
//  Created by Liujun Deng on 12-4-9.
//  Copyright (c) 2012年 aibang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@class ABConnection;

@protocol AibangApiDelegate <NSObject>

-(void) requestDidFinishWithData:(NSData*)data aibangApi:(id)aibangApi;
-(void) requestDidFailedWithError:(NSError*)error aibangApi:(id)aibangApi; 

@end


@interface AibangApi : NSObject{
    ABConnection* http;
}

@property(nonatomic, copy) NSString* alt;

@property(nonatomic, assign) id delegate;

+ (void)setAppkey:(NSString *)appkey;

-(void)connectionCancel;

/**
 * 商户搜索接口根据指定的城市、地址（或坐标）和关键词等参数查询满足条件的商户，返回商户列表。
 * 如果不指定地址，则在全市搜索。若不指定关键字，则返回地址周边的商户。地址和关键字必须至少有一个。
 *  最多返回前300个满足指定搜索条件的商户。
 */
- (void) searchBizWithCity:(NSString *)city 
                     Query:(NSString *)query
                   Address:(NSString *)address
                  Category:(NSString *)category
                       Lng:(NSString *)lng
                       Lat:(NSString *)lat
                    Radius:(NSString *)radius
                  Rankcode:(NSString *)rc
                      From:(NSString *)from
                        To:(NSString *)to;

/**
 * 地址定位接口。该接口查询指定地址的经纬度坐标。
 */
- (void) locateWithCity:(NSString *)city
                   Addr:(NSString *)addr;

/**
 * 商户信息查询接口。通过这个接口查询指定商户的信息。
 */
- (void) bizWithBid:(NSString *)bid;

/**
 * 商户点评查询。该接口查询指定商户的点评。（最多一次返回30条记录）
 */
- (void) bizCommentsWithBid:(NSString *)bid;

/**
 * 商户图片查询。该接口查询指定商户的图片。（最多一次返回30条记录）
 */
- (void)bizPicsWithBid:(NSString *)bid
                  From:(NSString *)from
                    To:(NSString *)to;

/**
 * 公交换乘查询。该接口根据起点和终点信息查询公交换乘方案。
 */
- (void)busTransferWithCity:(NSString *)city
                  StartAddr:(NSString *)startAddr
                    EndAddr:(NSString *)endAddr
                   StartLng:(NSString *)startLng
                   StartLat:(NSString *)startLat
                     EndLng:(NSString *)endLng
                     EndLat:(NSString *)endLat
                         Rc:(NSString *)rc
                      Count:(NSString *)count
                    Withxys:(NSString *)withxys;

/**
 * 公交线路查询。该接口根据关键字查询匹配的线路。
 */
-(void)buslinesWithCity:(NSString *)city
                KeyWord:(NSString *)keyword
               Withxys:(NSString *)withxys;

/**
 * 公交站点查询。该接口根据关键字查询匹配的站点。
 */
-(void)busStatsWithCity:(NSString *)city
                Keyword:(NSString *) keyword;

/**
 * 周边公交站点查询。该接口根据经纬度坐标查询其附近的站点。
 */
-(void)busStatsAroundWithCity:(NSString *)city
                         Dist:(NSString *)dist
                          Lng:(NSString *)lng
                          Lat:(NSString *)lat;

/**
 * 对指定商户发表点评。
 */
-(void)postCommentToBizWithBid:(NSString *)bid
                         Uname:(NSString *)uname
                         Score:(NSString *)score
                          Cost:(NSString *)cost
                       Content:(NSString *)content;

/**
 * 对指定商户上传图片。
 */
-(void)postBizPicWithBid:(NSString *)bid
                   Uname:(NSString *)uname
                   Title:(NSString *)title
               ImageData:(NSData *)imageData;

/**
 * 修改商户信息。
 */
-(void)postModifyBizInfoWithBid:(NSString *)bid
                          Uname:(NSString *)uname
                          Bname:(NSString *)bname
                         Status:(NSString *)status
                            Tel:(NSString *)tel
                           City:(NSString *)city
                         County:(NSString *)county
                           Addr:(NSString *)addr
                           Desc:(NSString *)desc
                            Lng:(NSString *)lng
                            Lat:(NSString *)lat
                           Cate:(NSString *)cate
                       Worktime:(NSString *)worktime
                           Cost:(NSString *)cost
                        SiteUrl:(NSString *)siteurl;

/**
 * 添加商户。
 */
- (void)postAddBizInfoWithBname:(NSString *)bname
                          Uname:(NSString *)uname
                         Status:(NSString *)status
                            Tel:(NSString *)tel
                           City:(NSString *)city
                         County:(NSString *)county
                           Addr:(NSString *)addr
                           Desc:(NSString *)desc
                            Lng:(NSString *)lng
                            Lat:(NSString *)lat
                           Cate:(NSString *)cate
                       Worktime:(NSString *)worktime
                           Cost:(NSString *)cost
                        SiteUrl:(NSString *)siteurl;
@end
