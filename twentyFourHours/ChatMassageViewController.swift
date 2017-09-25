//
//  ChatMassageViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 26.04.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit
import Alamofire

class ChatMassageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    var tokenIdProfile: String!
    var idProfile: String!
    
    var massages = [Massage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tokenIdProfile = DownloadDataManager.shared.tokenIdProfile
        self.idProfile = DownloadDataManager.shared.idProfile
        
        textField.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatMassageTableViewCell.self, forCellReuseIdentifier: "chatMassageCell")
        tableView.separatorStyle = .none
        
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = .clear
        
        // fon
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "фон2.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        self.tableView.backgroundColor = .clear
        
        // title label
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image2 = UIImage(named: "label2.png")
        imageView.image = image2
        navigationBar.topItem?.titleView = imageView
        
        if self.revealViewController() != nil
        {
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        initMassages()
        

        
        
        
        
        
//        let dict = ["profile_id" : "\(idProfile!)", "room_id" : "14"]
//        
//     Alamofire.request("https://datingservice.herokuapp.com/api/profiles/joinroom?access_token=\(tokenIdProfile!)", method: .post, parameters: dict, encoding: JSONEncoding.default)
//          .responseJSON { (response) in
//              if let JSON = response.result.value {
//                                print("JSON Room in : \(JSON)")
//        
//                        } else {
//                            print("Failure")
//                                print(response)
//                        }
//                }
//        
        
        
    
   
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
//            DispatchQueue.main.async(execute: { () -> Void in
//                print("------  -------  ------ ss ------  -------")
//                print(messageInfo)
//            })
//        }
//        
//    }
    
    
    
    
    
    // init massages
    
    fileprivate func initMassages()
    {
        let massage1 = Massage()
        massage1.massageText = "ёуу"
        massage1.massageId = false
        
        let massage2 = Massage()
        massage2.massageText = "привет."
        massage2.massageId = true
        
        let massage3 = Massage()
        massage3.massageText = "че кого ?"
        massage3.massageId = false
        
        let massage4 = Massage()
        massage4.massageText = "пока."
        massage4.massageId = true
        
        massages += [massage1, massage2, massage3, massage4]
    }
    
    // table view
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ChatMassageTableViewCell", owner: self, options: nil)?.first as! ChatMassageTableViewCell
        cell.massageLabel.text = massages[indexPath.row].massageText
        
        cell.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        
        if massages[indexPath.row].massageId == true
        {
            cell.massageLabel.textAlignment = .right
            cell.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        }
        
        return cell
    }
    
    // action
    
    func keyboardNotification(notification: NSNotification)
    {
        if let userInfo = notification.userInfo{
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    func pressSend()
    {
        textField.resignFirstResponder()
        
        
        
        
        if let text = textField.text
        {
            let massageToSend = Massage()
            massageToSend.massageId = true
            massageToSend.massageText = text
            massages.append(massageToSend)
        
        
        let dict = ["profile_id" : "\(idProfile!)", "message" : "\(text)"]
        
        Alamofire.request("https://datingservice.herokuapp.com/api/rooms/24/sendmessage?access_token=\(tokenIdProfile!)", method: .post, parameters: dict, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    print("JSON Room in : \(JSON)")
                    
                } else {
                    print("Failure")
                    print(response)
                }
            }
            
            
            tableView.reloadData()
            textField.text = ""
        }
        
    }
    
    @IBAction func pressSendBut(_ sender: Any) {
        pressSend()
    }
    
    // text field delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pressSend()
        return true
    }
    
    @IBAction func pressBackBut(_ sender: Any) {
        revealViewController().pushFrontViewController(ChatViewController(), animated: true)
    }
}
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        revealViewController().pushFrontViewController(ChatMassageViewController(), animated: true)
//    }
//    
//     height cell
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
//    
//
//    /*
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
//    }
//    */
//    
//     websocket chat
//    
//    func downloadChat()
//    {
//        
//
//        let hostUrl = NSURL(string:"http://IP_или_домен:ПОРТ")! //тут указываем адрес подключения
//        let tokenSDK = self.tokenIdProfile! //тут токен если есть
//        let socket = SocketIOClient(socketURL: hostUrl, config: ["log": false,
//                                                                  "reconnects": true,
//                                                                  "reconnectAttempts": 1,
//                                                                  "reconnectWait": 1,
//                                                                  "connectParams": ["token":tokenSDK]]) // тут задаем параметры передачи данных
//        
//        
//        let huelet = SocketIOClient(socketURL: <#T##NSURL#>, config: <#T##NSDictionary?#>)
//        
//        socket.on("connect") {data,ack in
//            
//            let paginav = ""
//            
//            socket.emitWithAck("ВАШЕ_СОБЫТИЕ", paginav)(timeoutAfter: 0)
//            {data in
//                
//                let dataTickets = data[1]["result"] as! NSArray // парсим json который пришел
//                let howMuchTickets = dataTickets.valueForKey("name")
//                
//                
//                for (var i=0; i < howMuchTickets.count; i++){
//                    let ticketName = dataTickets[i].valueForKey("name") as? String
//                    self.arrayOfTickets.append(ticketName!) // заполняем массив тикетов
//                }
//                
//                socket.emitWithAck("ВАШЕ_СОБЫТИЕ", <#T##items: SocketData...##SocketData#>)
//                
//            }
//    }
//        
//        socket.connect()
//
//}

class Massage
{
    var massageText: String!
    var massageId: Bool!
}
