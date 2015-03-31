//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Jorge Casariego on 17/3/15.
//  Copyright (c) 2015 Jorge Casariego. All rights reserved.
//

import UIKit

//Creamo un protocolo
@objc protocol TaskDetailViewControllerDelegate {
    optional func taskDetailEdited()
}

class TaskDetailViewController: UIViewController {
    
    //var mainVC:ViewController!
    
    @IBOutlet weak var tareaTextField: UITextField!
    @IBOutlet weak var subtareaTextField: UITextField!
    @IBOutlet weak var fechaDatePicker: UIDatePicker!
    
    //Agregamos un propieda
    var delegate: TaskDetailViewControllerDelegate?
    
    var detailTaskModel: TaskModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        
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
        
        /*
        //YA no usamos estas lineas de codigo luego de usar CoreDate
        var tarea = TaskModel(tarea: tareaTextField.text, subtarea: subtareaTextField.text, fecha: fechaDatePicker.date, completado: false)
        mainVC.arrayBase[0][mainVC.tableView.indexPathForSelectedRow()!.row] = tarea
        */
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        detailTaskModel.tarea = tareaTextField.text
        detailTaskModel.subtarea = subtareaTextField.text
        detailTaskModel.fecha = fechaDatePicker.date
        
        detailTaskModel.completado = detailTaskModel.completado
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
        
        delegate?.taskDetailEdited!()
    }
    
}
