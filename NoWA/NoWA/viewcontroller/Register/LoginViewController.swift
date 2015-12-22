//
//  LoginViewController.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 21/12/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        self.view.addGestureRecognizer(tap)
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.translucent = true;
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.hidden = false
        
        self.navigationController?.navigationBar.backgroundColor = .clearColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage();
        self.navigationController!.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont.appLatoFontOfSize(18)]
    }

    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func startApp(){
        
        let tabBarController = MainTabBarController()
        let vc1 = AlarmasTableViewController()//UIViewController()
        let vc2 = UIViewController()
        let controllers = [vc1,vc2]
        
        tabBarController.viewControllers = controllers
        
        let firstImage = UIImage(named: "alarma")?.imageWithRenderingMode(.AlwaysOriginal)
        let secondImage = UIImage(named: "profile")?.imageWithRenderingMode(.AlwaysOriginal)
        vc1.tabBarItem = UITabBarItem(
            title: "Pie",
            image: firstImage,
            selectedImage: secondImage)
        vc2.tabBarItem = UITabBarItem(
            title: "Pizza",
            image: secondImage,
            selectedImage: secondImage)
        
        
        let navigationController = UINavigationController()
        navigationController.viewControllers = [tabBarController]
        
        switchRootViewController(navigationController, animated: true, completion: nil)
        
    }
    
    func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if animated {
            UIView.transitionWithView(UIApplication.sharedApplication().keyWindow!, duration: 0.5, options: .TransitionCrossDissolve, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled()
                UIView.setAnimationsEnabled(false)
                UIApplication.sharedApplication().keyWindow?.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
                }, completion: { (finished: Bool) -> () in
                    if (completion != nil) {
                        completion!()
                    }
            })
        } else {
            UIApplication.sharedApplication().keyWindow?.rootViewController = rootViewController
        }
    }
    
}
