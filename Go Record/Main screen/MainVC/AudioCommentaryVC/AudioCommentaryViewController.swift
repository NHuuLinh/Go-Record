//
//  AudioCommentaryViewController.swift
//  Go Record
//
//  Created by LinhMAC on 29/04/2024.
//

import UIKit
import CollectionViewPagingLayout


class AudioCommentaryViewController: UIViewController {
    
    @IBOutlet weak var videoListCollectionView: UICollectionView!
    @IBOutlet weak var videoBarCollectionView: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    var videoLists = [VideosList]()
    var index = 0
    var didDeleteVideo : (()-> Void)?

    enum CellSection: Int,CaseIterable {
        case videoList = 0
        case videoBar
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        videoListCollectionView.reloadData()
        subviewHandle(showSubview: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        setCurrentPage(indexPath: index)
//    }
    
    func blindData(data: [VideosList], index: Int){
        self.videoLists = data
        self.index = index
    }
    
    func subviewHandle(showSubview: Bool){
        let childVC = AudioCommentarySubViewController()
        guard let videoIndex = getCurrentIndexPath(for: videoListCollectionView)?.item else {return}
        childVC.videoList = videoLists[videoIndex]

        addChild(childVC)
        view.addSubview(childVC.view)
        childVC.view.frame = view.bounds
        if showSubview {
            childVC.didMove(toParent: self)
        } else {
            childVC.willMove(toParent: nil)
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
        childVC.willHideSubview = {
            childVC.willMove(toParent: nil)
            childVC.view.removeFromSuperview()
            childVC.removeFromParent()
        }
        childVC.reloadData = {
            self.fetchData()
        }
    }
    
    func fetchData(){
        guard let data = VideoListCoreDataHelper.shared.fetchVideoListData() else {return}
        self.videoLists = data
        DispatchQueue.main.async { [self] in
            videoListCollectionView.reloadData()
            videoBarCollectionView.reloadData()
        }
        print("fetchData")
        didDeleteVideo?()
//        setCurrentPage(indexPath: 0)
    }
    
    func addBotomBorder(uiView: UIButton, otherUIView: [UIButton]){
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0,
                                    y: uiView.frame.height,
                                    width: uiView.bounds.width,
                                    height: 2)
        bottomBorder.backgroundColor = UIColor(hex: "#09FFA7")?.cgColor
        uiView.layer.addSublayer(bottomBorder)
        for view in otherUIView {
            let bottomLayersToRemove = view.layer.sublayers?.filter {$0.frame.height == 2 }
            bottomLayersToRemove?.forEach { $0.removeFromSuperlayer() }
        }
        print("addBotomBorder")
    }
    
    @IBAction func btnHandle(_ sender: UIButton) {
        switch sender {
        case backBtn:
            navigationController?.popViewController(animated: true)
        case startBtn:
            if let indexPath = getCurrentIndexPath(for: videoListCollectionView) {
                addBotomBorder(uiView: startBtn, otherUIView: [stopBtn, deleteBtn, saveBtn])
                playvideo(indexPath: indexPath)
            }
        case stopBtn:
            if let indexPath = getCurrentIndexPath(for: videoListCollectionView) {
            addBotomBorder(uiView: stopBtn, otherUIView: [startBtn,deleteBtn,saveBtn])
                pausevideo(indexPath: indexPath)
            }
        case deleteBtn:
            addBotomBorder(uiView: deleteBtn, otherUIView: [startBtn,stopBtn,saveBtn])
            subviewHandle(showSubview: true)
        case saveBtn:
            addBotomBorder(uiView: saveBtn, otherUIView: [startBtn,stopBtn,deleteBtn])
            reloadDataAndLayout()
            let vc = ShareViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func reloadDataAndLayout() {
        videoListCollectionView.reloadData()
        videoBarCollectionView.reloadData()
    }
    
    func getCurrentIndexPath(for collectionView: UICollectionView) -> IndexPath? {
        let centerPoint = view.convert(collectionView.center, to: collectionView)
              let indexPath = collectionView.indexPathForItem(at: centerPoint)
        return indexPath
    }
    
}
// MARK: - CollectionView
extension AudioCommentaryViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        videoListCollectionView.dataSource = self
        videoListCollectionView.delegate = self
        videoListCollectionView.register(UINib(nibName: "VideoListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideoListCollectionViewCell")
        videoListCollectionView.isPagingEnabled = true
        let layout = CollectionViewPagingLayout()
        videoListCollectionView.collectionViewLayout = layout
        videoListCollectionView.showsHorizontalScrollIndicator = false
        videoListCollectionView.clipsToBounds = false
        
        videoBarCollectionView.dataSource = self
        videoBarCollectionView.delegate = self
        videoBarCollectionView.register(UINib(nibName: "VideosBarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideosBarCollectionViewCell")
        
        DispatchQueue.main.async { [self] in
            setCurrentPage(indexPath: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.videoListCollectionView {
            print("userDistance.count:\(videoLists.count)")
            return videoLists.count
        } else {
            return videoLists.count

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.videoListCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoListCollectionViewCell", for: indexPath) as! VideoListCollectionViewCell
            let data = videoLists[indexPath.item]
            cell.blindata(data: data)
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosBarCollectionViewCell", for: indexPath) as! VideosBarCollectionViewCell
            let data = videoLists[indexPath.item]
            cell.blindata(data: data)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.videoListCollectionView {
            didSelectvideo(indexPath: indexPath)
            setCurrentPage(indexPath: indexPath.item)
            print("indexpath:\(indexPath)")
        } else {
            setCurrentPage(indexPath: indexPath.item)
        }
    }
    func didSelectvideo(indexPath: IndexPath) {
        let cell = videoListCollectionView.cellForItem(at: indexPath) as! VideoListCollectionViewCell
        cell.controlVideo()
    }
    func playvideo(indexPath: IndexPath) {
        let cell = videoListCollectionView.cellForItem(at: indexPath) as! VideoListCollectionViewCell
        cell.play()
    }
    func pausevideo(indexPath: IndexPath) {
        let cell = videoListCollectionView.cellForItem(at: indexPath) as! VideoListCollectionViewCell
        cell.pause()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        videoListCollectionView.visibleCells.forEach { cell in
            if let cell = cell as? VideoListCollectionViewCell {
                cell.pause()
            }
        }
    }
    func setCurrentPage(indexPath: Int){
        if let layout = videoListCollectionView.collectionViewLayout as? CollectionViewPagingLayout {
            layout.setCurrentPage(indexPath)
            print("setCurrentPage:\(indexPath)")
        } else {
            print("lỗi không đúng CollectionViewPagingLayout")
        }
    }

    func gotoNextPage() {
        print("gotoNextPage")
        if let layout = videoListCollectionView.collectionViewLayout as? CollectionViewPagingLayout {
            layout.goToNextPage(animated: true)
        }
    }
    func gotoPreviousPage() {
        print("gotoPreviousPage")
        if let layout = videoListCollectionView.collectionViewLayout as? CollectionViewPagingLayout {
            layout.goToPreviousPage(animated: true)
        }
    }
}

