//
//  ViewController.swift
//  CompositeProject
//
//  Created by Alexandr Evtodiy on 10.01.2021.
//

import UIKit

class TasksViewController: UIViewController {
    
    var task: CompositeTask = CompositeTask(name: "mainTask")
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func back(_ sender: Any) {
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: "TasksTableViewCell", bundle: nil), forCellReuseIdentifier: "taskViewCell")
        
        if task.name == "mainTask" {
            let task1 = CompositeTask(name: "first task")
            task.subTasks.append(task1)
            let task2 = CompositeTask(name: "second task")
            let task3 = CompositeTask(name: "third task")
            let firstTaskOfMainTask = task.subTasks.first as! CompositeTask
            firstTaskOfMainTask.subTasks.append(task2)
            firstTaskOfMainTask.subTasks.append(task3)
            
            
        }
        tableView.reloadData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addTask" {
            let destinationVC = segue.destination as! AddTaskViewController
            destinationVC.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextVC = storyboard.instantiateViewController(withIdentifier: "TasksViewController") as! TasksViewController
        nextVC.task = self.task.subTasks[indexPath.row] as! CompositeTask
        //nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true)
        
    }
    
}

extension TasksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  task.subTasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "taskViewCell", for: indexPath) as! TasksTableViewCell
        let task = self.task.subTasks[indexPath.row]
        cell.config(task: task as! CompositeTask)
        return cell
    }
}

extension TasksViewController: AddTaskViewControllerDelegate {
    func addTask(task: Task) {
        self.task.subTasks.append(task)
        tableView.reloadData()
    }
    
    
}

