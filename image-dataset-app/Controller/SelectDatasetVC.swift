//
//  SelectDatasetVCViewController.swift
//  image-dataset-app
//
//  Created by Krzysztof Langner on 17/03/2018.
//  Copyright © 2018 Krzysztof Langner. All rights reserved.
//

import UIKit

class SelectDatasetVC: UIViewController {


    @IBOutlet weak var datasetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasetsTableView.dataSource = self
        datasetsTableView.delegate = self
    }

    @IBAction func onCancel(_ sender: Any) {
        moveToDatasetImagesVC()
    }
    
    @IBAction func editTableTapped(_ sender: UIBarButtonItem) {
        datasetsTableView.isEditing = !datasetsTableView.isEditing
        sender.title = datasetsTableView.isEditing ? "Done" : "Edit"
    }
    
    @IBAction func addNameTapped(_ sender: UIBarButtonItem) {
    }
    
    func selectDataset(withName name: String) {
        DataService.instance.currentDatasetName = name
        moveToDatasetImagesVC()
    }
    
    // Go back to main view controller
    func moveToDatasetImagesVC() {
        if let selectDatasetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "datasetImagesId") as? DatasetImagesVC {
            present(selectDatasetVC, animated: false, completion: nil)
        }
    }
    
}

extension SelectDatasetVC : UITableViewDataSource, UITableViewDelegate {

    // Number of items in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.datasetNames().count
    }

    // Show item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datasetNameCell", for: indexPath)
        let name = DataService.instance.datasetNames()[indexPath.row]
        cell.textLabel?.text = name
        if name == DataService.instance.currentDatasetName {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    // When user taps on datset, then select it and go back to main VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = DataService.instance.datasetNames()[indexPath.row]
        DataService.instance.currentDatasetName = name
        moveToDatasetImagesVC()
    }
    
    // Row was deleted or inserted. Update model
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            datasetNames.remove(at: indexPath.item - 1)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            
        }
    }
    
    // When the user swipes we want to show Edit and Delete actions
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            self.editCell(at: indexPath)
        })
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
//            self.datasetNames.remove(at: row)
//            self.datasetsTableView.reloadData()
        })
        
        return [deleteAction, editAction]
    }
    
    // Show alert which will allow to edit cell text
    func editCell(at indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "Edit Dataset name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.text = DataService.instance.datasetNames()[indexPath.row]
        })
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (updateAction) in
//            self.datasetNames[row] = alert.textFields!.first!.text!
//            self.datasetsTableView.reloadRows(at: [indexPath], with: .fade)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false)
    }
}
