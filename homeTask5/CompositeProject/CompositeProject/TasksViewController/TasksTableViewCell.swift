//
//  TasksTableViewCell.swift
//  CompositeProject
//
//  Created by Alexandr Evtodiy on 10.01.2021.
//

import UIKit

class TasksTableViewCell: UITableViewCell {

    @IBOutlet weak var nameTaskUILabel: UILabel!
    @IBOutlet weak var countOfSubTasksUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func config (task: CompositeTask) {
        nameTaskUILabel.text = task.name
        countOfSubTasksUILabel.text = String(task.countSubTasks)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
