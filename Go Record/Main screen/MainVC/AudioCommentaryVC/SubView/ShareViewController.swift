//
//  ShareViewController.swift
//  Go Record
//
//  Created by LinhMAC on 08/05/2024.
//

import UIKit

class ShareViewController: UIViewController {
     @IBOutlet weak var memoryPercentView: UIView!
     @IBOutlet weak var percentLabel: UILabel!
     @IBOutlet weak var saveView: UIView!
     @IBOutlet weak var uploadView: UIView!
     @IBOutlet weak var shareView: UIView!
     @IBOutlet weak var emailView: UIView!
     @IBOutlet weak var otherView: UIView!
     @IBOutlet weak var liveStreamView: UIView!
     @IBOutlet weak var saveBtn: UIButton!
     @IBOutlet weak var uploadBtn: UIButton!
     @IBOutlet weak var shareBtn: UIButton!
     @IBOutlet weak var emailBtn: UIButton!
     @IBOutlet weak var otherBtn: UIButton!
     @IBOutlet weak var liveStreamBtn: UIButton!
     
     override func viewDidLoad() {
          super.viewDidLoad()
          drawCircle()
          drawCircle1()
          setupView()
          createGradientForLabel()
          // Do any additional setup after loading the view.
     }
     
     override func viewWillAppear(_ animated: Bool) {
          navigationController?.isNavigationBarHidden = true
     }
     
     func reportMemory() -> Float{
         var taskInfo = task_vm_info_data_t()
         var count = mach_msg_type_number_t(MemoryLayout<task_vm_info>.size) / 4
         let result: kern_return_t = withUnsafeMutablePointer(to: &taskInfo) {
             $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
                 task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), $0, &count)
             }
         }
         let usedGb = Float(taskInfo.phys_footprint) / (pow(1024, 3))
         let totalGb = Float(ProcessInfo.processInfo.physicalMemory) / (pow(1024, 3))
//         result != KERN_SUCCESS ? print("Memory used: ? of \(usedGb)") : print("Memory used: \(usedGb) of \(totalGb)")
          let finalResult = ((usedGb/totalGb))
          percentLabel.text = "\(finalResult * 100)"
          print("usedGb:\(usedGb)")
          print("totalGb:\(totalGb)")
          print("finalResult:\(finalResult)%")
          return finalResult * 100
     }
     // Sử dụng hàm để lấy phần trăm dung lượng bộ nhớ còn lại

     func setupView(){
          addBotomBorder(uiView: saveView)
          addBotomBorder(uiView: uploadView)
          addBotomBorder(uiView: shareView)
          addBotomBorder(uiView: emailView)
          addBotomBorder(uiView: otherView)
          addBotomBorder(uiView: liveStreamView)
     }
     
     func createGradientForLabel() {
          // Khởi tạo gradient layer cho màu nền
          let gradient = getGradientLayer(bounds: percentLabel.bounds, color: [UIColor(hex: "#1F9E5A")!.cgColor,UIColor(hex: "#AFF3CA")!.cgColor, UIColor(hex: "#04FF87")!.cgColor])
          percentLabel.textColor = gradientColor(bounds: percentLabel.bounds, gradientLayer: gradient)
     }
     
     func gradientColor(bounds: CGRect, gradientLayer :CAGradientLayer) -> UIColor? {
          UIGraphicsBeginImageContext(gradientLayer.bounds.size)
          //create UIImage by rendering gradient layer.
          gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
          let image = UIGraphicsGetImageFromCurrentImageContext()
          UIGraphicsEndImageContext()
          //get gradient UIcolor from gradient UIImage
          return UIColor(patternImage: image!)
     }
     
     func getGradientLayer(bounds : CGRect, color: [CGColor]) -> CAGradientLayer{
          let gradient = CAGradientLayer()
          gradient.frame = bounds
          //order of gradient colors
          gradient.colors = color
          // start and end points
          gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
          gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
          return gradient
     }
     
     func addBotomBorder(uiView: UIView){
          let bottomBorder = CALayer()
          bottomBorder.frame = CGRect(x: 0,
                                      y: uiView.frame.height + 10,
                                      width: uiView.bounds.width,
                                      height: 1)
          bottomBorder.backgroundColor = UIColor.gray.cgColor
          uiView.layer.addSublayer(bottomBorder)
          print("addBotomBorder")
     }
     
     func drawCircle() {
          // Khởi tạo path cho hình tròn
          let circlePath = UIBezierPath(arcCenter: CGPoint(x: memoryPercentView.bounds.midX, y: memoryPercentView.bounds.midY),
                                        radius: min(memoryPercentView.bounds.width, memoryPercentView.bounds.height) / 2,
                                        startAngle: -CGFloat.pi / 2,
                                        endAngle: 3 * CGFloat.pi / 2,
                                        clockwise: true)
          // Khởi tạo layer để vẽ hình tròn
          let shapeLayer = CAShapeLayer()
          shapeLayer.path = circlePath.cgPath
          // Thiết lập các thuộc tính của layer
          shapeLayer.strokeColor = UIColor(hex: "#13BCB2", alpha: 0.2)?.withAlphaComponent(0.2).cgColor // Màu đường viền
////          shapeLayer.strokeColor = UIColor.black.withAlphaComponent(0.2).cgColor // Màu đường viền
          shapeLayer.lineWidth = 3 // Độ dày của đường viềnUIColor.black.withAlphaComponent(0.2).cgColor
          shapeLayer.fillColor = UIColor.clear.cgColor // Không tô màu
          
          // Thêm layer vào view
          memoryPercentView.layer.addSublayer(shapeLayer)
     }
     
     func drawCircle1() {
//          let degree = CGFloat(reportMemory()) * CGFloat.pi
          let memoryToDegree = reportMemory() * 360
          let degree = (CGFloat(memoryToDegree) - 180) * CGFloat.pi / 180
                    print("degree: \(degree)")

         // Khởi tạo path cho hình tròn
         let circlePath = UIBezierPath(arcCenter: CGPoint(x: memoryPercentView.bounds.midX, y: memoryPercentView.bounds.midY),
                                       radius: min(memoryPercentView.bounds.width - 9, memoryPercentView.bounds.height - 9) / 2,
                                       startAngle: CGFloat.pi,
                                       endAngle: degree,
                                       clockwise: true)
          print("circlePath:\(circlePath)")
         
         // Khởi tạo layer để vẽ hình tròn
          let shapeLayer = CAShapeLayer()
          shapeLayer.path = circlePath.cgPath
          let gradient = getGradientLayer(bounds: memoryPercentView.bounds, color: [UIColor(hex: "#1F9E80")!.cgColor,UIColor(hex: "#AFF3B2")!.cgColor, UIColor(hex: "#08EE9C")!.cgColor])
          shapeLayer.strokeColor = gradientColor(bounds: memoryPercentView.bounds, gradientLayer: gradient)?.cgColor
          // Thiết lập các thuộc tính của layer
//          shapeLayer.strokeColor = UIColor(hex: "#13BCB2")?.cgColor // Màu đường viền
////          shapeLayer.strokeColor = UIColor.black.withAlphaComponent(0.2).cgColor // Màu đường viền

          shapeLayer.lineWidth = 9 // Độ dày của đường viềnUIColor.black.withAlphaComponent(0.2).cgColor
          shapeLayer.fillColor = UIColor.clear.cgColor // Không tô màu
          
          // Thêm layer vào view
          memoryPercentView.layer.addSublayer(shapeLayer)
          memoryPercentView.backgroundColor = .clear
         
//         // Đặt strokeEnd ban đầu là 0
         shapeLayer.strokeEnd = 0
//
         // Tạo animation
         let animation = CABasicAnimation(keyPath: "strokeEnd")
         animation.fromValue = 0
         animation.toValue = 1
         animation.duration = 3 // Độ dài của animation (số giây)
         animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

         // Thiết lập fillMode và isRemovedOnCompletion
         animation.fillMode = .forwards
         animation.isRemovedOnCompletion = false

         // Áp dụng animation cho strokeEnd
         shapeLayer.add(animation, forKey: "strokeEndAnimation")
          
          let circleView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
              circleView.backgroundColor = UIColor.clear
              circleView.layer.cornerRadius = circleView.bounds.width / 2
              circleView.clipsToBounds = true
          circleView.backgroundColor = UIColor(hex: "#A4FEF8")!
//              circleView.layer.addSublayer(gradient)
              memoryPercentView.addSubview(circleView)
              
              // Animation for moving along the circle path
              let pathAnimation = CAKeyframeAnimation(keyPath: "position")
              pathAnimation.path = circlePath.cgPath
              pathAnimation.duration = 3
          pathAnimation.calculationMode = .paced
              pathAnimation.rotationMode = .rotateAuto
          
              pathAnimation.fillMode = .forwards
              pathAnimation.isRemovedOnCompletion = false
              
              // Apply animation
              circleView.layer.add(pathAnimation, forKey: "moveAlongPath")
              
              // Set the final position of the circle view after animation
              circleView.layer.position = circlePath.currentPoint
     }

     @IBAction func buttonHandle(_ sender: UIButton) {
          switch sender {
          case saveBtn :
               print("saveBtn")
          case uploadBtn:
               print("saveBtn")
          case shareBtn:
               print("saveBtn")
          case emailBtn:
               print("saveBtn")
          case otherBtn:
               print("saveBtn")
          case liveStreamBtn:
               print("saveBtn")
          default:
               break
          }
     }
}
