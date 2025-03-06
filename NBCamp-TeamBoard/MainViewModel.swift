//
//  MainViewModel.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/5/25.
//

import UIKit
import CoreData

class MainViewModel {
    
    var teams: [TeamEntity] {
        didSet {
            didChangeData()
        }
    }
    
    var members: [MemberEntity] {
        didSet {
            didChangeData()
        }
    }
    
    var didChangeData: (() -> ()) = {}
    var didSelectTeam: ((TeamEntity) -> ()) = { _ in }
    var didSelectMember: ((MemberEntity) -> ()) = { _ in }
    
    
    init(teams: [TeamEntity], members: [MemberEntity]) {
        self.teams = teams
        self.members = members
    }
    
    
    func fetchTeam() {
        self.teams = CoreDataManager.shared.fetchTeams()
    }
    
    func fetchMember() {
        self.members = CoreDataManager.shared.fetchMembers()
    }
    
    func addTeam() {
        CoreDataManager.shared.addTeam()
        fetchTeam()
    }
    
    func addMember() {
        CoreDataManager.shared.addMember()
        fetchMember()
    }
    
    func selectTeam(_ team: TeamEntity) {
        didSelectTeam(team)
    }
    
    func selectMember(_ member: MemberEntity) {
        didSelectMember(member)
    }

    func resetData() {
        CoreDataManager.shared.resetData()
        fetchTeam()
        fetchMember()
    }
}
