//
//  DownloadDataManager.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 07.04.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DownloadDataManager{
    

        static let shared = DownloadDataManager()
    var tokenIdProfile = ""
    var idProfile = ""
    
    
}

//    static let instance = Singleton()
//    
//    var tokenIdProfile = "1"
//    var idProfile = "11"
//    
//    private init(){}
//    func setData(tokenIdProfile1: String, idProfile2: String)
//    {
//        tokenIdProfile = tokenIdProfile1
//        idProfile = idProfile2
//    }
//    func getTokenIdProfile()
//    {
//        return tokenIdProfile

//    }
//    func getidProfile()
//    {
//        return idProfile
//    }

    
    
    
//    
//    
//    
//    var tokenIdProfile = "1"
//    var idProfile = "11"
//    
//    func initId(tokenIdProfile: String, idProfile: String)
//    {
//        self.tokenIdProfile = tokenIdProfile
//        self.idProfile = idProfile
//    }
//    
//    func getId() -> [String]
//    {
//        var arr = [String]()
//        arr.append("\(self.tokenIdProfile)")
//        arr.append("\(self.idProfile)")
//        return arr
//    }
    
//}

//    
//    
//    
//    
//    func DownloadPickerHair()
//    {
//        Alamofire.request("https://datingservice.herokuapp.com/api/hair_colors", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                } else {
//                    print("Failure")
//                }
//        }
//    }
//    
//    func DownloadPickerSex()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/genders", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerIMeetSex()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/meet_sexes", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerCities()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/cities", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerSexPrefer()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/sex_prefers", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerBodyTypes()
//    {
//        Alamofire.request("https://datingservice.herokuapp.com/api/body_types", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                } else {
//                    print("Failure")
//                }
//        }
//    }
//    
//    func DownloadPickerEyes()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/eyes_colors", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerMaterialSupport()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/material_supports", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerSmokeAttitudes()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/smoke_attitudes", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerAlcooholAttitudes()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/alcohol_attitudes", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//    func DownloadPickerMeetingPoints()
//    {
//        
//        Alamofire.request("https://datingservice.herokuapp.com/api/meeting_points", method: .get)
//            .responseJSON { (response) in
//                if let JSON = response.result.value {
//                    print("JSON: \(JSON)")
//                    
//                } else {
//                    print("Failure")
//                }
//        }
//        
//    }
//    
//}
