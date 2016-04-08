//
//  ViewController.swift
//  profitsimulator
//
//  Created by rpsapps on 2/4/16.
//  Copyright © 2016 rpsapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //heres a comment
    
    var numTransactionLabel=UILabel()
    var numTransactionSlider=UISlider()
    var numTransactionsIndicator=UILabel()
    var currentPriceLabel=UILabel()
    var inputnewPriceSlider=UISlider()
    var inputnewPriceButton=UIButton()
    var viewCurrentPricesButton=UIButton()
    var maximumProfitLabel=UILabel()
    var maximizeProfitButton=UIButton()
     var allCurrentPrices:[Int]=[]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="Profit Simulator"
        self.view.backgroundColor = UIColor.whiteColor()
       
    
        /*self.numTransactionsIndicator.frame=CGRect(x: -200, y: 100, width: UIScreen.mainScreen().bounds.width, height: 30)
        self.numTransactionsIndicator.text="Number of Transactions: "
        self.numTransactionsIndicator.textAlignment=NSTextAlignment.Center
        self.numTransactionsIndicator.textColor=UIColor.cyanColor()
        self.view.addSubview(numTransactionsIndicator)*/
        
        
        
        self.numTransactionLabel.frame = CGRect(x: -150, y: 150, width: UIScreen.mainScreen().bounds.width, height: 30)
        self.numTransactionLabel.text = "Current Number of Transactions: 0"
        self.numTransactionLabel.textAlignment = NSTextAlignment.Center
        self.numTransactionLabel.textColor = UIColor.blueColor()
        self.view.addSubview(numTransactionLabel)
        
        self.numTransactionSlider.frame=CGRect(x: 100, y: 210, width: 300, height: 100)
        self.numTransactionSlider.addTarget(self, action: "ChangeTransactionNum:", forControlEvents: UIControlEvents.ValueChanged);
        self.numTransactionSlider.setValue(1, animated: true)
        self.numTransactionSlider.minimumValue=0
        self.numTransactionSlider.maximumValue=100
        self.numTransactionSlider.backgroundColor=UIColor.cyanColor()
        self.view.addSubview(numTransactionSlider)
        
        
        self.currentPriceLabel.frame=CGRect(x: 450, y: 600, width: 200, height: 30)
        self.currentPriceLabel.text="Current Price: 1"
        self.currentPriceLabel.textAlignment=NSTextAlignment.Center
        self.currentPriceLabel.textColor=UIColor.redColor()
        self.view.addSubview(currentPriceLabel)
        
        
        self.maximumProfitLabel.frame=CGRect(x: 10, y: 700, width: 350, height: 20)
        self.maximumProfitLabel.text="Maximum Profit Possible: TBD"
        self.maximumProfitLabel.textAlignment=NSTextAlignment.Center
        self.maximumProfitLabel.textColor=UIColor.brownColor()
        self.view.addSubview(maximumProfitLabel)
        
        
        self.maximizeProfitButton.frame=CGRect(x: 50, y: 800, width: 150, height: 30)
        self.maximizeProfitButton.backgroundColor=UIColor.cyanColor()
        self.maximizeProfitButton.addTarget(self, action: "maximizeProfit:", forControlEvents: UIControlEvents.TouchUpInside)
        self.maximizeProfitButton.setTitle("Maximize Profit", forState: UIControlState.Normal)
        self.view.addSubview(maximizeProfitButton)
        
        
        self.inputnewPriceSlider.frame=CGRect(x: 400, y: 700, width: 300, height: 30)
        self.inputnewPriceSlider.setValue(1, animated:true)
        self.inputnewPriceSlider.addTarget(self, action: "ChangeCurrentPrice:", forControlEvents: UIControlEvents.ValueChanged)
        self.inputnewPriceSlider.minimumValue=0
        self.inputnewPriceSlider.maximumValue=60000
        
        self.inputnewPriceSlider.backgroundColor=UIColor.yellowColor()
        //self.inputnewPriceTextBox.becomeFirstResponder()
        self.inputnewPriceSlider.backgroundColor=UIColor.blueColor()
        self.view.addSubview(inputnewPriceSlider)
        
        self.inputnewPriceButton.frame=CGRect(x: 450, y: 800, width: 200, height: 30)
        self.inputnewPriceButton.addTarget(self, action: "InputPrice:", forControlEvents: UIControlEvents.TouchUpInside)
        self.inputnewPriceButton.setTitle("Input New Price", forState: UIControlState.Normal)
        self.inputnewPriceButton.backgroundColor=UIColor.greenColor()
        self.view.addSubview(inputnewPriceButton)
        
        self.viewCurrentPricesButton.frame=CGRect(x: 450, y: 200, width: 170, height: 30)
        self.viewCurrentPricesButton.addTarget(self, action:"buttonTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        self.viewCurrentPricesButton.setTitle("View Current Prices", forState: UIControlState.Normal)
        self.viewCurrentPricesButton.backgroundColor=UIColor.purpleColor()
        self.view.addSubview(viewCurrentPricesButton)
        
        
    }
    
    
    /*func minElem()->Int{
        var min=Int.max
        for value in allCurrentPrices{
            if(value<min){
                min=value
            }
        }
        return min
    }*/
    
    /*func maxElem()->Int{
        var max=Int.min
        for value in allCurrentPrices{
            if(value>max){
                max=value
            }
        
        }
        return max
    }*/
    
    
    func ChangeTransactionNum(sender: UISlider) {
        let sliderval = lroundf(sender.value)
        numTransactionLabel.text="Current Number of Transactions: "+"\(sliderval)"
        
    }
    
    func ChangeCurrentPrice(sender: UISlider){
        let sliderval=lroundf(sender.value)
        currentPriceLabel.text="Current Price: "+"\(sliderval)"
    }
    
    func InputPrice(sender: UIButton){
      //  self.navigationController

        allCurrentPrices.append(Int(inputnewPriceSlider.value))
        inputnewPriceSlider.setValue(1, animated: true)
        currentPriceLabel.text="1"

        
        
    }
    
    func maximizeProfit(sender: UIButton){
        /*if(Int(numTransactionSlider.value)==1){
            var min=allCurrentPrices.minElement()
            var max=allCurrentPrices.maxElement()
            var profit=allCurrentPrices.maxElement()!-allCurrentPrices.minElement()!
            maximumProfitLabel.text="\(profit)"
        }*/
        
        /*if(allCurrentPrices[0]==0){
            numTransactionLabel.text="ERRRRR"
        }*/
        
        let k=Int(numTransactionSlider.value)
        
        if(k>=allCurrentPrices.count){
            let profit=exceededBounds(k)
            maximumProfitLabel.text="Maximum Profit Possible: "+"\(profit)"
        }else{
        
        /*if(k==0){
            numTransactionLabel.text="ERRRRR"
        }*/
        var globals=[Int](count: k+1, repeatedValue: 0)
        /*for index in 0...k{
            globals[index]=0
        }*/
        var locals=[Int](count: k+1, repeatedValue: 0)
        /*for indice in 0...k{
            locals[indice]=0
        }*/
        
        for(var index=0;index<allCurrentPrices.count-1;index++){
            var curr_difference=allCurrentPrices[index+1]-allCurrentPrices[index]
            
            for(var j=k; j>=1; --j){
                locals[j]=max(globals[j-1]+max(curr_difference,0),locals[j]+curr_difference)
                globals[j]=max(globals[j],locals[j])
                //numTransactionLabel.text=numTransactionLabel.text!+"\(globals[j])"
            }
        }
        
        
        let profit=globals[k]
        /*if(profit==0){
            numTransactionLabel.text="ERRRR"
            
        }*/
          maximumProfitLabel.text="Maximum Profit Possible: "+"\(profit)"
       }
        
      
        
    }
    
    func exceededBounds(numTransactions:Int)->Int{
        var final=0
        for(var iterations=0;iterations<allCurrentPrices.count-1;iterations++){
            if(max((allCurrentPrices[iterations+1]-allCurrentPrices[iterations]), 0)==0){
            }else{
                final+=allCurrentPrices[iterations+1]-allCurrentPrices[iterations]
            }
        }
        return final
    }
    
    
    func buttonTapped(sender: UIButton){
        let vc = NextViewController()
        vc.data = allCurrentPrices
        self.navigationController?.pushViewController(vc, animated: true)
//        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}



