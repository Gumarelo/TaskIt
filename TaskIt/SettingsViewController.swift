//
//  SettingsViewController.swift
//  TaskIt
//
//  Created by Jorge Casariego on 25/3/15.
//  Copyright (c) 2015 Jorge Casariego. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var capitalizeTableView: UITableView!
    @IBOutlet weak var completeNewTodoTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let kVersionNumber = "1.0"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

        self.capitalizeTableView.delegate = self
        self.capitalizeTableView.dataSource = self
        self.capitalizeTableView.scrollEnabled = false
        
        
        self.completeNewTodoTableView.delegate = self
        self.completeNewTodoTableView.dataSource = self
        self.completeNewTodoTableView.scrollEnabled = false
        
        self.title = "Settings"
        
        self.versionLabel.text = kVersionNumber
        
        var dondeButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("dondeBarButtonItemPressed:"))
        
        self.navigationItem.leftBarButtonItem = dondeButton
        
        
    }
    
    func dondeBarButtonItemPressed(barButtonItem: UIBarButtonItem){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if tableView == self.capitalizeTableView{
            var capitalizeCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
            
            
            if indexPath.row == 0{
                capitalizeCell.textLabel?.text = "No Do not capitalize"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false{
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else{
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else{
                capitalizeCell.textLabel?.text = "Yes, capitalize!"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true{
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else{
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            
            return capitalizeCell
        }
        else {
            var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewTodoCell") as UITableViewCell
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "Do no complete task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldcompleteNewTodo) == false{
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else{
                cell.textLabel?.text = "Complete task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldcompleteNewTodo) == true{
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.capitalizeTableView{
            return "Capitalize new Task?"
        } else{
            return "Compete New Task?"
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.capitalizeTableView{
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            }
            else{
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
            }
        }
        else{
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldcompleteNewTodo)
            }
            else{
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldcompleteNewTodo)
            }
        }
        
        //Guardamos los datos que cambiamos en NSUserDefault
        NSUserDefaults.standardUserDefaults().synchronize()
        //recargamos la tabla
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
