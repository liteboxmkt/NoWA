//
//  TorneoItemTableViewCell.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 22/12/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class TorneoItemTableViewCell: AlarmItemTableViewCell {
    
    var cancelLabel: UILabel?
    //    var alarmID : NSNumber?
    
    var torneoDTO : TournamentDTO?{
        didSet{
            let stamp = torneoDTO!.stamp! as NSString
            
            let hour = stamp.substringWithRange(NSRange(location: 11, length: 2))
            let min = stamp.substringWithRange(NSRange(location: 14, length: 2))
            
            if amPmFormat == false {
                timeLabel!.text = stamp.substringWithRange(NSRange(location: 11, length: 5))
            } else {
                var hourAMPM : String!
                switch hour {
                case "00":
                    hourAMPM = "12"
                case "13":
                    hourAMPM = "01"
                case "14":
                    hourAMPM = "02"
                case "15":
                    hourAMPM = "03"
                case "16":
                    hourAMPM = "04"
                case "17":
                    hourAMPM = "05"
                case "18":
                    hourAMPM = "06"
                case "19":
                    hourAMPM = "07"
                case "20":
                    hourAMPM = "08"
                case "21":
                    hourAMPM = "09"
                case "22":
                    hourAMPM = "10"
                case "23":
                    hourAMPM = "11"
                case "24":
                    hourAMPM = "12"
                default:
                    print("default")
                }
                
                if hourAMPM != nil{
                    self.timeLabel!.text = "\(hourAMPM):\(min) PM"
                } else {
                    self.timeLabel!.text = "\(hour):\(min) AM"
                }
            }
            
            let day = stamp.substringWithRange(NSRange(location: 8, length: 2))
            let month = stamp.substringWithRange(NSRange(location: 5, length: 2))
            dateLabel!.text = "\(day)-\(month)"
            
            var teamsString : String!
            
            descriptionLabel!.text = ""
            for team in torneoDTO!.teams!{
                
                let _team = team as! TeamDTO
                teamsString = _team.name!
                
                if descriptionLabel!.text == "" {
                    descriptionLabel!.text = "@\(torneoDTO!.eventZone!) - " + teamsString
                }else{
                    descriptionLabel!.text = descriptionLabel!.text! + " VS \(teamsString)"
                }
                
                if serviceLabel!.text == nil {
                    if let tournamentName = _team.tournament {
                        serviceLabel!.text = tournamentName
                    }
                }
            }
            
            if torneoDTO!.status == 0{
                alarmSwitch?.selected = true
                cancelLabel!.hidden = true
                alarmSwitch?.hidden = false
                setInactiveColours()
            }else if torneoDTO!.status == 1 {
                alarmSwitch?.selected = false
                cancelLabel!.hidden = true
                alarmSwitch?.hidden = false
                setActiveColours()
            }else{
                cancelLabel!.hidden = false
                alarmSwitch?.hidden = true
                setInactiveColours()
            }
            
            if let daysString : String = torneoDTO!.repetition{
                let daysArray : NSArray = daysString.componentsSeparatedByString(",")
                if torneoDTO!.status == 0{
                    weekDaysView?.showDays(daysArray, color: UIColor.daysInactiveColor())
                }else{
                    weekDaysView?.showDays(daysArray, color: UIColor.daysActiveColor())
                }
            }
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //        alarmSwitch?.hidden = false
        
        serviceIcon!.image = UIImage(named: "cup")
        
        cancelLabel = UILabel()
        cancelLabel!.text = "CANCELADA POR ORGANIZADOR"
        cancelLabel!.textColor = UIColor.buttonSelectedRedColor()
        cancelLabel!.font = UIFont.appLatoFontOfSize(12)
        cancelLabel!.adjustsFontSizeToFitWidth = true
        cancelLabel!.textAlignment = .Left
        cancelLabel!.numberOfLines = 2
        cancelLabel!.hidden = true
        self.addSubview(cancelLabel!)
        
        cancelLabel!.autoPinEdge(.Left, toEdge: .Right, ofView: infoView!)
        cancelLabel!.autoPinEdge(.Right, toEdge: .Right, ofView: self, withOffset: -12)
        cancelLabel!.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: dateLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTournament(tournament: TournamentDTO){
        

    }
    
    override func setInactiveColours(){
        super.setInactiveColours()
        serviceIcon!.image = UIImage(named: "cup_inactive")
    }
    
    
    override func setActiveColours(){
        super.setActiveColours()
        serviceIcon!.image = UIImage(named: "cup")
        
    }
    
    override func alarmSwitchPressed (sender:UIButton) {
 
        sender.selected = !sender.selected;
        
        if sender.selected{
            
            cancelTournamentService(0)
            setInactiveColours()
        }else{
            
            cancelTournamentService(1)
            setActiveColours()
        }
    }
    
    func cancelTournamentService(value: NSNumber?){
        let tournamentService : TournamentService = TournamentService()
        tournamentService.cancelTournament(alarmID: (torneoDTO?.tournamentID!)!, value: value!, token: UserService.currentUser.token, target: self, message: "cancelAlarm:")
    }
    
    override func cancelAlarm (result : ServiceResult!){
        if(result.hasErrors()){
            print("Error Cancel Alarm")
            return
        }
        
        if self.torneoDTO!.status == 0{
            self.torneoDTO!.status = 1
        }else{
            self.torneoDTO!.status = 0
        }
        
    }
    
}
