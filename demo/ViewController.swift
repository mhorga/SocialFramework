//
//  ViewController.swift
//  demo
//
//  Created by Marius on 11/2/15.
//  Copyright © 2015 Marius Horga. All rights reserved.
//

import UIKit
import Social

class ViewController: UIViewController {

    @IBOutlet weak var socialTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func shareAction(sender: UIBarButtonItem) {
        if socialTextView.isFirstResponder() {
            socialTextView.resignFirstResponder()
        }
        let actionController = UIAlertController(title: "Share", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        presentViewController(actionController, animated: true, completion: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil)
        let tweetAction = UIAlertAction(title: "Tweet", style: UIAlertActionStyle.Default) { _ in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let tweet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                var text = self.socialTextView.text
                if text.characters.count > 140 {
                    text = (self.socialTextView.text as NSString).substringToIndex(140)
                }
                tweet.setInitialText(text)
                self.presentViewController(tweet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "You are not signed in to Twitter.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.Default) { _ in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookSheet = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookSheet.setInitialText(self.socialTextView.text)
                self.presentViewController(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts", message: "You are not signed in to Facebook.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        let moreAction = UIAlertAction(title: "More", style: UIAlertActionStyle.Default) { _ in
            let moreVC = UIActivityViewController(activityItems: [self.socialTextView.text], applicationActivities: nil)
            self.presentViewController(moreVC, animated: true, completion: nil)
        }
        actionController.addAction(tweetAction)
        actionController.addAction(facebookAction)
        actionController.addAction(moreAction)
        actionController.addAction(cancelAction)
    }
}
