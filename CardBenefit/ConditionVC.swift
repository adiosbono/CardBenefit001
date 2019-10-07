//
//  conditionVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 07/10/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class ConditionVC: UIViewController{
    
    //변수를 정의
    //사이드 바 오픈 기능을 위임할 델리게이트
    var delegate: RevealVC?
    
    //Done버튼...
    @IBAction func doneButton(_ sender: UIButton) {
        print("ConditionVC의 done눌러짐")
        if delegate == nil {
            print("딜리게이트가 닐이여브러")
        }
        self.delegate?.closeConditionBar(nil) //사이드 바를 닫는다
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
