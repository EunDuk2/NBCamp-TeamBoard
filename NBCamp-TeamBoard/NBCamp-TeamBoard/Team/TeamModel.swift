//
//  TeamModel.swift
//  NBCamp-TeamBoard
//
//  Created by 정근호 on 3/4/25.
//

import Foundation
import UIKit

struct TeamModel {
    
    let teamImage: UIImage?
    let teamName: String
    let teamRules: [String]
    let teamSchedules: [String]
    let teamTMI: String
    
    init(
        teamImage: UIImage? = UIImage(named: "TeamPic"),
        teamName: String =  "조은 I들",
        teamRules: [String] = ["12시에 점심, 18시에 저녁",
                               "궁금한 내용 언제든지 마이크 키고 물어보기"],
        teamSchedules: [String] = ["9시 15분 ~ 9시 30분 스크럼",
                                   "9시 30분 ~ 11시 30분 알고리즘 문제풀기",
                                   "11시 30분 알고리즘 문제 풀이 공유",
                                   "12시 ~ 1시 점심 식사",
                                   "1시 ~ 6시 프로젝트 진행 / 코딩 / 자 유롭게 마이크 켜서 질문",
                                   "6시 ~ 7시 저녁 식사",
                                   "7시 PR 발표 / 문제점 공유",
                                   "8시 45분 진척도"],
        teamTMI: String = "조은성님 주축이 되어 I가 모인 팀")
    
        {
            self.teamImage = teamImage
            self.teamName = teamName
            self.teamRules = teamRules
            self.teamSchedules = teamSchedules
            self.teamTMI = teamTMI
        }
}
