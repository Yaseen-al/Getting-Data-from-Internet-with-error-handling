//
//  ContactsViewController.swift
//  2017_11_28 Getting Data from Internet with error handling
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var mySearchBar: UISearchBar!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var errorHandlingLabel: UILabel!
 
    
    var contacts = [Contact](){
        didSet{
            myTableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contactSetup = contacts[indexPath.row]
        guard let cell: UITableViewCell = myTableView.dequeueReusableCell(withIdentifier: "myCell") else {
            let defaultCell = UITableViewCell()
            defaultCell.textLabel?.text = "\(contactSetup.name.first) \(contactSetup.name.last)"
            return defaultCell
        }
        if let contactCell = cell as? myCustomCellTableViewCell{
            contactCell.contactName.text = "\(contactSetup.name.first.capitalized) \(contactSetup.name.last.capitalized)"
            contactCell.contactAge.text = contactSetup.dob
            contactCell.cellPhone.text = contactSetup.cell
            contactCell.contactImage.image = nil // to avoid the flicker
            guard let imageURLStr = contactSetup.picture?.thumbnail else{
                return contactCell
            }
            let setImage: (UIImage)-> Void = {(imageFromURL: UIImage) in
                contactCell.contactImage.image = imageFromURL
            }
            
            ImageAPIClient.manager.getImage(from: imageURLStr, completionHandler: setImage, errorHandler: {print($0)})
            return contactCell
        }
        return cell
    }
    
    
    func loadData() {
        let URLStr = "https://randomuser.me/api/?results=100"
        
        let setContacts: ([Contact])->Void = {(onlineContacts: [Contact]) in
            self.contacts = onlineContacts
        }
        let errorHandler: (AppError)->Void = {(error: AppError) in
            switch error {
            case .couldNotParseJSON(rawError: let error):
                self.errorHandlingLabel.text = "JSONError; \(error)"
            case .noInternetConnection:
                self.errorHandlingLabel.text = "No Internet Connection"
            default:
                self.errorHandlingLabel.text = "other Error"
            }
        }
        
        ContactAPIClient.manager.getContacts(from: URLStr, completionHandler: setContacts, errorHandler:errorHandler)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mySearchBar.delegate = self
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        loadData()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailedContactViewController{
            let contactSetup = contacts[(myTableView.indexPathForSelectedRow?.row)!]
            destination.contact = contactSetup
        }
    }


}
