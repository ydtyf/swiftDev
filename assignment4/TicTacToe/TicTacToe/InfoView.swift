//
//  InfoView.swift
//  TicTacToe
//
//  Created by 宰英祺 on 2023/1/31.
//

import UIKit

class InfoView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // Learn from this website: https://www.kodeco.com/10317653-calayer-tutorial-for-ios-getting-started
    override func awakeFromNib() {
        self.layer.cornerRadius = 20.0
        self.layer.borderWidth = 3.0
        // MARK: - What's the difference between two kinds of color?
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = UIColor.yellow
        
        let newlayer = CAShapeLayer()
        newlayer.path = UIBezierPath(roundedRect: CGRect(x:0, y:self.frame.height/2, width: self.frame.width, height: 5), cornerRadius: 50).cgPath
        newlayer.fillColor = UIColor.red.cgColor
        self.layer.addSublayer(newlayer)
        

    }

}
