//
//  CoreData.swift
//  Go Record
//
//  Created by LinhMAC on 28/04/2024.
//

import Foundation
import CoreData
import UIKit

class VideoListCoreDataHelper {
    static let shared = VideoListCoreDataHelper()
    private init(){}
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let videoResquestResult = NSFetchRequest<NSFetchRequestResult>(entityName: "VideosList")
    let videoResquestRequestObject = NSFetchRequest<NSManagedObject>(entityName: "VideosList")
    
    func saveValue(){
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("lỗi lưu value : \(error)")
        }
    }
    
    func deleteLocationValue() {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: videoResquestResult)
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Lỗi khi xóa dữ liệu CoreData: \(error)")
        }
    }
    func deleteVideo(video: VideosList) {
        managedContext.delete(video)
        saveValue()
    }
    
    func saveVideoListData(videoDate: String, videoDuration: String, videoName: String, videoUrl: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "VideosList", in: managedContext) else {return}
        let videoList = VideosList(entity: entity, insertInto: managedContext)
        videoList.videoDate = videoDate
        videoList.videoDuration = videoDuration
        videoList.videoName = videoName
        videoList.videoUrl = videoUrl
        saveValue()
    }
    
    func fetchVideoListData() -> [VideosList]? {
        let fetchRequest = VideosList.fetchRequest()
        do {
            let videoDatas = try managedContext.fetch(fetchRequest)
            return videoDatas
        } catch let error as NSError {
            print("lỗi không lấy được dữ liệu :\(error)")
            return nil
        }
    }
}
