//
//  TweetsViewController.swift
//  Tweet
//
//  Created by Myles Johnson on 3/1/16.
//  Copyright © 2016 Myles. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    var detailTweet:Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.reloadData()
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            for tweet in tweets{
                print(tweet.text)
            }
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadList:",name:"load", object: nil)
        
        
        

        // Do any additional setup after loading the view.
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        var nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.BlackTranslucent
        nav?.tintColor = UIColor(red: 245/255, green: 152/255, blue: 255/255, alpha: 1.0)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
       
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        //let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as! TweetTableViewCell
        let tweet = tweets[indexPath.row]
        detailTweet = tweet
        self.performSegueWithIdentifier("tweetSegue", sender: nil)
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil{
            return tweets.count
            
        }else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetTableViewCell
        cell.selectionStyle = .None
        let tweet = tweets[indexPath.row]
        
        cell.profileImage.setImageWithURL(tweet.user!.profileUrl!)
        //print(tweet.user!.profileUrl)
        
        cell.tweetLabel.text = tweet.text as? String
        //cell.timeLabel.text = String(tweet.timestamp!)
        cell.userLabel.text = String(tweet.user!.name!)
        
        
        /*var formatter = NSDateFormatter()
        formatter.dateFormat = "h:mm aaa"
        //cell.timeLabel.text = formatter.stringFromDate(tweet.timestamp!)*/
        
        let formatter = NSDateComponentsFormatter()
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyle.Abbreviated
        formatter.collapsesLargestUnit = true
        formatter.maximumUnitCount = 1
        let timesince = NSDate().timeIntervalSinceDate(tweet.timestamp!)
        cell.timeLabel.text = formatter.stringFromTimeInterval(timesince)!

        
        

        return cell
    }
   
    @IBAction func onRetweetButton(sender: AnyObject) {
        print("retweeted")
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetTableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)
        
        let tweet = tweets[indexPath!.row]
        
        tweet.retweetCount += 1
        print(tweet.retweetCount);
       // button.setBackgroundImage(UIImage?, forState: UIControlState.Normal)
        
    }
  
    @IBAction func onProfileButton(sender: AnyObject) {
        self.performSegueWithIdentifier("profileSegue", sender: sender)
        
    }
    
    @IBAction func onFavButton(sender: AnyObject) {
        print("Favorited")
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetTableViewCell
        
        let indexPath = tableView.indexPathForCell(cell)
        
        let tweet = tweets[indexPath!.row]
        tweet.favoritesCount += 1
        print(tweet.favoritesCount);
    }
    
   
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
      

       
        if (segue.identifier == "profileSegue") {
            
            print("prepare for segue called(profile)")
            //let indexPath = self.tableView.indexPathForSelectedRow
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetTableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            
            let tweet = tweets[indexPath!.row]
            
            let profileViewController = segue.destinationViewController as! ProfileViewController
            
            profileViewController.tweet = tweet
            

            
        }
        
        if (segue.identifier == "tweetSegue") {
            
            print("prepare for segue called(tweet)")
            //let indexPath = self.tableView.indexPathForSelectedRow
            
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            
            detailsViewController.tweet = detailTweet
            
            
            
        }
    }

}
