//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Jorge Casariego on 17/3/15.
//  Copyright (c) 2015 Jorge Casariego. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    var mainVC:ViewController!
    
    @IBOutlet weak var tareaTextField: UITextField!
    @IBOutlet weak var subtareaTextField: UITextField!
    @IBOutlet weak var fechaDatePicker: UIDatePicker!
    
    
    
    var detailTaskModel: TaskModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(self.detailTaskModel.tarea)
        
        tareaTextField.text = detailTaskModel.tarea
        subtareaTextField.text = detailTaskModel.subtarea
        fechaDatePicker.date = detailTaskModel.fecha

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func hechoBarButtonItemPressed(sender: UIBarButtonItem) {
        var tarea = TaskModel(tarea: tareaTextField.text, subtarea: subtareaTextField.text, fecha: fechaDatePicker.date, completado: false)
        mainVC.arrayBase[0][mainVC.tableView.indexPathForSelectedRow()!.row] = tarea
        
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
