//
//  CountDownView.swift
//  CountdownDemo
//
//  Created by user on 15/6/29.
//  Copyright (c) 2015年 zhy. All rights reserved.
//

import UIKit

protocol CountDownViewDelegate {
    func countDownButtonAciton()
}

@IBDesignable
class CountDownView: UIView {
    
    var countDownBtn: UIButton!
    var showLabel: UILabel!
    var countDownTimer: NSTimer!
    var staticTime: Int!
    var time = 30
    var countDownDelegate: CountDownViewDelegate?
    
    func initFrame(frame: CGRect, time: Int) {
        initUI(frame)
        staticTime = time
        self.time = time
    }
    
    func initUI(frame: CGRect) {
        //
        showLabel = UILabel(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        showLabel.text = "重新获取"
        showLabel.textColor = UIColor.lightGrayColor()
        showLabel.font = UIFont.systemFontOfSize(14.0)
        showLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(showLabel)
        //
        countDownBtn = UIButton(type: UIButtonType.Custom)
        countDownBtn.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        countDownBtn.backgroundColor = UIColor.clearColor()
        countDownBtn.addTarget(self, action: #selector(CountDownView.countDownButtonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addSubview(countDownBtn) 
    }
    
    func countDownButtonAction(sender: UIButton) {
        initTimer()
        if countDownDelegate != nil {
            countDownDelegate?.countDownButtonAciton()
        }
    }
    
    func viewIn() {
        calculatorTheTime()
    }
    
    func viewOut() {
        stopCountDown()
        getTheOutTime()
        getTheCountDownTime()
    }
    
    //初始化计时器
    func initTimer() {
        if countDownTimer == nil {
            countDownTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(CountDownView.timeCountDown), userInfo: nil, repeats: true)
            countDownBtn.enabled = false
        }
    }
    
    //倒计时
    func timeCountDown() {
        time -= 1
        showLabel.text = "\(time)s"
        print("\(time)")
        if time == 0 {
            countDownBtn.enabled = true
            time = staticTime
            stopCountDown()
            showLabel.text = "重新获取"
        }
    }
    
    //停止计时器
    func stopCountDown() {
        if countDownTimer != nil {
            countDownTimer.invalidate()
            countDownTimer = nil
        }
    }
    
    //记录推出界面时间
    func getTheOutTime() {
        let date = NSDate().timeIntervalSince1970
        NSUserDefaults.standardUserDefaults().setObject(Int(date), forKey: "kOutTime")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //记录进入界面时间
    func getTheInTime() -> Int {
        let date = NSDate().timeIntervalSince1970
        return Int(date)
    }
    
    //记录倒计时剩余时间
    func getTheCountDownTime() {
        NSUserDefaults.standardUserDefaults().setObject(time, forKey: "kCountDownTime")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //计算剩余时间
    func calculatorTheTime() {
        if let outTime = NSUserDefaults.standardUserDefaults().objectForKey("kOutTime") {
            let oTime = outTime as! Int
            let inTime = getTheInTime()
            let countTime = NSUserDefaults.standardUserDefaults().objectForKey("kCountDownTime")as! Int
            if inTime - oTime > countTime {
                countDownBtn.enabled = true
                showLabel.text = "重新获取"
            } else {
                countDownBtn.enabled = false
                time = countTime - (inTime - oTime)
                showLabel.text = "\(time)s"
                initTimer()
            }
        }
    }
}
