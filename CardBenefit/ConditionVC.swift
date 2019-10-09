//
//  conditionVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 07/10/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class ConditionVC: UIViewController, UITextFieldDelegate{
    
    //변수를 정의
    
        //세부혜택화면DetailBenefitVC의 인스턴스를 받기위한 변수...조건추가완료후 테이블 리로드하기 위함임
    
        //card_id에 넣을 인자값을 전달받기위한 변수정의
    var cardId: Int!
    
        //DAO객체
    let cardDAO = CardDAO()
        //추가버튼
    @IBAction func add(_ sender: UIButton) {
        //디비에 사용조건을 추가하고 추가완료되면 텍스트필드를 클리어한다.
        //사용조건추가
        //inputField값이 nil인 경우에는 추가로직이 실현되지 않도록 하자.
        if inputField.text == "" {
            //텍스트필드에 아무 값도 입력하지 않은 경우
            self.alert("추가할 조건을 입력하세요")
        }else{
        cardDAO.addCondition(cardId: cardId, condition: inputField.text!)
            print("디비에 카드사용조건 값 추가 완료됨")
            //값 추가되었다는 비주얼적인 작용이 일어나지 않으면 사용자는 추가되었다고 인식하지 않으므로 키보드를 내리고, 텍스트필드에 들어간 값을 지우고, 알라트 팝업으로 추가되었다는걸 알리자.
                //키보드내리기
            inputField.resignFirstResponder()
                //텍스트필드의 값 비우기
            inputField.text = ""
                //알라트 팝업 띄우기
            self.alert("카드사용조건이 추가되었습니다")
        }
        
        
        
    
    }
    //추가조건 입력할 텍스트필드
    @IBOutlet var inputField: UITextField!
    
    
    
    //사이드 바 오픈 기능을 위임할 델리게이트
    var delegate: RevealVC?
    
    //Done버튼...
    @IBAction func doneButton(_ sender: UIButton) {
        print("ConditionVC의 done눌러짐")
        
        self.delegate?.closeConditionBar(nil) //사이드 바를 닫는다
    }
    
    
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트필드의 딜리게이트 메소드를 연결하려면 반드시 아래 구문이 필요함
        self.inputField.delegate = self
    }
}
