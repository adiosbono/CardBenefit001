//
//  CardEditVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 27/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class CardEditVC: UIViewController{
    
    //우측 바버튼(done버튼)을 눌럿을때 실행될 함수임
    @objc func finished() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "카드편집"
        
        //프로그래밍 방식으로 네비게이션 바 버튼 만들기 //finished 라는 함수를 실행하도록 하였다.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.rightBarButtonItem = doneButton
        
    }
}
