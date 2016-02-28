//
//  ResultsTableViewController.swift
//  Image-Search
//
//  Created by Amog Kamsetty on 2/27/16.
//  Copyright (c) 2016 Amog Kamsetty. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var text:String = ""
    var feeds:NSMutableArray = []
    var images:NSMutableArray = []
    var titles:NSMutableArray = []
    var urls:NSMutableArray = []
    var oText:String = ""
    
    var chosenCellIndex:Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        if(!(text==oText)) {
            let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "You typed '"+oText+"'. Instead searching for '"+text+"'."
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup() {
        
        self.feeds = NSMutableArray()
        
        if let URL = NSURL(string: "https://api.500px.com/v1/photos/search?term="+text+"&consumer_key=ZLQAZLcTh1ajfIf8XSkTQzrZy7bcvqP8aIYoje8f") {
            
            NSURLSession.sharedSession().dataTaskWithURL(URL,
                completionHandler: { (data :NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                    
                    let result = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    
                    var error:NSError? = nil
                    
                    var list:NSDictionary?
                    
                    do {
                      list  = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                    } catch _ {
                        list = nil
                    }

                    
                    let items = list!.valueForKey("photos") as! NSArray
                    
                    for item in items
                    {
                        let dictionaryItem = item as! NSDictionary
                        
                        let feed = ImageFeed()
                        
                        feed.title = dictionaryItem.valueForKey("name") as! String!
                        feed.media = dictionaryItem.valueForKeyPath("image_url") as! String!
                        
                        self.feeds.addObject(feed)
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                    
                    
            }).resume()
        }
        
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feeds.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageFeedCell", forIndexPath: indexPath) as! ImageFeedTableViewCell
        
        let feed = self.feeds[indexPath.row] as! ImageFeed
        
        var title = feed.title!
        
        cell.nameLabel?.text = title
        self.titles.addObject(title)
        
        var url = feed.media!
        self.urls.addObject(url)
        
        var image:UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)!
        
        cell.imageView?.image = image
        self.images.addObject(image)
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        chosenCellIndex = indexPath.row
        self.performSegueWithIdentifier("showDetail", sender: self)
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let VC = nav.viewControllers.first as? ImageDetailViewController {
                VC.text = self.titles[chosenCellIndex] as! String
                VC.image = self.images[chosenCellIndex] as! UIImage
                VC.url = self.urls[chosenCellIndex] as! String
                }
            }
        }
    }
    
    @IBAction func cancelToResultsTableViewController(segue:UIStoryboardSegue) {
        
    }
    
    @IBAction func saveImage(segue:UIStoryboardSegue) {
        if let imageDetailViewController = segue.sourceViewController as? ImageDetailViewController {
            var title = imageDetailViewController.title
            var url = imageDetailViewController.url
            
            let image = PFObject(className: "Image")
            image.setValue(title, forKey: "title")
            image.setValue(url, forKey: "media")
            image.save()
            
        }
    }
}
