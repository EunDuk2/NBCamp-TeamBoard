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
    
    func addTeam(image: Data, name: String, rule: String, schedules: String, tmi: String) {
        let team = TeamEntity(context: context)
        team.image = image
        team.name = name
        team.rule = rule
        team.schedules = schedules
        team.tmi = tmi
        
        saveContext()
    }
    
    func editTeam(team: TeamEntity ,image: Data, name: String, rule: String, schedules: String, tmi: String) {
        team.image = image
        team.name = name
        team.rule = rule
        team.schedules = schedules
        team.tmi = tmi
        
        saveContext()
    }
    
    func addMember(image: Data?, name: String, mbti: String, hobby: String, githubLink: String, introduction: String, role: String, notionLink: String)  {
        
        let member = MemberEntity(context: context)
        member.image = image
        member.name = name
        member.mbti = mbti
        member.hobby = hobby
        member.githubLink = githubLink
        member.introduction = introduction
        member.role = role
        member.notionLink = notionLink
        saveContext()
    }
    
    func editMember(member: MemberEntity, image: Data?, name: String, mbti: String, hobby: String, githubLink: String, introduction: String, role: String, notionLink: String)  {
        
        member.image = image
        member.name = name
        member.mbti = mbti
        member.hobby = hobby
        member.githubLink = githubLink
        member.introduction = introduction
        member.notionLink = notionLink
        member.role = role
        
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
