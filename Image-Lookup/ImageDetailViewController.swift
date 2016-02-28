
//
//  ImageDetailViewController.swift
//  Image-Search
//
//  Created by Amog Kamsetty on 2/27/16.
//  Copyright (c) 2016 Amog Kamsetty. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    var text:String = ""
    var image:UIImage = UIImage()
    var url:String = ""
    
    @IBOutlet var imageView: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        self.title = text
        
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
