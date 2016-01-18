//
//  NewAlarmInsertTableViewCell.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 15/1/16.
//  Copyright © 2016 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class NewAlarmInsertTableViewCell: GenericTableViewCell {
    
    var newAlertLabel : UILabel?
    var nameTextField : UITextField?
    var timeLabel: UITextField?
    var datePicker : UIDatePicker?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clearColor()
        self.contentView.backgroundColor = .clearColor()
        
        newAlertLabel = UILabel()
        newAlertLabel!.text = "NUEVA ALERTA"
        newAlertLabel!.textColor = .whiteColor()
        newAlertLabel!.font = UIFont.appLatoFontOfSize(14)
        newAlertLabel!.adjustsFontSizeToFitWidth = true
        newAlertLabel!.textAlignment = .Center
        newAlertLabel!.numberOfLines = 1
        self.addSubview(newAlertLabel!)
        
        nameTextField = UITextField()
        nameTextField!.attributedPlaceholder =  NSAttributedString(string: "INGRESÁ UN NOMBRE ...",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        nameTextField!.textColor = .whiteColor()
        nameTextField!.font = UIFont.appLatoFontOfSize(16)
        nameTextField!.adjustsFontSizeToFitWidth = true
        nameTextField!.keyboardType = UIKeyboardType.Default
        nameTextField!.clearButtonMode = .WhileEditing
        nameTextField!.textAlignment = .Left
        self.addSubview(nameTextField!)
        
        
        
        datePicker = UIDatePicker()//(frame: CGRect(x: 0, y: 210, width: 320, height: 216))
        datePicker!.datePickerMode = UIDatePickerMode.Time
        datePicker!.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        datePicker?.backgroundColor = .ribbonAltColor()
        datePicker!.addTarget(self, action: "onDatePickerValueChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        timeLabel = UITextField()
        timeLabel!.text = "07:30"
        timeLabel!.textColor = .whiteColor()
        timeLabel!.font = UIFont.appLatoFontOfSize(60)
        timeLabel!.adjustsFontSizeToFitWidth = true
        timeLabel!.textAlignment = .Left
        timeLabel!.inputView = datePicker!
        self.addSubview(timeLabel!)
        
        setupConstrains()
    }
    
    func onDatePickerValueChanged(datePicker: UIDatePicker){
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh:mm"
//        datePicker.setValue(UIColor.whiteColor(), forKeyPath: "textColor")
        timeLabel!.text = String(dateFormatter.stringFromDate(datePicker.date))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstrains(){
        
        newAlertLabel?.autoPinEdge(.Top, toEdge: .Top, ofView: self, withOffset: 5)
        newAlertLabel?.autoPinEdge(.Left, toEdge: .Left, ofView: self)
        newAlertLabel?.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        
        nameTextField?.autoPinEdge(.Top, toEdge: .Bottom, ofView: newAlertLabel!, withOffset: 15)
        nameTextField?.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 10)
        nameTextField?.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        
        timeLabel?.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameTextField!, withOffset: 10)
        timeLabel?.autoPinEdge(.Left, toEdge: .Left, ofView: self, withOffset: 10)
        timeLabel?.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        
        
    }
    
}