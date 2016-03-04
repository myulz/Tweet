//
//  Tweet.swift
//  Tweet
//
//  Created by Myles Johnson on 2/29/16.
//  Copyright © 2016 Myles. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var user: User?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var profileImageUrl: NSString?
    
    init(dictionary: NSDictionary){
        user = User(dictionary: dictionary["user"]as! NSDictionary)
       // profileImageUrl = dictionary["profile_image_url"] as? String
        //print("profileImageUrl: \(profileImageUrl)")
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        
       
        
        if let timestampString = timestampString{
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
            
            
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary:dictionary)
            
            tweets.append(tweet)
        }
        return tweets
        
    }
}
