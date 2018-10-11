//
//  TaskTableViewCell.swift
//  Task
//
//  Created by Kaden Staker on 10/10/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func cellButtonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {
    
    var delegate: TaskTableViewCellDelegate?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    func update(task: Task) {
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.cellButtonTapped(self)
    }
}
