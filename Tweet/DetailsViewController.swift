//
//  DetailsViewController.swift
//  Tweet
//
//  Created by Myles Johnson on 3/5/16.
//  Copyright © 2016 Myles. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var profileView: UIImageView!
    var tweet: Tweet!
    
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var screen: UILabel!
    @IBOutlet weak var name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(tweet.user!.name as! String)'s tweet"
        name.text = tweet.user!.name as? String
        tweetText.text = tweet.text as? String
        favCount.text = String(tweet.favoritesCount)
        retweetCount.text = String(tweet.retweetCount)
        profileView.setImageWithURL((tweet.user?.profileUrl)!)
        screen.text = "@\(tweet.user?.screenname as! String)"
        
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
