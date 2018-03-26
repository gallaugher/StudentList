//
//  ViewController.swift
//  Student List
//
//  Created by John Gallaugher on 3/12/18.
//  Copyright © 2018 John Gallaugher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarbutton: UIBarButtonItem!
    @IBOutlet weak var addBarbutton: UIBarButtonItem!
    
    var students = ["Jeffrey Barros Pena",
                    "John J Bruggeman",
                    "Kevin F Cai",
                    "Carli S Casteel",
                    "Yu Chang",
                    "Noah C Clark",
                    "Barbara A Cleary",
                    "Joshua Concepcion",
                    "Tiffany J Daniggelis",
                    "Mark Dimeglio",
                    "Estevan J Feliz",
                    "Michael T Green",
                    "Connor S Greenleaf",
                    "Avery T Gu",
                    "Sean F Healy",
                    "Yehoon Joo",
                    "Bryan Kim",
                    "Daniel J Kurtyka",
                    "Nathan A Lee",
                    "Victoria LePore",
                    "Matthew G Mahoney",
                    "Ryan J Morrissey",
                    "Theodore Murphy",
                    "Kerry Nasta",
                    "Henry C Newlove",
                    "Jessica M Newman",
                    "Tram Nguyen",
                    "Rohan Pahwa",
                    "Ji Woo Pak",
                    "Gamamada Liyanage R Perera",
                    "Ernest J Perry",
                    "Caroline W Roughneen",
                    "John K Sexton",
                    "Lauren A Simon",
                    "Juan A Suarez",
                    "Amelie Trieu",
                    "Daniel T Wu",
                    "Michelle D Youn",
                    "Amanda Zhao",
                    "Anthony Zhao",
                    "Chunzhi Zhou"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowStudent" {
            let destination = segue.destination as! StudentDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.student = students[selectedIndexPath.row]
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: true)
            }
        }
    }
    
    @IBAction func unwindFromStudentDetail(segue: UIStoryboardSegue) {
        let source = segue.source as! StudentDetailViewController
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            students[selectedIndexPath.row] = source.student
            tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
        } else {
            let newIndexPath = IndexPath(row: students.count, section: 0)
            students.append(source.student)
            tableView.insertRows(at: [newIndexPath], with: .bottom)
            tableView.scrollToRow(at: newIndexPath, at: .bottom, animated: true)
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing { // am in editing mode, so get out of editing
            tableView.setEditing(false, animated: true)
            editBarbutton.title = "Edit"
            addBarbutton.isEnabled = true
        } else { // was not in editing mode, so get in editing mode
            tableView.setEditing(true, animated: true)
            editBarbutton.title = "Done"
            addBarbutton.isEnabled = false
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("*** just ran numberOfRowsInSection and studetns.count = \(students.count)")
        return students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = students[indexPath.row]
        print(">>> cellForRowAt called, indexPath.row = \(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            students.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let student = students[sourceIndexPath.row]
        students.remove(at: sourceIndexPath.row)
        students.insert(student, at: destinationIndexPath.row)
    }
}

