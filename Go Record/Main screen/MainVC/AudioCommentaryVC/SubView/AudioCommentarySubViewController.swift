//
//  AudioCommentarySubViewController.swift
//  Go Record
//
//  Created by LinhMAC on 07/05/2024.
//

import UIKit

class AudioCommentarySubViewController: UIViewController {
    
    @IBOutlet weak var backgroudView: UIView!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var hideSubviewBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    var willHideSubview : (()->Void)?
    var reloadData : (()->Void)?

    var videoList = VideosList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

        // Do any additional setup after loading the view.
    }
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        setupView()
//    }
    func setupView(){
        selectView.layer.cornerRadius = 26
        selectView.addLinearGradientBorderWithLocation(colors: Constant.colors, locations: Constant.locations, width: 1, cornerRadius: 26)
    }
    
    func deleteData(){
        VideoListCoreDataHelper.shared.deleteVideo(video: videoList)
        willHideSubview?()
        reloadData?()
    }
    
    @IBAction func btnHandle(_ sender: UIButton) {
        switch sender {
        case hideSubviewBtn:
            willHideSubview?()
        case cancelBtn:
            willHideSubview?()
        case removeBtn:
            deleteData()
        default :
            break
        }
    }
}
