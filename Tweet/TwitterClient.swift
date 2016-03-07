//
//  TwitterClient.swift
//  Tweet
//
//  Created by Myles Johnson on 2/29/16.
//  Copyright © 2016 Myles. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "u4AYUMxqBtngu3nPREvZm2nbp", consumerSecret: "aPqDubH4gAFsGVV5bGzdxRX8PpAKiJGMCWs0vTqiO83QBji1u7")
    
    var loginSuccess: (()->())?
    var loginFailure:((NSError)->())?
    
    
    func login(success: ()->(), failure:(NSError)->()){
        loginSuccess = success
        loginFailure = failure
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "tweet://oauth"), scope: nil, success: { (requestToken:BDBOAuth1Credential!) -> Void in
            print("Token!")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            }) { (error:NSError!) -> Void in
                print("error: \(error.localizedDescription)")
                self.loginFailure?(error)
        }
        
        
    }
    
    func tweet(params: NSDictionary?) {
        POST("1.1/statuses/update.json", parameters: params, progress: { (progress) -> Void in
            }, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                
        })
    }
    
    func logout(){
        User._currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
        

    }
    
    func handleOpenUrl(url:NSURL){
        
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User._currentUser = user
                self.loginSuccess?()
                
                }, failure: { (error: NSError) -> () in
                     self.loginFailure?(error)
                    
            })
            
            //self.loginSuccess?()
            
            }) { (error: NSError!) -> Void in
                print("error:\(error.localizedDescription)")
                self.loginFailure?(error)
        }

        
        
        
    }

    
    
    func homeTimeline(success: ([Tweet])->(), failure:(NSError)->()){
        
        
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            
            success(tweets)
    
            }, failure: { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                failure(error)
        })

        
    }
    
    func currentAccount(success:(User)->(),failure: (NSError)->()){
        
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            // print("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
        
            success(user)
            
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                
                failure(error)
                
        })
    }
    
    
}
 