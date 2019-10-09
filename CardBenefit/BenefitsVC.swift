//
//  BenefitsVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 07/10/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class BenefitsVC: UIViewController, UITextFieldDelegate{
    
    //변수를 정의
    
    //cardId넘겨받을 변수 선언
    var cardId: Int!
    //혜택받을곳이 어딘지 표시해주는 텍스트필드
    @IBOutlet var store: UITextField!
    //혜택받을곳 선택하는 버튼
    @IBAction func selectButton(_ sender: UIButton) {
        let uvc = self.storyboard!.instantiateViewController(withIdentifier: "shop") as! ShopVC
        uvc.originVC = self
        present(uvc, animated: true, completion: nil)
    }
    //혜택내용 추가 버튼
    @IBAction func addBenefit(_ sender: UIButton) {
    }
    
    //제약조건 추가 버튼
    @IBAction func addRestriction(_ sender: UIButton) {
    }
    
    //사이드 바 오픈 기능을 위임할 델리게이트
    var delegate: RevealVC?
    
    //Done버튼...
    @IBAction func doneButton(_ sender: UIButton) {
        print("BenefitsVC의 done눌러짐")
        
        //사용자가 키보드를 내리지 않고 done버튼을 눌렀을 경우에 대비해서 키보드를 내리는 함수를 실행한다.
        self.store.resignFirstResponder()
        
        self.delegate?.closeConditionBar(nil) //사이드 바를 닫는다
    }
    
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //textField.endEditing(true)
        //원래 있던 녀석
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트필드의 딜리게이트 메소드를 연결하려면 반드시 아래 구문이 필요함
        self.store.delegate = self
    }
}
