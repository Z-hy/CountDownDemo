//
//  SecondViewController.swift
//  CountdownDemo
//
//  Created by user on 15/6/26.
//  Copyright (c) 2015年 zhy. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var countDownBtn: CountDownView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if countDownBtn != nil {
            countDownBtn.viewIn()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if countDownBtn != nil {
            countDownBtn.viewOut()
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        countDownBtn.initFrame(countDownBtn.frame, time: 60)
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
