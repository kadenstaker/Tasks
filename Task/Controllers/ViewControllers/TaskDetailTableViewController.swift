//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Kaden Staker on 10/10/18.
//  Copyright © 2018 Kaden Staker. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    var task: Task? {
        didSet {
            super.loadViewIfNeeded()
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dueTextField.inputView = dueDatePicker
        tableView.keyboardDismissMode = .onDrag
    }
    
    func updateViews() {
        guard let task = task else { return }
        title = task.name
        nameTextField.text = task.name
        dueTextField.text = (task.due as Date?)?.stringValue()
        notesTextView.text = task.notes
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text else { return }
        let due = dueDateValue
        let notes = notesTextView.text
        if let task = self.task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: due)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        nameTextField.resignFirstResponder()
        dueTextField.resignFirstResponder()
        notesTextView.resignFirstResponder()
    }
}
