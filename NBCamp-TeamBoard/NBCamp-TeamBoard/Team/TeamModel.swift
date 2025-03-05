//
//  TeamModel.swift
//  NBCamp-TeamBoard
//
//  Created by 정근호 on 3/4/25.
//

import Foundation
import UIKit

struct TeamModel {
    
    var teamImage: UIImage?
    var teamName: String = ""
    var teamRules: String = ""
    var teamSchedules: String = ""
    var teamTMI: String = ""
    
    init(
        teamImage: UIImage? = UIImage(named: "TeamPic"),
        teamName: String =  "조은 I들",
        teamRules: String = "12시에 점심, 18시에 저녁",
        teamSchedules: String = "9시 15분 ~ 9시 30분 스크럼",
        teamTMI: String = "조은성님 주축이 되어 I가 모인 팀")
    
        {
            self.teamImage = teamImage
            self.teamName = teamName
            self.teamRules = teamRules
            self.teamSchedules = teamSchedules
            self.teamTMI = teamTMI
        }
}
