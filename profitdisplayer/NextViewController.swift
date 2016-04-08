//
//  NextViewController.swift
//  profitdisplayer
//
//  Created by rpsapps on 2/12/16.
//  Copyright © 2016 rpsapps. All rights reserved.
//
import UIKit

class NextViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   // let label=UILabel()
   // var button=UIButton()
    var PriceTable=UITableView()
    var data:Array<Int>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Starter"
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        
        
        self.PriceTable.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height);
        self.PriceTable.dataSource = self; // Letting TV speak to VU.
        self.PriceTable.delegate = self;
        self.PriceTable.reloadData(); // When you want the TV to call the marked methods (refresh data). When you need to change size or reload data.
        self.view.addSubview(self.PriceTable);
        

       /* self.label.frame = CGRect(x: 0, y: 200, width: UIScreen.mainScreen().bounds.width, height: 30)
        self.label.text = "Hello, CSSSS"
        self.label.textAlignment = NSTextAlignment.Center
        self.label.textColor = UIColor.blueColor()
        self.view.addSubview(label)
        
        self.button.frame = CGRect(x: self.view.bounds.size.width/2-150, y: 350, width: 300, height: 100)
        self.button.addTarget(self, action: "buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.button.setTitle("49339", forState: UIControlState.Normal)
        self.button.backgroundColor=UIColor.blueColor()
        self.view.addSubview(button)*/
        
        
    }
    
    // mark UITableViewDElegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 64;
    }
    
    // mark UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil);
        cell.textLabel?.text = "\(indexPath.row+1)";
        cell.detailTextLabel?.text = "$"+String(data[indexPath.row]);
        return cell;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1;
    }

    /*func buttonTapped(){
        self.view.backgroundColor=UIColor.brownColor()
        self.button.setTitle(String(Int((self.button.titleLabel?.text)!)!-1), forState: UIControlState.Normal)
        
    }*/
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
}
