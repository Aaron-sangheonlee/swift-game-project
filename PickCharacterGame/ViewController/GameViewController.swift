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
    //MARK: subview 생성
    var subview = UIView()
    let background = UIImageView()
    //MARK: 이미지뷰 배열 생성
    var char: [UIImageView] = []
    //MARK: 랜덤 array 생성을 위한 임의 배열 생성
    let imageArray = [0,1,2,0,1,2]
    //MARK: 어셋 이미지 배열 생성
    var images = [UIImage(named: "conveyPurple"), UIImage(named: "conveyWhite"), UIImage(named: "conveyYellow")]
    //MARK: 랜덤 배열 생성
    var shuffledNum: [Int] = []
    //MARK: 타이머 인스턴스 선언
    var gameTimer: Int = 0
    var timer = Timer()
    var timeRecord: Int = 0
    let timerLabel = UILabel()
    //MARK: 점수 인스턴스 선언
    let scoreLabel = UILabel()
    var score: Int = 0

    //MARK: resultVC로 시간 데이터 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let moveToResult = segue.destination as? resultViewController else { return }
        if score == 100 {
            timeRecord = 120 - gameTimer
            moveToResult.timeResult = String(timeRecord)
            moveToResult.resultTitle = "최고야!"
            moveToResult.resultContent = "색깔 맞추기를 척척 해내는 모습이 놀라워! 또 놀러와!"
        } else if gameTimer <= 0 {
            moveToResult.resultTitle = "실패...ㅠ"
            moveToResult.resultContent = "다시 한번 더 해보자! 화이팅!"
            moveToResult.timeResult = "시간 초과"
        }
    }
    //MARK: 점수 100점 획득 시 게임 종료 / resultVC 띄우는 performSegue
    func endGame() {
        if score == 100 || gameTimer == 0 {
            performSegue(withIdentifier: "moveToResult", sender: self)
        } else { return }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        //MARK: transparent NavigationBar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        //MARK: subview 크기 지정
        subview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        background.image = UIImage(named: "backGround")
        background.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        
        //MARK: subview 추가
        self.view.addSubview(subview)
        
        //MARK: subview 내에 background subview 추가
        self.subview.addSubview(background)
        
        //MARK: 스택뷰를 뷰 가장 앞으로
        self.view.bringSubviewToFront(buttonStackView)
        
        //MARK: 시간 기록 subview 추가
        self.subview.addSubview(timerLabel)
        timerLabel.frame = CGRect(x: 280, y: 80, width: 100, height: 80)
        timerLabel.textColor = .white
        timerLabel.font = UIFont(name: "system", size: 50)
        timerLabel.backgroundColor = .systemYellow
        timerLabel.layer.borderWidth = 5
        timerLabel.layer.borderColor = UIColor.orange.cgColor
        timerLabel.textAlignment = .center

        
        //MARK: 점수 subview 추가
        self.subview.addSubview(scoreLabel)
        scoreLabel.frame = CGRect(x: 10, y: 80, width: 100, height: 80)
        scoreLabel.textColor = .white
        scoreLabel.font = UIFont(name: "system", size: 50)
        scoreLabel.backgroundColor = .systemYellow
        scoreLabel.layer.borderWidth = 5
        scoreLabel.layer.borderColor = UIColor.orange.cgColor
        scoreLabel.textAlignment = .center
        
        //MARK: 스크린 크기 확인
        let screen = UIScreen.main.bounds
        print("Width: \(screen.size.width)")
        print("Height: \(screen.size.height)")
    }
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //MARK: dispatchquoue 이용한 background timer
        DispatchQueue.global(qos: .background).async {
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
            RunLoop.current.run()
        }
        //MARK: 이미지 배열에 이미지 데이터 주입
        let charFirst = UIImageView()
        let charSecond = UIImageView()
        let charThird = UIImageView()
        let charFourth = UIImageView()
        let charFifth = UIImageView()
        let charSixth = UIImageView()
        char.append(charFirst)
        char.append(charSecond)
        char.append(charThird)
        char.append(charFourth)
        char.append(charFifth)
        char.append(charSixth)
        print(char)
        
        //MARK: subview 내에 imageview를 subview로 넣고 크기 지정
        self.subview.addSubview(char[0])
        charFirst.frame = CGRect(x: 140, y: 450, width: 120, height: 120)
        self.subview.addSubview(charSecond)
        charSecond.frame = CGRect(x: 150, y: 330, width: 100, height: 100)
        self.subview.addSubview(charThird)
        charThird.frame = CGRect(x: 160, y: 230, width: 80, height: 80)
        self.subview.addSubview(charFourth)
        charFourth.frame = CGRect(x: 170, y: 150, width: 60, height: 60)
        self.subview.addSubview(charFifth)
        charFifth.frame = CGRect(x: 180, y: 90, width: 40, height: 40)
        self.subview.addSubview(charSixth)
        charSixth.frame = CGRect(x: 190, y: 50, width: 20, height: 20)
        
        //MARK: 배열을 랜덤 배열로 change
        shuffledNum = imageArray.shuffled()
        print(shuffledNum)
        
        //MARK: 랜덤 배열에 어셋 이미지 배정하는 for loop
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
        //MARK: 다시하기 클릭 시 점수 타이머 Reset
        score = 0
        scoreLabel.text = "\(score)"
        gameTimer = 120
        print(score)
        print(gameTimer)
        print("viewWillAppear")
    }
    //MARK: 타이머 함수 선언
    @objc func startTimer() {
        gameTimer -= 1
        if score >= 100 || gameTimer == 0 {
            self.timer.invalidate()
        }
        DispatchQueue.main.async {
            self.endGame()
        }
        DispatchQueue
            .main.async {
                if self.gameTimer >= 60 {
                    let mins = self.gameTimer / 60
                    let secs = self.gameTimer - (mins*60)
                    let time = "\(mins) : \(secs)"
                    self.timerLabel.text = String(time)
                } else{
                    self.timerLabel.text = String(self.gameTimer)
                }
            }
    }
    //MARK: 버튼 클릭 시마다 점수 업데이트
    func updateScore() {
        score += 1
        scoreLabel.text = "\(score)"
        endGame()
    }
    //MARK: 캐릭터 맞출 때 상단에 캐릭터 추가 if문 & for loop
    func char1ButtonClick() {
        char1Button.tag = 0
        if score < 96 && char1Button.tag == shuffledNum[0] {
            shuffledNum.remove(at: 0)
            shuffledNum.append(Int.random(in: 0...2))
            print(score)
            print(shuffledNum)
            updateScore()
            }
        else if score >= 96 && char1Button.tag == shuffledNum[0] {
            shuffledNum.remove(at: 0)
            print(score)
            print(shuffledNum)
            updateScore()
        } else { return }
        for i in 0...shuffledNum.count-1{
            if shuffledNum[i] == 0 {
                char[i].image = images[0]
            }
            else if shuffledNum[i] == 1 {
                char[i].image = images[1]
            }
            else if shuffledNum[i] == 2 {
                char[i].image = images[2]
            } else { return }
        }
    }
    func char2ButtonClick() {
        char2Button.tag = 1
        if score < 96 && char2Button.tag == shuffledNum[0] {
            shuffledNum.remove(at: 0)
            shuffledNum.append(Int.random(in: 0...2))
            print(score)
            print(shuffledNum)
            updateScore()
        } else if score >= 96 && char2Button.tag == shuffledNum[0] {
            shuffledNum.remove(at: 0)
            print(score)
            print(shuffledNum)
            updateScore()
        } else { return }
        for i in 0...shuffledNum.count-1{
            if shuffledNum[i] == 0 {
                char[i].image = images[0]
            }
            else if shuffledNum[i] == 1 {
                char[i].image = images[1]
            }
            else if shuffledNum[i] == 2 {
                char[i].image = images[2]
            } else { return }
        }
    }
    func char3ButtonClick() {
        char3Button.tag = 2
        if score < 96 && char3Button.tag == shuffledNum[0] {
            shuffledNum.remove(at: 0)
            shuffledNum.append(Int.random(in: 0...2))
            print(score)
            print(shuffledNum)
            updateScore()
        } else if score >= 96 && char3Button.tag == shuffledNum[0] {
            shuffledNum.remove(at: 0)
            print(score)
            print(shuffledNum)
            updateScore()
        } else { return }
        for i in 0...shuffledNum.count-1{
            if shuffledNum[i] == 0 {
                char[i].image = images[0]
            }
            else if shuffledNum[i] == 1 {
                char[i].image = images[1]
            }
            else if shuffledNum[i] == 2 {
                char[i].image = images[2]
            } else { return }
        }
    }
    
    //MARK: 다시하기 클릭 시 unwindSegue
    @IBAction func unwindToGameView(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
