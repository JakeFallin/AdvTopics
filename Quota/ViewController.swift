//
//  ViewController.swift
//  Quota
//
//  Created by rpsapps on 2/4/16.
//  Copyright © 2016 matthewmuccio. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    let addButton = UIButton(type: UIButtonType.ContactAdd);
    let listButton = UIButton(type: UIButtonType.DetailDisclosure);
    let reloadButton = UIButton();
    
    let quoteImageView = UIImageView(image: UIImage(named: "quoteImage.png"));
    let defaultLabel = UILabel();
    let indexLabel = UILabel();
    let quoteLabel = UILabel();
    let authorLabel = UILabel();
    
    let h = UIScreen.mainScreen().bounds.height;
    let w = UIScreen.mainScreen().bounds.width;
    
    let DEFAULT_QUOTE = "If today were the last day of your life, would you want to do what you are about to do today?";
    let DEFAULT_AUTHOR = "Steve Jobs";
    
    var quotes:Array<Dictionary<String, String>> = NSUserDefaults.standardUserDefaults().valueForKey("quotes") as! Array<Dictionary<String, String>>; // Get data from NSUserDefaults.
    var currentIndex = -1;
    
    override func viewWillAppear(animated: Bool)
    {
        self.quotes = NSUserDefaults.standardUserDefaults().valueForKey("quotes") as! Array<Dictionary<String, String>>; // Get data from NSUserDefaults.
        
        if (self.quotes.isEmpty)
        {
            self.quoteLabel.text = DEFAULT_QUOTE;
            self.authorLabel.text = DEFAULT_AUTHOR;
            self.indexLabel.removeFromSuperview();
            self.view.addSubview(defaultLabel);
        }
        else
        {
            reloadQuote();
            self.view.addSubview(indexLabel);
            self.defaultLabel.removeFromSuperview();
        }
        checkForReloadButton();
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        self.title = "Home";
        self.view.backgroundColor = UIColor(red: 102/255, green: 255/255, blue: 255/255, alpha: 1.0);
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: "onLeftSwipe");
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left;
        self.view.addGestureRecognizer(leftSwipe);
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: "onRightSwipe");
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right;
        self.view.addGestureRecognizer(rightSwipe);
        
        // Add Quote Button
        self.addButton.frame = CGRect(x: w - 50, y: 65, width: 50, height: 50);
        self.addButton.addTarget(self, action: "showAddQuote", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(addButton);
        
        // List Button
        self.listButton.frame = CGRect(x: 0, y: 65, width: 50, height: 50);
        self.listButton.addTarget(self, action: "showQuoteList", forControlEvents: UIControlEvents.TouchUpInside);
        self.view.addSubview(listButton);
        
        // Reload Button
        self.reloadButton.frame = CGRect(x: w/2 - 60, y: 70, width: 120, height: 40);
        self.reloadButton.addTarget(self, action: "reloadQuote", forControlEvents: UIControlEvents.TouchUpInside);
        self.reloadButton.backgroundColor = UIColor.redColor();
        self.reloadButton.titleLabel?.font = UIFont(name: "Noteworthy-Light", size: 18);
        self.reloadButton.titleLabel?.textColor = UIColor.whiteColor();
        self.reloadButton.layer.borderWidth = 0.5;
        self.reloadButton.layer.cornerRadius = 5.0;
        self.reloadButton.layer.borderColor = UIColor.grayColor().CGColor;
        self.reloadButton.setTitle("Random", forState: UIControlState.Normal);
        self.reloadButton.showsTouchWhenHighlighted = true;
        self.view.addSubview(reloadButton);
        
        // Quote Image
        self.quoteImageView.frame = CGRect(x: 25, y: h/2 - 100, width: 40, height: 30);
        self.view.addSubview(quoteImageView);
        
        // Default Label
        self.defaultLabel.frame = CGRect(x: w/2 - 75, y: 70, width: 150, height: 120);
        self.defaultLabel.font = UIFont(name: "Noteworthy-Bold", size: 16);
        self.defaultLabel.text = "Enter your own quote!";
        self.defaultLabel.numberOfLines = 0;
        self.defaultLabel.textAlignment = NSTextAlignment.Center;
        self.defaultLabel.textColor = UIColor.redColor();
        
        // Index Label
        self.indexLabel.frame = CGRect(x: w/2 - 50, y: 110, width: 100, height: 40);
        self.indexLabel.font = UIFont(name: "Noteworthy-Bold", size: 18);
        self.indexLabel.text = "Quote #" + String(self.currentIndex);
        self.indexLabel.numberOfLines = 0;
        self.indexLabel.textAlignment = NSTextAlignment.Center;
        self.indexLabel.textColor = UIColor.darkGrayColor();
        self.view.addSubview(indexLabel);
        
        // Quote Label
        self.quoteLabel.frame = CGRect(x: (w/2) - 100, y: h/2 - 100, width: 200, height: 150);
        self.quoteLabel.font = UIFont(name: "Noteworthy-Bold", size: 16);
        self.quoteLabel.numberOfLines = 0;
        self.quoteLabel.textAlignment = NSTextAlignment.Center;
        self.quoteLabel.textColor = UIColor.darkGrayColor();
        self.view.addSubview(quoteLabel);
        
        // Author Label
        self.authorLabel.frame = CGRect(x: w/2 - 80, y: h/2 + 35, width: 160, height: 100);
        self.authorLabel.font = UIFont(name: "Noteworthy-Bold", size: 16);
        self.authorLabel.numberOfLines = 0;
        self.authorLabel.textAlignment = NSTextAlignment.Center;
        self.authorLabel.textColor = UIColor.darkGrayColor();
        self.view.addSubview(authorLabel);
        
        checkForReloadButton();
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func showAddQuote()
    {
        self.navigationController?.pushViewController(AddQuoteViewController(), animated: true);
    }
    
    func showQuoteList()
    {
        self.navigationController?.pushViewController(QuoteListViewController(), animated: true);
    }
    
    func onLeftSwipe() // Swipe left to display previous quote.
    {
        if (!self.quotes.isEmpty)
        {
            if (self.quotes.count != 1)
            {
                self.currentIndex -= 1;
                if (self.currentIndex == -1)
                {
                    self.currentIndex = self.quotes.count - 1;
                }
                self.quoteLabel.text = self.quotes[self.currentIndex]["quote"];
                self.authorLabel.text = self.quotes[self.currentIndex]["author"];
                self.indexLabel.text = "Quote #" + String(self.currentIndex + 1);
            }
        }
    }
    
    func onRightSwipe() // Swipe right to display next quote.
    {
        if (!self.quotes.isEmpty)
        {
            if (self.quotes.count != 1)
            {
                self.currentIndex++;
                if (self.currentIndex == self.quotes.count)
                {
                    self.currentIndex = 0;
                }
                self.quoteLabel.text = self.quotes[self.currentIndex]["quote"];
                self.authorLabel.text = self.quotes[self.currentIndex]["author"];
                self.indexLabel.text = "Quote #" + String(self.currentIndex + 1);
            }
        }
    }
    
    func reloadQuote()
    {
        var ind = Int(arc4random_uniform(UInt32(self.quotes.count)));
        
        if (self.quotes.count > 1 && ind == self.currentIndex && ind > 0)
        {
            ind--;
        } else if (self.quotes.count > 1 && ind == self.currentIndex) {
            ind++;
        }
        
        self.currentIndex = ind;
        
        self.quoteLabel.text = self.quotes[ind]["quote"];
        self.authorLabel.text = self.quotes[ind]["author"];
        self.indexLabel.text = "Quote #" + String(self.currentIndex + 1);
    }
    
    func checkForReloadButton()
    {
        if (self.quotes.isEmpty)
        {
            self.reloadButton.backgroundColor = UIColor.darkGrayColor();
            self.reloadButton.enabled = false;
            self.reloadButton.userInteractionEnabled = false;
        }
        else if (self.quotes.count == 1)
        {
            self.reloadButton.backgroundColor = UIColor.darkGrayColor();
            self.reloadButton.enabled = false;
            self.reloadButton.userInteractionEnabled = false;
        }
        else
        {
            self.reloadButton.backgroundColor = UIColor.redColor();
            self.reloadButton.enabled = true;
            self.reloadButton.userInteractionEnabled = true;
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
}