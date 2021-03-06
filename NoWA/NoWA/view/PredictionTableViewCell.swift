//
//  PredictionTableViewCell.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 24/12/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class PredictionTableViewCell: GenericTableViewCell {
    
    var prediction : NSNumber?
    
    var titleView : UIView?
    var sliderView : UIView?
    var explainLabel : UILabel?
    var titleLabel : UILabel?
    var leftIcon : UIImageView?
    var sliderLeft : UISlider?
    var sliderLabel : UILabel?
        
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .serviceLocationColor()
        self.contentView.backgroundColor = .serviceLocationColor()
        
        leftIcon = UIImageView()
        leftIcon!.contentMode = UIViewContentMode.Center
        self.addSubview(leftIcon!)
        
        titleLabel = UILabel()
        titleLabel!.textColor = .whiteColor()
        titleLabel!.font = UIFont.appLatoFontOfSize(14)
        titleLabel!.adjustsFontSizeToFitWidth = true
        titleLabel!.textAlignment = .Left
        titleLabel!.numberOfLines = 1
        self.addSubview(titleLabel!)
        
        explainLabel = UILabel()
        explainLabel!.text = NSLocalizedString("La cancelación quedará sin efecto si se predice una mejoría dentro de:", comment: "")
        explainLabel!.textColor = .whiteColor()
        explainLabel!.font = UIFont.appLatoFontOfSize(14)
        explainLabel!.adjustsFontSizeToFitWidth = true
        explainLabel!.textAlignment = .Left
        explainLabel!.numberOfLines = 2
        self.addSubview(explainLabel!)
        
        sliderLabel = UILabel()
        sliderLabel!.textColor = .whiteColor()
        sliderLabel!.font = UIFont.appLatoFontOfSize(12)
        sliderLabel!.adjustsFontSizeToFitWidth = true
        sliderLabel!.textAlignment = .Center
        sliderLabel!.numberOfLines = 1
        self.addSubview(sliderLabel!)
        
        sliderLeft = UISlider()
        if self.prediction != nil{
            sliderLeft!.value = self.prediction as! Float
        }
        sliderLeft!.minimumValue = 0
        sliderLeft!.maximumValue = 3
        sliderLeft!.tintColor = UIColor.loginBlueColor()
        sliderLeft!.continuous = true
        sliderLeft!.addTarget(self, action: #selector(PredictionTableViewCell.sliderValueChanged(_:)), forControlEvents: .ValueChanged)
        self.addSubview(sliderLeft!)
        
        self.prediction = sliderLeft!.minimumValue
        sliderLabel!.text = "\(Int(sliderLeft!.minimumValue))hs"
        
        titleView = UIView()
        titleView!.addSubview(leftIcon!)
        titleView!.addSubview(titleLabel!)
        self.addSubview(titleView!)
        
        
        sliderView = UIView()
        sliderView!.addSubview(sliderLeft!)
        self.addSubview(sliderView!)
        
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setItems(myDictionary: NSDictionary) {
        
        if let left_icon = myDictionary["left_icon"] as? String{
            leftIcon!.image = UIImage(named: left_icon)
            
        }
        let lang =  NSLocale.preferredLanguages().first! as NSString
        let language = lang.substringWithRange(NSRange(location: 0, length: 2))
        
        if language == "en" {
            if let title = myDictionary["title_en"] as? String{
                titleLabel!.text = title
            }
        }else if language == "es" {
            
            if let title = myDictionary["title"] as? String{
                titleLabel!.text = title
            }
        }
    }
    
    override func resetValues(){
        self.prediction = 0
        self.sliderLeft!.value = Float(0)
        self.sliderLabel!.text = "\(String(0))hs"
    }
    
    func setupConstrains(){
        
        titleView!.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        titleView!.autoPinEdge(.Left, toEdge: .Left, ofView: self)
        titleView!.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        titleView!.autoMatchDimension(.Height, toDimension: .Height, ofView: self, withMultiplier: 0.33)
        
        leftIcon!.autoPinEdge(.Left, toEdge: .Left, ofView: titleView!)
        leftIcon!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: titleView!)
        leftIcon!.autoPinEdge(.Top, toEdge: .Top, ofView: titleView!)
        leftIcon!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.20)
        
        titleLabel!.autoPinEdge(.Left, toEdge: .Right, ofView: leftIcon!)
        titleLabel!.autoPinEdge(.Top, toEdge: .Top, ofView: titleView!)
        titleLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: titleView!)
        titleLabel!.autoPinEdge(.Right, toEdge: .Right, ofView: titleView!)
        
        explainLabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleView!)
        explainLabel!.autoPinEdge(.Left, toEdge: .Right, ofView: leftIcon!)
        explainLabel!.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -20)
        explainLabel!.autoMatchDimension(.Height, toDimension: .Height, ofView: self, withMultiplier: 0.33)
        
        sliderView!.autoPinEdge(.Left, toEdge: .Right, ofView: leftIcon!)
        sliderView!.autoPinEdge(.Top, toEdge: .Bottom, ofView: explainLabel!)
        sliderView!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        sliderView!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.60)
        
        sliderLeft!.autoPinEdge(.Left, toEdge: .Left, ofView: sliderView!)
        sliderLeft!.autoPinEdge(.Right, toEdge: .Right, ofView: sliderView!)
        sliderLeft!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: sliderView!)
        sliderLeft!.autoPinEdge(.Top, toEdge: .Top, ofView: sliderView!)
        
        sliderLabel!.autoPinEdge(.Left, toEdge: .Right, ofView: sliderView!)
        sliderLabel!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.20)
        sliderLabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: leftIcon!)
        sliderLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        
    }
    
    func rightButtonPressed(){
        print("pepe")
    }
    
    func sliderValueChanged(sender: UISlider) {
        
        let value = Int(sender.value)
        
        self.prediction = value as NSNumber
        
        sliderLabel!.text = "\(String(value))hs"
        
        sender.setValue(Float(value), animated: false)
        
    }
    
    override func setDefaults(defaultDTO: AlarmDTO,isCreate: Bool){
        if self.defaultSeted == false || isCreate == true{
            
            if let prediction = defaultDTO.prediction{
                self.prediction = prediction
                self.sliderLeft!.value = Float(prediction)
                self.sliderLabel!.text = "\(String(prediction))hs"
                self.defaultSeted = true
            }
        }
    }
    
    override func setEditAlarm(editAlarmDTO: PersonalAlarmDTO, isEdit: Bool, status: NSNumber?) {
        
        if self.firstTimeEdit == false {
            
            let event = editAlarmDTO.event![0] as? EventDTO
            let weather = editAlarmDTO.weather![0] as? AlarmDTO
            
            self.sliderLeft!.value = Float((weather!.prediction)!)
            self.sliderLabel!.text = "\(String(weather!.prediction))hs"
            
            self.firstTimeEdit = true
        }
    }
    
}
