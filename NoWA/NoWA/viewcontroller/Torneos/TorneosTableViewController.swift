//
//  TorneosTableViewController.swift
//  NoWA
//
//  Created by Ernesto Garmendia on 12/10/15.
//  Copyright © 2015 Ernesto Garmendia Luis. All rights reserved.
//

import UIKit

class TorneosTableViewController: GenericTableViewController {
    
    var alarmsArray: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(TorneoItemTableViewCell.self, forCellReuseIdentifier: "alarmItem")
        
        //        let backgroundImage = UIImageView()
        //        backgroundImage.image = UIImage(named: "create_alarm_background")
        //        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        //        self.tableView.addSubview(backgroundImage)
        
        
    }
    
    func addAlarm(){
        print("add Alarm")
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7//return alarmsArray.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 120
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        let identificador = alarmsArray[indexPath.row]["identifier"] as! String
        //
        let genericCell = tableView.dequeueReusableCellWithIdentifier("alarmItem", forIndexPath: indexPath) as! GenericTableViewCell
        
        return genericCell
    }
    
}
