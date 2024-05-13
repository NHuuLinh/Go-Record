//
//  SubViewOfMainVCViewController.swift
//  Go Record
//
//  Created by LinhMAC on 21/04/2024.
//

import UIKit

class SubViewOfMainVCViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var newProjectView: UIView!
    @IBOutlet weak var menuSelectView: UIView!
    @IBOutlet weak var hideSubviewBtn: UIButton!
    @IBOutlet weak var goRecordBtn: UIButton!
    @IBOutlet weak var deviceLibararyBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    var hidSubView : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnHandle(_ sender: UIButton) {
        switch sender {
        case hideSubviewBtn:
            hidSubView?()
        case goRecordBtn:
            print("goRecordBtn")
        case deviceLibararyBtn:
            let PickRecordingsVC = PickRecordingsViewController()
//            let PickRecordingsVC = AudioCommentaryViewController()
            navigationController?.pushViewController(PickRecordingsVC, animated: true)
        case cancelBtn:
            hidSubView?()
        default:
            break
        }

    }
    
    func setupView(){
        
        newProjectView.layer.cornerRadius = 26
        newProjectView.addLinearGradientBorderWithLocation(colors: Constant.colors, locations: Constant.locations, width: 1, cornerRadius: 26)
        
        menuSelectView.layer.cornerRadius = 26
        menuSelectView.addLinearGradientBorderWithLocation(colors: Constant.colors, locations: Constant.locations, width: 1, cornerRadius: 26)
        
        addBottomBorder(view: goRecordBtn)
        addBottomBorder(view: deviceLibararyBtn)
        addBottomBorder(view: cancelBtn)

    }
    private func addBottomBorder(view: UIView){
        let bottomBorder = CALayer()
        
        bottomBorder.frame = CGRect(x: 0,
                                    y: view.frame.height,
                                    width: view.bounds.width,
                                    height: 0.5)
        bottomBorder.backgroundColor = UIColor(hex: "727DA0")?.cgColor
        view.layer.addSublayer(bottomBorder)
    }

}
