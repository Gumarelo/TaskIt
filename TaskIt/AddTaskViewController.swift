//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Jorge Casariego on 19/3/15.
//  Copyright (c) 2015 Jorge Casariego. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var mainVC: ViewController!

    @IBOutlet weak var tareaTextField: UITextField!
    @IBOutlet weak var subtareaTextField: UITextField!
    @IBOutlet weak var fechaDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func agregarTareaButtonTapped(sender: UIButton) {
        var tarea = TaskModel(tarea: tareaTextField.text, subtarea: subtareaTextField.text, fecha: fechaDatePicker.date)
        mainVC.taskArray.append(tarea)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
