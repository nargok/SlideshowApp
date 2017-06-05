//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 後閑諒一 on 2017/05/28.
//  Copyright © 2017年 ryoichi.gokan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton! //進むボタン
    @IBOutlet weak var prevButton: UIButton! //戻るボタン
    @IBOutlet weak var slideShowButton: UIButton! //再生・停止ボタン
    
    let imageNames: [String] = ["dawn", "morning", "evening"]  //画像の名前
    let buttonNames: [String] = ["再生", "停止"] //ボタンの名前
    var timer: Timer!
    var imageNameFrom2X: String!  //拡大画像から戻る画像の名前を格納する
    var count: Int = 0       //画像変更のためのカウンタ
    var buttonCount: Int = 0 //ボタン変更のためのカウンタ
    
    @IBOutlet weak var landscapeView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // selector: #selector(updatetimer) で指定された関数
    // timeInterval: 2.0, repeats: true で指定された通り、2.0秒ごとに呼び出され続ける
    func updateTimer(timer: Timer) {
        count += 1  //次の画像へ切り替えるためにカウンタをカウントアップする
        
        //最後の画像で進むボタンを押したときは、最初の画像を表示する
        if count == imageNames.count {
            count = 0
        }
        landscapeView.image = UIImage(named: imageNames[count])
    }
    
    //進むボタン
    @IBAction func nextBtn(_ sender: UIButton) {
        count += 1  //次の画像へ切り替えるためにカウンタをカウントアップする
        
        //最後の画像で進むボタンを押したときは、最初の画像を表示する
        if count == imageNames.count {
            count = 0
        }
        landscapeView.image = UIImage(named: imageNames[count])
    }

    //戻るボタン
    @IBAction func prevBtn(_ sender: UIButton) {
        count -= 1  //前の画像へ切り替えるためにカウンタをカウントダウンする
        
        //最初の画像で戻るボタンを押したときは、最後の画像を表示する
        if count < 0 {
            count = imageNames.count - 1
        }
        landscapeView.image = UIImage(named: imageNames[count])
    }
    
    //再生、停止ボタン
    @IBAction func slideShowBtn(_ sender: UIButton) {
        //再生ボタンを押すとタイマー作成、始動
        //動作中のタイマーはひとつであるため、timerがnilのときのみスタートさせる
        if self.timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateTimer), userInfo: nil,  repeats: true)
            
            //進むボタン、戻るボタンをタップ不可にする
            nextButton.isEnabled = false
            prevButton.isEnabled = false
            
            //再生ボタンを押したら、停止ボタンに変える
            slideShowButton.setTitle("停止", for: .normal)

        } else {
        //スライドショーが再生されている場合、停止
            self.timer.invalidate()
            self.timer = nil
            
            //進むボタン、戻るボタンをタップ可能にする
            nextButton.isEnabled = true
            prevButton.isEnabled = true
            
            //停止ボタンを押したら、再生ボタンに変える
            slideShowButton.setTitle("再生", for: .normal)
        }
    }

    //遷移先の画面に画像情報を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueから遷移先のSecondViewControllerを取得する
        let secondViewController:SecondViewController = segue.destination as! SecondViewController
        // 遷移先のSecondViewControllerで宣言しているimageNameに値を代入して渡す
        imageNameFrom2X = imageNames[count]
        secondViewController.imageName = imageNameFrom2X
    }
    
    @IBAction func onTapImage(_ sender: Any) {
        //セグエを指定して画面遷移
        performSegue(withIdentifier: "expand", sender: nil)
    }
        
    @IBAction func unwind(sugue: UIStoryboardSegue){
        //拡大画像から戻った時に、拡大する前の画像を設定する
        landscapeView.image = UIImage(named: imageNameFrom2X)
    }
    
}

