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
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //카드명 스위치 값
    @IBOutlet var cardNameValue: UISwitch!
    
        //별칭 스위치
    @IBAction func nickNameSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //별칭 스위치 값
    @IBOutlet var nickNameValue: UISwitch!
    
        //메모 스위치
    @IBAction func memoSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //메모 스위치 값
    @IBOutlet var memoValue: UISwitch!
    
        //카드사용조건 스위치
    @IBAction func conditionSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //카드사용조건 값
    @IBOutlet var conditionValue: UISwitch!
    
        //혜택 스위치
    @IBAction func benefitSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //혜택 값
    @IBOutlet var benefitValue: UISwitch!
    
        //제약조건 스위치
    @IBAction func restrictionSW(_ sender: UISwitch) {
        if(self.switchCheck()){
            sender.isOn = true
        }
    }
        //제약조건 값
    @IBOutlet var restrictionValue: UISwitch!
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //스위치가 눌릴때매다 실행될 함수...스위치의 값을 검사하여 모두 0 이 된 경우 마지막에 0으로 만든 녀석을 다시 1로 돌린다
    //모든 값이 0이면 true반환, 하나라도 1이면 false반환
    func switchCheck() -> Bool {
        //if절 내에서 스위치의 값을 비교하여 모두 0이면 실행하도록 하자
        if((self.cardNameValue.isOn || self.nickNameValue.isOn || self.memoValue.isOn || self.conditionValue.isOn || self.benefitValue.isOn || self.restrictionValue.isOn) == false){
            //마지막에 실행된 스위치의 값을 다시 1로 돌리는 로직 작성
            print("모든 스위치 값이 0임을 확인함")
            self.alert("최소한 하나의 검색조건은 활성화되어야 합니다")
            return true
        }
        else{
            return false
        }
    }

}
