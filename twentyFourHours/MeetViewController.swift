//
//  MeetViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 24.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit
import Alamofire

class MeetViewController: UIViewController {

    @IBOutlet weak var popUpBut: UIBarButtonItem!
//    @IBOutlet weak var reLog: UIBarButtonItem!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var no: UIButton!
    @IBOutlet weak var gift: UIButton!
    @IBOutlet weak var okey: UIButton!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var tokenIdProfile: String!
    var idProfile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tokenIdProfile = DownloadDataManager.shared.tokenIdProfile
        self.idProfile = DownloadDataManager.shared.idProfile
        
        
        
        // fon
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "фон2.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        // title label
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = .clear
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image2 = UIImage(named: "label2.png")
        imageView.image = image2
        navigationBar.topItem?.titleView = imageView
        
        
        
        
        
        
        
        
        
        Alamofire.request("https://datingservice.herokuapp.com/api/profiles/\(idProfile!)/dating?access_token=\(tokenIdProfile!)", method: .get)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    print("Profile Json: \(JSON)")
                    
                } else {
                    print("Failure")
                }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        photo.backgroundColor = .black

        if revealViewController() != nil{
            popUpBut.target = self.revealViewController()
            popUpBut.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressYes(_ sender: Any) {
        if photo.backgroundColor == .black
        {
        photo.backgroundColor = .red
        } else{
        photo.backgroundColor = .black
        }
    }
    
    @IBAction func pressNo(_ sender: Any) {
        if photo.backgroundColor == .black
        {
            photo.backgroundColor = .green
        } else{
            photo.backgroundColor = .black
        }
    }
    
    @IBAction func pressGifts(_ sender: Any) {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        
        //let giftsController = GiftsViewController(collectionViewLayout: layout)
        revealViewController().pushFrontViewController(GiftViewController(), animated: true)
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
