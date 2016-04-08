//
//  QuoteListViewController.swift
//  Quota
//
//  Created by rpsapps on 2/4/16.
//  Copyright © 2016 matthewmuccio. All rights reserved.
//

import UIKit

class AddQuoteViewController: UIViewController, UITextViewDelegate
{
    let quoteText = UITextView();
    let authorText = UITextView();
    let addQuoteButton = UIButton();
    let confirmText = UILabel();
    let h = UIScreen.mainScreen().bounds.height;
    let w = UIScreen.mainScreen().bounds.width;
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        self.title = "Add Quote";
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
        self.quoteText.text = "Enter your quote here.";
        self.quoteText.textColor = UIColor.lightGrayColor();
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
        self.authorText.text = "Enter the author here.";
        self.authorText.textColor = UIColor.lightGrayColor();
        self.authorText.font = UIFont(name: "Noteworthy-Bold", size: 12);
        self.authorText.backgroundColor = UIColor.whiteColor();
        self.authorText.returnKeyType = UIReturnKeyType.Done;
        self.authorText.layer.borderWidth = 0.5;
        self.authorText.layer.cornerRadius = 5.0;
        self.authorText.layer.borderColor = UIColor.grayColor().CGColor;
        self.view.addSubview(authorText);
        
        // Add Quote Button
        self.addQuoteButton.frame = CGRect(x: (w/2) - 75, y: 72.5, width: 150, height: 50);
        self.addQuoteButton.addTarget(self, action: "addQuote", forControlEvents: UIControlEvents.TouchUpInside);
        self.addQuoteButton.titleLabel?.font = UIFont(name: "Noteworthy-Light", size: 18);
        self.addQuoteButton.backgroundColor = UIColor.darkGrayColor();
        self.addQuoteButton.layer.borderWidth = 0.5;
        self.addQuoteButton.layer.cornerRadius = 5.0;
        self.addQuoteButton.layer.borderColor = UIColor.grayColor().CGColor;
        self.addQuoteButton.setTitle("Add Quote", forState: UIControlState.Normal);
        self.addQuoteButton.showsTouchWhenHighlighted = true;
        self.view.addSubview(addQuoteButton);
        
        // Confirm Label
        self.confirmText.removeFromSuperview();
        self.confirmText.frame = CGRect(x: (w/2) - 110, y: 50, width: 220, height: 100);
        self.confirmText.text = "Quote has been added to list.";
        self.confirmText.textColor = UIColor.greenColor();
        self.confirmText.font = UIFont(name: "Noteworthy-Bold", size: 18);
        self.confirmText.textAlignment = NSTextAlignment.Center;
        
        checkForButton();
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
    // Subview functions
    func isTextFilled() -> Bool
    {
        if ((self.quoteText.text.isEmpty || self.quoteText.textColor == UIColor.lightGrayColor()) ||
            (self.authorText.text.isEmpty || self.authorText.textColor == UIColor.lightGrayColor()))
        {
            return false;
        }
        return true;
    }
    
    func onTapAway(sender: UITapGestureRecognizer)
    {
        quoteText.resignFirstResponder();
        authorText.resignFirstResponder();
    }
    
    func textViewDidBeginEditing(textView: UITextView)
    {
        if (self.confirmText.hidden == false)
        {
            self.confirmText.removeFromSuperview();
            self.view.addSubview(addQuoteButton);
            checkForButton();
        }
        
        if (textView == self.quoteText)
        {
            if (self.quoteText.text.isEmpty || self.quoteText.text == "Enter your quote here.")
            {
                self.quoteText.text = "";
                self.quoteText.textColor = UIColor.blackColor();
            }
            else
            {
                self.quoteText.textColor = UIColor.blackColor();
            }
        }
        else if (textView == self.authorText)
        {
            if (self.authorText.text.isEmpty || self.authorText.text == "Enter the author here.")
            {
                self.authorText.text = "";
                self.authorText.textColor = UIColor.blackColor();
            }
            else
            {
                self.authorText.textColor = UIColor.blackColor();
            }
        }
    }
    
    func textViewDidEndEditing(textView: UITextView)
    {
        if (textView == self.quoteText)
        {
            if (self.quoteText.text.isEmpty)
            {
                self.quoteText.text = "Enter your quote here.";
                self.quoteText.textColor = UIColor.lightGrayColor();
                self.addQuoteButton.enabled = false;
                self.addQuoteButton.userInteractionEnabled = false;
            }
        }
        else if (textView == self.authorText)
        {
            if (self.authorText.text.isEmpty)
            {
                self.authorText.text = "Enter the author here.";
                self.authorText.textColor = UIColor.lightGrayColor();
                self.addQuoteButton.enabled = false;
                self.addQuoteButton.userInteractionEnabled = false;
            }
        }
    }
    
    func textViewDidChange(textView: UITextView)
    {
        checkForButton();
    }
    
    func checkForButton()
    {
        if (isTextFilled())
        {
            self.addQuoteButton.backgroundColor = UIColor.greenColor();
            self.addQuoteButton.enabled = true;
            self.addQuoteButton.userInteractionEnabled = true;
        }
        else
        {
            self.addQuoteButton.backgroundColor = UIColor.darkGrayColor();
            self.addQuoteButton.enabled = false;
            self.addQuoteButton.userInteractionEnabled = false;
        }
    }
    
    func addQuote()
    {
        let quote = self.quoteText.text;
        let author = self.authorText.text;
        
        var quotes:Array<Dictionary<String, String>> = NSUserDefaults.standardUserDefaults().valueForKey("quotes") as! Array<Dictionary<String, String>>; // Get data from NSUserDefaults.
        quotes.append(["quote" : quote, "author" : author]); // Append new data.
            
        NSUserDefaults.standardUserDefaults().setValue(quotes, forKey: "quotes"); // Override current array in NSUserDefaults.
        NSUserDefaults.standardUserDefaults().synchronize(); // Synchronize it to file (everytime you change it).
        
        self.quoteText.text = "Enter your quote here.";
        self.quoteText.textColor = UIColor.lightGrayColor();

        self.authorText.text = "Enter the author here.";
        self.authorText.textColor = UIColor.lightGrayColor();
        
        self.quoteText.resignFirstResponder();
        self.authorText.resignFirstResponder();
        self.addQuoteButton.removeFromSuperview();
        
        self.view.addSubview(confirmText);
    }
}