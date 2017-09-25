//
//  PopUpViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 24.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class PopUpViewController: UITableViewController {
    
    let menu = ["Профиль", "Знакомства", "Чат", "Сообщения", "Отклики", "Выход"]
    
    var tokenIdProfile: String!
    var idProfile: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fon
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "фон.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        self.tableView.register(ProfileCell.self, forCellReuseIdentifier: "ProfileCell")
        self.tableView.register(TimerCell.self, forCellReuseIdentifier: "TimerCell")
        self.tableView.register(PopUpWriteAllCell.self, forCellReuseIdentifier: "PopUpWriteAllCell")
        self.tableView.register(PopUpWriteAllPeopleCell.self, forCellReuseIdentifier: "PopUpWriteAllPeopleCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 21 //menu.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (true)
        {
        case (indexPath.row == 0):
            let cell = Bundle.main.loadNibNamed("ProfileCell", owner: self, options: nil)?.first as! ProfileCell
            cell.name.text = menu[indexPath.row]
            cell.backgroundColor = .clear
            return cell
        case (indexPath.row <= 5):
           let cell = Bundle.main.loadNibNamed("PopUpCell", owner: self, options: nil)?.first as! PopUpCell
           cell.name.text = menu[indexPath.row]
           cell.backgroundColor = .clear
            return cell
        case (indexPath.row == 6):
           let cell = Bundle.main.loadNibNamed("TimerCell", owner: self, options: nil)?.first as! TimerCell
           cell.name.text = "Написать всем"
           cell.backgroundColor = .clear
            return cell
        case (indexPath.row == 7):
            let cell = Bundle.main.loadNibNamed("PopUpWriteAllCell", owner: self, options: nil)?.first as! PopUpWriteAllCell
            cell.backgroundColor = .clear
           return cell
        default:
           let cell = Bundle.main.loadNibNamed("PopUpWriteAllPeopleCell", owner: self, options: nil)?.first as!
           PopUpWriteAllPeopleCell
           cell.backgroundColor = .clear
            return cell
        }
            
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row <= 4){
        let switchMenu = menu[indexPath.row]
        
        switch switchMenu {
        case "Профиль":
            revealViewController().pushFrontViewController(ProfileViewController(), animated: true)
        case "Знакомства":
            let meetViewController = MeetViewController()
            meetViewController.idProfile = self.idProfile
            meetViewController.tokenIdProfile = self.tokenIdProfile
            revealViewController().pushFrontViewController(meetViewController, animated: true)
        case "Чат":
            revealViewController().pushFrontViewController(PreferencesViewController(), animated: true)
        case "Сообщения":
            revealViewController().pushFrontViewController(ChatViewController(), animated: true)
        case "Отклики":
            revealViewController().pushFrontViewController(ReciprocityViewController(), animated: true)
        case "Выход":
            revealViewController().pushFrontViewController(EnterViewController(), animated: true)
        default:
            print("ОШИБКА")
                        }
        }
        
        if (indexPath.row >= 7)
        {
            revealViewController().pushFrontViewController(ProfileViewController(), animated: true)
        }
        
    }
    
    // animation
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * Double.pi / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 1, delay:  0.2, options: .curveEaseOut, animations: {
                cell.layer.transform = CATransform3DIdentity
        })
    }
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
