//
//  ComposeViewController.swift
//  Tweet
//
//  Created by Myles Johnson on 3/5/16.
//  Copyright © 2016 Myles. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    @IBOutlet weak var profileView: UIImageView!

    @IBOutlet weak var tweetText: UITextField!
    @IBOutlet weak var screen: UILabel!
    @IBOutlet weak var name: UILabel!
    var params: [String: String]! = ["status": "", "in_reply_to_status_id": ""]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tweetText.text = params["status"]! + " "

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTweet(sender: AnyObject) {
        
            params["status"] = tweetText.text
            TwitterClient.sharedInstance.tweet(params)
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            self.dismissViewControllerAnimated(true, completion: {})
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(sender: AnyObject) {
       self.dismissViewControllerAnimated(true, completion: {})

        
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
