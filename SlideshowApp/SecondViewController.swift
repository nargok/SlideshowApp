//
//  SecondViewController.swift
//  SlideshowApp
//
//  Created by 後閑諒一 on 2017/06/02.
//  Copyright © 2017年 ryoichi.gokan. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var imageView2X: UIImageView!
    var imageName: String!
    var transScale = CGAffineTransform()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //拡大画像の設定
        imageView2X.image = UIImage(named: imageName)
        transScale = CGAffineTransform(scaleX: 2, y: 2)
        imageView2X.transform = transScale        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
