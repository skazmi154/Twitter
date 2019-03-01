//
//  HomeViewController.swift
//  Twitter
//
//  Created by Syed Kazmi on 2/24/19.
//  Copyright © 2019 Syed Kazmi. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [[String:Any]]()
    
    let uiRefresh = UIRefreshControl()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.fetchTweets()
        uiRefresh.addTarget(self,action:#selector(fetchTweets), for: .valueChanged )
       self.tableView.dataSource = self
       self.tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.refreshControl = uiRefresh
    }
    

    @IBAction func onLogoutButtonClicked(_ sender: Any) {
        
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey:"loggedIn")
        self.performSegue(withIdentifier: "logout", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell") as! TweetCell
        let feed_user = self.tweets[indexPath.row]["user"] as! [String:Any]
        let feed_username = feed_user["name"] as! String
        
        cell.username.text = feed_username
        let feed_tweet = self.tweets[indexPath.row]["text"] as! String
        cell.tweet.text = feed_tweet
        let userImageUrl = feed_user["profile_image_url"] as! String
        let url = URL(string:userImageUrl)!
        cell.userDp.af_setImage(withURL: url)
        return cell
    }
    
    @objc func fetchTweets() {
        
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count":10]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params, success: { (tweetArray:[NSDictionary]) in
            self.tweets.removeAll()
            for tweet in tweetArray {
                self.tweets.append(tweet as! [String : Any])
            }
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()

        }, failure: { (Error) in
            
            print(Error)
        })
    }
    

    
}
