//
//  Grid.swift
//  TicTacToe
//
//  Created by 宰英祺 on 2023/1/31.
//

import Foundation
import UIKit

class Grid {
    
    var boxOccupied = [Int](repeatElement(0, count: 9)) // 0: not occupied; 1: occupied by X; -1: occupied by O
    var turnCount = 0
    var CGBox = [CGRect]()
    var CGBoxCenter = [CGPoint]()
    let winDict: [Int:Array] = [1:[0,2], 3:[0,6], 5:[2,8], 7:[6,8], 4:[1,7, 3,5, 0,8,2,6] ]
    var start = -1
    var end = -1
    
    init(){
        for i in 0...2{
            for j in 0...2{
                CGBox.append(CGRect(x: 30+j*135, y: 230+i*135, width: 20, height: 20))
                CGBoxCenter.append(CGPoint(x: 60+j*135, y: 260+i*135))
            }
        }
    }
    
    func isOccupied(boxTag:Int) -> Int{
        // I have set the right tag, here we can use the !
        return boxOccupied[boxTag]
    }
    
    func boxOccuping(player:Int, boxTag:Int) {
        // Set the box. Theoritically there should be some guard function.
        boxOccupied[boxTag] = player
    }
    
    func reStart() {
        // resset the game
        for i in 0...8 {
            boxOccupied[i] = 0
        }
        turnCount = 0
    }
    
    func winnerCheck() -> Int {
        // If there is a winner, it will return the corresponding number; if there is no winner, it will return -2; if keep playing, return 0
        // Idea is from here https://stackoverflow.com/questions/37900603/compare-three-values-for-equality
        
        for (key, value) in winDict{
            for item in 0..<value.count/2{
                if boxOccupied[key] != 0 && (boxOccupied[key],boxOccupied[value[item*2]]) == (boxOccupied[value[item*2+1]],boxOccupied[key]) {
                    start = value[item*2]
                    end = value[item*2+1]
                    return boxOccupied[key]
                }
            }
        }
        
        
        
        
        
        // check winning conditions
//        if boxOccupied[4] != 0
//        {
//            let a = (boxOccupied[0],boxOccupied[4]) == (boxOccupied[4],boxOccupied[8]) || (boxOccupied[1],boxOccupied[4]) == (boxOccupied[4],boxOccupied[7])
//            let b = (boxOccupied[2],boxOccupied[4]) == (boxOccupied[4],boxOccupied[6]) || (boxOccupied[3],boxOccupied[4]) == (boxOccupied[4],boxOccupied[5])
//            if a || b {
//                return boxOccupied[4]
//            }
//        }
//        if boxOccupied[0] != 0 {
//            let c = (boxOccupied[0],boxOccupied[1]) == (boxOccupied[1],boxOccupied[2]) || (boxOccupied[0],boxOccupied[3]) == (boxOccupied[3],boxOccupied[6])
//            if c {
//                return boxOccupied[0]
//            }
//        }
//        if boxOccupied[8] != 0 {
//            let d = (boxOccupied[8],boxOccupied[7]) == (boxOccupied[7],boxOccupied[6]) || (boxOccupied[8],boxOccupied[5]) == (boxOccupied[5],boxOccupied[2])
//            if d {
//                return boxOccupied[8]
//            }
//        }
        
        // check no winner condition
        if turnCount == 9 {
            // no winner
            return -2
        }
        else {
            return 0
        }
    }
    
}



