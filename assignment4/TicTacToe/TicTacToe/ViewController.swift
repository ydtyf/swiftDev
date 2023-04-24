//
//  ViewController.swift
//  TicTacToe
//
//  Created by 宰英祺 on 2023/1/31.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet weak var infoMassage: InfoView!
    
    @IBOutlet weak var infoWord: UILabel!
    @IBOutlet weak var infoOkButton: UIButton!
    @IBOutlet weak var infoGiven: UIButton!
    @IBOutlet weak var PlayerX: UILabel!
    @IBOutlet weak var PlayerO: UILabel!
    @IBOutlet var squares: [UIView]!
    
    var currentPlayer: UILabel? // We always have a current player
    var nextPlayer: UILabel?
    let grid: Grid = Grid()
    var winnerPathLayer: CAShapeLayer?
    
    // MARK: - constant
    let playerXStart =  CGPoint(x:90, y:710)
    let playerOStart =  CGPoint(x:300, y:710)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // initialize and set PlayerX first
        currentPlayer = PlayerX
        setCurrentPlayer()
        nextPlayer = PlayerO
        
        // MARK: - Set info view
        infoGiven.addTarget(self,
                            action: #selector(infoButtonTapped),
                            for: UIControl.Event.touchUpInside)
        
        infoOkButton.addTarget(self,
                               action: #selector(okButtonTapped),
                               for: UIControl.Event.touchUpInside)
        
    }

        
    // modified from teacher's code
    @objc func infoButtonTapped(_ button: UIButton) {
        self.infoWord.text = "Get three in a row to win!"
        self.view.bringSubviewToFront(infoMassage)
        // make sure no one can move the figure when reading the instruction
        currentPlayer!.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveLinear],
                       animations: {
            self.infoMassage.center = self.view.center
        })
    }
    
    @objc func okButtonTapped(_ button: UIButton) {
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: [.curveLinear],
                       animations: {
            self.infoMassage.center = CGPoint(x: 195, y: 1000)
        }, completion: { _ in
            self.infoMassage.center = CGPoint(x: 195, y: -86)
            if self.grid.winnerCheck() != 0{
                self.grid.reStart()
                
                // delete the path https://stackoverflow.com/questions/49518958/how-do-i-remove-a-cashapelayer-and-cabasicanimation-from-my-uiview
                self.winnerPathLayer?.path = nil
                for anyView in self.view.subviews{
                    if anyView.tag < 30 {
                        anyView.removeFromSuperview()
                    }
                }
                
                self.currentPlayer = self.pieceCreation(target: 1)
                self.nextPlayer = self.pieceCreation(target: -1)
            }
            self.setCurrentPlayer()
        }
        )
    }
    
    
    
    
    func callInfoView(show: String) {
        self.infoWord.text = show
        self.view.bringSubviewToFront(infoMassage)
        // make sure no one can move the figure when reading the instruction
        currentPlayer!.isUserInteractionEnabled = false
        UIView.animate(withDuration: 1.0,
                       delay: 1.0,
                       options: [.curveLinear],
                       animations: {
            self.infoMassage.center = self.view.center
        })
    }
    
    
    @objc func handlePan(_ recognizer:UIPanGestureRecognizer) {
        
      let translation = recognizer.translation(in: self.view)
      if let view = recognizer.view {
        view.center = CGPoint(x:view.center.x + translation.x,
                              y:view.center.y + translation.y)
        
        // Observe the state through color change
        switch recognizer.state{
        case .ended:
            for i in 0...8{
                if grid.CGBox[i].intersects(view.frame) {
                    gameOperation(num: i)
                    break
                }
            }
            if self.currentPlayer!.tag == 1 {movePlayer(targetPoint: playerXStart)}
            else {movePlayer(targetPoint: playerOStart)}
            self.currentPlayer!.isUserInteractionEnabled = true
            
        default: break
            
        }
      }
      
      recognizer.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    func gameOperation(num:Int){
        if grid.isOccupied(boxTag: num) == 0 {
            // If one is not occupied, mark it, and move the one to the place
            grid.boxOccuping(player: currentPlayer!.tag, boxTag: num)
            movePlayer(targetPoint: grid.CGBoxCenter[num])
            grid.turnCount += 1
            
            // check whether someone wins
            let winnerCheck = grid.winnerCheck()
            if winnerCheck == 0{
                // game continue
                
                let theTag = currentPlayer!.tag
                currentPlayer = nextPlayer
                nextPlayer = pieceCreation(target: theTag)
                self.view.addSubview(nextPlayer!)
                setCurrentPlayer()
                
                // It seems that this one has to be here all the time
                let panGesture = UIPanGestureRecognizer(target: self,
                                                         action: #selector(handlePan(_:)))
                self.currentPlayer!.addGestureRecognizer(panGesture)
            }
            else {
                currentPlayer = nextPlayer
                if winnerCheck == -2 {
                // Game ends with no winner
                callInfoView(show: "No winner!")
            }
            else if winnerCheck == 1 {drawWinnerLine(toShow: "X is winner!")}
            else {drawWinnerLine(toShow: "O is winner!")}
            }
        }
        
    }
    
    func drawWinnerLine(toShow:String){
        // Learn from this file https://developer.apple.com/forums/thread/15398
        let path: UIBezierPath = UIBezierPath()
        path.move(to: self.grid.CGBoxCenter[self.grid.start])
        path.addLine(to: self.grid.CGBoxCenter[self.grid.end])

        //Create a CAShape Layer
        let pathLayer: CAShapeLayer = CAShapeLayer.init()
        winnerPathLayer = pathLayer
        pathLayer.frame = self.view.bounds
        pathLayer.path = path.cgPath
        pathLayer.strokeColor = UIColor.yellow.cgColor
        pathLayer.fillColor = nil
        pathLayer.lineWidth = 5.0
        pathLayer.lineJoin = CAShapeLayerLineJoin.bevel
        
        //Add the layer to your view's layer
        self.view.layer.addSublayer(pathLayer)

        //This is basic animation, quite a few other methods exist to handle animation see the reference site answers
        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 0.5
        pathAnimation.fromValue = NSNumber(0.0)
        pathAnimation.toValue = NSNumber(1.0)
        //Animation will happen right away
        pathLayer.add(pathAnimation, forKey: "strokeEnd")
        
        callInfoView(show: toShow)
        
    }
    
    
    
    
    func movePlayer(targetPoint:CGPoint){
        UIView.animate(withDuration: 0.1,
                          delay: 0,
                          options: [.curveLinear],
                          animations: {
            self.currentPlayer!.isUserInteractionEnabled = false
            self.currentPlayer!.center = targetPoint
           })
    }
    
    func pieceCreation(target: Int) -> UILabel {
        let newLabel = UILabel(frame: CGRect(x: 30, y: 650, width: 120, height: 120))
        if target == 1 {
            newLabel.tag = 1
            newLabel.text = "X"
            newLabel.backgroundColor = .blue
        } else {
            newLabel.center = CGPoint(x: 300, y: 710)
            newLabel.text = "O"
            newLabel.tag = -1
            newLabel.backgroundColor = .red
        }
        
        newLabel.textAlignment = NSTextAlignment.center
        newLabel.textColor = .white
        newLabel.font = UIFont.systemFont(ofSize: 70, weight: UIFont.Weight.semibold)
        self.view.addSubview(newLabel)
        newLabel.layer.opacity = 0.5
        return newLabel
    }
    
    
    func setCurrentPlayer() {
        // inform who should play next
        // set current Player, check: https://developer.apple.com/documentation/uikit/uiview/1622541-bringsubviewtofront
          
        UIView.animate(withDuration: 0.1,
                            delay: 0.1,
                            options: [.curveLinear],
                            animations: {
              
              self.currentPlayer!.alpha = 1
              self.view.bringSubviewToFront(self.currentPlayer!)
                             
             }, completion: { _ in
                 self.currentPlayer!.isUserInteractionEnabled = true
             })
        
        let panGesture = UIPanGestureRecognizer(target: self,
                                                 action: #selector(handlePan(_:)))
        self.currentPlayer!.addGestureRecognizer(panGesture)
        
    }

}
