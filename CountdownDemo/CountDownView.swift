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
    var countDownTimer: Timer!
    var staticTime: Int!
    var time = 30
    var countDownDelegate: CountDownViewDelegate?
    
    func initFrame(_ frame: CGRect, time: Int) {
        initUI(frame)
        staticTime = time
        self.time = time
    }
    
    func initUI(_ frame: CGRect) {
        //
        showLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        showLabel.text = "重新获取"
        showLabel.textColor = UIColor.lightGray
        showLabel.font = UIFont.systemFont(ofSize: 14.0)
        showLabel.textAlignment = NSTextAlignment.center
        self.addSubview(showLabel)
        //
        countDownBtn = UIButton(type: UIButtonType.custom)
        countDownBtn.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        countDownBtn.backgroundColor = UIColor.clear
        countDownBtn.addTarget(self, action: #selector(CountDownView.countDownButtonAction(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(countDownBtn) 
    }
    
    func countDownButtonAction(_ sender: UIButton) {
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
            countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(CountDownView.timeCountDown), userInfo: nil, repeats: true)
            countDownBtn.isEnabled = false
        }
    }
    
    //倒计时
    func timeCountDown() {
        time -= 1
        showLabel.text = "\(time)s"
        print("\(time)")
        if time == 0 {
            countDownBtn.isEnabled = true
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
        let date = Date().timeIntervalSince1970
        UserDefaults.standard.set(Int(date), forKey: "kOutTime")
        UserDefaults.standard.synchronize()
    }
    
    //记录进入界面时间
    func getTheInTime() -> Int {
        let date = Date().timeIntervalSince1970
        return Int(date)
    }
    
    //记录倒计时剩余时间
    func getTheCountDownTime() {
        UserDefaults.standard.set(time, forKey: "kCountDownTime")
        UserDefaults.standard.synchronize()
    }
    
    //计算剩余时间
    func calculatorTheTime() {
        if let outTime = UserDefaults.standard.object(forKey: "kOutTime") {
            let oTime = outTime as! Int
            let inTime = getTheInTime()
            let countTime = UserDefaults.standard.object(forKey: "kCountDownTime")as! Int
            if inTime - oTime > countTime {
                countDownBtn.isEnabled = true
                showLabel.text = "重新获取"
            } else {
                countDownBtn.isEnabled = false
                time = countTime - (inTime - oTime)
                showLabel.text = "\(time)s"
                initTimer()
            }
        }
    }
}
