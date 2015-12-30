//
//  RegisterViewController.swift
//  NoWA
//
//  Created by Ernesto Garmendia on 12/1/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

class RegisterViewController: LoginViewController {
    
    var backgroundImage : UIImageView!
    var emailView : RegisterFieldView!
    var passwordView : RegisterFieldView!
    var ingresarButton : UIButton!
    var ingresarFacebookButton : UIButton!
    var createAccountButton : UIButton!
    var recoverButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "login")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(backgroundImage)
        
        emailView = RegisterFieldView()
        emailView.setItems("envelope",placeholder: "TU CORREO", secureMode: false)
        self.view.addSubview(emailView)
        
        passwordView = RegisterFieldView()
        passwordView.setItems("lock",placeholder: "CONTRASEÑA", secureMode: true)
        self.view.addSubview(passwordView)
        
        ingresarButton = UIButton()
        ingresarButton.backgroundColor = .loginRedColor()
        ingresarButton.setTitle("INGRESAR", forState: UIControlState.Normal)
        ingresarButton.titleLabel!.font = UIFont.appLatoFontOfSize(15)
        ingresarButton.addTarget(self, action: "login", forControlEvents: UIControlEvents.TouchUpInside)
        ingresarButton.layer.cornerRadius = 20
        self.view.addSubview(ingresarButton)
        
        ingresarFacebookButton = UIButton()
        ingresarFacebookButton.backgroundColor = .loginBlueColor()
        ingresarFacebookButton.setTitle("INGRESAR CON FACEBOOK", forState: UIControlState.Normal)
        ingresarFacebookButton.titleLabel!.font = UIFont.appLatoFontOfSize(15)
        ingresarFacebookButton.addTarget(self, action: "loginFacebook", forControlEvents: UIControlEvents.TouchUpInside)
        ingresarFacebookButton.layer.cornerRadius = 20
        self.view.addSubview(ingresarFacebookButton)
        
        createAccountButton = UIButton()
        createAccountButton.titleLabel!.font = UIFont.appLatoFontOfSize(12)
        createAccountButton.setTitle("CREAR UNA CUENTA", forState: UIControlState.Normal)
        createAccountButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        createAccountButton.addTarget(self, action: "createAccount", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(createAccountButton)
        
        recoverButton = UIButton()
        recoverButton.backgroundColor = .clearColor()
        recoverButton.setTitle("RECUPERAR", forState: UIControlState.Normal)
        recoverButton.setTitleColor(.whiteColor(), forState: UIControlState.Normal)
        recoverButton.titleLabel!.font = UIFont.appLatoFontOfSize(12)
        recoverButton.titleLabel?.adjustsFontSizeToFitWidth = true
        recoverButton.addTarget(self, action: "recover", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(recoverButton)
        
        self.view.bringSubviewToFront(recoverButton)
        setupConstrains()
        
    }
    
    
    func setupConstrains(){
        
        backgroundImage.autoPinEdge(ALEdge.Top, toEdge: .Top, ofView: self.view)
        backgroundImage.autoPinEdge(ALEdge.Bottom, toEdge: .Bottom, ofView: self.view)
        backgroundImage.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: self.view)
        backgroundImage.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: self.view)
        
        ingresarButton.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.view)
        ingresarButton.autoSetDimension(ALDimension.Height, toSize: 40)
        ingresarButton.autoSetDimension(ALDimension.Width, toSize: self.view.frame.width * 0.7)
        ingresarButton.autoPinEdge(ALEdge.Top, toEdge: .Top, ofView: self.view, withOffset: self.view.frame.height * 0.68)
        
        ingresarFacebookButton.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.view)
        ingresarFacebookButton.autoSetDimension(ALDimension.Height, toSize: 40)
        ingresarFacebookButton.autoSetDimension(ALDimension.Width, toSize: self.view.frame.width * 0.7)
        ingresarFacebookButton.autoPinEdge(ALEdge.Top, toEdge: .Bottom, ofView: ingresarButton, withOffset: 20)
        
        createAccountButton.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.view)
        createAccountButton.autoSetDimension(ALDimension.Height, toSize: 40)
        createAccountButton.autoSetDimension(ALDimension.Width, toSize: 200)
        createAccountButton.autoPinEdge(ALEdge.Top, toEdge: .Bottom, ofView: ingresarFacebookButton, withOffset: 20)
        
        passwordView.autoSetDimension(ALDimension.Height, toSize: 50)
        passwordView.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: self.view, withOffset: 40)
        passwordView.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: self.view, withOffset: -40)
        passwordView.autoPinEdge(ALEdge.Bottom, toEdge: .Top, ofView: ingresarButton, withOffset: -20 )
        
        emailView.autoSetDimension(ALDimension.Height, toSize: 50)
        emailView.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: self.view, withOffset: 40)
        emailView.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: self.view, withOffset: -40)
        emailView.autoPinEdge(ALEdge.Bottom, toEdge: .Top, ofView: passwordView, withOffset: -20)
        
        recoverButton.autoPinEdge(.Top, toEdge: .Top, ofView: passwordView)
        recoverButton.autoPinEdge(.Right, toEdge: .Right, ofView: passwordView)
        recoverButton.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: passwordView)
        recoverButton.autoMatchDimension(.Width, toDimension: .Width, ofView: passwordView, withMultiplier: 0.4)
        
    }
    
    
    
    func loginFacebook(){
        
    }
    
    func createAccount(){
        let createAccountViewController = CreateAccountViewController()
        self.navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
    func login(){
        
        callService()
    }
    
    
    func callService () {
        let userService : UserService = UserService()
        userService.login("gfaraone@litebox.com.ar", code: "631263" ,target: self,message: "loginFinish:")

//        userService.login(emailView.inputTextField.text, code: passwordView.inputTextField.text ,target: self,message: "loginFinish:")
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
    
    func recover(){
        
        print("recover")
        let userService : UserService = UserService()
        userService.recover(emailView.inputTextField.text,target: self,message: "recoverFinish:")
    }
    
    
    func recoverFinish (result : ServiceResult!){
        if(result.hasErrors()){
            print("Error papu")
            return
        }
        
        let recoverDTO:RecoverDTO = result.entityForKey("RecoverCode") as! RecoverDTO
        if recoverDTO.code != "" {
            let alert = UIAlertController(title: "Nueva Contraseña:", message: recoverDTO.code, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            dispatch_async(dispatch_get_main_queue()) {
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    
}
