//
//  MainViewModel.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/5/25.
//

import UIKit
import CoreData

class MainViewModel {
    
    var onSnapshotUpdated: ((NSDiffableDataSourceSnapshot<Section, CellItem>) -> Void)?

    func fetchSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, CellItem>()
        let teams = CoreDataManager.shared.fetchTeams()
        
        if teams.isEmpty {
            snapshot.appendSections([.team])
            snapshot.appendItems([.addTeam], toSection: .team)
        } else {
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(teams.map { CellItem.team($0) }, toSection: .team)
            
            let members = CoreDataManager.shared.fetchMembers()
            snapshot.appendItems(members.map { CellItem.member($0) }, toSection: .members)
            snapshot.appendItems([.addMember], toSection: .members)
        }
        
        onSnapshotUpdated?(snapshot)
    }
    
    func addTeam() {
        CoreDataManager.shared.addTeam()
        fetchSnapshot()
    }
    
    func addMember() {
        CoreDataManager.shared.addMember()
        fetchSnapshot()
    }
    
    func selectTeam(_ team: TeamEntity, fromCurrentVC: UIViewController) {
        let teamVM = TeamViewModel(team: team)
        
        let navVC = fromCurrentVC.navigationController
        
        let detailVC = TeamDetailViewController(viewModel: teamVM)
        navVC?.pushViewController(detailVC, animated: true)
    }
    
    func selectMember(_ member: MemberEntity, fromCurrentVC: UIViewController) {
        let memberVM = MemberViewModel(member: member)
        
        let navVC = fromCurrentVC.navigationController
        
        let detailVC = MemberDetailViewController(viewModel: memberVM)
        navVC?.pushViewController(detailVC, animated: true)
    }

    func resetData() {
        CoreDataManager.shared.resetData()
        fetchSnapshot()
    }
}
