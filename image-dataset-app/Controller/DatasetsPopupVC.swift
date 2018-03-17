//
//  SelectDatasetVCViewController.swift
//  image-dataset-app
//
//  Created by Krzysztof Langner on 17/03/2018.
//  Copyright © 2018 Krzysztof Langner. All rights reserved.
//

import UIKit

class DatasetsPopupVC: UIViewController {

    @IBOutlet weak var datasetsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasetsTableView.dataSource = self
        datasetsTableView.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closePopup()
    }
    
    func closePopup() {
        view.removeFromSuperview()
    }
}

extension DatasetsPopupVC : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "datasetNameCell", for: indexPath) as? DatasetNameCell {
            cell.updateName(with: "Dataset name")
            return cell
        } else {
            return DatasetNameCell()
        }
    }
}

