//
//  TournamentDAO.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 18/1/16.
//  Copyright © 2016 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class TournamentDAO: GenericDAO {

    func getTournamentsAdmin(token _token: String!, handler _handler : ((Operation,AnyObject)->Void)! ) {
        
        if(!self.register()){
            return;
        }
        
        completionHandler = _handler
        
        let objectManager = RKObjectManager(baseURL: NSURL(string: serverURL))
        
        RKMIMETypeSerialization.registerClass(RKNSJSONSerialization.self, forMIMEType: "application/json")
        
        let mapping = TournamentDTO.mapping()
        
        let responseDescriptor : RKResponseDescriptor = RKResponseDescriptor(mapping: mapping, method: RKRequestMethod.GET, pathPattern: nil, keyPath: "events", statusCodes: nil)
        
        let request = objectManager.requestWithObject(  nil,
            method: RKRequestMethod.GET,
            path: "alarms/tournament/\(_token)/",
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
    
}
