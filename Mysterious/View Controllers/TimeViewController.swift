//
//  TimeViewController.swift
//  Mysterious
//
//  Created by Jason Wei on 7/8/19.
//  Copyright © 2019 Kaifan Wei. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {

    var timer = Timer()
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var totalDaysLabel: UILabel!
    @IBOutlet var calculatingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.isHidden = true
        yearLabel.isHidden = true
        monthLabel.isHidden = true
        dayLabel.isHidden = true
        totalDaysLabel.isHidden = true
        
        loadTime()
        
        //scheduledTimerWithTimeInterval()
    }
    
    func loadTime() {
        
        let startDate = "2017-09-24"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formatedStartDate = dateFormatter.date(from: startDate)
        
        
        let currentDate = Date()
        let components = Set<Calendar.Component>([.day, .month, .year])
        let differenceOfDate = Calendar.current.dateComponents(components, from: formatedStartDate!, to: currentDate)
        
        calculatingLabel.isHidden = true
        
        titleLabel.text = "距离一个特殊的时间已经过去了"
        yearLabel.text = "\(differenceOfDate.year!) 年"
        monthLabel.text = "\(differenceOfDate.month!) 个月"
        dayLabel.text = "\(differenceOfDate.day!) 天"
        
        titleLabel.isHidden = false
        yearLabel.isHidden = false
        monthLabel.isHidden = false
        dayLabel.isHidden = false
        
        
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentDay = calendar.component(.day, from: currentDate)
        
        var targetYear = currentYear
        
        if (currentMonth == 9 && currentDay > 24) || currentMonth > 9{
            targetYear = targetYear + 1
        }
        
        let nextDate = "\(targetYear)-09-24"
        let formatedNextDate = dateFormatter.date(from: nextDate)
        
        let dateUntil = Calendar.current.dateComponents(components, from: currentDate, to: formatedNextDate!)
        
        

    }
    
    func scheduledTimerWithTimeInterval(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounting() {
        
    }
    


}
