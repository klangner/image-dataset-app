//
//  SelectDatasetVCViewController.swift
//  image-dataset-app
//
//  Created by Krzysztof Langner on 17/03/2018.
//  Copyright © 2018 Krzysztof Langner. All rights reserved.
//

import UIKit

class DatasetsPopupVC: UIViewController {

    var datasetNames = ["Resitors", "Cars", "Fruits", "Vegetable"]
    
    @IBOutlet weak var datasetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasetsTableView.dataSource = self
        datasetsTableView.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closePopup()
    }
    
    @IBAction func editTableTapped(_ sender: UIBarButtonItem) {
        datasetsTableView.isEditing = !datasetsTableView.isEditing
        sender.title = datasetsTableView.isEditing ? "Done" : "Edit"
    }
    
    @IBAction func addNameTapped(_ sender: UIBarButtonItem) {
    }
    
    func closePopup() {
        view.removeFromSuperview()
    }
}

extension DatasetsPopupVC : UITableViewDataSource, UITableViewDelegate {

    // Number of items in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasetNames.count + 1
    }

    // Create cell for item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datasetNameCell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "All Datasets"
            cell.accessoryType = .checkmark
        } else {
            cell.textLabel?.text = datasetNames[indexPath.row - 1]
        }
        return cell
    }
    
    // Since first cell contains "All Datasets" selection, we don't want to edit it
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row > 0
    }
    
    // Since first cell contains "All Datasets" selection, we don't want to move it
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.item > 0
    }
    
    // Row was reordered
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let name = datasetNames.remove(at: sourceIndexPath.row - 1)
        datasetNames.insert(name, at: destinationIndexPath.row - 1)
    }
    
    // Row was deleted or inserted. Update model
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            datasetNames.remove(at: indexPath.item - 1)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            
        }
    }
    
    
    
    // When the user sweps we want to show Edit and Delete actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let row = indexPath.row - 1
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            self.editCell(at: indexPath)
        })
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            self.datasetNames.remove(at: row)
            self.datasetsTableView.reloadData()
        })
        
        return [deleteAction, editAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if datasetsTableView.isEditing {
            editCell(at: indexPath)
        }
    }
    
    // Show alert which will allow to edit cell text
    func editCell(at indexPath: IndexPath) {
        let row = indexPath.row - 1
        let alert = UIAlertController(title: "", message: "Edit Dataset name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.text = self.datasetNames[row]
        })
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
            self.datasetNames[row] = alert.textFields!.first!.text!
            self.datasetsTableView.reloadRows(at: [indexPath], with: .fade)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false)
    }
}

