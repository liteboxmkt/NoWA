//
//  WeatherService.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 28/12/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class WeatherService: GenericService {
    
    func getForecasts(token _token :String?, target _target : NSObject, message _message : String ) {
        
        let serviceResult = ServiceResult()
        
        if !TTInternetConnection.sharedInstance().internetAccess() {
            serviceResult.addError("No Internet")
            self.callMessage(target: _target, message: _message, withResult: serviceResult)
            return
        }
        
        let weatherDAO: WeatherDAO = WeatherDAO()
        weatherDAO.delegate = self
        weatherDAO.getForecasts( token: _token, handler: { (operation, result) in
//            let forecasts = result as? WeatherDTO;
            
//            if(weatherDTO == nil || (weatherDTO != nil && weatherDTO!.errorTitle != nil)){
//                serviceResult.addErrorsFromDTO(weatherDTO!)
//                self.callMessage(target: _target, message: _message, withResult: serviceResult)
//            }else{
            
                    serviceResult.addEntity(result, forKey: "Forecasts")
                    
                    self.callMessage(target: _target, message: _message, withResult: serviceResult)
//                }
//            }
        })
    }
    
}
