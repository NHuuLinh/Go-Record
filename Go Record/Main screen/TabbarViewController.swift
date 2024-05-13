//
//  MyCustomTabBar.swift
//  CustomTabbar
//
//  Created by LinhMAC on 06/04/2024.
//
import UIKit
import Foundation

class MyCustomTabBarController : UITabBarController, UITabBarControllerDelegate {
    
    var menuBtn = UIButton()
    let btnWidth = 70
    let colors: [CGColor] = [
        UIColor(red: 6/255, green: 165/255, blue: 255/255, alpha: 1.0).cgColor, // #06A5FF
        UIColor(red: 20/255, green: 23/255, blue: 43/255, alpha: 1.0).cgColor,   // #14172B
        UIColor(red: 16/255, green: 20/255, blue: 35/255, alpha: 1.0).cgColor,   // #101423
        UIColor(red: 5/255, green: 162/255, blue: 250/255, alpha: 1.0).cgColor   // #05A2FA
    ]
    let locations: [NSNumber] = [0.0, 0.36, 0.67, 1.0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSomeTabItems()
        self.selectedIndex = 1
        self.delegate = self
        self.tabBar.addSubview(menuBtn)
        setupBtn()
        setupCustomTabBar()
        print("tabbarHeight: \(tabBar.frame.height)")
        print("tabbarBounds: \(tabBar.bounds.height)")
        
    }
    override func loadView() {
        super.loadView()
        //        self.tabBar.addSubview(btnMiddle)
        //        setupCustomTabBar()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)!
        if selectedIndex == 1 {
            menuBtn.tintColor = UIColor(hex: "09FFA7")
        } else {
            menuBtn.tintColor = UIColor.white
        }
    }
    
    func setupBtn(){
        menuBtn.frame = CGRect(x: (Int(self.tabBar.bounds.width)/2) - (btnWidth/2), y: -10, width: btnWidth, height: btnWidth)
        menuBtn.backgroundColor = UIColor(hex: "0B163C")
        menuBtn.layer.cornerRadius = menuBtn.frame.width / 2
        menuBtn.addLinearGradientBorderWithLocation(colors: colors, locations: locations, width: 1, cornerRadius: 35)
        if let image = UIImage(named: "MainButton") {
            let tintedImage = image.withRenderingMode(.alwaysTemplate)
            menuBtn.setImage(tintedImage, for: .normal)
            if let imageView = menuBtn.imageView {
                setupImage(imageView: imageView, shadowSize: 1, color: UIColor.white.cgColor, width: 0, height: 0)
                print(" có uiimage ")
                
            } else {
                print("không có uiimage")
            }
        }
        menuBtn.contentMode = .scaleToFill
        menuBtn.tintColor = UIColor(hex: "#09FF98")
        
        menuBtn.clipsToBounds = false
        menuBtn.isEnabled = false
    }
    
    func setupImage(imageView: UIImageView, shadowSize: CGFloat, color: CGColor, width: CGFloat, height: CGFloat){
        imageView.layer.shadowColor = color
        imageView.layer.shadowOpacity = 1
        imageView.layer.shadowOffset = CGSize(width: width, height: height)
        imageView.layer.shadowRadius = shadowSize
        imageView.clipsToBounds = false
    }
    
    func setupCustomTabBar() {
        let path : UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 0.3
        //        shape.strokeColor = UIColor.red.cgColor
        shape.strokeColor = UIColor(red: 38/225, green: 145/255, blue: 222/255, alpha: 1.0).cgColor
        shape.fillColor = UIColor(hex: "#0b163c")?.cgColor
        
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = UIColor(hex: "09FFA7")
        self.tabBar.unselectedItemTintColor = UIColor.white
        self.tabBar.layer.cornerRadius = 26
        
        self.tabBar.tabbarBorder(colors: colors, locations: locations, width: 2, cornerRadius: 26, customShapePath: path)
        
        self.tabBar.layer.shadowColor = UIColor(red: 38/225, green: 145/255, blue: 222/255, alpha: 1.0).cgColor
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.tabBar.layer.shadowRadius = 3
        self.tabBar.clipsToBounds = false
    }
    
    func addSomeTabItems() {
        let settingVC = UINavigationController(rootViewController: SettingViewController())
                let mainVC = UINavigationController(rootViewController: ShareViewController())
//        let mainVC = UINavigationController(rootViewController: MainViewController())
        let recordingVC = UINavigationController(rootViewController: StartRecordingViewController())
        
        settingVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape.fill"), selectedImage: UIImage(systemName: "gearshape.fill"))
        recordingVC.tabBarItem = UITabBarItem(title: "Start Recording", image: UIImage(systemName: "play.fill"), selectedImage: UIImage(systemName: "play.fill"))
        setViewControllers([settingVC, mainVC, recordingVC], animated: false)
    }
    
    func getPathForTabBar() -> UIBezierPath {
        var safeAreaHeight : CGFloat
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                safeAreaHeight = window.safeAreaInsets.top// + window.safeAreaInsets.bottom
                print("Chiều cao của safe area: \(safeAreaHeight)")
            } else {
                safeAreaHeight = 60
                print("Không thể lấy được window")
            }
        } else {
            safeAreaHeight = 60
            print("Không thể lấy được window scene")
        }
        
        let frameWidth = self.tabBar.bounds.width //self.tabBar.bounds.width
        let frameHeight = self.tabBar.bounds.height + safeAreaHeight
        let holeWidth = 220
        let holeHeight = holeWidth/2
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path : UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: leftXUntilHole , y: 0)) // 1.Line
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6,y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2)) // part I
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4)) // part II
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3,y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0)) // part III
        path.addLine(to: CGPoint(x: frameWidth, y: 0)) // 2. Line
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight)) // 3. Line
        path.addLine(to: CGPoint(x: 0, y: frameHeight)) // 4. Line
        path.addLine(to: CGPoint(x: 0, y: 0)) // 5. Line
        path.close()
        return path
    }
}

extension UIColor {
    public convenience init?(hex: String, alpha: Double = 1.0) {
        var pureString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (pureString.hasPrefix("#")) {
            pureString.remove(at: pureString.startIndex)
        }
        if ((pureString.count) != 6) {
            return nil
        }
        let scanner = Scanner(string: pureString)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            self.init(
                red: CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(hexNumber & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0))
            return
        }
        return nil
    }
}

