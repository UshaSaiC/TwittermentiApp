//
//  ViewController.swift
//  TwittermentiApp
//
//  Created by Usha Sai Chintha on 15/09/22.
//

import UIKit
import SwifteriOS // twitter framework for iOS and mocOS written in swift

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UIStackView!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    // consumerKey --> API key on portal
    // consumerSecret --> API key secret on portal
    let swifter = Swifter(consumerKey: "drhYArJK83I5fnqs3CAQI8qYl", consumerSecret: "7bYWVWU8xkFXjQtBvm0T5d9mxcstxrXlxKDYHUqudTld4ZuZOV")
    // Its not safe to have these keys in file, so alternative is creating a new info.list via navigating through File -> New -> File -> Choose iOS and select Property List which create new plist file. Then we can add above values as key value pairs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // by default only 15 tweets are returned, via using ount we can get upto 100 twweets
        // the data returned has text cut down to 140 characters, so tweetMode parameter helps in dislaying full_text instead of text highlighting search parameter which can be upto 280 characters
        // we get tweets of different languages but we can get tweets of desired language via lang parameter 
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { results, metadata in
            print(results)
        }) { error in
            print(error)
        }

    }

    @IBAction func predictButtonClicked(_ sender: UIButton) {
        
    }
    
}

