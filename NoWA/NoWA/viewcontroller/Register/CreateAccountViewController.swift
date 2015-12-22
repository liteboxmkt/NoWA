//
//  CreateAccountViewController.swift
//  NoWA
//
//  Created by Ernesto Garmendia on 12/1/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

class CreateAccountViewController: LoginViewController {

    var backgroundImage : UIImageView!
    var checkImage : UIImageView!
    var aceptTermsLabel : UILabel!
    var emailView : RegisterFieldView!
    var passwordView : RegisterFieldView!
    var confirmView : RegisterFieldView!
    var ingresarButton : UIButton!
    var termsView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "REGISTRO"
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "registro")!)

        backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: "registro")
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(backgroundImage)
    
        emailView = RegisterFieldView()
        emailView.setItems("envelope",placeholder: "TU CORREO", recover: false, secureMode: false)
        self.view.addSubview(emailView)
        
        passwordView = RegisterFieldView()
        passwordView.setItems("lock",placeholder: "CONTRASEÑA", recover: false, secureMode: true)
        self.view.addSubview(passwordView)
        
        confirmView = RegisterFieldView()
        confirmView.setItems("lock",placeholder: "CONFIRMAR", recover: false, secureMode: true)
        self.view.addSubview(confirmView)
        
        ingresarButton = UIButton()
        ingresarButton.backgroundColor = .loginRedColor()
        ingresarButton.setTitle("INGRESAR", forState: UIControlState.Normal)
        ingresarButton.titleLabel!.font = UIFont.appLatoFontOfSize(15)
        ingresarButton.addTarget(self, action: "startApp", forControlEvents: UIControlEvents.TouchUpInside)
        ingresarButton.layer.cornerRadius = 20
        self.view.addSubview(ingresarButton)
     
        aceptTermsLabel = UILabel()
        aceptTermsLabel.font = UIFont.appLatoFontOfSize(12)
        aceptTermsLabel.text = "ACEPTO TÉRMINOS Y CONDICIONES"
        aceptTermsLabel.textColor = .whiteColor()
        aceptTermsLabel.textAlignment = .Center
        aceptTermsLabel.adjustsFontSizeToFitWidth = true
        aceptTermsLabel.numberOfLines = 1
        self.view.addSubview(aceptTermsLabel)
                
        checkImage = UIImageView()
        checkImage.image = UIImage(named: "tilde")
        checkImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.view.addSubview(checkImage)
        
        termsView = UIView()
        termsView.addSubview(aceptTermsLabel)
        termsView.addSubview(checkImage)
        self.view.addSubview(termsView)
        
        setupConstrains()

        
    }
    
    func setupConstrains() {
        
        backgroundImage.autoPinEdge(ALEdge.Top, toEdge: .Top, ofView: self.view)
        backgroundImage.autoPinEdge(ALEdge.Bottom, toEdge: .Bottom, ofView: self.view)
        backgroundImage.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: self.view)
        backgroundImage.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: self.view)
        
        ingresarButton.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.view)
        ingresarButton.autoSetDimension(ALDimension.Height, toSize: 40)
        ingresarButton.autoSetDimension(ALDimension.Width, toSize: self.view.frame.width * 0.7)
        ingresarButton.autoPinEdge(ALEdge.Top, toEdge: .Top, ofView: self.view, withOffset: self.view.frame.height * 0.68)
        
        checkImage.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: termsView)
        checkImage.autoAlignAxis(.Horizontal, toSameAxisOfView: termsView)
        checkImage.autoSetDimension(ALDimension.Height, toSize: 25)
        checkImage.autoSetDimension(ALDimension.Width, toSize: 25)
        
        aceptTermsLabel.autoPinEdge(ALEdge.Left, toEdge: .Right, ofView: checkImage, withOffset: 10)
        aceptTermsLabel.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: termsView)
        aceptTermsLabel.autoPinEdge(ALEdge.Bottom, toEdge: .Bottom, ofView: termsView)
        aceptTermsLabel.autoPinEdge(ALEdge.Top, toEdge: .Top, ofView: termsView)

        termsView.autoSetDimension(ALDimension.Height, toSize: 30)
        termsView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: self.view)
        termsView.autoPinEdge(ALEdge.Bottom, toEdge: .Top, ofView: ingresarButton, withOffset: -20 )
        
        confirmView.autoSetDimension(ALDimension.Height, toSize: 50)
        confirmView.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: self.view, withOffset: 40)
        confirmView.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: self.view, withOffset: -40)
        confirmView.autoPinEdge(ALEdge.Bottom, toEdge: .Top, ofView: termsView, withOffset: -20 )
        
        passwordView.autoSetDimension(ALDimension.Height, toSize: 50)
        passwordView.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: self.view, withOffset: 40)
        passwordView.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: self.view, withOffset: -40)
        passwordView.autoPinEdge(ALEdge.Bottom, toEdge: .Top, ofView: confirmView, withOffset: -20 )
        
        emailView.autoSetDimension(ALDimension.Height, toSize: 50)
        emailView.autoPinEdge(ALEdge.Left, toEdge: .Left, ofView: self.view, withOffset: 40)
        emailView.autoPinEdge(ALEdge.Right, toEdge: .Right, ofView: self.view, withOffset: -40)
        emailView.autoPinEdge(ALEdge.Bottom, toEdge: .Top, ofView: passwordView, withOffset: -20)

    }

    
}