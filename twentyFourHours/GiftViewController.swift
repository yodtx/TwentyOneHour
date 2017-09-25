//
//  GiftViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 30.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit

class GiftViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var popUpBut: UIBarButtonItem!
    
    @IBOutlet weak var collectionViewOne: UICollectionView!
    @IBOutlet weak var collectionViewTwo: UICollectionView!
    @IBOutlet weak var collectionViewThree: UICollectionView!
    
    let imageArray = [UIImage(named:"1"),  UIImage(named:"2"), UIImage(named:"3"), UIImage(named:"4"), UIImage(named:"5"), UIImage(named:"6")]
    let nameArray = ["Шарики","Букет","Подарок","Подарок","Торт","Пес"]
    let priceArray = ["10","20","30","40","50","60"]
    
    
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
        
        
        
        if revealViewController() != nil
        {
            popUpBut.target = self.revealViewController()
            popUpBut.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }

        let nibs = UINib(nibName: "GiftCellView", bundle: nil)
        
        // first collection view
        collectionViewOne.register(GiftCellView.self, forCellWithReuseIdentifier: "CellCollection")
        collectionViewOne.register(nibs, forCellWithReuseIdentifier: "CellCollection")
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        collectionViewOne.backgroundColor = .clear
        
        // second collection view
        collectionViewTwo.register(GiftCellView.self, forCellWithReuseIdentifier: "CellCollection")
        collectionViewTwo.register(nibs, forCellWithReuseIdentifier: "CellCollection")
        collectionViewTwo.delegate = self
        collectionViewTwo.dataSource = self
        collectionViewTwo.backgroundColor = .clear
        
        // third collection view                       // kakogo x?
        collectionViewThree.register(GiftCellView.self, forCellWithReuseIdentifier: "CellCollection")
        collectionViewThree.register(nibs, forCellWithReuseIdentifier: "CellCollection")
        collectionViewThree.delegate = self
        collectionViewThree.dataSource = self
        collectionViewThree.backgroundColor = .clear
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.collectionViewOne.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as! GiftCellView
        cell.backgroundColor = .white
        cell.cellImage.image = imageArray[indexPath.row]
        cell.cellName.text = nameArray[indexPath.row]
        cell.cellPrice.text = priceArray[indexPath.row]
        cell.backgroundColor = .clear
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // нажатие на ячейку
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
