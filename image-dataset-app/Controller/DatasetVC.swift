//
//  ViewController.swift
//  image-dataset-app
//
//  Created by Krzysztof Langner on 16/03/2018.
//  Copyright © 2018 Krzysztof Langner. All rights reserved.
//

import UIKit

class DatasetVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // Switch to the view which will take new picture
    @IBAction func takePictureTapped(_ sender: Any) {
        print("Take picture")
    }
    
    @IBAction func selectDatasetTapped(_ sender: Any) {
        if let popupVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "datasetsPopup") as? DatasetsPopupVC {
            self.addChildViewController(popupVC)
            popupVC.view.frame = view.frame
            view.addSubview(popupVC.view)
            popupVC.didMove(toParentViewController: self)
        }
    }
    
}

