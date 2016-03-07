//
//  ProfileViewController.swift
//  Tweet
//
//  Created by Myles Johnson on 3/6/16.
//  Copyright © 2016 Myles. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var screen: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = tweet.user?.name as? String
        profileView.setImageWithURL((tweet.user?.profileUrl)!)
        //name.text = tweet.user?.name as? String
        screen.text = "@\(tweet.user?.screenname as! String)"
        
        followersCount.text = String(tweet.user!.followersCount!)
        followingCount.text = String(tweet.user!.followingCount!)
        tweetsCount.text = String(tweet.user!.tweetCount!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
