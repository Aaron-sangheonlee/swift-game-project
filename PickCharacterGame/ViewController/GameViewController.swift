//
//  GameViewController.swift
//  PickCharacterGame
//
//  Created by 이상헌 on 2021/07/31.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var char2Button: UIButton!
    @IBOutlet weak var char1Button: UIButton!
    @IBOutlet weak var char3Button: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBAction func char1ButtonAction(_ sender: Any) {
        char1ButtonClick()
    }
    @IBAction func char2ButtonAction(_ sender: Any) {
        char2ButtonClick()
    }
    @IBAction func char3ButtonAction(_ sender: Any) {
        char3ButtonClick()
    }
    var subview = UIView()
    let background = UIImageView()
    
    var char: [UIImageView] = []
    
    let imageArray = [0,1,2,0,1,2]
    var images = [UIImage(named: "characterNormalPurple"), UIImage(named: "characterNormalWhite"), UIImage(named: "characterNormalYellow")]
    var shuffledNum: [Int] = []
    
    var gameTimer = 180
    var timer = Timer()
    
    let timerLabel = UILabel()
    let scoreLabel = UILabel()
    var score: Int = 0
    
    @objc func startTimer() {
        gameTimer -= 1
        
        if gameTimer >= 60 {
            var mins = gameTimer / 60
            var secs = gameTimer - (mins*60)
            var time = "\(mins)분 \(secs)초"
            timerLabel.text = String(time)
        } else{
            timerLabel.text = String(gameTimer)
        }
        
        if gameTimer <= 0 {
            timer.invalidate()
        }
    }
    
    
    func addImageToShuffledNum() {
        for i in 0...5{
            if shuffledNum[i] == 0 {
                char[i].image = images[0]
            }
            else if shuffledNum[i] == 1 {
                char[i].image = images[1]
            }
            else {
                char[i].image = images[2]
            }
        }
    }
    
    func updateScore() {

        score += 1
        scoreLabel.text = "\(score)"
    }
    
    func viewSetting(){
        var charFirst = UIImageView()
        var charSecond = UIImageView()
        var charThird = UIImageView()
        var charFourth = UIImageView()
        var charFifth = UIImageView()
        var charSixth = UIImageView()
        char.append(charFirst)
        char.append(charSecond)
        char.append(charThird)
        char.append(charFourth)
        char.append(charFifth)
        char.append(charSixth)
        print(char)
        self.view.addSubview(subview)
        self.subview.addSubview(background)
        self.view.bringSubviewToFront(buttonStackView)
        self.subview.addSubview(char[0])
        charFirst.frame = CGRect(x: 150, y: 450, width: 120, height: 120)
        self.subview.addSubview(charSecond)
        charSecond.frame = CGRect(x: 150, y: 350, width: 110, height: 110)
        self.subview.addSubview(charThird)
        charThird.frame = CGRect(x: 150, y: 270, width: 100, height: 100)
        self.subview.addSubview(charFourth)
        charFourth.frame = CGRect(x: 150, y: 180, width: 90, height: 90)
        self.subview.addSubview(charFifth)
        charFifth.frame = CGRect(x: 150, y: 110, width: 80, height: 80)
        self.subview.addSubview(charSixth)
        charSixth.frame = CGRect(x: 150, y: 50, width: 70, height: 70)
        self.subview.addSubview(timerLabel)
        timerLabel.frame = CGRect(x: 320, y: 80, width: 160, height: 80)
        self.subview.addSubview(scoreLabel)
        scoreLabel.frame = CGRect(x: 10, y: 80, width: 160, height: 80)
        scoreLabel.text = "\(score)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startTimer), userInfo: nil, repeats: true)
        
        shuffledNum = imageArray.shuffled()
        print(shuffledNum)
       
        addImageToShuffledNum()

        subview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        background.image = UIImage(named: "backGround")
        background.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        
        let screen = UIScreen.main.bounds
        print("Width: \(screen.size.width)")
        print("Height: \(screen.size.height)")
        
        viewSetting()
    
//        backGround.image = UIImage(named: "backGround")
        
//        char1Button.setImage(UIImage( characterNormalPurple), for: .normal)
//        char1Button.setImage(UIImage(named: "characterNormalWhite"), for: .highlighted)
    }
    
    func char1ButtonClick() {
        char1Button.tag = 0
        print("버튼 눌림")
            if char1Button.tag == shuffledNum[0] {
                shuffledNum.remove(at: 0)
                shuffledNum.append(Int.random(in: 0...2))
                print(shuffledNum)
                updateScore()
            } else {
                return
            }
       addImageToShuffledNum()
    }
    func char2ButtonClick() {
        char2Button.tag = 1
        
            if char2Button.tag == shuffledNum[0] {
                shuffledNum.remove(at: 0)
                shuffledNum.append(Int.random(in: 0...2))
                print(shuffledNum)
                updateScore()
            } else {
                return
            }
        addImageToShuffledNum()
    }
    func char3ButtonClick() {
        char3Button.tag = 2

        if char3Button.tag == shuffledNum[0] {
            shuffledNum.remove(at: 0)
            shuffledNum.append(Int.random(in: 0...2))
            print(shuffledNum)
            updateScore()
            } else {
                return
            }
        addImageToShuffledNum()
    }
}
