//
//  CoreDataManager.swift
//  NBCamp-TeamBoard
//
//  Created by 박주성 on 3/4/25.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("AppDelegate를 찾을 수 없음")
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    
    func resetData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let entityNames = appDelegate.persistentContainer.managedObjectModel.entities.compactMap { $0.name }

        do {
            for entityName in entityNames {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                try context.execute(deleteRequest)
            }
            try context.save()
            print("Core Data 리셋")
        } catch {
            print("Core Data 리셋 실패: \(error)")
        }
    }
    
    func fetchTeams() -> [TeamEntity] {
        let request: NSFetchRequest<TeamEntity> = TeamEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("팀 가져오기 실패: \(error)")
            return []
        }
    }
    
    func fetchMembers() -> [MemberEntity] {
        let request: NSFetchRequest<MemberEntity> = MemberEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("팀원 가져오기 실패: \(error.localizedDescription)")
            return []
        }
    }
    
    func addTeam() {
        let teams = fetchTeams()
        guard teams.isEmpty else { return }
        
        let team = TeamEntity(context: context)
        team.name = "3팀"
        saveContext()
    }
    
    func addMember() {
        let member = MemberEntity(context: context)
        member.name = "박주성"
        member.role = "팀원"
        saveContext()
    }
    
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Context 저장 실패: \(error)")
            }
        }
    }
}
