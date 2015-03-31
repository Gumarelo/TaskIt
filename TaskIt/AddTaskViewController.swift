//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Jorge Casariego on 19/3/15.
//  Copyright (c) 2015 Jorge Casariego. All rights reserved.
//

import UIKit
import CoreData

protocol AddTaskViewControllerDelegate{
    func addTask(mensaje:String)
    func cancelar(mensaje:String)
}

class AddTaskViewController: UIViewController {
    
    //var mainVC: ViewController!

    @IBOutlet weak var tareaTextField: UITextField!
    @IBOutlet weak var subtareaTextField: UITextField!
    @IBOutlet weak var fechaDatePicker: UIDatePicker!
    
    var delegate:AddTaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("La tarea no fue agregada!")
    }

    @IBAction func agregarTareaButtonTapped(sender: UIButton) {
        
        //Sin CoreData
        /*var tarea = TaskModel(tarea: tareaTextField.text, subtarea: subtareaTextField.text, fecha: fechaDatePicker.date, completado: false)
        mainVC.arrayBase[0].append(tarea)*/
        
        //Con CoreData
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        let tarea = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true{
            tarea.tarea = tareaTextField.text.capitalizedString
        }
        else {
            tarea.tarea = tareaTextField.text
        }
        
        if NSUserDefaults.standardUserDefaults().boolForKey(kShouldcompleteNewTodo) == true {
            tarea.completado = true
        }
        else {
            tarea.completado = false
        }
        
        
        
        tarea.subtarea = subtareaTextField.text
        tarea.fecha = fechaDatePicker.date
        
        
        appDelegate.saveContext()
        
        //NSFetchRequest returns a request to the core data object, it's how we get data from it.
        //This's just as a test to make sure everything is working fine. 
        //We're simply saying that if there are any results, print it to the debugger so we can see them.
        var request = NSFetchRequest(entityName: "TaskModel")
        var error: NSError? = nil
        
        var resultado: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in resultado{
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
        delegate?.addTask("Tarea agregada")
    }

}
