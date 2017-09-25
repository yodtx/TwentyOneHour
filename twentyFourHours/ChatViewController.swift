//
//  ChatViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 24.04.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit
import Alamofire

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var popUpBut: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    var tokenIdProfile: String!
    var idProfile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tokenIdProfile = DownloadDataManager.shared.tokenIdProfile
        self.idProfile = DownloadDataManager.shared.idProfile
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: "chatCell")

        //fon
        self.tableView.backgroundColor = .clear
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
    
    
    // table view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ChatTableViewCell", owner: self, options: nil)?.first as! ChatTableViewCell
        cell.nameLabel.text = "person \(indexPath.row)"
        cell.lastMassageLabel.text = "this is text numbet \(indexPath.row)"
        cell.timeLabel.text = "4:20"
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
//        self.revealViewController().pushFrontViewController(ChatMassageViewController(), animated: true)

        let dict = ["profile_id" : 74]
        
        Alamofire.request("https://datingservice.herokuapp.com/api/profiles/\(idProfile!)/chat?access_token=\(tokenIdProfile!)", method: .post, parameters: dict, encoding: JSONEncoding.default)
                .responseJSON { (response) in
                    if let JSON = response.result.value {
                        print("JSON Room init : \(JSON)")
       
                        self.revealViewController().pushFrontViewController(ChatMassageViewController(), animated: true)
                } else {
                    print("Failure")
                        print(response)
                }
        }
        
    }
    
    // height cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
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
