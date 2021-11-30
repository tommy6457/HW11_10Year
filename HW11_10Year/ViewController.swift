//
//  ViewController.swift
//  HW11_10Year
//
//  Created by 蔡尚諺 on 2021/11/27.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var slider: UISlider!
    
    var timer: Timer? //for 自動播放
    var year = 1999 //控制年份
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        
    }
    
    @IBAction func pickerChangedDate(_ picker: UIDatePicker) {
        syncYear(date: picker.date)
    }
    
    @IBAction func sliderChanged(_ slider: UISlider) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        slider.setValue(slider.value.rounded(), animated: true)
        let year = slider.value.rounded()
        let date = formatter.date(from: "\(Int(year))")
        
        syncYear(date: date!)
    }
    
    @IBAction func switchChanged(_ uiSwitch: UISwitch) {
        if uiSwitch.isOn {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setYear), userInfo: nil, repeats: true)
        }else{
            
            timer?.invalidate()
            timer = nil
            year = 1999
        }
    }
    
    @objc func setYear(){
        
        self.year += 1
        
        if year > 2012 {
            year = 2000
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        syncYear(date: formatter.date(from: "\(year)")!)
    }
    
    func syncYear(date: Date){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        let year = formatter.string(from: date)
    
        //更新圖片
        ivImage.image = UIImage(named: "\(year)")
        //更新DatePicker
        datePicker.setDate(date, animated: true)
        //更新slider
        slider.value = Float(year)!
    }
    
    func initUI() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        
        ivImage.image = UIImage(named: "2000")
        datePicker.setDate(formatter.date(from: "2000")! , animated: true)
        slider.setValue(2000, animated: true)
        
    }
    
}

