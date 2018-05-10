//
//  EffectiveScanningRangeView.swift
//  huataiSwift
//
//  Created by Bryan on 2018/5/4.
//  Copyright © 2018年 U-Sync. All rights reserved.
//

import UIKit

class EffectiveScanningRangeView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.initView()
    }
    
    override func draw(_ rect: CGRect) {
        let centerRect = rect
        let context:CGContext = UIGraphicsGetCurrentContext()!;
        context.setAllowsAntialiasing(true)
        
        context.setFillColor(UIColor.black.cgColor)
        context.fill(rect)
        
        let x = rect.size.width/2
        let y = rect.size.height/2
        var center = CGPoint(x:x,y:y)
        // 中间扣空
        context.clear(centerRect)
        
        // 绘制正方形框
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(2)
        context.addRect(centerRect)
        context.drawPath(using:.stroke)
        // 绘制4个角
        let cornerWidth = centerRect.width/10;
        let cornerHeight = centerRect.height/10;
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.green.cgColor)
        
        // 绘制左上角
        context.move(to: CGPoint(x: centerRect.origin.x, y: centerRect.origin.y + cornerHeight))
        context.addLine(to: CGPoint(x: centerRect.origin.x, y: centerRect.origin.y))
        context.addLine(to: CGPoint(x: centerRect.origin.x + cornerWidth, y: centerRect.origin.y))
        context.drawPath(using: .stroke)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
