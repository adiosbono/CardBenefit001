//
//  SearchHomeVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 08/11/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class SearchHomeVC: UIViewController {
    
    //화면에 있는 객체들을 연결한다
        //서치바
    @IBOutlet var SearchBar: UISearchBar!
        //카드명 스위치 중괄호안의 내용은 버튼이 터치될때마다 실행된다.
    @IBAction func cardNameSW(_ sender: UISwitch) {
        print("카드명 스위치 눌림")
    }
        //별칭 스위치
    @IBAction func nickNameSW(_ sender: UISwitch) {
    }
        //메모 스위치
    @IBAction func memoSW(_ sender: UISwitch) {
    }
        //카드사용조건 스위치
    @IBAction func conditionSW(_ sender: UISwitch) {
    }
        //혜택 스위치
    @IBAction func benefitSW(_ sender: UISwitch) {
    }
        //제약조건 스위치
    @IBAction func restrictionSW(_ sender: UISwitch) {
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //스위치가 눌릴때매다 실행될 함수...스위치의 값을 검사하여 모두 0 이 된 경우 마지막에 0으로 만든 녀석을 다시 1로 돌린다
    func switchCheck() {
        
    }

}
