//
//  ViewController.swift
//  TwittermentiApp
//
//  Created by Usha Sai Chintha on 15/09/22.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var textField: UIStackView!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TextClassifier()
    
    let swifter = Swifter(consumerKey: "drhYArJK83I5fnqs3CAQI8qYl", consumerSecret: "7bYWVWU8xkFXjQtBvm0T5d9mxcstxrXlxKDYHUqudTld4ZuZOV")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prediction = try! sentimentClassifier.prediction(text: "@Apple is not so bad")
        print(prediction.label)
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended, success: { results, metadata in
            var tweets = [String]()
            
            for i in 0...99{
                if let tweet = results[i]["full_text"].string{
                    tweets.append(tweet)
                }
            }
            
        }) { error in
            print(error)
        }
        
    }
    
    @IBAction func predictButtonClicked(_ sender: UIButton) {
        
    }
    
}

