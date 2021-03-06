//
//  SliderTableViewCell.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 24/12/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class SliderTableViewCell: GenericTableViewCell {
    
    var minValue : NSNumber?
    var maxValue : NSNumber?
    
    var titleView : UIView?
    var sliderView : UIView?
    
    var titleLabel : UILabel?
    var leftIcon : UIImageView?
    var rightIcon : UIImageView?
    var sliderLeft : UISlider?
    var sliderMinLabel : UILabel?
    var sliderRight : UISlider?
    var sliderMaxLabel : UILabel?
    
    var rightIconString : String?
    var leftIconString : String?
    
    var unity : String!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .serviceLocationColor()
        self.contentView.backgroundColor = .serviceLocationColor()
        
        leftIcon = UIImageView()
        leftIcon!.contentMode = UIViewContentMode.Center
        self.addSubview(leftIcon!)
        
        rightIcon = UIImageView()
        rightIcon!.contentMode = UIViewContentMode.Center
        self.addSubview(rightIcon!)
        
        titleLabel = UILabel()
        titleLabel!.textColor = .whiteColor()
        titleLabel!.font = UIFont.appLatoFontOfSize(14)
        titleLabel!.adjustsFontSizeToFitWidth = true
        titleLabel!.textAlignment = .Left
        titleLabel!.numberOfLines = 1
        self.addSubview(titleLabel!)
        
        sliderLeft = UISlider()
        sliderLeft!.tintColor = UIColor.loginBlueColor()
        sliderLeft!.minimumTrackTintColor = UIColor.loginBlueColor()
        sliderLeft!.maximumTrackTintColor = UIColor.loginBlueColor()
        sliderLeft!.continuous = true;
        sliderLeft!.addTarget(self, action: #selector(SliderTableViewCell.sliderMinLabelChanged(_:)), forControlEvents: .ValueChanged)
        self.addSubview(sliderLeft!)
        
        sliderMinLabel = UILabel()
        sliderMinLabel!.text = "Min \nOff"
        sliderMinLabel!.textColor = .whiteColor()
        sliderMinLabel!.font = UIFont.appLatoFontOfSize(12)
        sliderMinLabel!.adjustsFontSizeToFitWidth = true
        sliderMinLabel!.textAlignment = .Center
        sliderMinLabel!.numberOfLines = 2
        self.addSubview(sliderMinLabel!)
        
        sliderRight = UISlider()
        sliderRight!.minimumTrackTintColor = UIColor.loginBlueColor()
        sliderRight!.maximumTrackTintColor = UIColor.loginBlueColor()
        sliderRight!.continuous = true;
        sliderRight!.addTarget(self, action: #selector(SliderTableViewCell.sliderMaxLabelChanged(_:)), forControlEvents: .ValueChanged)
        self.addSubview(sliderRight!)
        
        sliderMaxLabel = UILabel()
        sliderMaxLabel!.text =  "Max \nOff"
        sliderMaxLabel!.textColor = .whiteColor()
        sliderMaxLabel!.font = UIFont.appLatoFontOfSize(12)
        sliderMaxLabel!.adjustsFontSizeToFitWidth = true
        sliderMaxLabel!.textAlignment = .Center
        sliderMaxLabel!.numberOfLines = 2
        self.addSubview(sliderMaxLabel!)
        
        titleView = UIView()
        titleView!.addSubview(leftIcon!)
        titleView!.addSubview(titleLabel!)
        self.addSubview(titleView!)
        
        
        sliderView = UIView()
        sliderView!.addSubview(sliderLeft!)
        sliderView!.addSubview(sliderRight!)
        self.addSubview(sliderView!)
        
        
        
        setupConstrains()
        
        setSlidersGradient(sliderLeft!, leftColor: UIColor.loginBlueColor(),rightColor: UIColor.loginRedColor())
        setSlidersGradient(sliderRight!, leftColor: UIColor.loginRedColor(),rightColor: UIColor.redColor())
        
        
        
    }
    
    func setSlidersGradient(slider : UISlider, leftColor: UIColor, rightColor: UIColor){
        let colors : NSArray = NSArray(objects: leftColor.CGColor, rightColor.CGColor)
        let trackGradientLayer : CAGradientLayer = CAGradientLayer()
        var frame = CGRect(x: 20, y: 0, width: 120, height: 2)
        frame.size.height = 2.0;
        trackGradientLayer.frame = frame;
        trackGradientLayer.colors = colors as! [CGColor]
        //setting gradient as horizontal
        trackGradientLayer.startPoint = CGPointMake(0.0, 0.2);
        trackGradientLayer.endPoint = CGPointMake(1.0, 0.2);
        let trackImage : UIImage = self.imageFromLayer(trackGradientLayer).resizableImageWithCapInsets(UIEdgeInsetsZero)
        slider.setMinimumTrackImage(trackImage, forState: .Normal)
        slider.setMaximumTrackImage(trackImage, forState: .Normal)
        
    }
    
    func imageFromLayer(layer : CALayer) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.opaque, 0.0);
        
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let outputImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
        
        UIGraphicsEndImageContext();
        
        return outputImage;
        
    }
    
    
    override func setItems(myDictionary: NSDictionary){
        if let left_icon = myDictionary["left_icon"] as? String{
            leftIcon!.image = UIImage(named: left_icon)
        }
        if let right_icon = myDictionary["right_icon"] as? String{
            rightIconString = right_icon
        }
        
        
        
//        let language = NSLocale.currentLocale().objectForKey(NSLocaleLanguageCode)! as! String
//        
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
        
        if let cellUnity = myDictionary["unity"] as? String{
            unity = cellUnity
        }
        if let minimumValue = myDictionary["min"] as? Float{
            if self.minValue == nil {
                sliderLeft!.minimumValue = minimumValue
                sliderRight!.minimumValue = minimumValue
                sliderLeft!.value = minimumValue
                self.minValue = minimumValue
            }
        }
        if let maximumValue = myDictionary["max"] as? Float{
            if self.maxValue == nil {
                sliderLeft!.maximumValue = maximumValue
                sliderRight!.maximumValue = maximumValue
                sliderRight!.value = maximumValue
                self.maxValue = maximumValue
            }
        }
        
        if self.editAlarmDTO != nil && self.firstTimeEdit == false{
            editSeted = false
            self.setEditAlarm(self.editAlarmDTO!, isEdit: false, status: alarmStatus)
        }
    }
    
    override func setDefaults(defaultDTO: AlarmDTO,isCreate: Bool){
        
        if titleLabel!.text == (NSLocalizedString("TEMPERATURA", comment: "")) {
            setDefaultValues(defaultDTO.minTemp, maxDefaultValue: defaultDTO.maxTemp, isCreate: isCreate)
        }else if titleLabel!.text == (NSLocalizedString("VIENTO", comment: "")) {
            setDefaultValues(defaultDTO.minWind, maxDefaultValue: defaultDTO.maxWind, isCreate: isCreate)
        }else if titleLabel!.text == (NSLocalizedString("HUMEDAD", comment: "")) {
            setDefaultValues(defaultDTO.minHumidity, maxDefaultValue: defaultDTO.maxHumidity, isCreate: isCreate)
        }else if titleLabel!.text == (NSLocalizedString("NIEVE", comment: "")) {
            setDefaultValues(defaultDTO.minSnow, maxDefaultValue: defaultDTO.maxSnow, isCreate: isCreate)
        }
        
    }
    
    func setDefaultValues(minDefaultValue: NSNumber, maxDefaultValue: NSNumber, isCreate: Bool){
        
        if !defaultSeted || isCreate == true {
            
            self.minValue = minDefaultValue
            self.maxValue = maxDefaultValue
            self.sliderLeft?.value = Float(minDefaultValue)
            self.sliderRight?.value = Float(maxDefaultValue)
            
            if minDefaultValue != sliderLeft?.minimumValue{
                self.sliderMinLabel?.text = "Min \n \(String(minDefaultValue)) \(unity)"
            }else{
                self.sliderMinLabel?.text = "Min \nOff"
            }
            
            if maxDefaultValue != sliderLeft?.maximumValue{
                self.sliderMaxLabel?.text = "Max \n \(String(maxDefaultValue)) \(unity)"
            }else{
                self.sliderMaxLabel?.text = "Max \nOff"
            }
            
            defaultSeted = true
        }
    }
    
    override func resetValues(){
        self.sliderMaxLabel?.text = "Max \nOff"
        self.sliderMinLabel?.text = "Min \nOff"
        
        if let minimumValue = myDictionary!["min"] as? Float{
            sliderLeft!.minimumValue = minimumValue
            sliderRight!.minimumValue = minimumValue
            sliderLeft!.value = Float(minimumValue)
            self.minValue = minimumValue
            
        }
        if let maximumValue = myDictionary!["max"] as? Float{
            sliderLeft!.maximumValue = maximumValue
            sliderRight!.maximumValue = maximumValue
            sliderRight!.value = Float(maximumValue)
            self.maxValue = maximumValue
            
        }
    }
    
    func sliderMinLabelChanged(sender: UISlider) {
        
        var value : Int!
        
        if sender.value >= sliderRight?.value{
            sender.value = (sliderRight?.value)!
            value = Int((sliderRight?.value)!)
        }else{
            value = Int(sender.value)
        }
        
        if value != Int((sliderLeft?.minimumValue)!) {
            sliderMinLabel!.text = "Min \n \(String(value))\(unity)"
        }else{
            sliderMinLabel!.text = "Min \nOff"
        }
        
        minValue = value
        
    }
    
    
    func sliderMaxLabelChanged(sender: UISlider) {
        
        var value : Int!
        
        if sender.value <= sliderLeft?.value{
            sender.value = (sliderLeft?.value)!
            value = Int((sliderLeft?.value)!)
        }else{
            value = Int(sender.value)
        }
        
        if value != Int((sliderRight?.maximumValue)!) {
            sliderMaxLabel!.text = "Max \n \(String(value))\(unity)"
        }else{
            sliderMaxLabel!.text = "Max \nOff"
        }
        
        maxValue = value
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstrains(){
        
        titleView!.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        titleView!.autoPinEdge(.Left, toEdge: .Left, ofView: self)
        titleView!.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        titleView!.autoMatchDimension(.Height, toDimension: .Height, ofView: self, withMultiplier: 0.45)
        
        
        leftIcon!.autoPinEdge(.Left, toEdge: .Left, ofView: titleView!)
        leftIcon!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: titleView!)
        
        leftIcon!.autoPinEdge(.Top, toEdge: .Top, ofView: titleView!)
        leftIcon!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.20)
        
        titleLabel!.autoPinEdge(.Left, toEdge: .Right, ofView: leftIcon!)
        titleLabel!.autoPinEdge(.Top, toEdge: .Top, ofView: titleView!)
        titleLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: titleView!)
        titleLabel!.autoPinEdge(.Right, toEdge: .Right, ofView: titleView!)
        
        sliderView!.autoPinEdge(.Left, toEdge: .Right, ofView: leftIcon!)
        sliderView!.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel!)
        sliderView!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        sliderView!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.60)
        sliderView!.autoMatchDimension(.Height, toDimension: .Height, ofView: titleLabel!)
        
        sliderLeft!.autoPinEdge(.Left, toEdge: .Left, ofView: sliderView!)
        sliderLeft!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: sliderView!)
        sliderLeft!.autoPinEdge(.Top, toEdge: .Top, ofView: sliderView!)
        
        sliderRight!.autoPinEdge(.Left, toEdge: .Right, ofView: sliderLeft!, withOffset: 12)
        sliderRight!.autoPinEdge(.Right, toEdge: .Right, ofView: sliderView!)
        sliderRight!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: sliderView!)
        sliderRight!.autoPinEdge(.Top, toEdge: .Top, ofView: sliderView!)
        sliderRight!.autoMatchDimension(.Width, toDimension: .Width, ofView: sliderLeft!, withMultiplier: 1)
        
        rightIcon!.autoPinEdge(.Left, toEdge: .Right, ofView: titleLabel!)
        rightIcon!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        rightIcon!.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        rightIcon!.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        
        sliderMinLabel!.autoPinEdge(.Left, toEdge: .Left, ofView: leftIcon!)
        sliderMinLabel!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.20)
        sliderMinLabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: leftIcon!)
        sliderMinLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        
        
        sliderMaxLabel!.autoPinEdge(.Left, toEdge: .Right, ofView: sliderView!)
        sliderMaxLabel!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.20)
        sliderMaxLabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: leftIcon!)
        sliderMaxLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        
        
    }
    
    func rightButtonPressed(){
        print("pepe")
    }
    
    override func setEditAlarm(editAlarmDTO: PersonalAlarmDTO, isEdit: Bool, status: NSNumber?) {
        
        let event = editAlarmDTO.event![0] as? EventDTO
        let weather = editAlarmDTO.weather![0] as? AlarmDTO
        
        if titleLabel!.text == (NSLocalizedString("TEMPERATURA", comment: "")) {
            setEditValues(weather!.minTemp, maxDefaultValue: weather!.maxTemp, isEdit: isEdit)
        }else if titleLabel!.text == (NSLocalizedString("VIENTO", comment: "")){
            setEditValues(weather!.minWind, maxDefaultValue: weather!.maxWind, isEdit: isEdit)
        }else if titleLabel!.text == (NSLocalizedString("HUMEDAD", comment: "")){
            setEditValues(weather!.minHumidity, maxDefaultValue: weather!.maxHumidity, isEdit: isEdit)
        }else if titleLabel!.text == (NSLocalizedString("NIEVE", comment: "")){
            setEditValues(weather!.minSnow, maxDefaultValue: weather!.maxSnow, isEdit: isEdit)
            
            
        }
    }
    
    func setEditValues(minDefaultValue: NSNumber, maxDefaultValue: NSNumber, isEdit: Bool){
        
        if !editSeted || isEdit == true {
            
            self.minValue = minDefaultValue
            self.maxValue = maxDefaultValue
            self.sliderLeft?.value = Float(minDefaultValue)
            self.sliderRight?.value = Float(maxDefaultValue)
            
            if minDefaultValue != sliderLeft?.minimumValue{
                self.sliderMinLabel?.text = "Min \n \(String(minDefaultValue)) \(unity)"
            }else{
                self.sliderMinLabel?.text = "Min \nOff"
            }
            
            if maxDefaultValue != sliderLeft?.maximumValue{
                self.sliderMaxLabel?.text = "Max \n \(String(maxDefaultValue)) \(unity)"
            }else{
                self.sliderMaxLabel?.text = "Max \nOff"
            }
            
            editSeted = true
            self.firstTimeEdit = true
        }
    }
    
}
