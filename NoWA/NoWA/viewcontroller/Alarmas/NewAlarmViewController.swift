//
//  NewAlarmViewController.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 14/1/16.
//  Copyright © 2016 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class NewAlarmViewController: GenericViewController, UITableViewDelegate, UITableViewDataSource, DefaultCellDelegate, LocationTableViewCellDelegate {
    
    var amPmFormat : Bool! = false

    var newAlarmDTO : AlarmDTO?
    var newAlarmEventDTO : EventDTO?
    var cellsArray: NSMutableArray!
    
    var useDefaults : Bool? = false
    
    var datetime : String?
    var isRepetitionSelected : Bool? = false
    
    override func viewDidLoad() {
        
        print(ServicioViewController.defaultData)
        
        super.viewDidLoad()
        self.view.backgroundColor = .registroGrayColor()
        
        let logoImage = UIImage(named:"logoNav")
        self.navigationItem.titleView = UIImageView(image: logoImage)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tabla!.addGestureRecognizer(tap)
        
        let lang =  NSLocale.preferredLanguages().first! as NSString
        let language = lang.substringWithRange(NSRange(location: 0, length: 2))
        
        if language == "en" {
            let empty_newalarm = UIImage(named: "empty_crear-alarma_en")
            emptyStateView?.image = empty_newalarm
        } else if language == "es" {
            let empty_newalarm = UIImage(named: "empty_crear-alarma")
            emptyStateView?.image = empty_newalarm
        }

        let locale = NSLocale.currentLocale()
        
        let dateFormat = NSDateFormatter.dateFormatFromTemplate("j", options: 0, locale: locale)!
        
        if dateFormat.rangeOfString("a") != nil {
            print("12 hour")
            amPmFormat = true
        }
        else {
            print("24 hour")
            amPmFormat = false
        }
        
        tabla?.delegate = self
        tabla?.dataSource = self
        
        self.tabla!.registerClass(NewAlarmInsertTableViewCell.self, forCellReuseIdentifier: "Insert")
        self.tabla!.registerClass(ServicePickerTableViewCell.self, forCellReuseIdentifier: "ServicePicker")
        self.tabla!.registerClass(RingtoneTableViewCell.self, forCellReuseIdentifier: "RingtoneCell")
        self.tabla!.registerClass(PickerTableViewCell.self, forCellReuseIdentifier: "PickerCell")
        self.tabla!.registerClass(LocationTableViewCell.self, forCellReuseIdentifier: "LocationCell")
        self.tabla!.registerClass(DefaultCancelTableViewCell.self, forCellReuseIdentifier: "ServiceAdviceCell")
        self.tabla!.registerClass(SliderTableViewCell.self, forCellReuseIdentifier: "SliderCell")
        self.tabla!.registerClass(PredictionTableViewCell.self, forCellReuseIdentifier: "PredictionSliderCell")
        self.tabla!.registerClass(ButtonTableFooterView.self, forCellReuseIdentifier: "AcceptButtonCell")
        
        
        let path = NSBundle.mainBundle().pathForResource("NewAlarmCells", ofType: "plist")
        self.cellsArray = NSMutableArray(contentsOfFile: path!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey("firstNuevaAlarma") == false {
            self.entendidoButton.hidden = false
            emptyStateView?.hidden = false
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstNuevaAlarma")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        let myBackButton:UIButton = UIButton(type: .Custom) as UIButton
        myBackButton.addTarget(self, action: #selector(NewAlarmViewController.popToRoot(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        myBackButton.setTitle(NSLocalizedString("< Volver", comment: ""), forState: UIControlState.Normal)
        myBackButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        myBackButton.sizeToFit()
        let myCustomBackButtonItem:UIBarButtonItem = UIBarButtonItem(customView: myBackButton)
        self.navigationItem.leftBarButtonItem  = myCustomBackButtonItem
        
        //        let button = UIButton(type: .Custom) as UIButton
        //        button.setImage(UIImage(named: "left_arrow"), forState: UIControlState.Normal)
        //        button.addTarget(self, action: "popToRoot:", forControlEvents: UIControlEvents.TouchUpInside)
        //        button.frame=CGRectMake(0, 0, 30, 30)
        //        let barButton = UIBarButtonItem(customView: button)
        //        self.navigationItem.leftBarButtonItem = barButton
    }
    
    func popToRoot(sender:UIBarButtonItem){
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if cellsArray != nil && self.emptyStateView?.hidden == true {
            return cellsArray.count
        }else{
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        
        let height = cellsArray[indexPath.row]["height"] as! CGFloat
        return height
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identificador = cellsArray[indexPath.row]["identifier"] as! String
        
        let genericCell = self.tabla!.dequeueReusableCellWithIdentifier(identificador, forIndexPath: indexPath) as! GenericTableViewCell
        
        genericCell.myDictionary = cellsArray[indexPath.row] as? NSDictionary
        genericCell.tag = indexPath.row + 100
        if self.useDefaults == true{
            if ServicioViewController.defaultData != nil {
                genericCell.setDefaults(ServicioViewController.defaultData!,isCreate: true)
                genericCell.resetedValues = false
            }
        }else{
            if (genericCell.resetedValues == false) {
                genericCell.resetValues()
                genericCell.resetedValues = true
            }
        }
        if identificador == "AcceptButtonCell"{
            genericCell.buttonDelegate = self
        }
        if identificador == "ServiceAdviceCell"{
            genericCell.defaultDelegate = self
        }
        if identificador == "LocationCell"{
            genericCell.locationDelegate = self
        }
        return genericCell
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Error", message: NSLocalizedString("La ubicación seleccionada no es válida", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func createButtonPressed() {
        print("new alarm view controller")
        
        newAlarmEventDTO = EventDTO()
        newAlarmDTO = AlarmDTO()
        
        let insertCell = tabla!.viewWithTag(100) as! NewAlarmInsertTableViewCell
        if let alarmName = insertCell.nameTextField!.text{
            newAlarmEventDTO?.name = alarmName
            newAlarmEventDTO?.eventDescription = alarmName // preguntar este campo que onda
            
            // armar stamp con dia actual mas horario del picker
            setStamp(insertCell, newAlarmDTO: newAlarmDTO!)
            
            if alarmName == ""{
//                validateObligatoryFields("Nombre de la alarma")
//                return
                let alert = UIAlertController(title: "Error", message: NSLocalizedString("Debe completar el campo Nombre de la alarma", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                return
            }
        }
        setNewAlarmRepetitionDays(insertCell, newAlarmDTO: newAlarmDTO!, newAlarmEventDTO: newAlarmEventDTO!)
        
        if (!isRepetitionSelected!) {
            let alert = UIAlertController(title: "Error", message: NSLocalizedString("Debe seleccionar qué dias que sonará la alarma", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(alert, animated: true, completion: nil)
            }
            return
        }
        
        let locationCell = tabla!.viewWithTag(101) as! LocationTableViewCell
        if let place = locationCell.locationTextField!.text{
            newAlarmDTO?.place = place
            
            var ok : Bool = false
            for location in LocationTableViewCell.locationsArray{
                if location as! String == place{
                    ok = true
                }
            }
            
            if ok == false{
                let alert = UIAlertController(title: "Error", message: NSLocalizedString("La ubicación seleccionada no es válida", comment: ""), preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.presentViewController(alert, animated: true, completion: nil)
                }
                return
            }
            
        }
        
        let ringtoneCell = tabla!.viewWithTag(102) as! RingtoneTableViewCell
        if let ringtone = ringtoneCell.ringtone{
            newAlarmEventDTO?.ringtone = "\(ringtone as String).mp3"
        }
        
        let serviceCell = tabla!.viewWithTag(104) as! ServicePickerTableViewCell
        if let service = serviceCell.service{
            newAlarmDTO?.service = service
        }
        let conditionCell = tabla!.viewWithTag(105) as! PickerTableViewCell
        if let condition = conditionCell.condition{
            newAlarmDTO?.condition = condition
        }
        let temperatureCell = tabla!.viewWithTag(106) as! SliderTableViewCell
        if let minTemp = temperatureCell.minValue{
            newAlarmDTO?.minTemp = minTemp
        }
        if let maxTemp = temperatureCell.maxValue{
            newAlarmDTO?.maxTemp = maxTemp
        }
        let windCell = tabla!.viewWithTag(107) as! SliderTableViewCell
        if let minWind = windCell.minValue{
            newAlarmDTO?.minWind = minWind
        }
        if let maxWind = windCell.maxValue{
            newAlarmDTO?.maxWind = maxWind
        }
        let humidityCell = tabla!.viewWithTag(108) as! SliderTableViewCell
        if let minHumidity = humidityCell.minValue{
            newAlarmDTO?.minHumidity = minHumidity
        }
        if let maxHumidity = humidityCell.maxValue{
            newAlarmDTO?.maxHumidity = maxHumidity
        }
        let snowCell = tabla!.viewWithTag(109) as! SliderTableViewCell
        if let minSnow = snowCell.minValue{
            newAlarmDTO?.minSnow = minSnow
        }
        if let maxSnow = snowCell.maxValue{
            newAlarmDTO?.maxSnow = maxSnow
        }
        let predictionCell = tabla!.viewWithTag(110) as! PredictionTableViewCell
        if let prediction = predictionCell.prediction{
            newAlarmDTO?.prediction = prediction
        }
        
        let alarmService : AlarmService = AlarmService()
        alarmService.createAlarm(dateTime: self.datetime! ,eventDTO: newAlarmEventDTO!, alarmDTO: newAlarmDTO!, token: UserService.currentUser.token,target: self,message: "createAlarmFinish:")
        
        
    }
    
    func createAlarmFinish (result : ServiceResult!){
        if(result.hasErrors()){
            print("Error create")
            return
        }
        
        
        let alert = UIAlertController(title: NSLocalizedString("Se ha creado la alarma", comment: ""), message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler:  { (action: UIAlertAction!) in
            self.navigationController!.popToRootViewControllerAnimated(true)
        }))
        
        dispatch_async(dispatch_get_main_queue()) {
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
    }
    
    func setNewAlarmRepetitionDays(insertCell: NewAlarmInsertTableViewCell, newAlarmDTO : AlarmDTO, newAlarmEventDTO : EventDTO){
        
        if insertCell.daysButtonsView?.lunes?.dayButton?.selected == false {
            setRepetitionValue("1")
        }
        if insertCell.daysButtonsView?.martes?.dayButton?.selected == false {
            setRepetitionValue("2")
        }
        if insertCell.daysButtonsView?.miercoles?.dayButton?.selected == false {
            setRepetitionValue("3")
        }
        if insertCell.daysButtonsView?.jueves?.dayButton?.selected == false {
            setRepetitionValue("4")
        }
        if insertCell.daysButtonsView?.viernes?.dayButton?.selected == false {
            setRepetitionValue("5")
        }
        if insertCell.daysButtonsView?.sabado?.dayButton?.selected == false {
            setRepetitionValue("6")
        }
        if insertCell.daysButtonsView?.domingo?.dayButton?.selected == false {
            setRepetitionValue("7")
        }
    }
    
    func setRepetitionValue(day: String){
        if newAlarmEventDTO!.repetition == nil{
            newAlarmEventDTO!.repetition = ""
            newAlarmEventDTO!.repetition = (newAlarmEventDTO!.repetition)! + "\(day)"
        }else{
            newAlarmEventDTO!.repetition = (newAlarmEventDTO!.repetition)! + ",\(day)"
        }
        print(newAlarmEventDTO!.repetition)
        isRepetitionSelected = true
    }
    
    func setStamp(insertCell: NewAlarmInsertTableViewCell, newAlarmDTO : AlarmDTO){
        
        let formatter = NSNumberFormatter()
        formatter.minimumIntegerDigits = 2
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar() //2015-11-24 17:00:49.0
        let components = calendar.components([ .Year, .Month, .Day], fromDate: date)
        let year = formatter.stringFromNumber(components.year)
        let month = formatter.stringFromNumber(components.month)
        let day = formatter.stringFromNumber(components.day)
        
        let timeLabel = insertCell.timeLabel!.text! as NSString
        
        
//        let hour = timeLabel.substringWithRange(NSRange(location: 0, length: 2))
//        let minute = timeLabel.substringWithRange(NSRange(location: 3, length: 2))
//        
//        //        dd-MM-yyyy-HH-mm-ss
//        self.datetime = "\(day!)-\(month!)-\(year!)-\(hour)-\(minute)-00"
        
        
        
        
        
        let hour = timeLabel.substringWithRange(NSRange(location: 0, length: 2))
        let minute = timeLabel.substringWithRange(NSRange(location: 3, length: 2))
        
        if amPmFormat == true {
            let amPm = timeLabel.substringWithRange(NSRange(location: 6, length: 2))
            if amPm != "" {
                var hourAMPM : String!
                
                if amPm == "PM"{
                    switch hour {
                    case "00":
                        hourAMPM = "12"
                    case "01":
                        hourAMPM = "13"
                    case "02":
                        hourAMPM = "14"
                    case "03":
                        hourAMPM = "15"
                    case "04":
                        hourAMPM = "16"
                    case "05":
                        hourAMPM = "17"
                    case "06":
                        hourAMPM = "18"
                    case "07":
                        hourAMPM = "19"
                    case "08":
                        hourAMPM = "20"
                    case "09":
                        hourAMPM = "21"
                    case "10":
                        hourAMPM = "22"
                    case "11":
                        hourAMPM = "23"
                    case "12":
                        hourAMPM = "12"
                    default:
                        print("default")
                    }
                    self.datetime = "\(day!)-\(month!)-\(year!)-\(hourAMPM)-\(minute)-00"
                    
                }else{
                    self.datetime = "\(day!)-\(month!)-\(year!)-\(hour)-\(minute)-00"
                }
            } else {
                //        dd-MM-yyyy-HH-mm-ss
                self.datetime = "\(day!)-\(month!)-\(year!)-\(hour)-\(minute)-00"
            }
        } else {
            //        dd-MM-yyyy-HH-mm-ss
            self.datetime = "\(day!)-\(month!)-\(year!)-\(hour)-\(minute)-00"
        }
        
    }
    
    func defaultButtonPressed(){
        print("apretadooooooooooooo")
        
        self.useDefaults = true
        dispatch_async(dispatch_get_main_queue()) {
            
            self.tabla?.reloadData()
        }
        
    }
    
    func defaultButtonDisabled(){
        self.useDefaults = false
        dispatch_async(dispatch_get_main_queue()) {
            
            self.tabla?.reloadData()
        }
    }
    

}
