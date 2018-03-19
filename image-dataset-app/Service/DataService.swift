//
//  DataService.swift
//  image-dataset-app
//
//  Created by Krzysztof Langner on 19/03/2018.
//  Copyright © 2018 Krzysztof Langner. All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    private var data = ["My Dataset", "Resitors", "Cars", "Fruits", "Vegetables"]
    private var currentDatasetNameData = "My Dataset"

    var currentDatasetName: String {
        get { return currentDatasetNameData }
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
    // Return name of the added dataset
    func addDataset(withName name: String) -> String {
        if data.contains(name) {
            let n = Int(arc4random_uniform(10))
            return addDataset(withName:"\(name)\(n)")
        } else {
            data.append(name)
            return name
        }
    }
}
