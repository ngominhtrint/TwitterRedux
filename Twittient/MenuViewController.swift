//
//  MenuViewController.swift
//  Twittient
//
//  Created by TriNgo on 4/2/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIGestureRecognizerDelegate {

    
    private var profileViewController: UIViewController!
    private var mentionViewController: UIViewController!
    private var timeLineViewController: UIViewController!
    private var suggestionViewController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController!
    var user: User!
    
    //UI variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        user = User.currentUser

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        profileViewController = storyBoard.instantiateViewControllerWithIdentifier("ProfileViewController")
        
        timeLineViewController = storyBoard.instantiateViewControllerWithIdentifier("TweetsNavigationController")
        mentionViewController = storyBoard.instantiateViewControllerWithIdentifier("MentionViewController")
        suggestionViewController = storyBoard.instantiateViewControllerWithIdentifier("SuggestionViewController")
        viewControllers.append(timeLineViewController)
        viewControllers.append(mentionViewController)
        viewControllers.append(suggestionViewController)
        
        hamburgerViewController.contentViewController = timeLineViewController
        
        // Do any additional setup after loading the view.
        initView()
        
    }
    
    func initView() {
        let tap = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
        tap.delegate = self
        avatarImage.userInteractionEnabled = true
        avatarImage.addGestureRecognizer(tap)
        
        avatarImage.layer.cornerRadius = 6.0
        avatarImage.setImageWithURL(user.profileUrl!)
        nameLabel.text = user.name as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleTap(sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("> on avatar tap")
        hamburgerViewController.contentViewController = profileViewController
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuCell", forIndexPath: indexPath) as! MenuCell
        
        let titles = ["Home Timeline", "Mentions Timeline", "People You May Know", "Jobs",
            "Your Recent Activity", "Companies", "Connections", "Groups", "Add shortcut"]
        let icons = ["eye", "pulse", "add_user", "suitcase",
            "clock", "building", "people", "chat", "add"]
        cell.titleLabel.text = titles[indexPath.row]
        cell.iconImage.image = UIImage(named: icons[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row <= 2 {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        }
    }
    
}











