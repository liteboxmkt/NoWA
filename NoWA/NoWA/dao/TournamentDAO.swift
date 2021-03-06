//
//  TournamentDAO.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 18/1/16.
//  Copyright © 2016 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class TournamentDAO: GenericDAO {

    func getTournamentsListAdmin(token _token: String!, handler _handler : ((Operation,AnyObject)->Void)! ) {
        
        if(!self.register()){
            return;
        }
        
        completionHandler = _handler
        
        let objectManager = RKObjectManager(baseURL: NSURL(string: serverURL))
        
        RKMIMETypeSerialization.registerClass(RKNSJSONSerialization.self, forMIMEType: "application/json")
        
        let mapping = TournamentAdminDTO.mapping()
        
        let responseDescriptor : RKResponseDescriptor = RKResponseDescriptor(mapping: mapping, method: RKRequestMethod.GET, pathPattern: nil, keyPath: "tournaments", statusCodes: nil)
        
        let originalURL = "tournaments/list/\(_token)/"
        
        let url = self.encodeURL(originalURL)
        
        let request = objectManager.requestWithObject(  nil,
            method: RKRequestMethod.GET,
            path: url,
            parameters: nil)
        
        
        let operation : RKObjectRequestOperation = RKObjectRequestOperation(request: request, responseDescriptors: [responseDescriptor])
        operation.setCompletionBlockWithSuccess({ (operation, response) in
            if response != nil{
                let array = response.array() as NSArray
                self.finish(array)
            }else{
                self.finish(nil)
            }
            },
            failure: { (operation, error) in
                self.printResponse(operation)
                self.finish(nil)
        })
        operation.start()
    }
    
    func editTournament(dateTime _dateTime : String, alarmID _alarmID: NSNumber, token _token: String!, handler _handler : ((Operation,AnyObject)->Void)! ) {
        
        if(!self.register()){
            return;
        }
        
        completionHandler = _handler
        
        let objectManager = RKObjectManager(baseURL: NSURL(string: serverURL))
        
        RKMIMETypeSerialization.registerClass(RKNSJSONSerialization.self, forMIMEType: "application/json")
        
        let mapping = PersonalAlarmDTO.mapping()
        
        let responseDescriptor : RKResponseDescriptor = RKResponseDescriptor(mapping: mapping, method: RKRequestMethod.GET, pathPattern: nil, keyPath: nil, statusCodes: nil)
        
        let originalURL = "alarms/updatetime/\(_alarmID)/\(_dateTime)/\(_token)/"
        let url = self.encodeURL(originalURL)
        
        let request = objectManager.requestWithObject(  nil,
            method: RKRequestMethod.GET,
            path: url,
            parameters: nil)
        
        let operation : RKObjectRequestOperation = RKObjectRequestOperation(request: request, responseDescriptors: [responseDescriptor])
        operation.setCompletionBlockWithSuccess({ (operation, response) in
            if response != nil{
                let array = response.array() as NSArray
                self.finish(array)
            }else{
                self.finish(nil)
            }
            },
            failure: { (operation, error) in
                self.printResponse(operation)
                self.finish(nil)
        })
        operation.start()
        
    }
    
    func cancelTournament(alarmID _alarmID : NSNumber, value _value : NSNumber, token _token :String!, handler _handler : ((Operation,AnyObject)->Void)! ) {
        if(!self.register()){
            return;
        }
        
        completionHandler = _handler
        
        let objectManager = RKObjectManager(baseURL: NSURL(string: serverURL))
        
        RKMIMETypeSerialization.registerClass(RKNSJSONSerialization.self, forMIMEType: "application/json")
        
        let mapping = PersonalAlarmDTO.mapping()
        
        let responseDescriptor : RKResponseDescriptor = RKResponseDescriptor(mapping: mapping, method: RKRequestMethod.GET, pathPattern: nil, keyPath: nil, statusCodes: nil)
        
        let originalURL = "alarms/tournament/toggle/\(_alarmID)/\(_value)/\(_token)/"
        let url = self.encodeURL(originalURL)
        
        let request = objectManager.requestWithObject(  nil,
            method: RKRequestMethod.GET,
            path: url,
            parameters: nil)
        
        let operation : RKObjectRequestOperation = RKObjectRequestOperation(request: request, responseDescriptors: [responseDescriptor])
        operation.setCompletionBlockWithSuccess({ (operation, response) in
            if response != nil{
                let array = response.array() as NSArray
                self.finish(array)
            }else{
                self.finish(nil)
            }
            },
            failure: { (operation, error) in
                self.printResponse(operation)
                self.finish(nil)
        })
        operation.start()
        
    }
    
    func getTournamentsEvents(tournamentID _tournamentID : NSNumber!,token _token :String!, handler _handler : ((Operation,AnyObject)->Void)! ) {
        
        if(!self.register()){
            return;
        }
        
        completionHandler = _handler
        
        let objectManager = RKObjectManager(baseURL: NSURL(string: serverURL))
        
        RKMIMETypeSerialization.registerClass(RKNSJSONSerialization.self, forMIMEType: "application/json")
        
        let mapping = TournamentDTO.mapping()
        
        let responseDescriptor : RKResponseDescriptor = RKResponseDescriptor(mapping: mapping, method: RKRequestMethod.GET, pathPattern: nil, keyPath: "events", statusCodes: nil)
        
        let originalURL = "tournaments/\(_tournamentID)/\(_token)/"
        
        let url = self.encodeURL(originalURL)
        
        let request = objectManager.requestWithObject(  nil,
            method: RKRequestMethod.GET,
            path: url,
            parameters: nil)
        
        print("tournaments/\(_tournamentID!)/\(_token)/")
        
        let operation : RKObjectRequestOperation = RKObjectRequestOperation(request: request, responseDescriptors: [responseDescriptor])
        operation.setCompletionBlockWithSuccess({ (operation, response) in
            if response != nil{
                let array = response.array() as NSArray
                self.finish(array)
            }else{
                self.finish([])
            }
            },
            failure: { (operation, error) in
                self.printResponse(operation)
                self.finish(nil)
        })
        operation.start()
    }
    
    
}
