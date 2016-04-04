//
//  MentionViewController.swift
//  Twittient
//
//  Created by TriNgo on 4/2/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class MentionViewController: UIViewController {
    var tweets: [Tweet]!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        loadDataFromNetwork()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataFromNetwork() {
        TwitterClient.shareInstance.mentionTimeLine(1, success: { (tweets:[Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
                print(error.localizedDescription)
        }
    }

}

extension MentionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MeCell", forIndexPath: indexPath) as! MeCell
        let tweet = tweets[indexPath.row]
        
        cell.nameLabel.text = tweet.name as? String
        cell.tagLabel.text = "@\(tweet.screenName)"
        cell.descriptionLabel.text = tweet.text as? String
        cell.timeagoLabel.text = timeAgoSince(tweet.timeStamp!)
        cell.avatarImage.setImageWithURL(tweet.profileImageUrl!)
        
        let isFavorited = tweet.favorited
        if isFavorited {
            let image = UIImage(named: "like.png")! as UIImage
            cell.favoriteButton.setImage(image, forState: .Normal)
        } else {
            let image = UIImage(named: "unlike.png")! as UIImage
            cell.favoriteButton.setImage(image, forState: .Normal)
        }
        
        let isRetweeted = tweet.retweeted
        if isRetweeted {
            let image = UIImage(named: "retweeted.png")! as UIImage
            cell.retweetButton.setImage(image, forState: .Normal)
        } else {
            let image = UIImage(named: "retweet.png")! as UIImage
            cell.retweetButton.setImage(image, forState: .Normal)
        }
        
        return cell
    }
}
