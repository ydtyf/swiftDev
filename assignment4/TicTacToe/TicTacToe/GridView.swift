//
//  GridView.swift
//  TicTacToe
//
//  Created by 宰英祺 on 2023/1/31.
//

import UIKit

class GridView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    // MARK: - Can use IBDesignable to enhance it.
    
    override func draw(_ rect: CGRect) {
        // directly modified from teacher's example
        let width = rect.width
        let height = rect.height

          
        // Draw dashed horizontal lines
        let lines = UIBezierPath()
        

        lines.move(to: CGPoint(x: 0, y: height / 3))
        lines.addLine(to: CGPoint(x: width, y: height / 3))
        
        lines.move(to: CGPoint(x: width / 3, y: 0))
        lines.addLine(to: CGPoint(x: width / 3, y: height))

        lines.move(to: CGPoint(x: 0, y: 2 * height / 3))
        lines.addLine(to: CGPoint(x: width, y: 2 * height / 3))
        
        lines.move(to: CGPoint(x: 2 * width / 3, y: 0))
        lines.addLine(to: CGPoint(x: 2 * width / 3, y: height))

        lines.lineWidth = 15
        UIColor.purple.setStroke()
        lines.stroke()
        
    }

}
