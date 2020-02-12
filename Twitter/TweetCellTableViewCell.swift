 //
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Kaeley Lenard on 2/2/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    
    var favorited:Bool = false
    var isRetweeted: Bool = false
    
    var tweetId:Int = -1
    
    @IBAction func favoriteTweet(_ sender: Any) {
        
        //what is this
        let toBeFavorited = !favorited
        
        
        if (toBeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
                print("Successful Favorite")
            }, failure: {(error) in print("Favorite did not succeed: \(error)")})
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
                print("successful UN-Favorite")
            }, failure: {(error) in print("Unfavorite did not succeed: \(error)")})
        }
    }
    @IBAction func retweet(_ sender: Any) {
        
        let toBeRetweeted = !isRetweeted
        
        //determine if the retweet image matches ewither the 'retweet' or 'unretweeted' image
        //to go thru the if statement, check to see what image is set in the retweet button
        if(toBeRetweeted){
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
                print("successful Retweet")
            }, failure: { (error) in print("Error is retweeting: \(error)")})
        }else{
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
                print("successful UN-Retweet")
                
            }, failure: { (error) in print("Error is retweeting: \(error)")})
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        print("set retweet")
        if (isRetweeted) {
            print("Retweeted")
            retweetButton.setImage(UIImage(named: "twitter_retweet_green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            print("unretweeeet")
            retweetButton.setImage(UIImage(named: "twitter_retweet_gray"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    func setFavorite(_ isFavorited:Bool) {
        favorited = isFavorited
        print("set favorited")
        if (favorited) {
            print("Favorited")
            favButton.setImage(UIImage(named: "twitter_heart_red"), for: UIControl.State.normal)
        }
        else {
            favButton.setImage(UIImage(named: "twitter_heart_gray"), for: UIControl.State.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
