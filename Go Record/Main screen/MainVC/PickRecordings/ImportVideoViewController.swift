//
//  ImportVideoViewController.swift
//  Go Record
//
//  Created by LinhMAC on 01/05/2024.
//

import UIKit

class ImportVideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    

}
//extension ImportVideoViewController: UITableViewDataSource, UITableViewDelegate {
//
//    func registerCell(){
//        mainTBView.dataSource = self
//        mainTBView.delegate = self
//        let cell = UINib(nibName: "VideoListTableViewCell", bundle: nil)
//        mainTBView.register(cell, forCellReuseIdentifier: "VideoListTableViewCell")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("videoLists.count:\(videoLists.count)")
//        return allAssets.count
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = mainTBView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
////        let resource1 = PHAssetResource.assetResources(for: self.allAssets[indexPath.row])
////        print("Get resources\(resource1)")
////
////        var data = ""
////        if let firstResource = resource1.first {
////            data = firstResource.originalFilename
////        } else {
////            data = "Unknown"
////        }
////
////        cell.bindData1(data: data)
////        return cell
////    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = mainTBView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
//        let asset = allAssets[indexPath.row]
//        let duration = asset.duration
//        let durationString = formattedTimeString(time: duration)
//        cell.bindData1(data: durationString)
//        return cell
//    }
