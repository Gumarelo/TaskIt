//
//  TaskModel.swift
//  TaskIt
//
//  Created by Jorge Casariego on 21/3/15.
//  Copyright (c) 2015 Jorge Casariego. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var fecha: NSDate
    @NSManaged var completado: NSNumber
    @NSManaged var subtarea: String
    @NSManaged var tarea: String

}
