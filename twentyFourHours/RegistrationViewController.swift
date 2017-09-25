//
//  RegistrationViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 25.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit
import PCLBlurEffectAlert
import Alamofire
import SwiftyJSON

class RegistrationViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var inputAnswer: UITextField!
    @IBOutlet weak var inputTwoPass: UITextField!
    @IBOutlet weak var nextStep: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var importPhoto: UIButton!
    
    var genderDict = [String:String]()
    var meetsextDict = [String:String]()
    var cityDict = [String:String]()
    var bodyTypeDict = [String:String]()
    
    var step: Int = 1
    var dtoRegister = DTORegistration()
    var pickerArray = ["1", "2", "3", "4"]
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // fon
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "фон.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)

        
        
        
        
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "фон.png")!)
        
        
//        registrationOnServer()        // загружать дату в unix секундах
        
        self.inputAnswer.text = "1"
        
//        DownloadDataManager().DownloadPickerAlcooholAttitudes()
//         DownloadDataManager().DownloadPickerHair()
//         DownloadDataManager().DownloadPickerSex()
//         DownloadDataManager().DownloadPickerEyes()
//         DownloadDataManager().DownloadPickerCities()
//         DownloadDataManager().DownloadPickerIMeetSex()
//         DownloadDataManager().DownloadPickerBodyTypes()
//         DownloadDataManager().DownloadPickerSexPrefer()
//         DownloadDataManager().DownloadPickerMeetingPoints()
//         DownloadDataManager().DownloadPickerSmokeAttitudes()
//         DownloadDataManager().DownloadPickerMaterialSupport()
        
       // DownloadPickerHair()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        stepOne()
        
        // hide keyboard
        
        inputAnswer.delegate = self
        inputAnswer.resignFirstResponder()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // hide alert if textfield == nil
    
    func showAlert(title: String, message: String)
    {
        let alert = PCLBlurEffectAlert.Controller(title: title, message: message, effect: UIBlurEffect(style: .dark), style: .alert)
        let alertBut = PCLBlurEffectAlert.Action(title: "Ok", style: .cancel , handler: nil)
         alert.addAction(alertBut)
        
        alert.configure(titleColor: .red)
        alert.configure(cornerRadius: 30)
        alert.configure(overlayBackgroundColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pressNextBut(_ sender: Any) {
        // !inputAnswer.isEmpty
        
        if (self.inputAnswer.text == "")
        {
            showAlert(title: "Ошибка", message: "Заполните поле")
        }else{
            
            self.step += 1
            
            switch step {
            case 2:
                stepTwo()
            case 3:
                stepThree()
            case 4:
                stepFour()
            case 5:
                stepFive()
            case 6:
                stepSix()
            case 7:
                stepSeven()
            case 8:
                stepEight()
            case 9:
                stepNine()
            case 10:
                stepTen()
            case 11:
                stepFEleven()
            case 12:
                stepTwelve()
            case 13:
                stepThirteen()
            default:
                stepFinish()
            }
        }

    }
    
    // registration in dto for push in the server
    
    func stepOne(){
            self.photoView.isHidden = true
            self.importPhoto.isHidden = true
            self.inputTwoPass.isHidden = true
            self.pickerView.isHidden = true
            self.question.text = "Как тебя зовут ?"
    }
    
    func stepTwo(){
        pickerView.reloadAllComponents()
        self.pickerView.isHidden = true
        
        dtoRegister.name = self.inputAnswer.text!
        self.inputAnswer.text = ""
        self.question.text = "Твой пол ?"
        self.activityIndicatorStart()
        
        Alamofire.request("https://datingservice.herokuapp.com/api/genders", method: .get)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    //print("JSON Genders: \(JSON)")
                    var pickerArrayColorHair = [String]()
                    
                    let info = JSON as! NSArray
                    for i in 0..<(JSON as! NSArray).count
                    {
                        let dict = info[i] as! NSDictionary
                        self.genderDict["\(dict["name"]!)"] = "\(dict["id"]!)"
//                        print("id   --- \(dict["id"]!)")
//                        print("name --- \(dict["name"]!)")
                        pickerArrayColorHair.append(dict["name"]! as! String)
                    }
                    self.pickerArray = pickerArrayColorHair
                    pickerArrayColorHair = []
                    
                    self.pickerView.isHidden = false
                    
                    self.pickerView.reloadAllComponents()
                    self.activityIndicatorStop()
                } else {
                    print("Failure")
                }
        }
    }
    
    
    func stepThree(){
        self.pickerView.isHidden = true
        dtoRegister.sex = Int(genderDict["\(self.inputAnswer.text!)"]!)
        
        self.inputAnswer.text = ""
        self.question.text = "Я ищу"
        
        Alamofire.request("https://datingservice.herokuapp.com/api/meet_sexes", method: .get)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                   // print("JSON i meet sex: \(JSON)")
                    var pickerArrayColorHair = [String]()
                    
                    let info = JSON as! NSArray
                    for i in 0..<(JSON as! NSArray).count
                    {
                        let dict = info[i] as! NSDictionary
                        self.meetsextDict["\(dict["name"]!)"] = "\(dict["id"]!)"
//                        print("id   --- \(dict["id"]!)")
//                        print("name --- \(dict["name"]!)")
                        pickerArrayColorHair.append(dict["name"]! as! String)
                    }
                    self.pickerArray = pickerArrayColorHair
                    
                    self.pickerView.isHidden = false
                    
                    self.pickerView.reloadAllComponents()
                    self.activityIndicatorStop()
                } else {
                    print("Failure")
                }
        }
        
    }
    
    func stepFour(){
        self.pickerView.isHidden = true
        dtoRegister.iMeetSex = Int(meetsextDict["\(self.inputAnswer.text!)"]!)
        self.inputAnswer.text = ""
        self.question.text = "Откуда ты ?"
        
        
        Alamofire.request("https://datingservice.herokuapp.com/api/cities", method: .get)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                   // print("JSON cities: \(JSON)")
                    var pickerArrayColorHair = [String]()
                    
                    let info = JSON as! NSArray
                    for i in 0..<(JSON as! NSArray).count
                    {
                        let dict = info[i] as! NSDictionary
                        self.cityDict["\(dict["title"]!)"] = "\(dict["id"]!)"
//                        print("id   --- \(dict["id"]!)")
//                        print("title --- \(dict["title"]!)")
                        pickerArrayColorHair.append(dict["title"]! as! String)
                    }
                    self.pickerArray = pickerArrayColorHair
                    
                    self.pickerView.isHidden = false
                    
                    self.pickerView.reloadAllComponents()
                    self.activityIndicatorStop()
                } else {
                    print("Failure")
                }
        }
        
        
    }
    
    func stepFive(){
        dtoRegister.town = Int(cityDict["\(self.inputAnswer.text!)"]!)
        self.inputAnswer.text = ""
        self.question.text = "Сколько тебе лет ?"
        var ageArray = [String]()
        for i in 18...90
        {
            ageArray.append("\(i)")
        }
        self.pickerArray = ageArray
        ageArray = []
        self.pickerView.reloadAllComponents()
        
        

        
//        let oneYear = TimeInterval(60 * 60 * 24 * 365)
//        let newYears1971 = Date(timeIntervalSince1970: oneYear)
//        let newYears1969 = Date(timeIntervalSince1970: -oneYear)
//        let s2 = NSDate(timeIntervalSince1970: TimeInterval(0))
//        
//        print(oneYear)
//        print(newYears1971)
//        print(newYears1969)
//        print(s2)
        
        
    }
    
    func stepSix(){
        
        let age = Int(self.inputAnswer.text!)
        
//        if(age! <= 47)
//        {
//        let yearsAgo = TimeInterval(60 * 60 * 24 * 365 * age!)
        let yearsOld = (age! * 60 * 60 * 24 * 365)
//        }
//        print(yearsAgo)
        print(yearsOld)
        
        
        dtoRegister.age = yearsOld
        print("data in ------ \(dtoRegister.age!)")
        
        
        self.inputAnswer.text = ""
        self.question.text = "Сексуальные предпочтения ?"
        
        Alamofire.request("https://datingservice.herokuapp.com/api/sex_prefers", method: .get)
            .responseJSON { (response) in
                if let JSON = response.result.value {
//                     print("JSON sex prefer: \(JSON)")
                    var pickerArrayColorHair = [String]()
                    
                    let info = JSON as! NSArray
                    for i in 0..<(JSON as! NSArray).count
                    {
                        let dict = info[i] as! NSDictionary
//                        print("id   --- \(dict["id"]!)")
//                        print("name --- \(dict["name"]!)")
                        pickerArrayColorHair.append(dict["name"]! as! String)
                    }
                    self.pickerArray = pickerArrayColorHair
                    
                    self.pickerView.isHidden = false
                    
                    self.pickerView.reloadAllComponents()
                    self.activityIndicatorStop()
                } else {
                    print("Failure")
                }
        }
        
        
    }
    
    func stepSeven(){
        dtoRegister.sexPrefer = self.inputAnswer.text!
        self.inputAnswer.text = ""
        self.question.text = "Телосложение ?"
        
        Alamofire.request("https://datingservice.herokuapp.com/api/body_types", method: .get)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                                        print("JSON sex prefer: \(JSON)")
                    var pickerArrayColorHair = [String]()
                    
                    let info = JSON as! NSArray
                    for i in 0..<(JSON as! NSArray).count
                    {
                        let dict = info[i] as! NSDictionary
                        self.bodyTypeDict["\(dict["name"]!)"] = "\(dict["id"]!)"
//                                                print("id   --- \(dict["id"]!)")
//                                                print("name --- \(dict["name"]!)")
                        pickerArrayColorHair.append(dict["name"]! as! String)
                    }
                    self.pickerArray = pickerArrayColorHair
                    
                    self.pickerView.isHidden = false
                    
                    self.pickerView.reloadAllComponents()
                    self.activityIndicatorStop()
                } else {
                    print("Failure")
                }
        }
        
    }
    
    func stepEight(){
        dtoRegister.bodyType = Int(bodyTypeDict["\(self.inputAnswer.text!)"]!)
        self.inputAnswer.text = ""
        self.question.text = "Рост"
        var heightArray = [String]()
        for i in 100...220
        {
            heightArray.append("\(i)")
        }
        self.pickerArray = heightArray
        heightArray = []
        self.pickerView.reloadAllComponents()
    }
    
    func stepNine(){
        dtoRegister.height = Double(self.inputAnswer.text!)
        self.inputAnswer.text = ""
        self.question.text = "Вес"
        var weightArray = [String]()
        for i in 30...200
        {
            weightArray.append("\(i)")
        }
        self.pickerArray = weightArray
        weightArray = []
        self.pickerView.reloadAllComponents()
    }
    
    func stepTen(){
        self.pickerView.isHidden = true
        dtoRegister.weight = Double(self.inputAnswer.text!)
        self.inputAnswer.text = ""
        self.question.text = "Расскажи о себе"
    }
    
    func stepFEleven(){
        self.inputAnswer.isHidden = true
        self.photoView.isHidden = false
        self.importPhoto.isHidden = false
        dtoRegister.aboutMe = self.inputAnswer.text!
        self.inputAnswer.text = "1"
        self.question.text = "Загрузи свое фото"
    }
    
    func stepTwelve(){
        self.inputAnswer.isHidden = false
        self.photoView.isHidden = true
        self.importPhoto.isHidden = true
        //dtoRegister.photo = self.inputAnswer.text!
        self.inputAnswer.text = ""
        self.question.text = "Придумай логин"
    }
    
    func stepThirteen(){
        self.inputTwoPass.isHidden = false
        dtoRegister.userName = self.inputAnswer.text!
        self.inputAnswer.text = ""
        self.question.text = "Придумай пароль"
    }
    
    func stepFinish(){
        
        if(inputAnswer.text == inputTwoPass.text)
        {
            dtoRegister.password = self.inputAnswer.text!
            registrationOnServer()
            self.inputAnswer.text = ""
            let profile = ProfileViewController()
            profile.dtoRegister = self.dtoRegister
            revealViewController().pushFrontViewController(profile, animated: true)
        }else{
            showAlert(title: "Ошибка", message: "Пароли не совпадают")
        }
        
    }
    
    // hide keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        inputAnswer.resignFirstResponder()
        return(true)
    }
    
    // picker view
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputAnswer.text = pickerArray[row]
    }
    
    // import photo/image
    
    @IBAction func pressImportPhoto(_ sender: Any)
    {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            photoView.image = image
        }else{
            print("ошибка imagePickerController")
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // alamofire function
    
    func registrationOnServer()
    {
        // объект в словарь переделать // интеграция фото // куфдь ??
       // let dic = ["username": "123", "password": "123", "name": "ivan", "bdate": "12"]
        
        print("DTO ------  \(dtoRegister.name!)")
        print("DTO ------  \(dtoRegister.sex!)")
        print("DTO ------  \(dtoRegister.iMeetSex!)")
        print("DTO ------  \(dtoRegister.town!)")
        print("DTO ------  \(dtoRegister.age!)")
        print("DTO ------  \(dtoRegister.bodyType!)")
        print("DTO ------  \(dtoRegister.height!)")
        print("DTO ------  \(dtoRegister.weight!)")
        print("DTO ------  \(dtoRegister.aboutMe!)")
        print("DTO ------  \(dtoRegister.userName!)")
        print("DTO ------  \(dtoRegister.password!)")
        
        let dict = ["name": "\(dtoRegister.name!)", "gender_id": "\(dtoRegister.sex!)", "meet_sex_id": "\(dtoRegister.iMeetSex!)", "city_id": "\(dtoRegister.town!)", "bdate": "\(dtoRegister.age!)", /*"sexPrefer": "\(dtoRegister.sexPrefer!)",*/ "body_type_id": "\(dtoRegister.bodyType!)", "height": "\(dtoRegister.height!)", "weight": "\(dtoRegister.weight!)", "about": "\(dtoRegister.aboutMe!)", /*"photo_1": "\(dtoRegister.photo)",*/ "username": "\(dtoRegister.userName!)", "password": "\(dtoRegister.password!)"]
        
        Alamofire.request("https://datingservice.herokuapp.com/api/profiles", method: .post, parameters: dict, encoding: JSONEncoding.default)
            .responseJSON { (response) in
                if let JSON = response.result.value {
                    print("JSONER: \(JSON)")
                    
                } else {
                    print("Failure")
                }
        }
        
    }
    
    // activity indicator
    
    func activityIndicatorStart()
    {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func activityIndicatorStop()
    {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
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
