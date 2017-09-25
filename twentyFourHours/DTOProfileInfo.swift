//
//  DTOProfileInfo.swift
//  twentyFourHours
//
//  Created by Антон Погремушкин on 27.03.17.
//  Copyright © 2017 Антон Погремушкин. All rights reserved.
//

import Foundation

class DTOProfileInfo{
    
    //11
    var name: String!
    var sex: String!
    var iMeetSex: String! // polovie predpochtenia
    var town: String!
    var age: Int!
    var sexPrefer: String!
    var bodyType: String!
    var height: Double!
    var weight: Double!
    var aboutMe: String!
    var photo: String!   // x3
    
    //13
    var hair: String!
    var eyes: String!
    var langueges: String!
    var size: Double!
    var exications: String!  // mne mravitsa
    var disgust: String!    // mne ne nravitsa
    var gifts: String!
    var materialSupport: String!
    var attitudesAlcohol: String!
    var attitudesSmoke: String!
    var rating: Double!
    var meetingPoint: String!
    var tatoo: Bool!
    
    init (name: String, sex: String, iMeetSex: String, town: String, age: Int, sexPrefer: String, bodyType: String, height: Double, weight: Double, aboutMe: String, photo: String, hair: String, eyes: String, langueges: String, size: Double, exications: String, disgust: String, gifts: String, materialSupport: String, attitudesAlcohol: String, attitudesSmoke: String, rating: Double, meetigPoint: String, tatoo: Bool)
    {
        self.name = name
        self.sex = sex
        self.iMeetSex = iMeetSex
        self.town = town
        self.age = age
        self.sexPrefer = sexPrefer
        self.bodyType = bodyType
        self.height = height
        self.weight = weight
        self.aboutMe = aboutMe
        self.photo = photo
        
        self.hair = hair
        self.eyes = eyes
        self.langueges = langueges
        self.size = size
        self.exications = exications
        self.disgust = disgust
        self.gifts = gifts
        self.materialSupport = materialSupport
        self.attitudesAlcohol = attitudesAlcohol
        self.attitudesSmoke = attitudesSmoke
        self.rating = rating
        self.meetingPoint = meetigPoint
        self.tatoo = tatoo
    }
    
//    init (name: String, sex: Int, iMeetSex: Int, town: Int, age: Int, sexPrefer: String, bodyType: String, height: Double, weight: Double, aboutMe: String, photo: String, hair: String, eyes: String, langueges: String, size: Double, exications: String, disgust: String, gifts: String, materialSupport: String, attitudesAlcohol: String, attitudesSmoke: String, rating: Double, meetigPoint: String, tatoo: Bool)
//    {
//        self.name = name
//        self.sex = sex
//        self.iMeetSex = iMeetSex
//        self.town = town
//        self.age = age
//        self.sexPrefer = sexPrefer
//        self.bodyType = bodyType
//        self.height = height
//        self.weight = weight
//        self.aboutMe = aboutMe
//        self.photo = photo
//        
//        self.hair = hair
//        self.eyes = eyes
//        self.langueges = langueges
//        self.size = size
//        self.exications = exications
//        self.disgust = disgust
//        self.gifts = gifts
//        self.materialSupport = materialSupport
//        self.attitudesAlcohol = attitudesAlcohol
//        self.attitudesSmoke = attitudesSmoke
//        self.rating = rating
//        self.meetingPoint = meetigPoint
//        self.tatoo = tatoo
//    }
//    
    init()
    {
        self.name = ""
        self.sex = ""
        self.iMeetSex = ""
        self.town = ""
        self.age = 0
        self.sexPrefer = ""
        self.bodyType = ""
        self.height = 0
        self.weight = 0
        self.aboutMe = ""
        self.photo = "devushka-lico-voda-glaza.jpg"
        
        self.hair = ""
        self.eyes = ""
        self.langueges = ""
        self.size = 0
        self.exications = ""
        self.disgust = ""
        self.gifts = ""
        self.materialSupport = ""
        self.attitudesAlcohol = ""
        self.attitudesSmoke = ""
        self.rating = 0
        self.meetingPoint = ""
        self.tatoo = false
    }
}
