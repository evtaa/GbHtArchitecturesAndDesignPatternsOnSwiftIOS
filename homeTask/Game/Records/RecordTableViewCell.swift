//
//  RecordTableViewCell.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 16.12.2020.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet var dateUILabel: UILabel!
    @IBOutlet var scoreUILabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup ()
        // Initialization code
    }

    private func setup () {
        dateUILabel.textAlignment = .center
        scoreUILabel.textAlignment = .center
    }
    
    func config (record: Record) {
        let dateFormatter = DateFormatter ()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        dateUILabel.text = dateFormatter.string(from: record.date)
        scoreUILabel.text = "Вы ответили на \(String(record.score))% вопросов"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
