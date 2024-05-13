//
//  MainViewController.swift
//  Go Record
//
//  Created by LinhMAC on 06/04/2024.
//

import UIKit
import Photos

class MainViewController: UIViewController {

    @IBOutlet weak var mainTBView: UITableView!
    @IBOutlet weak var test: UIImageView!
    @IBOutlet weak var recordBtn: UIButton!
    var videoLists = [VideosList]()
    var allAssets: [PHAsset] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subviewHandle(willShow: false)
        registerCell()
        fetchVideoAssets()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnHandle(_ sender: UIButton) {
        switch sender {
        case recordBtn:
            subviewHandle(willShow: true)
        default:
            break
        }
    }
    
    func subviewHandle(willShow: Bool){
        let subview = SubViewOfMainVCViewController()
        addChild(subview)
        view.addSubview(subview.view)
        subview.view.frame = view.bounds
        subview.hidSubView = {
            subview.willMove(toParent: nil)
            subview.view.removeFromSuperview()
            subview.removeFromParent()
        }
        if willShow {
            subview.didMove(toParent: self)
        } else {
            subview.willMove(toParent: nil)
            subview.view.removeFromSuperview()
            subview.removeFromParent()
        }
    }
    func fetchVideoAssets() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.video.rawValue)
        let videoAssets = PHAsset.fetchAssets(with: fetchOptions)
        self.allAssets = videoAssets.objects(at: IndexSet(integersIn: 0..<videoAssets.count))
        mainTBView.reloadData()
    }

    
    func fetchData1(){
        guard let data = VideoListCoreDataHelper.shared.fetchVideoListData() else {return}
        self.videoLists = data
        mainTBView.reloadData()
        print("fetchData")
    }
    
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCell(){
        mainTBView.dataSource = self
        mainTBView.delegate = self
        let cell = UINib(nibName: "VideoListTableViewCell", bundle: nil)
        mainTBView.register(cell, forCellReuseIdentifier: "VideoListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("videoLists.count:\(videoLists.count)")
        return allAssets.count
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = mainTBView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
//        let resource1 = PHAssetResource.assetResources(for: self.allAssets[indexPath.row])
//        print("Get resources\(resource1)")
//        
//        var data = ""
//        if let firstResource = resource1.first {
//            data = firstResource.originalFilename
//        } else {
//            data = "Unknown"
//        }
//        
//        cell.bindData1(data: data)
//        return cell
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTBView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
        let asset = allAssets[indexPath.row]
        let duration = asset.duration
        let durationString = formattedTimeString(time: duration)
        cell.bindData1(data: durationString)
        return cell
    }

    func formattedTimeString(time: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: time) ?? ""
    }


    
}
