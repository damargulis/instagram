//
//  HomeViewController.swift
//  instagram
//
//  Created by Daniel Margulis on 3/5/16.
//  Copyright © 2016 Daniel Margulis. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var Posts: [PFObject]!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            if let posts = posts{
                self.Posts = posts
                print("got posts")
                print(self.Posts.count)
                self.tableView.reloadData()
            } else{
                print("failed to get posts")
                print(error?.localizedDescription)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostTableViewCell
        let post = Posts[indexPath.row]
        
        print("loading \(indexPath.row)")
        
        cell.captionLabel.text = post["caption"] as? String
        
        cell.postImageView.file = post["media"] as? PFFile
        cell.postImageView.loadInBackground()
        
        
        
        
        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let Posts = Posts{
            print("returning \(Posts.count)")
            return Posts.count
        } else{
            print("returning none")
            return 0
        }
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
