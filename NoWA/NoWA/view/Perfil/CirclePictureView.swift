//
//  CirclePictureView.swift
//  NoWA
//
//  Created by Ernesto Garmendia Luis on 13/1/16.
//  Copyright © 2016 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class CirclePictureView: UIView {
    
    var picture : UIImageView?
    var borderImage : UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.backgroundColor = .clearColor()
        
        borderImage = UIImageView(image: UIImage(named: "profile_photo_container"))
        self.addSubview(borderImage!)
        
        
        
        picture = UIImageView(image: UIImage(named: "panda"))
        picture?.backgroundColor = .yellowColor()
        picture?.contentMode = UIViewContentMode.ScaleAspectFill
        picture?.layer.masksToBounds = true
        UIGraphicsBeginImageContext(picture!.bounds.size)
        self.addSubview(picture!)
               
        let defaultImageKey = "\(UserService.currentUser!.username!)ImageKey"
                if let imgData = NSUserDefaults.standardUserDefaults().objectForKey(defaultImageKey) as? NSData {


            let retrievedImg = UIImage(data: imgData)
                    
//                    let orientedImage = UIImage(CGImage: initialImage.CGImage, scale: 1, orientation: initialImage.imageOrientation)!

//            let orientedImg = UIImage(CGImage: retrievedImg!.CGImage!, scale: 1, orientation: UIImageOrientation.Left)
            self.picture!.image = retrievedImg
        } else {
            
            let fbID = NSUserDefaults.standardUserDefaults().valueForKey("fbID") as! String!
            if fbID != ""{
                
                dispatch_async(dispatch_get_main_queue()) {
                    let facebookProfileUrl = "http://graph.facebook.com/\(fbID)/picture?type=large"
                    
                    if let url  = NSURL(string: facebookProfileUrl),
                        let data = NSData(contentsOfURL: url)
                    {
                        self.picture!.image = UIImage(data: data)
                    }
                }
                
            }
        }
        
        
        
        self.autoSetDimension(.Width, toSize: 120)
        self.autoSetDimension(.Height, toSize: 120)
        self.layer.cornerRadius = 60
        
        picture!.autoSetDimension(.Width, toSize: 100)
        picture!.autoSetDimension(.Height, toSize: 100)
        picture!.layer.cornerRadius = 50
        
        borderImage?.autoPinEdge(.Top, toEdge: .Top, ofView: self)
        borderImage?.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: self)
        borderImage?.autoPinEdge(.Left, toEdge: .Left, ofView: self)
        borderImage?.autoPinEdge(.Right, toEdge: .Right, ofView: self)
        
        picture?.autoCenterInSuperview()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
    }
}
