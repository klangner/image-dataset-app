//
//  DataService.swift
//  image-dataset-app
//
//  Created by Krzysztof Langner on 19/03/2018.
//  Copyright © 2018 Krzysztof Langner. All rights reserved.
//

import UIKit

class DataService {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let instance = DataService()
    
    private var data = ["My Dataset", "Resitors", "Cars", "Fruits", "Vegetables"]
    private var currentDatasetNameData = "My Dataset"

    var currentDatasetName: String {
        get {
            if data.contains(currentDatasetNameData) {
                return currentDatasetNameData
            } else if data.count > 0 {
                return data[0]
            } else {
                return "My Dataset"
            }
        }
        set { currentDatasetNameData = newValue }
    }
    
    // Return all dataset names
    func datasetNames() -> [String] {
        return data
    }
    
    // Remove dataset if possible.
    // There are some restrictions on this function:
    //  * name must exists
    //  * datset must be empty
    func removeDataset(withName name: String) -> Bool {
        if data.contains(name) {
            data = data.filter({(dataset) in dataset != name})
            return true
        } else {
            return false
        }
    }
    
    // Add new dataset.
    // If there is already dataset with the given name then add suffix to the name.
    func addDataset(withName name: String) {
        if data.contains(name) {
            addDataset(withName:"\(name)-COPY")
        } else {
            data.append(name)
            currentDatasetNameData = name
        }
    }
    
    // Rename dataset. This can be done only if there is no dataset with this name yet
    func rename(oldName: String, newName: String) -> Bool {
        guard let index = data.index(of: oldName) else { return false }
        
        if data.contains(newName) {
            return false
        } else {
            data[index] = newName
            return true
        }
    }
}
