//
//  StudentDetailViewController.swift
//  Student List
//
//  Created by John Gallaugher on 3/12/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit

class StudentDetailViewController: UIViewController {
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var studentField: UITextField!
    var student: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if student == nil {
            student = ""
        }
        studentField.text = student
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        student = studentField.text
    }

    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
