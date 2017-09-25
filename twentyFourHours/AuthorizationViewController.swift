//
//  AuthorizationViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 05.04.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit
import Alamofire

class AuthorizationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // fon
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "фон.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        loginTextField.text = "013"
        passTextField.text = "013"
        
        // hide keyboard
        
        loginTextField.delegate = self
        loginTextField.resignFirstResponder()
        passTextField.delegate = self
        passTextField.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // next button
    // паралелить 
    @IBAction func pressEnterBut(_ sender: Any) {
        
        
        
        let autorizationParam = ["username": "\(loginTextField.text!)", "password": "\(passTextField.text!)"]
        
        Alamofire.request("https://datingservice.herokuapp.com/api/profiles/login", method: .post, parameters: autorizationParam, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    print("JSONER: \(JSON)")
                    
                    var loginInfo = [String]()
                    
                    
                    let infoArr = JSON as! NSDictionary
                    
//                    if let test = infoArr["id"] as? String {
                        let id = (infoArr["id"] as? String)!
                        loginInfo.append(id)
//                    }else{
//                       let tags="ERROR LOGIN ALAMOFIRE"
//                        print(tags)
//                    }
                    
//                    if let test = infoArr["userId"] as? Int {
                        let userId = (infoArr["userId"] as? Int)!
                        loginInfo.append(String(userId))
//                    }else{
//                        let tags="ERROR LOGIN ALAMOFIRE"
//                        print(tags)
//                    }
                    
//                    if let test = infoArr["ttl"] as? Int {
                        let ttl = (infoArr["ttl"] as? Int)!
                        loginInfo.append(String(ttl))
//                    }else{
//                        let tags="ERROR LOGIN ALAMOFIRE"
//                        print(tags)
//                    }
                    
                    
//                    self.revealViewController().rearViewController.tokenIdProfile = loginInfo[0]
                    
                    DownloadDataManager.shared.tokenIdProfile = loginInfo[0]
                    DownloadDataManager.shared.idProfile = loginInfo[1]

                    
//                    let profileView = ProfileViewController()
//                    profileView.tokenIdProfile = loginInfo[0]
//                    profileView.idProfile = loginInfo[1]
//                   // profileView.initAutorization()
                    
                    
                    
                    
                    self.revealViewController().pushFrontViewController(ProfileViewController(), animated: true)
                } else {
                    print("Failure")
                }
        }
        
        
        
        
 //       autorizationAlamofire()
        
    }
    
    // hide keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        passTextField.resignFirstResponder()
        return(true)
    }
    
    
    
    
    
    
    
    // alamofire autorization
    
//    func autorizationAlamofire()
//    {
//        let autorizationParam = ["username": "\(loginTextField.text!)", "password": "\(passTextField.text!)"]
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/profiles/login", method: .post, parameters: autorizationParam, encoding: JSONEncoding.default)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSONER: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
