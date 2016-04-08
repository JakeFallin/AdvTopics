//
//  EditQuoteViewController.swift
//  Quota
//
//  Created by rpsapps on 2/25/16.
//  Copyright © 2016 matthewmuccio. All rights reserved.
//

import UIKit

class EditQuoteViewController: UIViewController, UITextViewDelegate
{
    let quoteText = UITextView();
    let authorText = UITextView();
    let editQuoteButton = UIButton();
    let confirmText = UILabel();
    var quotes:Array<Dictionary<String, String>> = NSUserDefaults.standardUserDefaults().valueForKey("quotes") as! Array<Dictionary<String, String>>;
    let h = UIScreen.mainScreen().bounds.height;
    let w = UIScreen.mainScreen().bounds.width;
    
    var quoteIndex = -1;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Edit Quote";
        self.view.backgroundColor = UIColor.grayColor();
        self.automaticallyAdjustsScrollViewInsets = false;
        
        // Tapping away from TextViews
        let tapView = UIView(frame: self.view.bounds);
        let onTapAway = UITapGestureRecognizer(target: self, action: "onTapAway:");
        tapView.addGestureRecognizer(onTapAway);
        self.view.addSubview(tapView);
        
        // Quote TextView
        self.quoteText.delegate = self;
        self.quoteText.frame = CGRect(x: (w/2) - 150, y: (h/2) - 150, width: 300, height: 125);
        self.quoteText.text = self.quotes[quoteIndex]["quote"];
        self.quoteText.font = UIFont(name: "Noteworthy-Bold", size: 12);
        self.quoteText.backgroundColor = UIColor.whiteColor();
        self.quoteText.returnKeyType = UIReturnKeyType.Done;
        self.quoteText.layer.borderWidth = 0.5;
        self.quoteText.layer.cornerRadius = 5.0;
        self.quoteText.layer.borderColor = UIColor.grayColor().CGColor;
        self.view.addSubview(quoteText);
        
        // Author TextView
        self.authorText.delegate = self;
        self.authorText.frame = CGRect(x: (w/2) - 150, y: (h/2) - 22.5, width: 300, height: 50);
        self.authorText.text = self.quotes[quoteIndex]["author"];
        self.authorText.font = UIFont(name: "Noteworthy-Bold", size: 12);
        self.authorText.backgroundColor = UIColor.whiteColor();
        self.authorText.returnKeyType = UIReturnKeyType.Done;
        self.authorText.layer.borderWidth = 0.5;
        self.authorText.layer.cornerRadius = 5.0;
        self.authorText.layer.borderColor = UIColor.grayColor().CGColor;
        self.view.addSubview(authorText);
        
        // Edit Quote Button
        self.editQuoteButton.frame = CGRect(x: (w/2) - 75, y: 72.5, width: 150, height: 50);
        self.editQuoteButton.addTarget(self, action: "editQuote", forControlEvents: UIControlEvents.TouchUpInside);
        self.editQuoteButton.titleLabel?.font = UIFont(name: "Noteworthy-Light", size: 18);
        self.editQuoteButton.backgroundColor = UIColor.greenColor();
        self.editQuoteButton.layer.borderWidth = 0.5;
        self.editQuoteButton.layer.cornerRadius = 5.0;
        self.editQuoteButton.layer.borderColor = UIColor.grayColor().CGColor;
        self.editQuoteButton.setTitle("Edit Quote", forState: UIControlState.Normal);
        self.editQuoteButton.showsTouchWhenHighlighted = true;
        self.view.addSubview(editQuoteButton);
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onTapAway(sender: UITapGestureRecognizer)
    {
        quoteText.resignFirstResponder();
        authorText.resignFirstResponder();
    }
    
    func editQuote()
    {
        self.quotes = NSUserDefaults.standardUserDefaults().valueForKey("quotes") as! Array<Dictionary<String, String>>; // Get data from NSUserDefaults.
        self.quotes[self.quoteIndex]["quote"] = self.quoteText.text;
        self.quotes[self.quoteIndex]["author"] = self.authorText.text;
        
        NSUserDefaults.standardUserDefaults().setValue(quotes, forKey: "quotes"); // Override current array in NSUserDefaults.
        NSUserDefaults.standardUserDefaults().synchronize(); // Synchronize it to file (everytime you change it).
        
        self.quoteText.resignFirstResponder();
        self.authorText.resignFirstResponder();
        
        self.navigationController?.popViewControllerAnimated(true);
    }
}