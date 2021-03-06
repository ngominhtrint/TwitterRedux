//
//  ProfileViewController.swift
//  Twittient
//
//  Created by TriNgo on 4/2/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var user: User!
    var tweets: [Tweet]!
    
    // UI variables

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numOfTweetsLabel: UILabel!
    @IBOutlet weak var numOfFollowingLabel: UILabel!
    @IBOutlet weak var numOfFollowersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profileBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Do any additional setup after loading the view.
        user = User.currentUser
        initView()
    }

    func initView() {
        avatarImage.layer.cornerRadius = 4.0
        avatarImage.setImageWithURL(user.profileUrl!)
        nameLabel.text = user.name as? String
        numOfTweetsLabel.text = String(user.tweetCount!)
        numOfFollowingLabel.text = String(user.followingCount!)
        numOfFollowersLabel.text = String(user.followersCount!)
        
        let data = NSData(contentsOfURL: user.profileBackgroundUrl!)
        profileBackgroundView.backgroundColor = UIColor(patternImage: UIImage(data: data!)!)
        
        loadDataFromNetwork()
    }
    
    func loadDataFromNetwork() {

            TwitterClient.shareInstance.profileTimeLine(1, success: { (tweets:[Tweet]) -> () in
                self.tweets = tweets
                self.tableView.reloadData()
            }) { (error: NSError) -> () in
                print(error.localizedDescription)
            }

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

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
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

