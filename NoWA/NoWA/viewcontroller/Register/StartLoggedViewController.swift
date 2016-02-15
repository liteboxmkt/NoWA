//
//  StartLoggedViewController.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 14/2/16.
//  Copyright © 2016 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class StartLoggedViewController: LoginViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userService : UserService = UserService()
        
        let email = NSUserDefaults.standardUserDefaults().valueForKey("email") as! String
        let pass = NSUserDefaults.standardUserDefaults().valueForKey("pass") as! String
        
        userService.login(email, code: pass,target: self,message: "loginFinish:")
    }
    
    func loginFinish (result : ServiceResult!){
        if(result.hasErrors()){
            print("Error papu")
            return
        }
        
        let usuarioLogueado:UserDTO = result.entityForKey("User") as! UserDTO
        if usuarioLogueado.token != nil {
            dispatch_async(dispatch_get_main_queue()) {
                self.startApp()
            }
            
        }
        
    }
}

