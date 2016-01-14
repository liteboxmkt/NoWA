//
//  AlarmItemTableViewCell.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 21/12/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class AlarmItemTableViewCell: GenericTableViewCell {
    
    var serviceIcon: UIImageView?
    var serviceLabel: UILabel?
    var serviceView : UIView?
    var separatorBar : UIView?
    var timeLabel: UILabel?
    var dateLabel: UILabel?
    var descriptionLabel: UILabel?
    var infoView : UIView?
    var weekDaysView : WeekDaysView?
    var alarmSwitch : UIButton?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .darkGrayCustomColor()
        self.contentView.backgroundColor = .darkGrayCustomColor()
        
        serviceIcon = UIImageView()
        serviceIcon!.image = UIImage(named: "cloud_blue")
        //        serviceIcon!.backgroundColor = .grayColor()
        serviceIcon!.contentMode = UIViewContentMode.ScaleAspectFit
        self.addSubview(serviceIcon!)
        
        serviceLabel = UILabel()
        serviceLabel!.text = "ACCU WEATHER"
        serviceLabel!.textColor = .whiteColor()
        //        serviceLabel!.backgroundColor = .yellowColor()
        serviceLabel!.font = UIFont.appLatoFontOfSize(10)
        serviceLabel!.adjustsFontSizeToFitWidth = true
        serviceLabel!.textAlignment = .Center
        serviceLabel!.numberOfLines = 2
        self.addSubview(serviceLabel!)
        
        serviceView = UIView()
        //        serviceView!.backgroundColor = .orangeColor()
        serviceView!.addSubview(serviceIcon!)
        serviceView!.addSubview(serviceLabel!)
        self.addSubview(serviceView!)
        
        separatorBar = UIView()
        separatorBar!.backgroundColor = .tourBlueColor()
        self.addSubview(separatorBar!)
        
        timeLabel = UILabel()
        timeLabel!.text = "07:30"
        timeLabel!.textColor = .whiteColor()
        timeLabel!.font = UIFont.appLatoFontOfSize(40)
        timeLabel!.adjustsFontSizeToFitWidth = true
        timeLabel!.textAlignment = .Left
        timeLabel!.numberOfLines = 1
        self.addSubview(timeLabel!)
        
        dateLabel = UILabel()
        dateLabel!.textColor = .whiteColor()
        dateLabel!.font = UIFont.appLatoFontOfSize(15)
        dateLabel!.adjustsFontSizeToFitWidth = true
        dateLabel!.textAlignment = .Left
        dateLabel!.numberOfLines = 1
        self.addSubview(dateLabel!)
        
        descriptionLabel = UILabel()
        descriptionLabel!.text = "ENTRENAMIENTO SEMANAL"
        descriptionLabel!.textColor = .whiteColor()
        descriptionLabel!.font = UIFont.appLatoFontOfSize(12)
        descriptionLabel!.adjustsFontSizeToFitWidth = true
        descriptionLabel!.textAlignment = .Left
        descriptionLabel!.numberOfLines = 1
        self.addSubview(descriptionLabel!)
        
        infoView = UIView()
        //        infoView?.backgroundColor = .purpleColor()
        infoView?.addSubview(timeLabel!)
        infoView?.addSubview(dateLabel!)
        infoView?.addSubview(descriptionLabel!)
        self.addSubview(infoView!)
        
        weekDaysView = WeekDaysView()
        //        weekDaysView?.backgroundColor = .redColor()
        self.addSubview(weekDaysView!)
        
        alarmSwitch = UIButton()
        alarmSwitch!.addTarget(self, action: "alarmSwitchPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        alarmSwitch!.setImage(UIImage(named: "switch_on"), forState: UIControlState.Normal)
        alarmSwitch!.setImage(UIImage(named: "switch_off"), forState: UIControlState.Selected)
        self.addSubview(alarmSwitch!)
        
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstrains(){
        
        serviceView!.autoPinEdge(.Left, toEdge: .Left, ofView: self)
        serviceView!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        serviceView!.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        serviceView!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.18)
        
        serviceIcon!.autoAlignAxis(.Vertical, toSameAxisOfView: serviceView!)
        serviceIcon!.autoConstrainAttribute(.MarginTop, toAttribute: .MarginTop, ofView: self, withMultiplier: 2.8)
        serviceIcon!.autoMatchDimension(.Width, toDimension: .Width, ofView: serviceView!, withMultiplier: 0.35)
        serviceIcon!.autoMatchDimension(.Height, toDimension: .Width, ofView: serviceView!, withMultiplier: 0.35)
        
        serviceLabel!.autoAlignAxis(.Vertical, toSameAxisOfView: serviceView!)
        serviceLabel!.autoPinEdge(.Left, toEdge: .Left, ofView: serviceView!, withOffset: 5)
        serviceLabel!.autoPinEdge(.Right, toEdge: .Right, ofView: serviceView!, withOffset: -5)
        serviceLabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: serviceIcon!, withOffset: 5)
        serviceLabel!.autoMatchDimension(.Height, toDimension: .Width, ofView: serviceView!, withMultiplier: 0.5)
        
        separatorBar!.autoMatchDimension(.Height, toDimension: .Height, ofView: self, withMultiplier: 0.8)
        separatorBar!.autoSetDimension(.Width, toSize: 1.5)
        separatorBar!.autoConstrainAttribute(.MarginTop, toAttribute: .MarginTop, ofView: self, withMultiplier: 2)
        separatorBar!.autoPinEdge(.Left, toEdge: .Right, ofView: serviceView!)
        
        infoView!.autoPinEdge(.Left, toEdge: .Right, ofView: separatorBar!, withOffset: 8)
        infoView!.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        infoView!.autoMatchDimension(.Width, toDimension: .Width, ofView: self, withMultiplier: 0.55)
        infoView!.autoMatchDimension(.Height, toDimension: .Height, ofView: self, withMultiplier: 0.72)
        
        timeLabel!.autoPinEdge(.Left, toEdge: .Left, ofView: infoView!)
        timeLabel!.autoConstrainAttribute(.MarginTop, toAttribute: .MarginTop, ofView: infoView!)
        timeLabel!.autoMatchDimension(.Width, toDimension: .Width, ofView: infoView!, withMultiplier: 0.55)
        timeLabel!.autoMatchDimension(.Height, toDimension: .Height, ofView: infoView!, withMultiplier: 0.70)
        
        dateLabel!.autoPinEdge(.Left, toEdge: .Right, ofView: timeLabel!)
        dateLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: timeLabel!, withOffset: -5)
        dateLabel!.autoPinEdge(.Right, toEdge: .Right, ofView: infoView!)
        dateLabel!.autoMatchDimension(.Height, toDimension: .Height, ofView: timeLabel!, withMultiplier: 0.50)
        
        descriptionLabel!.autoPinEdge(.Left, toEdge: .Left, ofView: infoView!)
        descriptionLabel!.autoPinEdge(.Top, toEdge: .Bottom, ofView: timeLabel!, withOffset: -8)
        descriptionLabel!.autoPinEdge(.Right, toEdge: .Right, ofView: infoView!)
        descriptionLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: infoView!)
        
        weekDaysView!.autoPinEdge(.Top, toEdge: .Bottom, ofView: infoView!)
        weekDaysView!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        weekDaysView!.autoPinEdge(.Left, toEdge: .Left, ofView: infoView!)
        weekDaysView!.autoPinEdge(.Right, toEdge: .Right, ofView: infoView!)
        
        alarmSwitch!.autoPinEdge(.Left, toEdge: .Right, ofView: infoView!, withOffset: 10)
        alarmSwitch!.autoConstrainAttribute(.MarginTop, toAttribute: .MarginTop, ofView: self, withMultiplier: 3)
        alarmSwitch!.autoSetDimension(.Width, toSize: 50)
        alarmSwitch!.autoSetDimension(.Height, toSize: 30)
        
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
    }
    
    func alarmSwitchPressed (sender:UIButton) {
        //        sender.selected = !sender.selected;
        
        //        if !sender.selected{
        //            if let melodyId = self.myMelodyDTO?.objectId{ // todo borrar
        //                var festMakerService : FestMakerService = FestMakerService()
        //                festMakerService.likeMelody(target: self, message: "likeFinish:", melodyID: melodyId)
        sender.selected = !sender.selected;
        //                sender.userInteractionEnabled = false
        //            }
        //        }
    }
    
    func setupAlarm(alarm: PersonalAlarmDTO){
        
        let event = alarm.event![0] as! EventDTO
        let alarm = alarm.weather![0] as! AlarmDTO
        
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.S"
//        let date = dateFormatter.dateFromString(event.stamp!)
        
        let stamp = event.stamp! as NSString
        
        timeLabel!.text = stamp.substringWithRange(NSRange(location: 11, length: 5))
        
        let day = stamp.substringWithRange(NSRange(location: 8, length: 2))
        let month = stamp.substringWithRange(NSRange(location: 5, length: 2))

        dateLabel!.text = "\(day)-\(month)"
        
        descriptionLabel!.text = event.eventDescription
        
        if event.status == 0{
            alarmSwitch?.selected = true
        }

    }
    
}
