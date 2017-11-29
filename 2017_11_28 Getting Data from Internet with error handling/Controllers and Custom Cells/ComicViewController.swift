//
//  ComicViewController.swift
//  2017_11_28 Getting Data from Internet with error handling
//
//  Created by C4Q on 11/28/17.
//  Copyright © 2017 Quark. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {

    @IBOutlet weak var comicTextField: UITextField!
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicHeadline: UILabel!
    var myComic: Comic?{
        didSet{
            setLabels()
        }
    }
    var Counter = 0
    @IBAction func mostRecentButton(_ sender: UIButton) {
        loadData()
        setLabels()
    }
    @IBAction func randomComicButtone(_ sender: UIButton) {
        let randomNumber = Int(arc4random_uniform(650))
        let URLStr = "https://xkcd.com/\(randomNumber)/info.0.json"
        let setComic: (Comic)->Void = {(onlineComic: Comic) in
            self.myComic = onlineComic
        }
        let errorHandler: (AppError)->Void = {(error: AppError) in
            switch error {
            case .couldNotParseJSON(let error):
                self.comicHeadline.text = "JSONError; \(error)"
            case .noInternetConnection:
                self.comicHeadline.text = "No Internet connection"
            default:
                self.comicHeadline.text = "Other Error"
            }
        }
        ComicAPIClient.manager.getContacts(from: URLStr, completionHandler: setComic, errorHandler: errorHandler)
        setLabels()
        
    }

    @IBAction func commicStepper(_ sender: UIStepper) {
    }
    func setLabels() {
        comicHeadline.text = myComic?.title
        guard let safeImageURL = myComic?.img else {
            return
        }
        let setImage: (UIImage)->Void = {(onlineImage: UIImage) in
            self.comicImage.image = onlineImage
        }
        ImageAPIClient.manager.getImage(from: safeImageURL, completionHandler: setImage, errorHandler: {print($0)})
    }
    
    func loadData(){
        let URLStr = "https://xkcd.com/info.0.json"
        let setComic: (Comic)->Void = {(onlineComic: Comic) in
            self.myComic = onlineComic
        }
        let errorHandler: (AppError)->Void = {(error: AppError) in
            switch error {
            case .couldNotParseJSON(let error):
                self.comicHeadline.text = "JSONError; \(error)"
            case .noInternetConnection:
                self.comicHeadline.text = "No Internet connection"
            default:
                self.comicHeadline.text = "Other Error"
            }
        }
        ComicAPIClient.manager.getContacts(from: URLStr, completionHandler: setComic, errorHandler: errorHandler)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
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
