//
//  EnterViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 24.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class EnterViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // fon
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "фон.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressButEnter(_ sender: Any) {
        revealViewController().pushFrontViewController(AuthorizationViewController(), animated: true)
    }
    
    @IBAction func pressButRegistr(_ sender: Any) {
        revealViewController().pushFrontViewController(RegistrationViewController(), animated: true)
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
