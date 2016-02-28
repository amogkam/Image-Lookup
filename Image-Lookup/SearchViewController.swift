//
//  SearchViewController.swift
//  Image-Search
//
//  Created by Amog Kamsetty on 2/27/16.
//  Copyright (c) 2016 Amog Kamsetty. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    var text:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "searchSegue") {
            if let VC = segue.destinationViewController as? ResultsTableViewController {
                
                if let text = searchTextField.text {
                    
                    VC.oText = text
                    
                    var cleanText = stripOutUnwantedCharactersFromText(text)
                    var checker  = UITextChecker()
                    var range:NSRange = NSMakeRange(0, cleanText.characters.count)
                    var misspelledRange:NSRange = checker.rangeOfMisspelledWordInString(cleanText, range: range, startingAt: range.location, wrap: false, language: "en_US")
                    var isRealWord:Bool = misspelledRange.location == NSNotFound
                    if(!isRealWord) {
                        var arrGuessed:NSArray = checker.guessesForWordRange(misspelledRange, inString: cleanText, language: "en_US")!
                        searchTextField.text = (cleanText as NSString).stringByReplacingCharactersInRange(misspelledRange, withString: arrGuessed[0] as! String)
                    }
                    else {
                        searchTextField.text = cleanText
                    }
                }
                
                VC.text = searchTextField.text!
            }
        }
    }
    
    func stripOutUnwantedCharactersFromText(text: String) -> String {
        let okayChars : Set<Character> = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ".characters)
        return String(text.characters.filter {okayChars.contains($0)})
    }

}
