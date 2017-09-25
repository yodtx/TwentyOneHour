//
//  PreferencesViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 26.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class PreferencesViewController: UIViewController {

    @IBOutlet weak var popUpBut: UIBarButtonItem!
    
    @IBOutlet weak var labelView: UILabel!
    
    @IBOutlet weak var inChatButt: UIButton!
    
    @IBOutlet weak var preferOneText: UITextField!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        if revealViewController() != nil{
            popUpBut.target = self.revealViewController()
            popUpBut.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        self.labelView.text = "На тему"
        self.view.backgroundColor = .white
        inChatButt.backgroundColor = .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressInBut(_ sender: Any) {
        revealViewController().pushFrontViewController(ChatViewController(), animated: true)
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
