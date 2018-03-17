//
//  DatasetNameCell.swift
//  image-dataset-app
//
//  Created by Krzysztof Langner on 17/03/2018.
//  Copyright © 2018 Krzysztof Langner. All rights reserved.
//

import UIKit

class DatasetNameCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
  
    func updateName(with name: String) {
        nameLabel.text = name
    }
}
