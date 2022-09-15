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
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier = TextClassifier()
    let tweetCount = 100
    
    let swifter = Swifter(consumerKey: "drhYArJK83I5fnqs3CAQI8qYl", consumerSecret: "7bYWVWU8xkFXjQtBvm0T5d9mxcstxrXlxKDYHUqudTld4ZuZOV")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func predictButtonClicked(_ sender: UIButton) {
        fetchTweets()
    }
    
    func fetchTweets(){
        if let searchText = searchTextField.text{
            swifter.searchTweet(using: searchText, lang: "en", count: tweetCount, tweetMode: .extended, success: { results, metadata in
                var tweets = [TextClassifierInput]()
                
                for i in 0..<self.tweetCount{
                    if let tweet = results[i]["full_text"].string{
                        let tweetForClassification = TextClassifierInput(text: tweet)
                        tweets.append(tweetForClassification)
                    }
                }
                self.makePrediction(with: tweets)
            }) { error in
                print(error)
            }
        }
    }
    
    func makePrediction(with tweets: [TextClassifierInput]){
        do{
        let predictions = try self.sentimentClassifier.predictions(inputs: tweets)
            var sentimentScore = 0
            for prediction in predictions {
                let sentiment = prediction.label
                if sentiment == "Pos"{
                    sentimentScore += 1
                }else if sentiment == "Neg"{
                    sentimentScore -= 1
                }
            }
         updateUI(with: sentimentScore)
        }catch{
            print(error)
        }
    }
    
    func updateUI(with sentimentScore: Int){
        if sentimentScore>20{
            self.sentimentLabel.text = "😃"
        }else if sentimentScore>0{
            self.sentimentLabel.text = "😑"
        }else{
            self.sentimentLabel.text = "☹️"
        }
    }
    
}

