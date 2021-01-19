//
//  AddTaskViewController.swift
//  CompositeProject
//
//  Created by Alexandr Evtodiy on 10.01.2021.
//

import UIKit

protocol AddTaskViewControllerDelegate {
    func addTask (task: Task)
}

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var nemeOfTaskUITextField: UITextField!
    
    var delegate: AddTaskViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addATaskTouchUpInside(_ sender: Any) {
        
        if let nameOfTask = nemeOfTaskUITextField.text,
           let delegate = self.delegate {
            let task = CompositeTask(name: nameOfTask)
            delegate.addTask(task: task)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
