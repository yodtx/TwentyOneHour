//
//  EditProfileViewController.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 30.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import UIKit
import Alamofire

class EditProfileViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var tokenIdProfile: String!
    var idProfile: String!
    
    var editDTO: DTOProfileInfo!
    
    var pickerArray = ["1", "2", "3", "4"]
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var popUpBut: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var okButton: UIButton!
    

    @IBOutlet weak var photoOne: UIImageView!
    @IBOutlet weak var photoTwo: UIImageView!
    @IBOutlet weak var photoThree: UIImageView!
    var flagPhoto: Int!
    
    
    @IBOutlet weak var nameEdit: UITextField!
    @IBOutlet weak var sexEdit: UITextField!
    @IBOutlet weak var iMeetSexEdit: UITextField!
    @IBOutlet weak var townEdit: UITextField!
    @IBOutlet weak var ageEdit: UITextField!
    @IBOutlet weak var sexPreferEdit: UITextField!
    @IBOutlet weak var bodyTypeEdit: UITextField!
    @IBOutlet weak var heightEdit: UITextField!
    @IBOutlet weak var weightEdit: UITextField!
    @IBOutlet weak var aboutMeEdit: UITextField!
    @IBOutlet weak var hairEdit: UITextField!
    @IBOutlet weak var eyesEdit: UITextField!
    @IBOutlet weak var languagesEdit: UITextField!
    @IBOutlet weak var sizeEdit: UITextField!
    @IBOutlet weak var exicationsEdit: UITextField!
    @IBOutlet weak var disgustEdit: UITextField!
    @IBOutlet weak var materialSupportEdit: UITextField!
    @IBOutlet weak var attitudesAlcoholEdit: UITextField!
    @IBOutlet weak var attitudesSmokeEdit: UITextField!
    @IBOutlet weak var meetingPointEdit: UITextField!
    @IBOutlet weak var tatooEdit: UITextField!
    
    var sexDict = [String:String]()
    var iMeetSexDict = [String:String]()
    var townDict = [String:String]()
    var ageDict = [String:String]()        // ---
    var sexPreferDict = [String:String]()
    var bodyTypeDict = [String:String]()
    var heightDict = [String:String]()     // ---
    var weightDict = [String:String]()     // ---
    var hairDict = [String:String]()
    var eyesDict = [String:String]()
    var sizeDict = [String:String]()        // ---
    var exicationDict = [String:String]()  // ----
    var disgustDict = [String:String]()    // ----
    var materialSupportDict = [String:String]()
    var attitudesAlcoholDict = [String:String]()
    var attitudesSmokeDict = [String:String]()
    var meetingPointDict = [String:String]()
    var tatooDict = [String:String]()
    
    var flagPickerField = ""
    
    

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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image2 = UIImage(named: "label2.png")
        imageView.image = image2
        navigationBar.topItem?.titleView = imageView
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = .clear
        
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        textFieldInit()

        if revealViewController() != nil{
            popUpBut.target = self.revealViewController()
            popUpBut.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
        
        if (editDTO != nil)
        {
            initialSelf(editDTOIn: editDTO)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pressSaveBut(_ sender: Any) {
        editDTO.name = self.nameEdit.text
        editDTO.sex = sexDict["\(self.sexEdit.text!)"]
        editDTO.iMeetSex = iMeetSexDict["\(self.iMeetSexEdit.text!)"]
        editDTO.town = townDict["\(self.townEdit.text!)"]
        editDTO.age = Int(self.ageEdit.text!)
        editDTO.sexPrefer = self.sexPreferEdit.text
        editDTO.bodyType = bodyTypeDict["\(self.bodyTypeEdit.text!)"]
        editDTO.height = Double(self.heightEdit.text!)
        editDTO.weight = Double(self.weightEdit.text!)
        editDTO.aboutMe = self.aboutMeEdit.text
        editDTO.hair = hairDict["\(self.hairEdit.text!)"]
        editDTO.eyes = eyesDict["\(self.eyesEdit.text!)"]
        editDTO.langueges = self.languagesEdit.text
        editDTO.size = Double(self.sizeEdit.text!)
        editDTO.exications = self.exicationsEdit.text
        editDTO.disgust = self.disgustEdit.text
        editDTO.materialSupport = materialSupportDict["\(self.materialSupportEdit.text!)"]
        editDTO.attitudesAlcohol = attitudesAlcoholDict["\(self.attitudesAlcoholEdit.text!)"]
        editDTO.attitudesSmoke = attitudesSmokeDict["\(self.attitudesSmokeEdit.text!)"]
        editDTO.meetingPoint = meetingPointDict["\(self.meetingPointEdit.text!)"]
        
        
        if (self.tatooEdit.text == "Есть"){
            editDTO.tatoo = true
        }else{
            editDTO.tatoo = false
        }
        
        let image3 = photoOne.image
        let imageData = UIImageJPEGRepresentation(image3!, 0.5)!
        

        print("sdsasd-------------------------------------dasfdsafasdf--------------------------------adfaf")
        print("\(self.idProfile!)")
        
        
//        Alamofire.upload(.POST, "https://datingservice.herokuapp.com/api/profiles/\(self.idProfile!)/photo1?access_token=\(self.tokenIdProfile!)", multipartFormData: {
//            multipartFormData in
//            if let _image = self.profilePic.image {
//                if let imageData = UIImagePNGRepresentation(_image) {
//                    multipartFormData.appendBodyPart(data: imageData, name: "photo", fileName: "photo.png", mimeType: "photo/png")
//                }
//            }
//            for (key, value) in userInfo {
//                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
//            }
//        }, encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .Success(let upload, _, _):
//                upload.responseJSON { response in
//                    debugPrint(response)
//                }
//            case .Failure(let encodingError):
//                print(encodingError)
//            }
//        }
//        )
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                //multipartFormData.append(rainbowImageURL, withName: "rainbow")
                
                multipartFormData.append(imageData, withName: "photo", fileName: "photo.jpeg", mimeType: "photo/jpeg")
                
        },
            to: "https://datingservice.herokuapp.com/api/profiles/\(self.idProfile!)/photo1?access_token=\(self.tokenIdProfile!)",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        print("SUCCESS")
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
                
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.validate()
//                    upload.responseJSON { response in
//                                    if let JSON = response.result.value {
//                                        print("JSONER: \(JSON)")
//                        
//                        
//                                    } else {
//                                        print("Failure")
//                                    }
//                    }
//                case .failure(let encodingError):
//                    print(encodingError)
//                    
//                }
        })

        
        
        
        //        Alamofire.upload(imageData, to: "https://datingservice.herokuapp.com/api/profiles/\(self.idProfile!)/photo1").responseJSON { response in
        //            if let JSON = response.result.value {
        //                print("JSONER: \(JSON)")
        //
        //
        //            } else {
        //                print("Failure")
        //            }
        //            
        //        }
        
        
        
        
        
        // Change into your own upload image url
//        Alamofire.upload(.POST, "http://192.168.0.234:3000"
//            , multipartFormData: { formData in
//                // get file path URL
//                let filePath = NSURL(fileURLWithPath: path)
//                // add file as Request Body with fieldname "upload"
//                formData.appendBodyPart(fileURL: filePath, name: "upload")
//                // add a string with fieldname "test" and value "Alamofire"
//                formData.appendBodyPart(data: "Alamofire".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: "test")
//        }, encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .Success:
//                print("SUCCESS")
//            case .Failure(let error):
//                print(error)
//            }
//        })
        
//        Alamofire.upload(.POST, "https://datingservice.herokuapp.com/api/profiles/\(self.idProfile!)/photo1?access_token=\(self.tokenIdProfile!)"
//            , multipartFormData: { formData in
//                // get file path URL
//                let filePath = NSURL(fileURLWithPath: path)
//                // add file as Request Body with fieldname "upload"
//                formData.appendBodyPart(fileURL: filePath, name: "upload")
//                // add a string with fieldname "test" and value "Alamofire"
//                formData.appendBodyPart(data: "Alamofire".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!, name: "test")
//        }, encodingCompletion: { encodingResult in
//            switch encodingResult {
//            case .Success:
//                print("SUCCESS")
//            case .Failure(let error):
//                print(error)
//            }
//        })
        
//        let profile = ProfileViewController()
//        profile.profileDtoEdit = self.editDTO
//        revealViewController().pushFrontViewController(profile, animated: true)
        
        
        
        
        
        
        
        
//        print("DTO ------  \(editDTO.name!)")
//        print("DTO ------  \(editDTO.sex!)")
//        print("DTO ------  \(editDTO.iMeetSex!)")
//        print("DTO ------  \(editDTO.town!)")
//        print("DTO ------  \(editDTO.age!)")
//        print("DTO ------  \(editDTO.sexPrefer!)")
//        print("DTO ------  \(editDTO.bodyType!)")
//        print("DTO ------  \(editDTO.height!)")
//        print("DTO ------  \(editDTO.weight!)")
//        print("DTO ------  \(editDTO.aboutMe!)")
//        
//        print("DTO ------  \(editDTO.hair!)")
//        print("DTO ------  \(editDTO.eyes!)")
//        print("DTO ------  \(editDTO.langueges!)")
//        print("DTO ------  \(editDTO.size!)")
//        print("DTO ------  \(editDTO.exications!)")
//        print("DTO ------  \(editDTO.disgust!)")
// //       print("DTO ------  \(editDTO.gifts!)")
//        print("DTO ------  \(editDTO.materialSupport!)")
//        print("DTO ------  \(editDTO.attitudesAlcohol!)")
//        print("DTO ------  \(editDTO.attitudesSmoke!)")
//        print("DTO ------  \(editDTO.rating!)")
//        print("DTO ------  \(editDTO.meetingPoint!)")
//        print("DTO ------  \(editDTO.tatoo!)")
        
        
//        let dict = ["name": "\(editDTO.name!)", "gender_id": "\(editDTO.sex!)", "meet_sex_id": "\(editDTO.iMeetSex!)", "city_id": "\(editDTO.town!)", "bdate": "\(editDTO.age!)", /*"sexPrefer": "\(editDTO.sexPrefer!)",*/ "body_type_id": "\(editDTO.bodyType!)", "height": "\(Int(editDTO.height!))", "weight": "\(Int(editDTO.weight!))", "about": "\(editDTO.aboutMe!)", /*"photo_1": "\(editDTO.photo)",*/ "hair_color_id": "\(editDTO.hair!)", "eyes_color_id": "\(editDTO.eyes!)", "size": "\(Int(editDTO.size!))", "exications": "\(editDTO.exications!)", "disgust": "\(editDTO.disgust!)", "material_support_id": "\(editDTO.materialSupport!)", "alcohol_attitude_id": "\(editDTO.attitudesAlcohol!)", "smoke_attitude_id": "\(editDTO.attitudesSmoke!)", "rating": "\(Int(editDTO.rating!))", "meeting_point_id": "\(editDTO.meetingPoint!)" /*, "has_tatoo": "\(editDTO.tatoo!)",*/  ]
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/profiles/\(idProfile!)?access_token=\(tokenIdProfile!)", method: .put, parameters: dict, encoding: JSONEncoding.default)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSONER: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//
//        
//        
        
        // ----------------------------------------------------------------------------------------------        
        
        
        
//        let image = UIImage.init(named: "myImage")
//        let imgData = UIImageJPEGRepresentation(photoOne.image!, 0.2)!
//        
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            }
//        },
//                         to:"mysite/upload.php")
//        { (result) in
//            switch result {
//            case .success(let upload, _, _):
//                
//                upload.uploadProgress(closure: { (progress) in
//                    print("Upload Progress: \(progress.fractionCompleted)")
//                })
//                
//                upload.responseJSON { response in
//                    print(response.result.value)  
//                }
//                
//            case .failure(let encodingError):
//                print(encodingError)  
//            }
//        }
        
//        // ----------------------------------------------------------------------------------------------

}

        
//        // ----------------------------------------------------------------------------------------------
//        
//        
//        
//        
//        
//        
//        Alamofire.upload("https://datingservice.herokuapp.com/api/profiles/\(self.idProfile!)/photo1", method: .post, parameters: photoOne, encoding: JSONEncoding.default).responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSONER: \(JSON)")
//                    
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//                Alamofire.request("https://datingservice.herokuapp.com/api/profiles/\(self.idProfile!)/photo2", method: .post, parameters: photoTwo, encoding: JSONEncoding.default)
//                    .responseJSON { (response) in
//                        if let JSON = response.result.value {
//                            print("JSONER: \(JSON)")
//                            
//                            
//                        } else {
//                            print("Failure")
//                        }
//        }
//        
//                        Alamofire.request("https://datingservice.herokuapp.com/api/profiles/\(self.idProfile!)/photo3", method: .post, parameters: photoThree, encoding: JSONEncoding.default)
//                            .responseJSON { (response) in
//                                if let JSON = response.result.value {
//                                    print("JSONER: \(JSON)")
//                                    
//                                    
//                                } else {
//                                    print("Failure")
//                                }
//        }
        
//    }
    
    
    func initialSelf(editDTOIn: DTOProfileInfo)
    {
        self.nameEdit.text = editDTOIn.name
        self.sexEdit.text = editDTOIn.sex
        self.iMeetSexEdit.text = editDTOIn.iMeetSex
        self.townEdit.text = editDTOIn.town
        self.ageEdit.text = String(editDTOIn.age)
        self.sexPreferEdit.text = editDTOIn.sexPrefer
        self.bodyTypeEdit.text = editDTOIn.bodyType
        self.heightEdit.text = String(editDTOIn.height)
        self.weightEdit.text = String(editDTOIn.weight)
        self.aboutMeEdit.text = editDTOIn.aboutMe
        self.hairEdit.text = editDTOIn.hair
        self.eyesEdit.text = editDTOIn.eyes
        self.languagesEdit.text = editDTOIn.langueges
        self.sizeEdit.text = String(editDTOIn.size)
        self.exicationsEdit.text = editDTOIn.exications
        self.disgustEdit.text = editDTOIn.disgust
        self.materialSupportEdit.text = editDTOIn.materialSupport
        self.attitudesAlcoholEdit.text = editDTOIn.attitudesAlcohol
        self.attitudesSmokeEdit.text = editDTOIn.attitudesSmoke
        self.meetingPointEdit.text = editDTOIn.meetingPoint
        
        if (editDTOIn.tatoo == true){
            self.tatooEdit.text = "Есть"
        }else{
            self.tatooEdit.text = "Нету"
        }
    }
    
    // hide keyboard
    
    // resignFirstResponder() ??
    func textFieldInit()
    {
        nameEdit.delegate = self
        sexEdit.delegate = self
        iMeetSexEdit.delegate = self
        townEdit.delegate = self
        ageEdit.delegate = self
        sexPreferEdit.delegate = self
        bodyTypeEdit.delegate = self
        heightEdit.delegate = self
        weightEdit.delegate = self
        aboutMeEdit.delegate = self
        hairEdit.delegate = self
        eyesEdit.delegate = self
        languagesEdit.delegate = self
        sizeEdit.delegate = self
        exicationsEdit.delegate = self
        disgustEdit.delegate = self
        materialSupportEdit.delegate = self
        attitudesAlcoholEdit.delegate = self
        attitudesSmokeEdit.delegate = self
        meetingPointEdit.delegate = self
        tatooEdit.delegate = self
        
        nameEdit.resignFirstResponder()
        sexEdit.resignFirstResponder()
        iMeetSexEdit.resignFirstResponder()
        townEdit.resignFirstResponder()
        ageEdit.resignFirstResponder()
        sexPreferEdit.resignFirstResponder()
        bodyTypeEdit.resignFirstResponder()
        heightEdit.resignFirstResponder()
        weightEdit.resignFirstResponder()
        aboutMeEdit.resignFirstResponder()
        hairEdit.resignFirstResponder()
        eyesEdit.resignFirstResponder()
        languagesEdit.resignFirstResponder()
        sizeEdit.resignFirstResponder()
        exicationsEdit.resignFirstResponder()
        disgustEdit.resignFirstResponder()
        materialSupportEdit.resignFirstResponder()
        attitudesAlcoholEdit.resignFirstResponder()
        attitudesSmokeEdit.resignFirstResponder()
        meetingPointEdit.resignFirstResponder()
        tatooEdit.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        nameEdit.resignFirstResponder()
        sexEdit.resignFirstResponder()
        iMeetSexEdit.resignFirstResponder()
        townEdit.resignFirstResponder()
        ageEdit.resignFirstResponder()
        sexPreferEdit.resignFirstResponder()
        bodyTypeEdit.resignFirstResponder()
        heightEdit.resignFirstResponder()
        weightEdit.resignFirstResponder()
        aboutMeEdit.resignFirstResponder()
        hairEdit.resignFirstResponder()
        eyesEdit.resignFirstResponder()
        languagesEdit.resignFirstResponder()
        sizeEdit.resignFirstResponder()
        exicationsEdit.resignFirstResponder()
        disgustEdit.resignFirstResponder()
        materialSupportEdit.resignFirstResponder()
        attitudesAlcoholEdit.resignFirstResponder()
        attitudesSmokeEdit.resignFirstResponder()
        meetingPointEdit.resignFirstResponder()
        tatooEdit.resignFirstResponder()
        
        return(true)
    }
    
    // did press textField -> picker view
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        switch textField{
            
        case sexEdit:
            
            self.flagPickerField = "sexEdit"
            
            self.activityIndicatorStart()
        
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
                
                Alamofire.request("https://datingservice.herokuapp.com/api/genders", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArraySex = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.sexDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArraySex.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArraySex
                            pickerArraySex = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
            
        case iMeetSexEdit:
            self.flagPickerField = "iMeetSexEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
            
            
                Alamofire.request("https://datingservice.herokuapp.com/api/meet_sexes", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
//                            print("JSON: \(JSON)")
                            var pickerArrayiMeetSex = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.iMeetSexDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayiMeetSex.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayiMeetSex
                            pickerArrayiMeetSex = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
        case townEdit:
            self.flagPickerField = "townEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                Alamofire.request("https://datingservice.herokuapp.com/api/cities", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArraytown = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.townDict["\(dict["title"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArraytown.append(dict["title"]! as! String)
                            }
                            self.pickerArray = pickerArraytown
                            pickerArraytown = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
        case ageEdit:
            self.flagPickerField = "ageEdit"
            
            self.pickerView.isHidden = false
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            var ageArray = [String]()
            for i in 18...90
            {
                ageArray.append("\(i)")
            }
            self.pickerArray = ageArray
            ageArray = []
            self.pickerView.reloadAllComponents()
            
            
            // --------------------------- self
            
        case sexPreferEdit:
            self.flagPickerField = "sexPreferEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                
                Alamofire.request("https://datingservice.herokuapp.com/api/sex_prefers", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArraySexPrefer = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.sexPreferDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArraySexPrefer.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArraySexPrefer
                            pickerArraySexPrefer = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
        case bodyTypeEdit:
            self.flagPickerField = "bodyTypeEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                Alamofire.request("https://datingservice.herokuapp.com/api/body_types", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
//                            print("JSON: \(JSON)")
                            var pickerArrayBodyType = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.bodyTypeDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayBodyType.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayBodyType
                            pickerArrayBodyType = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                        } else {
                            print("Failure")
                        }
                }
            
        case heightEdit:
            self.flagPickerField = "heightEdit"
            
            self.pickerView.isHidden = false
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
            var heightArray = [String]()
            for i in 100...220
            {
                heightArray.append("\(i)")
            }
            self.pickerArray = heightArray
            heightArray = []
            self.pickerView.reloadAllComponents()
            
            // --------------------------- self
            
        case weightEdit:
            self.flagPickerField = "weightEdit"
            
            self.pickerView.isHidden = false
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
            var weightArray = [String]()
            for i in 30...200
            {
                weightArray.append("\(i)")
            }
            self.pickerArray = weightArray
            weightArray = []
            self.pickerView.reloadAllComponents()
            // --------------------------- self
            
        case hairEdit:
            self.flagPickerField = "hairEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
            
                Alamofire.request("https://datingservice.herokuapp.com/api/hair_colors", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArrayHair = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.hairDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayHair.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayHair
                            pickerArrayHair = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                        } else {
                            print("Failure")
                        }
                }
                
            
        case eyesEdit:
            self.flagPickerField = "eyesEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                
                Alamofire.request("https://datingservice.herokuapp.com/api/eyes_colors", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArrayEyes = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.eyesDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayEyes.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayEyes
                            pickerArrayEyes = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
        case sizeEdit:
            self.flagPickerField = "sizeEdit"
            
            self.pickerView.isHidden = false
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
            var sizeArray = [String]()
            for i in 5...40
            {
                sizeArray.append("\(i)")
            }
            pickerArray = sizeArray
            sizeArray = []
            self.pickerView.reloadAllComponents()
            
            // --------------------------- self
            
            
        case materialSupportEdit:
            self.flagPickerField = "materialSupportEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                
                Alamofire.request("https://datingservice.herokuapp.com/api/material_supports", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArrayMaterialSupport = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.materialSupportDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayMaterialSupport.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayMaterialSupport
                            pickerArrayMaterialSupport = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            

            
        case attitudesAlcoholEdit:
            self.flagPickerField = "attitudesAlcoholEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                
                Alamofire.request("https://datingservice.herokuapp.com/api/alcohol_attitudes", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArrayAttitudesAlcohol = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.attitudesAlcoholDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayAttitudesAlcohol.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayAttitudesAlcohol
                            pickerArrayAttitudesAlcohol = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
        case attitudesSmokeEdit:
            self.flagPickerField = "attitudesSmokeEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                
                Alamofire.request("https://datingservice.herokuapp.com/api/smoke_attitudes", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
//                            print("JSON: \(JSON)")
                            var pickerArrayAttitudesSmoke = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.attitudesSmokeDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayAttitudesSmoke.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayAttitudesSmoke
                            pickerArrayAttitudesSmoke = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
        case meetingPointEdit:
            self.flagPickerField = "meetingPointEdit"
            
            self.activityIndicatorStart()
            
            self.pickerView.isHidden = true
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
                
                Alamofire.request("https://datingservice.herokuapp.com/api/meeting_points", method: .get)
                    .responseJSON { (response) in
                        if let JSON = response.result.value {
 //                           print("JSON: \(JSON)")
                            var pickerArrayMeetingPoint = [String]()
                            
                            let info = JSON as! NSArray
                            for i in 0..<(JSON as! NSArray).count
                            {
                                let dict = info[i] as! NSDictionary
                                self.meetingPointDict["\(dict["name"]!)"] = "\(dict["id"]!)"
                                //                        print("id   --- \(dict["id"]!)")
                                //                        print("name --- \(dict["name"]!)")
                                pickerArrayMeetingPoint.append(dict["name"]! as! String)
                            }
                            self.pickerArray = pickerArrayMeetingPoint
                            pickerArrayMeetingPoint = []
                            
                            self.pickerView.isHidden = false
                            
                            self.pickerView.reloadAllComponents()
                            self.activityIndicatorStop()
                            
                            
                        } else {
                            print("Failure")
                        }
                }
            
            
        case tatooEdit:
            self.flagPickerField = "tatooEdit"
            pickerView.isHidden = false
            self.scrollView.isHidden = true
            okButton.isHidden = false
            self.view.endEditing(true)
            
            
            var tatooArray = [String]()
            tatooArray.append("Есть")
            tatooArray.append("Нету")
            self.pickerArray = tatooArray
            tatooArray = []
            self.pickerView.reloadAllComponents()
            
            // --------------------------- self
            
        default:
            self.flagPickerField = ""
            print("what")
        }
    }
    
    
    // button okey
    
    @IBAction func pressOkButton(_ sender: Any) {
        okButton.isHidden = true
        pickerView.isHidden = true
        self.scrollView.isHidden = false
        
        
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
        
        switch flagPickerField
        {
        case "sexEdit":
            self.sexEdit.text = pickerArray[row]
        case "iMeetSexEdit":
            self.iMeetSexEdit.text = pickerArray[row]
        case "townEdit":
            self.townEdit.text = pickerArray[row]
        case "ageEdit":
            self.ageEdit.text = pickerArray[row]
        case "sexPreferEdit":
            self.sexPreferEdit.text = pickerArray[row]
        case "bodyTypeEdit":
            self.bodyTypeEdit.text = pickerArray[row]
        case "heightEdit":
            self.heightEdit.text = pickerArray[row]
        case "weightEdit":
            self.weightEdit.text = pickerArray[row]
        case "hairEdit":
            self.hairEdit.text = pickerArray[row]
        case "eyesEdit":
            self.eyesEdit.text = pickerArray[row]
        case "sizeEdit":
            self.sizeEdit.text = pickerArray[row]
        case "exicationsEdit":
            self.exicationsEdit.text = pickerArray[row]
        case "disgustEdit":
            self.disgustEdit.text = pickerArray[row]
        case "materialSupportEdit":
            self.materialSupportEdit.text = pickerArray[row]
        case "attitudesAlcoholEdit":
            self.attitudesAlcoholEdit.text = pickerArray[row]
        case "attitudesSmokeEdit":
            self.attitudesSmokeEdit.text = pickerArray[row]
        case "meetingPointEdit":
            self.meetingPointEdit.text = pickerArray[row]
        case "tatooEdit":
            self.tatooEdit.text = pickerArray[row]
            
        default:
            print("what2")
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
    
    // UpLoad Photo
    
    @IBAction func pressEditPhotoOne(_ sender: Any) {
        flagPhoto = 1
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true, completion: nil)
    }
    @IBAction func pressEditPhotoTwo(_ sender: Any) {
        flagPhoto = 2
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true, completion: nil)
    }
    @IBAction func pressEditPhotoThree(_ sender: Any) {
        flagPhoto = 3
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
            switch flagPhoto
            {
            case 1:
                photoOne.image = image
            case 2:
                photoTwo.image = image
            case 3:
                photoThree.image = image
            default:
                print("ошибка flagPhoto imagePickerController")
            }
        }else{
            print("ошибка imagePickerController")
        }
        
        dismiss(animated: true, completion: nil)
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
