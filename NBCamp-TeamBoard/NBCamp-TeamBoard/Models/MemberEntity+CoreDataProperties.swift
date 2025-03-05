//
//  MemberEntity+CoreDataProperties.swift
//  
//
//  Created by 박주성 on 3/4/25.
//
//

import Foundation
import CoreData


extension MemberEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemberEntity> {
        return NSFetchRequest<MemberEntity>(entityName: "MemberEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var role: String?
    @NSManaged public var team: TeamEntity?

}
