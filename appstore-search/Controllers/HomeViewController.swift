//
//  ViewController.swift
//  appstore-search
//
//  Created by Nandika on 10/2/18.
//  Copyright © 2018 SLIIT. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchValue : String = ""
    var softwares = [Software]()
    var isSearching : Bool = false
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView()
    var selectedSoftware : Software!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SoftwareCell", bundle: nil), forCellReuseIdentifier: "softwareCell")
        tableView.separatorColor = UIColor.clear
        tableView.rowHeight = 76
        searchBar.delegate = self
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //NO
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchValue = searchText
        
        if searchValue.count >= 3 {
            isSearching = true
            activityIndicator.startAnimating()
            HttpHelper.shared().getRequest(seachValue: searchValue, completion: fetchDataFromApi)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Custom delay to smoothen the real-time searching
        }
    }
    
    func fetchDataFromApi(isSuccess : Bool, fetchSoftwares : [Software]) {
        
        if isSuccess {
            isSearching = false
            softwares = fetchSoftwares
            tableView.reloadData()
        } else {
            isSearching = false
            print("error")
        }
        activityIndicator.stopAnimating()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        tableView.backgroundView = nil
            if softwares.count == 0 {
                TableViewHelper.EmptyMessage("search using search bar !", view: tableView)
                return 0
            } else {
                return 1
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return softwares.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "softwareCell", for: indexPath) as? SoftwareCell
        let software = softwares[indexPath.row]
        cell?.appName.text = software.name
        cell?.appCompanyName.text = software.companyName
        let imageData = try! Data(contentsOf : URL(string: software.appIconURL)!)
        cell?.imageView?.image = UIImage(data: imageData)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSoftware = softwares[indexPath.row]
        performSegue(withIdentifier: "showModal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showModal" {
            if let dvc = segue.destination as? ModalViewController {
                dvc.selectedSoftware = selectedSoftware
            }
        }
    }
}

//Converts Hex ---> UIColor
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

