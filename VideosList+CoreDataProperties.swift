//
//  VideosList+CoreDataProperties.swift
//  
//
//  Created by LinhMAC on 28/04/2024.
//
//

import Foundation
import CoreData


extension VideosList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VideosList> {
        return NSFetchRequest<VideosList>(entityName: "VideosList")
    }
    @NSManaged public var videoName: String?
    @NSManaged public var videoDate: String?
    @NSManaged public var videoDuration: String?
    @NSManaged public var videoUrl: String?
}
