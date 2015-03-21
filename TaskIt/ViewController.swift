//
//  ViewController.swift
//  TaskIt
//
//  Created by Jorge Casariego on 12/3/15.
//  Copyright (c) 2015 Jorge Casariego. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayBase:[[TaskModel]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let fecha1 = Date.from(year: 2015, month: 07, day: 08)
        let fecha2 = Date.from(year: 2015, month: 11, day: 11)
        let fecha3 = Date.from(year: 2015, month: 05, day: 14)


        
        let tarea1 = TaskModel(tarea: "Ver videos iOS", subtarea: "Ver de lunes a viernes", fecha: fecha1, completado: false)
        let tarea2 = TaskModel(tarea: "Ver form sepre", subtarea: "Hacer controles iunput", fecha: fecha2, completado: false)

        //Tareas incompletas
        let taskArray = [tarea1, tarea2, TaskModel(tarea: "Bajar pelicula", subtarea: "The walking dead", fecha: fecha3, completado: false)]
        
        //tareas completas
        var tareasCompletasArray = [TaskModel(tarea: "Terminar iTask", subtarea: "Como maximo el domingo", fecha: fecha1, completado: true)]
            
        arrayBase = [taskArray, tareasCompletasArray]
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        func sortByDate(taskUno:TaskModel, taskDos:TaskModel) -> Bool{
            return taskUno.fecha.timeIntervalSince1970 < taskDos.fecha.timeIntervalSince1970
        }
        
        taskArray = taskArray.sorted(sortByDate)*/
        
        //Esto es lo mismo que arriba pero utilizando closure
        arrayBase[0] = arrayBase[0].sorted{
            (taskUno:TaskModel, taskDos:TaskModel) -> Bool in
                return taskUno.fecha.timeIntervalSince1970 < taskDos.fecha.timeIntervalSince1970
        
        }
        
        
        
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            let detailVC: TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = arrayBase[indexPath!.section][indexPath!.row]
            detailVC.detailTaskModel = thisTask
            
            detailVC.mainVC = self
        }
        else if segue.identifier == "showAddTask" {
            let addTaskVC: AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
            addTaskVC.mainVC = self
        }
    }
    
    
    @IBAction func addTaskButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showAddTask", sender: self)
    }
    
    
    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return arrayBase.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayBase[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        let taskDit = arrayBase[indexPath.section][indexPath.row]
        
        cell.taskLabel.text = taskDit.tarea
        cell.descriptionLabel.text = taskDit.subtarea
        cell.dateLabel.text = Date.toString(date: taskDit.fecha)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return " Tareas Incompletas"
        }
        else {
            return "Tareas Completas"
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = arrayBase[indexPath.section][indexPath.row]
        
        var nuevaTarea = TaskModel(tarea: thisTask.tarea, subtarea: thisTask.subtarea, fecha: thisTask.fecha, completado: true)
        
        arrayBase[indexPath.section].removeAtIndex(indexPath.row)
        arrayBase[1].append(nuevaTarea)
        
        tableView.reloadData()
    }
    
    

}

