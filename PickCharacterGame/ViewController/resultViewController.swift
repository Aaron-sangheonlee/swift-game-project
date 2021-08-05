//
//  resultViewController.swift
//  PickCharacterGame
//
//  Created by 이상헌 on 2021/08/03.
//

import UIKit
//프로토콜 선언
protocol endGameDelegate {
    func endGame()
    }
class resultViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var resultStackView: UIStackView!
    @IBOutlet weak var retryButton: UIButton!
    
    @IBAction func retryButtonAction(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToGameView", sender: self)
    }
    
    //데이터 전달 위한 delgate 선언
    var delegate : endGameDelegate?
    //subview 변수 선언
    var subview = UIView()
    //imageview 선언
    var background = UIImageView()
    var resultBoard = UIImageView()
    var timeResult: String = "a"
    var resultTitle: String = "a"
    var resultContent: String = "a"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //subview 추가
        self.view.addSubview(subview)
        self.subview.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        
        //background subview 추가
        self.subview.addSubview(background)
        self.background.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        
        //background 이미지 추가
        self.background.image = UIImage(named: "backGround")
        self.background.alpha = 0.3
        
        //stackview, button 가장 앞으로
        self.view.bringSubviewToFront(resultStackView)
        self.view.bringSubviewToFront(retryButton)
        
        self.resultStackView.backgroundColor = .systemYellow
        self.resultStackView.layer.cornerRadius = 20
        self.resultStackView.layer.borderWidth = 5
        self.resultStackView.layer.borderColor = UIColor.orange.cgColor
        
        //time 초 -> 분, 초
        if timeResult == "시간 초과ㅠㅠ" {
            self.firstLabel.text = resultTitle
            self.resultLabel.text = timeResult
            self.thirdLabel.text = resultContent
        }
        else if Int(timeResult)! >= 60 {
            let mins = Int(timeResult)! / 60
            let secs = Int(timeResult)! - (mins*60)
            if secs >= 10 {
            timeResult = "\(mins): \(secs)"
            self.resultLabel.text = String(timeResult)
            } else {
                timeResult = "\(mins):0\(secs)"
                self.resultLabel.text = String(timeResult)
            }
        } else{
            self.resultLabel.text = timeResult
        }
        //label text 받아오기
        self.firstLabel.text = resultTitle
        self.thirdLabel.text = resultContent
        
        //라벨 자동 줄 조절
        self.thirdLabel.numberOfLines = 4
        self.thirdLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //label UI 수정
        self.resultLabel.font = UIFont.systemFont(ofSize: 25)
        self.resultLabel.textColor = .blue
        self.firstLabel.font = UIFont.systemFont(ofSize: 20)
        self.thirdLabel.font = UIFont.systemFont(ofSize: 15)

        //button UI 수정
        self.retryButton.setTitle("다시하기", for: .normal)
        self.retryButton.titleLabel?.font = UIFont(name: "system", size: 20)
        self.retryButton.setTitleColor(.white, for: .normal)
        self.retryButton.backgroundColor = .orange
        self.retryButton.layer.cornerRadius = 30
    }
}
