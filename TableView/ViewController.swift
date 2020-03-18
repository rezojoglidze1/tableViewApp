//
//  ViewController.swift
//  TableView
//
//  Created by rezo on 3/13/20.
//  Copyright © 2020 rezo. All rights reserved.

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    //Main.storyboard-shi style gavukete grouped, radgan kargad iyos gamoyofili

    
    @IBOutlet weak var taskTableView: UITableView!
    
    //Table view Deletage methods
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
            
            let completeAction = UIContextualAction(style: .normal, title: "Complete") {
                (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
                
                //find the right object and set it to completed
                switch indexPath.section {
                case 0:
                    self.hourlyTasks[indexPath.row].completed = true
                case 1:
                    self.dailyTasks[indexPath.row].completed = true
                case 2:
                    self.weeklyTasks[indexPath.row].completed = true
                case 3:
                    self.monthlyTasks[indexPath.row].completed = true
                default:
                    break
                }
                tableView.reloadData()
                actionPerformed(true)
            }
            return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let completeAction = UIContextualAction(style: .normal, title: "Uncomplete") {
            (action: UIContextualAction, sourceView: UIView, actionPerformed: (Bool) -> Void) in
            
            //find the right object and set it to completed
            switch indexPath.section {
            case 0:
                self.hourlyTasks[indexPath.row].completed = false
            case 1:
                self.dailyTasks[indexPath.row].completed = false
            case 2:
                self.weeklyTasks[indexPath.row].completed = false
            case 3:
                self.monthlyTasks[indexPath.row].completed = false
            default:
                break
            }
            tableView.reloadData()
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    
    
    
    
    //didSelectRowAt method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you selected item row \(indexPath.row) in section \(indexPath.section)")
    }
    
    
    
    
    @IBAction func toogleDarkMode(_ sender: Any) {
        
        let mySwitch = sender as! UISwitch
        
        if mySwitch.isOn {
            view.backgroundColor = UIColor.darkGray
        } else {
            view.backgroundColor = UIColor.white
        }
    }
    
    
    @IBAction func resetMyList(_ sender: Any) {
        
        let confirm = UIAlertController(title: "are you sure?", message: "Realy reset List?", preferredStyle: .alert)
               
               let yesAction = UIAlertAction(title: "Yes", style: .destructive) {
                   action in
                   
                   for i in 0..<self.hourlyTasks.count{
                       self.hourlyTasks[i].completed = false
                   }
                   for i in 0..<self.dailyTasks.count{
                       self.dailyTasks[i].completed = false
                   }
                   for i in 0..<self.weeklyTasks.count{
                       self.weeklyTasks[i].completed = false
                   }
                   for i in 0..<self.monthlyTasks.count{
                       self.monthlyTasks[i].completed = false
                   }
               
                   self.taskTableView.reloadData()
    }
  
      let noAction = UIAlertAction(title: "No", style: .cancel){
      action in
      print("there everything no clloese!")
      }
      
      //add action to alert controller
      confirm.addAction(yesAction)
      confirm.addAction(noAction)
      
      //show it
      present (confirm, animated: true, completion: nil)
  }
    
    
    
    
    
    //Table view Data source methods
    
    //vabruneb ramdeni section minda
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundColor = UIColor.clear
        return 4
    }
    
    //titon agenerirebs
    //titoeul seqcias ubruneb ramdeni elementi unda iyos shig
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //chven gvaqvs 4 seqcia, radgan zemot func-shi mivutite. amitom this mettod automatic called 4 times
        switch section {
        case 0:
            return hourlyTasks.count
        case 1:
            return dailyTasks.count
        case 2:
            return weeklyTasks.count
        case 3:
            return monthlyTasks.count
        default:
            return 0
        }
    }
    
    
    
    //titon agenerirebs
    //vwer mnishvnelobebs
    //return cell for each row, IndexPath parameter containing two integers, one for section one for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //indexPath give us a reference table view itself
        //  let cell = UITableViewCell()//return each row for each section
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "tableViewObject", for: indexPath)
        
        myCell.textLabel?.numberOfLines = 0 // numberOfLines aris defaultad 1, xolod me ro 0 mivutuite
        //did teqsts gamoitans axla kargad, manam ar gamoqonda radgan 1 xazze werda yvelafers
        myCell.accessoryType = .disclosureIndicator
        
        
        //to hold the current Task
        var currentTaks: Task!
        
        switch indexPath.section {
        case 0:
            currentTaks = hourlyTasks [indexPath.row]
        case 1:
            currentTaks = dailyTasks [indexPath.row]
        case 2:
            currentTaks = weeklyTasks [indexPath.row]
        case 3:
            currentTaks = monthlyTasks [indexPath.row]
        default:
            myCell.textLabel?.text = "nothing "
        }
        
        
        myCell.textLabel?.text = currentTaks.name
        
        if currentTaks.completed {
            myCell.textLabel?.textColor = UIColor.gray
            myCell.accessoryType = .checkmark
        } else {
            myCell.textLabel?.textColor = UIColor.black
            myCell.accessoryType = .none
            
        }
        myCell.backgroundColor = UIColor.clear
        return myCell
    }
    
    
    //section-ebs vanicheb tavis saxels
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //this method don't have to have a titles, and this method marked to return a optional String
        switch section {
        case 0:
            return "hourly tasks"
        case 1:
            return "daily tasks"
        case 2:
            return "weekly tasks"
        case 3:
            return "monthly tasks"
        default:
            return nil
        }
    }
    
    
    //let hourlyTasks = ["wash my hand, this safe me from korona"]
    
    //    let dailyTasks = ["john Doe live in London",
    //                      "nikita xrushovi stalinis dmza :Dd " ,
    //                      "ioseb stalini from gori, georgian people proud for him :D "]
    //
    //  let weeklyTasks = ["my MacBook Air is good",
    //                         "Real madrdid",
    //                         "Go to gym",
    //                         "wath a horror film"]
    //
    //      let monthlyTasks = ["work hard",
    //                        "play footbal in Dinamo Arena",
    //                        "learn iOS Development",
    //                        "write code in swift language",
    //                        "don't touch my computer"]
    
    
    var hourlyTasks = [
        Task(name: "wash my hand, this safe me from korona", type: .daily, completed: false, lastCompleted: nil )
    ]
    
    var dailyTasks = [
        Task(name: "john Doe live in London", type: .daily, completed: false, lastCompleted: nil ),
        Task(name: "ikita xrushovi stalinis dmza :Dd", type: .daily, completed: true, lastCompleted: nil ),
        Task(name: "ioseb stalini from gori, georgian people proud for him :D", type: .daily, completed: false, lastCompleted: nil )
    ]
    
    
    
    var weeklyTasks = [  Task(name: "my MacBook Air is good", type: .daily, completed: false, lastCompleted: nil ),
                         Task(name: "iReal Madrid", type: .daily, completed: true, lastCompleted: nil ),
                         Task(name: "Go to gym", type: .daily, completed: false, lastCompleted: nil ),
                         Task(name: "watch a horror film", type: .daily, completed: true, lastCompleted: nil )
    ]
    
    var monthlyTasks = [  Task(name: "work hard", type: .daily, completed: false, lastCompleted: nil ),
                          Task(name: "wathch footbal match in Dinamo Arena", type: .daily, completed: false, lastCompleted: nil ),
                          Task(name: "learn iOS", type: .daily, completed: true, lastCompleted: nil )]
    
    
    //
    
    
    //    //tells the data source to return the number of rows in a given section of a tableView
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return 30
    //    }
    //
    //    //asks the data source for a cell to insert a particular location of a table view
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell =  UITableViewCell() // cell-ში დავიჭირე tableView-ს უჯრა
    //        cell.textLabel?.text = "This is a cell for \(indexPath.count)"
    //        return cell
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //self.title = "First Page"
    }
}

