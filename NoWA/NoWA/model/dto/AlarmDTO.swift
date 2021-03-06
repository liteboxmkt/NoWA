//
//  AlarmDTO.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 5/1/16.
//  Copyright © 2016 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class AlarmDTO: GenericDTO {

    var service : NSNumber!
    var place : String?
    var condition : NSNumber!
    var repetition : String?
    var prediction : NSNumber!
    var minTemp : NSNumber!
    var maxTemp : NSNumber!
    var minSnow : NSNumber!
    var maxSnow : NSNumber!
    var minWind : NSNumber!
    var maxWind : NSNumber!
    var minHumidity : NSNumber!
    var maxHumidity : NSNumber!
    var stamp : String?
    var alarmID : NSNumber?
    var status : NSNumber?
    var ringtone : String?

    
    override class func mapping() -> RKObjectMapping {
        
        let mapping = RKObjectMapping(forClass: AlarmDTO.self)
        mapping.addAttributeMappingsFromDictionary([
            
            "condition": "condition",
            "stamp": "stamp",
            "status": "status",
            "maxWind": "maxWind",
            "repetition": "repetition",
            "prediction": "prediction",
            "minTemp": "minTemp",
            "minHumidity": "minHumidity",
            "id": "alarmID",
            "maxTemp": "maxTemp",
            "minWind": "minWind",
            "service": "service",
            "maxHumidity": "maxHumidity",
            "minSnow": "minSnow",
            "maxSnow": "maxSnow",
            "ringtone": "ringtone",
            "place": "place"
            
            ])
        
        return mapping
    }
    
}
