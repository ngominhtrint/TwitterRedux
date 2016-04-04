//
//  SuggestionViewController.swift
//  Twittient
//
//  Created by TriNgo on 4/4/16.
//  Copyright © 2016 TriNgo. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController {
    
    var users: [User]!

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension

        // Do any additional setup after loading the view.
        loadDataFromNetwork()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loadDataFromNetwork() {
        TwitterClient.shareInstance.suggestions({ (users:[User]) -> () in
            self.users = users
            self.tableView.reloadData()
        }) { (error: NSError) -> () in
            print(error.localizedDescription)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SuggestionCellSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let user = users[indexPath!.row]
            
            let profileViewController = segue.destinationViewController as! ProfileViewController
            profileViewController.user = user
        }
    }
}

extension SuggestionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SuggestionCell", forIndexPath: indexPath) as! SuggestionCell
        
        let user = users[indexPath.row]
        
        cell.avatarImage.setImageWithURL(user.profileUrl!)
        cell.nameLabel.text = user.name as? String
        cell.tagLabel.text = user.screenName as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        
    }
}







