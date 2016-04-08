//
//  AddQuoteViewController.swift
//  Quota
//
//  Created by rpsapps on 2/8/16.
//  Copyright © 2016 matthewmuccio. All rights reserved.
//

import UIKit

class QuoteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let quotesTableView = UITableView();
    var cells = Array<UITableViewCell>();
    var refreshQuote = UIRefreshControl();
    var quotes:Array<Dictionary<String, String>> = NSUserDefaults.standardUserDefaults().valueForKey("quotes") as! Array<Dictionary<String, String>>;
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        self.title = "Quotes";
        
        // Refresh Quote Control
        self.refreshQuote.attributedTitle = NSAttributedString(string: "Pull to Refresh Quotes.");
        self.refreshQuote.backgroundColor = UIColor.lightGrayColor();
        self.refreshQuote.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged);
        self.quotesTableView.addSubview(refreshQuote);
        
        // Quotes TableView
        self.quotesTableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height);
        self.quotesTableView.dataSource = self;
        self.quotesTableView.delegate = self;
        self.quotesTableView.backgroundColor = UIColor.lightGrayColor();
        self.view.addSubview(self.quotesTableView);
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        self.quotes = NSUserDefaults.standardUserDefaults().valueForKey("quotes") as! Array<Dictionary<String, String>>;
        fillInTableView();
        self.quotesTableView.reloadData();
    }
    
    func fillInTableView() // Filling Quotes TableView with Quotes from Array (NSUserDefaults).
    {
        
        self.cells = Array<UITableViewCell>();
        
        for (var i = 0; i < self.quotes.count; i++)
        {
            let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil);
            cell.textLabel?.font = UIFont(name: "Noteworthy-Bold", size: 16);
            cell.detailTextLabel?.font = UIFont(name: "Noteworthy-Bold", size: 14);
            cell.textLabel?.text = self.quotes[i]["quote"];
            cell.detailTextLabel?.text = self.quotes[i]["author"];
            self.cells.append(cell);
        }
    }
    
    func refresh(sender: AnyObject)
    {
        NSUserDefaults.standardUserDefaults().setValue(self.quotes, forKey: "quotes");
        NSUserDefaults.standardUserDefaults().synchronize();
        self.quotesTableView.reloadData();
        self.refreshQuote.endRefreshing();
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.Delete)
        {
            self.cells[indexPath.row].alpha = 0.0;
            self.cells.removeAtIndex(indexPath.row);
            self.quotes.removeAtIndex(indexPath.row);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic);
            
            NSUserDefaults.standardUserDefaults().setValue(self.quotes, forKey: "quotes");
            NSUserDefaults.standardUserDefaults().synchronize();
            self.quotesTableView.reloadData();
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let vc = EditQuoteViewController();
        vc.quoteIndex = indexPath.row;
        
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 60;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cells.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        return self.cells[indexPath.row];
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }
    
}