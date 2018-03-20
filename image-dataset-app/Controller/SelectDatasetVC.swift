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
    // Cache for dataset names
    var datasetNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasetsTableView.dataSource = self
        datasetsTableView.delegate = self
        loadDatasets()
    }
    
    func loadDatasets() {
        datasetNames = DataService.instance.datasetNames()
    }

    @IBAction func onCancel(_ sender: Any) {
        showDatasetImagesVC()
    }
    
    @IBAction func addNameTapped(_ sender: UIBarButtonItem) {
        editName(name: "New Dataset", updateHandler: {(name) in
            DataService.instance.addDataset(withName: name)
            self.showDatasetImagesVC()
        })
    }
    
    func selectDataset(withName name: String) {
        DataService.instance.currentDatasetName = name
        showDatasetImagesVC()
    }
    
    // Go back to main view controller
    func showDatasetImagesVC() {
        if let selectDatasetVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "datasetImagesId") as? DatasetImagesVC {
            present(selectDatasetVC, animated: false, completion: nil)
        }
    }
    
    // Show alert which will allow to edit cell text
    // Return true if name should be changed
    func editName(name: String, updateHandler: @escaping (String) -> ()) {
        let alert = UIAlertController(title: "", message: "Edit Dataset name", preferredStyle: .alert)
        alert.addTextField(configurationHandler: { (textField) in
            textField.text = name
        })
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (updateAction) in
            let name = alert.textFields!.first!.text!
            updateHandler(name)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false)
    }

    
}

extension SelectDatasetVC : UITableViewDataSource, UITableViewDelegate {

    // Number of items in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasetNames.count
    }

    // Show item
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datasetNameCell", for: indexPath)
        let name = datasetNames[indexPath.row]
        cell.textLabel?.text = name
        if name == DataService.instance.currentDatasetName {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    // When user taps on datset, then select it and go back to main VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = datasetNames[indexPath.row]
        DataService.instance.currentDatasetName = name
        showDatasetImagesVC()
    }
    
    // When the user swipes we want to show Edit and Delete actions
    // Delete is only shown if there is more then 1 row
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            self.editCell(at: indexPath)
        })
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            if DataService.instance.removeDataset(withName: self.datasetNames[indexPath.row]) {
                self.loadDatasets()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                self.datasetsTableView.reloadData()
            }
        })
        
        if datasetNames.count > 1 { return [deleteAction, editAction] }
        else { return [editAction] }
    }
    
    // Show alert which will allow to edit cell text
    func editCell(at indexPath: IndexPath) {
        let name = datasetNames[indexPath.row]
        editName(name: name, updateHandler: {(newName) in
            if DataService.instance.rename(oldName: name, newName: newName) {
                self.loadDatasets()
                self.datasetsTableView.reloadRows(at: [indexPath], with: .fade)
            }
        })
    }
}

