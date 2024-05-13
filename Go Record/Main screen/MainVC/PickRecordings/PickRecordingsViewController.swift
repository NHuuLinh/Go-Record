//
//  PickRecordingsViewController.swift
//  Go Record
//
//  Created by LinhMAC on 24/04/2024.
//

import UIKit
import UniformTypeIdentifiers
import AVFoundation
import Photos


class PickRecordingsViewController: UIViewController {

    @IBOutlet weak var fileTableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var importBtn: UIButton!
    var imagePicker = UIImagePickerController()
    let videoListCoreDataHelper = VideoListCoreDataHelper.shared
    var videoLists = [VideosList]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        fetchData()
        registerCell()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func btnHandle(_ sender: UIButton) {
        switch sender {
        case backBtn:
            print("BackBtn")
            navigationController?.popToRootViewController(animated: true)
        case importBtn:
            openVideoGallery()
        default:
            break
        }
    }
    
    func fetchData(){
        guard let data = videoListCoreDataHelper.fetchVideoListData() else {return}
        self.videoLists = data
        print("data:\(data.last?.videoName)")
        fileTableView.reloadData()
    }
}

extension PickRecordingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func registerCell(){
        fileTableView.dataSource = self
        fileTableView.delegate = self
        let cell = UINib(nibName: "VideoListTableViewCell", bundle: nil)
        fileTableView.register(cell, forCellReuseIdentifier: "VideoListTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("videoLists.count:\(videoLists.count)")
        return videoLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fileTableView.dequeueReusableCell(withIdentifier: "VideoListTableViewCell", for: indexPath) as! VideoListTableViewCell
        cell.selectionStyle = .none
        
        cell.bindData(data: videoLists[indexPath.item])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = AudioCommentaryViewController()
        vc.didDeleteVideo = { [weak self] in
            self?.fetchData()
        }
        
        vc.blindData(data: videoLists, index: indexPath.item)
        navigationController?.pushViewController(vc, animated: true)
    }
}

/// MARK : Import Video
extension PickRecordingsViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    func openVideoGallery() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .savedPhotosAlbum
        picker.mediaTypes = ["public.movie"]
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    //            Task {
    //                  let videoDuration = try await asset.load(.duration)
    //             }

    func timeFormatted(totalSeconds: TimeInterval) -> String {
        let seconds = Int(totalSeconds) % 60
        let minutes = Int(totalSeconds) / 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[.mediaURL] as? URL {
            // Lấy tên file video từ URL
            let videoName = videoURL.deletingPathExtension().lastPathComponent

            // Tiếp tục với xử lý của bạn
            let asset = AVAsset(url: videoURL)
            let videoDuration = CMTimeGetSeconds(asset.duration)
            let durationString = timeFormatted(totalSeconds: videoDuration) // Convert duration to minute:second format
            let dataFormatter = DateFormatter()
            dataFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = dataFormatter.string(from: Date())
            videoListCoreDataHelper.saveVideoListData(videoDate: dateString, videoDuration: durationString, videoName: videoName, videoUrl: videoURL.absoluteString)

            dismiss(animated: true, completion: nil)
            fetchData()
        } else {
            print("lỗi url")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
