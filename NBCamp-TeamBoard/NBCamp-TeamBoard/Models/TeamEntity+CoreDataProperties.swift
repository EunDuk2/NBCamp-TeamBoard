//
//  TeamEntity+CoreDataProperties.swift
//  
//
//  Created by 박주성 on 3/4/25.
//
//

import Foundation
import CoreData


extension TeamEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamEntity> {
        return NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var teamMember: NSSet?

}

// MARK: Generated accessors for teamMember
extension TeamEntity {

    @objc(addTeamMemberObject:)
    @NSManaged public func addToTeamMember(_ value: MemberEntity)

    @objc(removeTeamMemberObject:)
    @NSManaged public func removeFromTeamMember(_ value: MemberEntity)

    @objc(addTeamMember:)
    @NSManaged public func addToTeamMember(_ values: NSSet)

    @objc(removeTeamMember:)
    @NSManaged public func removeFromTeamMember(_ values: NSSet)

}
