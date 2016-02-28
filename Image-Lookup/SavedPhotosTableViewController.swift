
//
//  SavedPhotosTableViewController.swift
//  Image-Lookup
//
//  Created by Amog Kamsetty on 2/27/16.
//  Copyright © 2016 Amog Kamsetty. All rights reserved.
//

import UIKit

class SavedPhotosTableViewController: PFQueryTableViewController {
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
    }
    
    required init(coder aDecoder:NSCoder)  
    {
        super.init(coder: aDecoder)!
        
        self.parseClassName = "Image"
        self.paginationEnabled = false
        self.pullToRefreshEnabled = true
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
    }
    
    override func queryForTable() -> PFQuery {
        
        var query:PFQuery = PFQuery(className:"Image")
        
        query.orderByDescending("createdAt")
        
        return query
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        let cellIdentifier:String = "Cell"
        
        var cell:SavedPhotosTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? SavedPhotosTableViewCell
        
        if let pfObject = object {
            cell?.nameLabel?.text = pfObject["title"] as? String
            
            cell?.mediaImageView?.image = nil
            if var urlString:String? = pfObject["media"] as? String {
                var url:NSURL? = NSURL(string: urlString!)
                
                if var url:NSURL? = NSURL(string: urlString!) {
                    var error:NSError?
                    var request:NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
                    
                    NSOperationQueue.mainQueue().cancelAllOperations()
                    
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                        (response:NSURLResponse?, imageData:NSData?, error:NSError?) -> Void in
                        
                        cell?.mediaImageView?.image = UIImage(data: imageData!)
                    })
                }
            }
            
        }
        
        return cell;
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
