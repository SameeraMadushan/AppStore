//
//  ModalViewController.swift
//  appstore-search
//
//  Created by Nandika on 10/4/18.
//  Copyright © 2018 SLIIT. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var softwareName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var softwareType: UILabel!
    @IBOutlet weak var softwareGenre: UILabel!
    @IBOutlet weak var isFreelabel: UILabel!
    @IBOutlet weak var popupView: UIView!
    
    var selectedSoftware : Software!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 10
//        imageView.image = UIImage(data: selectedSoftware.appIcon)
        
        let imageData = try! Data(contentsOf : URL(string: selectedSoftware.appIconURL)!)
        imageView.image = UIImage(data: imageData)
        
        softwareName.text = selectedSoftware.name
        companyName.text = selectedSoftware.companyName
        softwareType.text = selectedSoftware.type
        softwareGenre.text = selectedSoftware.genre
        isFreelabel.text = " " + selectedSoftware.formattedPrice + " "
        isFreelabel.layer.borderWidth = 1
        isFreelabel.layer.borderColor = UIColor(hexString: "#0FC0BF").cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: false, completion: nil)
    }
}
