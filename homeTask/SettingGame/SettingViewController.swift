//
//  SettingViewController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by Alexandr Evtodiy on 20.12.2020.
//

import UIKit

enum OrderOfQuestions: Int, Codable {
    case sequential, random
}

class SettingViewController: UIViewController {

    @IBOutlet weak var orderOfQuestionsUISegmentControl: UISegmentedControl!
    @IBAction func backTouch(_ sender: Any) {
        Game.shared.orderOfQuestions = self.selectOrderOfQuestions
        dismiss(animated: true, completion: nil)
    }
    
    private var selectOrderOfQuestions: OrderOfQuestions {
        get {
            switch orderOfQuestionsUISegmentControl.selectedSegmentIndex {
            case 0:
                return .sequential
            case 1:
                return .random
            default:
                return .sequential
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        orderOfQuestionsUISegmentControl.selectedSegmentIndex = Game.shared.orderOfQuestions.rawValue
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
