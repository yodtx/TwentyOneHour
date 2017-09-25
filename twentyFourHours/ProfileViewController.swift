//
//  ProfileViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 24.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var statInfo: UILabel!
    @IBOutlet weak var popUpBut: UIBarButtonItem!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var giftsCollectionView: UICollectionView!
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var tokenIdProfile: String!
    var idProfile: String!
    
    var dtoRegister: DTORegistration!
    var profileDto: DTOProfileInfo!
    var profileDtoEdit: DTOProfileInfo!
    
    let imageArray = [UIImage(named:"1"),  UIImage(named:"2"), UIImage(named:"3"), UIImage(named:"4"), UIImage(named:"5"), UIImage(named:"6")]
    let nameArray = ["Шарики","Букет","Подарок","Подарок","Торт","Пес"]
    let priceArray = ["10","20","30","40","50","60"]
    let photoArray = ["devushka-lico-voda-glaza.jpg", "devushka-bryunetka-ten-profil.jpg", "elza-hosk-elsa-hosk-model.jpg"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tokenIdProfile = DownloadDataManager.shared.tokenIdProfile
        self.idProfile = DownloadDataManager.shared.idProfile
        
        SocketIOManager.sharedInstance.subscribe(room : "profile\(idProfile!)")

        
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
        
        
        
        
            // title label
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
            imageView.contentMode = .scaleAspectFit
            let image2 = UIImage(named: "label2.png")
            imageView.image = image2
            navigationBar.topItem?.titleView = imageView
        
        
        
        if self.revealViewController() != nil
        {
            self.popUpBut.target = self.revealViewController()
            self.popUpBut.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        Alamofire.request("https://datingservice.herokuapp.com/api/profiles/\(idProfile!)?access_token=\(tokenIdProfile!)", method: .get)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    print("Profile Json: \(JSON)")
                    
                    let infoArr = JSON as! NSDictionary
                    
                    let name = (infoArr["name"] as? String)!
                    let sex = (infoArr["gender_id"] as? Int)!
                    let iMeetSex = (infoArr["meet_sex_id"] as? Int)!
                    let town = (infoArr["city_id"] as? Int)!
                    let age = (infoArr["bdate"] as? Int)!
                    
//                    let sexPrefer = (infoArr["id"] as? String)!
                    let bodyType = (infoArr["body_type_id"] as? Int)!
                    let height = (infoArr["height"] as? Int)!
                    let weight = (infoArr["weight"] as? Int)!
//                    let aboutMe = (infoArr["about"] as? String)!
                    
//                    let photo = (infoArr["id"] as? String)!
                    let hair = (infoArr["hair_color_id"] as? Int)!
                    let eyes = (infoArr["eyes_color_id"] as? Int)!
//                    let exications = (infoArr["exications"] as? String)!
 //                   let disgust = (infoArr["disgust"] as? String)!
                    
//                    let gifts = (infoArr["id"] as? String)!
                    let materialSupport = (infoArr["material_support_id"] as? Int)!
                    let attitudesAlcohol = (infoArr["alcohol_attitude_id"] as? Int)!
                    let attitudesSmoke = (infoArr["smoke_attitude_id"] as? Int)!
                    let rating = (infoArr["rating"] as? Int)!
                    
                    
//                    let meetigPoint = (infoArr["meetig_point_id"] as? Int)!
                    let tatoo = (infoArr["has_tatoo"] as? Bool)!
                    
                    
                self.profileDto =  DTOProfileInfo(name: "\(name)", sex: "\(sex)", iMeetSex: "\(iMeetSex)", town: "\(town)", age: Int(age), sexPrefer: "вававава", bodyType: "\(bodyType)", height: Double(height), weight: Double(weight), aboutMe: "dfsdfsd", photo: "devushka-lico-voda-glaza.jpg", hair: "\(hair)", eyes: "\(eyes)", langueges: "Английский, Японский",  size: 45.0, exications: "hghgh", disgust: "jjhgf", gifts: "подарки...", materialSupport: "\(materialSupport)", attitudesAlcohol: "\(attitudesAlcohol)", attitudesSmoke: "\(attitudesSmoke)", rating: Double(rating), meetigPoint: "hhjhjhj", tatoo:tatoo)
                    
                    self.statInfo.text = "Рейтинг: 100, Статус: Нищий"
                    
                    
                    // collection gifts view
                    
                    let nibs = UINib(nibName: "GiftCellView", bundle: nil)
                    
                    self.giftsCollectionView.register(GiftCellView.self, forCellWithReuseIdentifier: "CellCollection")
                    self.giftsCollectionView.register(nibs, forCellWithReuseIdentifier: "CellCollection")
                    self.giftsCollectionView.delegate = self
                    self.giftsCollectionView.dataSource = self
                    self.giftsCollectionView.backgroundColor = .clear
                    
                    // collection photo
                    
                    let nib = UINib(nibName: "PhotoProfileCollectionCell", bundle: nil)
                    
                    self.photoCollection.register(PhotoProfileCollectionCell.self, forCellWithReuseIdentifier: "PhotoCell")
                    self.photoCollection.register(nib, forCellWithReuseIdentifier: "PhotoCell")
                    self.photoCollection.delegate = self
                    self.photoCollection.dataSource = self
                    self.giftsCollectionView.backgroundColor = .clear
                    
                    
                    
                    
                    
                    
                    self.initProfile(dtoTwo: self.profileDto)
                    
                    if (self.profileDtoEdit != nil)
                    {
                        self.initProfile(dtoTwo: self.profileDtoEdit)
                    }
                    
                    if (self.dtoRegister != nil)
                    {
                        self.initRegistration(dto: self.dtoRegister)
                    }
                    
                } else {
                    print("Failure")
                }
        }
        
        
        
//        self.profileDto =  DTOProfileInfo(name: "Антон", sex: "M", iMeetSex: "Традиционный", town: "Москва", age: 27, sexPrefer: "Адские", bodyType: "Атлетическое", height: 150, weight: 160, aboutMe: "Я такой то такой то", photo: "devushka-lico-voda-glaza.jpg", hair: "Светлые", eyes: "Голубые", langueges: "Английский, Японский", size: 30, exications: "Красивые", disgust: "Уродливые", gifts: "подарки...", materialSupport: "Хочу найти спонсра", attitudesAlcohol: "Негативное", attitudesSmoke: "Позитивное", rating: 100, meetigPoint: "Есть", tatoo: true)
    
        
        
        
        
//        if revealViewController() != nil
//        {
//        popUpBut.target = self.revealViewController()
//        popUpBut.action = #selector(SWRevealViewController.revealToggle(_:))
//        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
//        }
//        
//        // collection gifts view
//        
//        let nibs = UINib(nibName: "GiftCellView", bundle: nil)
//
//        giftsCollectionView.register(GiftCellView.self, forCellWithReuseIdentifier: "CellCollection")
//        giftsCollectionView.register(nibs, forCellWithReuseIdentifier: "CellCollection")
//        giftsCollectionView.delegate = self
//        giftsCollectionView.dataSource = self
//        giftsCollectionView.backgroundColor = .white
//        
//        // collection photo
//        
//        let nib = UINib(nibName: "PhotoProfileCollectionCell", bundle: nil)
//        
//        photoCollection.register(PhotoProfileCollectionCell.self, forCellWithReuseIdentifier: "PhotoCell")
//        photoCollection.register(nib, forCellWithReuseIdentifier: "PhotoCell")
//        photoCollection.delegate = self
//        photoCollection.dataSource = self
        
        
        // test test test
        
//        self.profileDto =  DTOProfileInfo(name: "Антон", sex: "M", iMeetSex: "Традиционный", town: "Москва", age: 27, sexPrefer: "Адские", bodyType: "Атлетическое", height: 150, weight: 160, aboutMe: "Я такой то такой то", photo: "devushka-lico-voda-glaza.jpg", hair: "Светлые", eyes: "Голубые", langueges: "Английский, Японский", size: 30, exications: "Красивые", disgust: "Уродливые", gifts: "подарки...", materialSupport: "Хочу найти спонсра", attitudesAlcohol: "Негативное", attitudesSmoke: "Позитивное", rating: 100, meetigPoint: "Есть", tatoo: true)
        
//        initProfile(dtoTwo: profileDto)
//        
//        if (profileDtoEdit != nil)
//        {
//        initProfile(dtoTwo: profileDtoEdit)
//        }
//        
//        if (dtoRegister != nil)
//        {
//            initRegistration(dto: dtoRegister)
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initProfile(dtoTwo: DTOProfileInfo){
        
        //self.image.image = UIImage(named: "\(dtoTwo.photo!)")
        
        var tatoo = ""
        
        if (dtoTwo.tatoo == true){
         tatoo = "Есть"
        }else{
         tatoo = "Нету"
        }
        
        
        self.infoTextView.text = " Имя:  \(dtoTwo.name!) \n\n Пол: \(dtoTwo.sex!) \n\n Предпочтения: \(dtoTwo.iMeetSex!) \n\n Город: \(dtoTwo.town!) \n\n Возраст: \(dtoTwo.age!) \n\n Секс предпочтения: \(dtoTwo.sexPrefer!) \n\n Телосложение: \(dtoTwo.bodyType!) \n\n Рост: \(dtoTwo.height) \n\n Вес: \(dtoTwo.weight!) \n\n Обо мне: \(dtoTwo.aboutMe!) \n\n Волосы: \(dtoTwo.hair!) \n\n Глаза: \(dtoTwo.eyes!) \n\n Языки: \(dtoTwo.langueges!) \n\n Размер: \(dtoTwo.size!) \n\n Меня возбуждает: \(dtoTwo.exications) \n\n Меня отталкивает: \(dtoTwo.disgust!) \n\n Мои подарки: \(dtoTwo.gifts!) \n\n Достаток: \(dtoTwo.materialSupport!) \n\n Отношение к курению: \(dtoTwo.attitudesSmoke!) \n\n Отношение к алкоголю: \(dtoTwo.attitudesAlcohol!) \n\n Рейтинг: \(dtoTwo.rating!) \n\n Место для встречи: \(dtoTwo.meetingPoint!) \n\n Тату: \(tatoo)"
        
    }
    
    func initRegistration(dto: DTORegistration)
    {
        self.infoTextView.text = " Имя:  \(dto.name!) \n\n Пол: \(dto.sex!) \n\n Предпочтения: \(dto.iMeetSex!) \n\n Город: \(dto.town!) \n\n Возраст: \(dto.age!) \n\n Секс предпочтения: \(dto.sexPrefer!) \n\n Телосложение: \(dto.bodyType!) \n\n Рост: \(dto.height!) \n\n Вес: \(dto.weight!) \n\n Обо мне: \(dto.aboutMe!)"
   //     print("\(dto.name!)")
    }
    
    @IBAction func pressEdit(_ sender: Any) {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.editDTO = self.profileDto
//        editProfileViewController.tokenIdProfile = self.tokenIdProfile
//        editProfileViewController.idProfile = self.idProfile
        revealViewController().pushFrontViewController(editProfileViewController, animated: true)
    }
    
    
    // collection gifts view
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == giftsCollectionView){
            return 6
        }else{
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == giftsCollectionView){
            let cell = self.giftsCollectionView.dequeueReusableCell(withReuseIdentifier: "CellCollection", for: indexPath) as! GiftCellView
            cell.backgroundColor = .white
            cell.cellImage.image = imageArray[indexPath.row]
            cell.cellName.text = nameArray[indexPath.row]
            cell.cellPrice.text = priceArray[indexPath.row]
            cell.backgroundColor = .clear
            
            return cell
        }else{
            let cell = self.photoCollection.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoProfileCollectionCell
            switch (indexPath.row)
            {
            case 0:
            cell.photoImage.image = UIImage(named: photoArray[indexPath.row])
            case 1:
            cell.photoImage.image = UIImage(named: photoArray[indexPath.row])
            case 2:
            cell.photoImage.image = UIImage(named: photoArray[indexPath.row])
            default:
            cell.backgroundColor = .yellow
            }
            cell.backgroundColor = .clear
            return cell
        }

        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // нажатие на ячейку
    }
    
    // Up Raiting Button
    
    @IBAction func UpRaitingButton(_ sender: Any) {
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
