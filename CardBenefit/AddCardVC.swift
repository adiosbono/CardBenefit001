//
//  CardEditVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 25/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

//UITextFieldDelegate는 텍스트필드를 사용하기 위한것
class AddCardVC: UIViewController, UITextFieldDelegate{
    
    //작성내용을 임시 저장해 둘 변수들
    var cardName: String?
    var nickName: String?
    var traffic: Bool?
    var oversea: Bool?
    var image: UIImage?
    
    //화면상에 나타난 컨트롤들을 연결
    @IBOutlet var cardNameField: UITextField!
    @IBOutlet var nickNameField: UITextField!
    @IBOutlet var trafficSegment: UISegmentedControl!
    @IBOutlet var overseaSegment: UISegmentedControl!
    @IBAction func uploadImage(_ sender: UIButton) {
    }
    
    //카드명 텍스트필드의 입력 완료시 임시저장한다.
    func textFieldDidEndEditing(_ textField: UITextField) {
        //텍스트필드에 뭔가 입력했을때에만 임시변수에 저장한다.
        if cardNameField.hasText {
        cardName = cardNameField.text
        }
        if nickNameField.hasText {
        nickName = nickNameField.text
        }
    }
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //우측 바버튼(done버튼)을 눌럿을때 실행될 함수임
    @objc func finished() {
        //입력값이 제대로 들어갔는지 확인하는 로직 입력
        //별칭 및 이미지를 제외하고 값이 없는경우 알라트 띄운다
        if cardName == nil {
            self.alert("카드이름을 입력해주세요")
        }else if traffic == nil {
            self.alert("교통카드 사용가능여부를 체크해주세요")
        }else if oversea == nil{
            self.alert("해외결제 가능여부를 체크해주세요")
        }else {
            //원래 화면으로 돌아가는 로직
            self.navigationController?.popViewController(animated: true)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "카드추가"
        
        //프로그래밍 방식으로 네비게이션 바 버튼 만들기 //finished 라는 함수를 실행하도록 하였다.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.rightBarButtonItem = doneButton
        
        //세그먼트 컨트롤이 기본적으로 값을 가지고 있지 않도록 설정
        self.trafficSegment.selectedSegmentIndex = -1
        self.overseaSegment.selectedSegmentIndex = -1
        
        //텍스트필드 딜리게이트 설정
        cardNameField.delegate = self
        nickNameField.delegate = self
    }
    
    //교통카드사용가능여부 바뀌었을때 임시변수에 저장하는 메소드
    @objc func trafficValueChanged() {
        self.traffic = (self.trafficSegment.selectedSegmentIndex == 1) ? true : false
        
    }
    //해외결제가능여부 바뀌었을때 임시변수에 저장하는 메소드
    @objc func overseaValueChanged() {
        self.oversea = (self.overseaSegment.selectedSegmentIndex == 1) ? true : false
    }
}
