//
//  GestureUnlockViewController.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/7.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class GestureUnlockViewController: UIViewController {
  
  @IBOutlet weak var customizeDrawImageView: UIImageView!
  
  //設定線條顏色與寬度
  var drawLineWidth: CGFloat!
  var drawLinecolor: UIColor!
  
  //起止點
  var lineStartPoint: CGPoint!
  var lineEndPoint: CGPoint!
  
  //所有按鈕與選中的按鈕
  var buttonArray = [UIButton]()
  var selectedButtonsArray = [UIButton]()
  
  var drawFlag:Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadButtons()
  }
  
  func loadButtons() {
    let w = 70
    let h = 70
    var x = 0
    var y = 0
    let space = 40
    
    buttonArray = []
    for index in 0...8 {
      
      if((index % 3 == 0) && index > 0) {
        //換行
        y += h + space
        x = 0
      }
      
      //添加按鈕
      CreateButton(v: index+1, x: Float(x), y: Float(y), h: Float(h), w: Float(w))
      x += w + space
    }
  }
  
  func CreateButton(v :Int, x:Float ,y:Float, h:Float, w:Float) {
    //初始化按钮
    let cbtn = UIButton()
    cbtn.tintColor = UIColor.red
    cbtn.setImage(UIImage.init(named:"圖形鎖_灰"), for:.normal)
    
    //設置位置和尺寸
    cbtn.frame = CGRect(x: Int(x), y: Int(y), width: Int(w), height: Int(h))
    
    //設置按钮信息
    cbtn.isUserInteractionEnabled = false
    cbtn.tag = v
    
    //設置字體顏色
    cbtn.setTitleColor(UIColor.white, for: .normal)
    
    //設置背景颜色
    cbtn.backgroundColor = UIColor.clear
    
    /*//設置為圓型
     cbtn.layer.cornerRadius = 35
     cbtn.layer.borderWidth = 4
     cbtn.layer.borderColor = Singleton.sharedInstance().getThemeColorR226xG75xB91().cgColor
     cbtn.clipsToBounds = true*/
    
    customizeDrawImageView.addSubview(cbtn)
    
    //添加到數組
    buttonArray.append(cbtn)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if(selectedButtonsArray.count != 0) {
      for btn in selectedButtonsArray {
        btn.setImage(UIImage.init(named:"圖形鎖_灰"), for:.normal)
      }
      selectedButtonsArray.removeAll()
    }
    
    let touch = touches.first!
    var touchPoint:CGPoint!
    
    for btn in buttonArray {
      touchPoint = touch.location(in: btn)
      if(btn.point(inside: touchPoint, with: nil)) {
        lineStartPoint = btn.center
        drawFlag = true
        
        if(selectedButtonsArray.count > 0) {
          selectedButtonsArray.reserveCapacity(9)
        }
        
        selectedButtonsArray.append(btn)
      }
    }
  }
  
  override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      
      if(drawFlag) {
        lineEndPoint = touch.location(in: customizeDrawImageView)
        var touchPoint:CGPoint!
        var btnContained:Bool!
        
        for btn in buttonArray {
          touchPoint = touch.location(in: btn)
          if(btn.point(inside: touchPoint, with: nil)) {
            btnContained = false
            
            for selectedBtn in selectedButtonsArray {
              if(btn == selectedBtn) {
                btnContained = true
                break
              }
            }
            
            if(!btnContained) {
              selectedButtonsArray.append(btn)
            }
          }
        }
        
        drawLineWidth = 10.0
        drawLinecolor = Singleton.sharedInstance().getThemeColorR226xG75xB91()
        drawLineWithColor(color: drawLinecolor, width: drawLineWidth)
      }
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchEndDrawLineColor(color: drawLinecolor, width: drawLineWidth)
    drawFlag = false
    //判斷手勢密碼是否正確
  }
  
  func drawLineWithColor(color:UIColor, width:CGFloat) {
    var btnCenter:CGPoint!
    var customizeImage:UIImage!
    
    UIGraphicsBeginImageContext(customizeDrawImageView.frame.size)
    
    //一個不透明型的Quzrtz 2D繪畫環境，相當於一個畫布，你可以在上面任意繪畫
    let context = UIGraphicsGetCurrentContext()
    //設置畫線寬度和顏色
    context?.setLineWidth(width)
    context?.setStrokeColor(color.cgColor)
    
    /**
     * CGLineCap
     *  kCGLineCapButt   //和第三個一樣
     *  kCGLineCapRound  //端點是圓的
     *  kCGLineCapSquare //正方形
     */
    //設置線的端點形狀
    context?.setLineCap(CGLineCap.round)
    //設置線的起始位置
    context?.move(to: CGPoint(x: lineStartPoint.x, y: lineStartPoint.y))
    //將選中的點連接起來
    for btn in selectedButtonsArray {
      btnCenter = btn.center
      btn.setImage(UIImage.init(named:"圖形鎖_紅"), for:.normal)
      context?.addLine(to: CGPoint(x: btnCenter.x, y: btnCenter.y))
    }
    //结束位置
    context?.addLine(to: CGPoint(x: lineEndPoint.x, y: lineEndPoint.y))
    
    context?.strokePath()
    
    customizeImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext();
    //追加到畫板
    customizeDrawImageView.image = customizeImage
    customizeImage = nil
  }
  
  func touchEndDrawLineColor(color:UIColor, width:CGFloat) {
    var btnCenter:CGPoint!
    var customizeImage:UIImage!
    
    UIGraphicsBeginImageContext(customizeDrawImageView.frame.size)
    
    //一個不透明型的Quzrtz 2D繪畫環境，相當於一個畫布，你可以在上面任意繪畫
    let context = UIGraphicsGetCurrentContext()
    //設置畫線寬度和顏色
    context?.setLineWidth(width)
    context?.setStrokeColor(color.cgColor)
    
    /**
     * CGLineCap
     *  kCGLineCapButt   //和第三個一樣
     *  kCGLineCapRound  //端點是圓的
     *  kCGLineCapSquare //正方形
     */
    //設置線的端點形狀
    context?.setLineCap(CGLineCap.round)
    //設置線的起始位置
    context?.move(to: CGPoint(x: lineStartPoint.x, y: lineStartPoint.y))
    //將選中的點連接起來
    for btn in selectedButtonsArray {
        btnCenter = btn.center
        context?.addLine(to: CGPoint(x: btnCenter.x, y: btnCenter.y))
    }
    context?.strokePath()
    
    customizeImage = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext();
    //追加到畫板
    customizeDrawImageView.image = customizeImage
    customizeImage = nil
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}
