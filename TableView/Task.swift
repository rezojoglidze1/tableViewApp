//
//  Task.swift
//  TableView
//
//  Created by rezo on 3/18/20.
//  Copyright © 2020 rezo. All rights reserved.
//

import Foundation

enum TaskType {
    case hourly, daily, weekly, monthly
}

struct Task {
    var name : String
    var type : TaskType
    var completed : Bool
    var lastCompleted : NSDate?
}
