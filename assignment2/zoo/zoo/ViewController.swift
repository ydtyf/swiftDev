//
//  ViewController.swift
//  zoo
//
//  Created by 宰英祺 on 2023/1/14.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    // global variable
    // animals[array]: array of all class of Animal
    // soundEffect[AVAudioPlayer]: initialize at start (due to unknown reason)
    
    var animals: [Animal] = []
    var soundEffect: AVAudioPlayer?
    @IBOutlet weak var myScroll: UIScrollView!
    @IBOutlet weak var nameOfAnimal: UILabel!
    
    
    @IBAction func tapShowAlert(_ sender: UIButton){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // initialize values and add them to the array
        // Everything relevant to audio file is from https://developer.apple.com/library/archive/qa/qa1913/_index.html
        // Pictures are taken by myself, all rights reserved. The sources of sounds and AppIcon can be found in README
        let dogPath = NSDataAsset(name: "dog_sound")!
        let dog1 = Animal(theName: "Maomao", theSpecies: "dog", theAge: 9, theImage: UIImage(named: "dog.jpeg")!, theSoundPath: dogPath)
        let birdPath = NSDataAsset(name: "bird_sound")!
        let bird1 = Animal(theName: "Qiqi", theSpecies: "bird", theAge: 5, theImage: UIImage(named: "bird.jpeg")!, theSoundPath: birdPath)
        let squirrelPath = NSDataAsset(name: "squirrel_sound")!
        let squirrel1 = Animal(theName: "Yueyue", theSpecies: "squirrel", theAge: 3, theImage: UIImage(named: "squirrel.jpeg")!, theSoundPath: squirrelPath)
        
        animals += [dog1, bird1, squirrel1]
        animals.shuffle()
        
        // test for output, reserved here
        for ani in animals{
            print(ani)
        }
        
        // direct copy from Module 2, only chane width
        myScroll.delegate = self
        myScroll.contentSize = CGSize(width: 390*3, height: myScroll.frame.height)
        
        // Create a button
        var count = 0
        let config = UIButton.Configuration.filled()
        // set the template of the configuration, from https://useyourloaf.com/blog/button-configuration-in-ios-15/
        
        for ani in animals{
            
            let curimage = ani.image
            // Success combination of https://www.appsdeveloperblog.com/create-uiimage-and-uiimageview-programmatically/ and Module 2
            let myImageView:UIImageView = UIImageView(frame: CGRect(x: count * 390, y: 0, width: 390, height: 600))
            myImageView.image = curimage
            self.myScroll.addSubview(myImageView)
            
            // copy from the module 2 example, modified for the assignment
            let button = UIButton(frame: CGRect(x: 260 + count * 390, y: 80, width: 100, height: 30))
            // #selector is used to link for the function below
            button.addTarget(self,
                             action: #selector(buttonTapped),
                             for: UIControl.Event.touchUpInside)
            button.tag = count
            button.setTitle("\(ani.name)", for: .normal)
            button.configuration = config
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitleColor(UIColor.red, for: .highlighted)
            
            // Add button
            self.myScroll.addSubview(button)
            
            count += 1
        }
        
        // Initialize the label text
        nameOfAnimal.text = "\(animals[0].name)"
    }
    
    // Modified from Module 2
    @objc func buttonTapped(_ button: UIButton!) {
        let cur = button.tag
        let alert = UIAlertController(title: "\(animals[cur].name)", message: "This \(animals[cur].species) is \(animals[cur].age) years old.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Sound", style: .default, handler: {action in self.myHandler(curAni: cur, curNS: self.animals[cur].soundPath)}))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Learn the idea of using function to set all actions: https://stackoverflow.com/questions/24190277/writing-handler-for-uialertaction
    func myHandler(curAni: Int, curNS: NSDataAsset){
        print(self.animals[curAni])
        do {
            soundEffect = try AVAudioPlayer(data: curNS.data, fileTypeHint: "mp3")
            soundEffect?.numberOfLoops = 0
            soundEffect?.play()
        } catch {
            print("Loading sound failed")
        }
    }
    
}

//
// - MARK: UIScrollViewDelegate Protocol Methods
// Modified from Module 2
extension ViewController: UIScrollViewDelegate {
    
    // This function set alpha = 1 when scrolling to far left or far right.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("\(scrollView.contentOffset)")
        if (scrollView.contentOffset.x < 195) {
            nameOfAnimal.text = "\(animals[0].name)"
            if (scrollView.contentOffset.x < 0) {
                nameOfAnimal.alpha = 1.0
            } else {
                nameOfAnimal.alpha = 1.0 - scrollView.contentOffset.x / 195.0
            }
        } else if (scrollView.contentOffset.x < 585) {
            nameOfAnimal.text = "\(animals[1].name)"
            nameOfAnimal.alpha = 1.0 - abs(390.0 - scrollView.contentOffset.x) / 195.0
        } else {
            nameOfAnimal.text = "\(animals[2].name)"
            if (scrollView.contentOffset.x > 780) {
                nameOfAnimal.alpha = 1.0
            } else {
                nameOfAnimal.alpha = 1.0 - (780.0 - scrollView.contentOffset.x) / 195.0
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("Done moving")
    }
}
