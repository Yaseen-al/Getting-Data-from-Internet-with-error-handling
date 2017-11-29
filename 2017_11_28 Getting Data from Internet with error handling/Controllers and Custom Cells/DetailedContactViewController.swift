//
//  DetailedContactViewController.swift
//  2017_11_28 Getting Data from Internet with error handling
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class DetailedContactViewController: UIViewController {
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactAge: UILabel!
    @IBOutlet weak var contactLocation: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    var contact: Contact? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let contact = contact{
            contactName.text = "\(contact.name.first.capitalized) \(contact.name.last.capitalized)"
            contactAge.text = contact.dob
            contactLocation.text = "\(contact.location.city), \(contact.location.state)"
            contactPhoneNumber.text = "Cell: \(contact.cell), Phone: \(contact.phone)"
            guard let imageURLStr = contact.picture?.large else{
                return
            }
            let setImage: (UIImage)-> Void = {(imageFromURL: UIImage) in
                self.contactImage.image = imageFromURL
            }
            ImageAPIClient.manager.getImage(from: imageURLStr, completionHandler: setImage, errorHandler: {print($0)})
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
