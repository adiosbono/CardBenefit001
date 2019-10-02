//
//  CardEditVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 27/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class CardEditVC: UIViewController, UITextFieldDelegate{
    
    //내가 생각하는 곧 터질 에러의 주범!!!디비 DAO클라스!!!주의!!!폭발위험
    var cardDAO : CardDAO!
    
    
    
    //변수들을 설정해놓자
    @IBOutlet var cardNameField: UITextField!
    @IBOutlet var nickNameField: UITextField!
    @IBAction func uploadImage(_ sender: UIButton) {
    }
    @IBOutlet var trafficSegment: UISegmentedControl!
    @IBOutlet var overseaSegment: UISegmentedControl!
    
    //화면에 미리 입력해둘 데이터들을 넘겨받을 임시변수들을 정의한다.
    var cardId: Int!
    var cardName: String!
    var image: String?
    var nickName: String?
    var traffic: Bool!
    var oversea: Bool!
    
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //우측 바버튼(done버튼)을 눌럿을때 실행될 함수임
    @objc func finished() {
        
        //오류나는 이유는 바로 DAO클라스의 함수를 실행할 때에 nil값이 쳐 들어가기 때문임...
        //이걸 잡기 위해선 DAO클라스 내에 입력값 검사 로직을 둬서 값이 nil일땐 디비 수정을 안하도록 해야할듯
        //디버깅을 위해서 변수에 있는 값들을 출력하도록 해봄
        print(self.cardId)
        print(self.cardName)
        print(self.nickName)
        print(self.image)
        print(self.traffic)
        print(self.oversea)
        
        
        //잠깐만 주석처리해놈...실행되나좀 보게
        cardDAO.editCardAttribute(cardId: cardId, cardName: cardName, nickName: nickName, image: image, traffic: traffic, oversea: oversea)
        print("카드내용변경 완료!")
        
        //화면 뒤로가기 구현해야함
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "카드편집"
        
        //프로그래밍 방식으로 네비게이션 바 버튼 만들기 //finished 라는 함수를 실행하도록 하였다.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(finished))
        self.navigationItem.rightBarButtonItem = doneButton
        
        //화면의 초기값을 집어넣어준다(선택한 셀의 정보 표시)
        self.cardNameField.text = self.cardName
        self.nickNameField.text = self.nickName
        //self.uploadImage이녀석은 어케해야될지 생각좀해보자
        //세그먼트의 초기값을 다른데서 불러온 값으로 설정한다.
        self.trafficSegment.selectedSegmentIndex = self.traffic == true ? 1 : 0
        self.overseaSegment.selectedSegmentIndex = self.oversea == true ? 1 : 0
        
        //텍스트필드 딜리게이트 설정
        self.cardNameField.delegate = self
        self.nickNameField.delegate = self
        
        //세그먼트 컨트롤의 값이 변경되면 특정 함수를 실행하도록 하여 임시변수의 값에 변동사항을 저장
        self.trafficSegment.addTarget(self, action: #selector(trafficValueChange), for: .valueChanged)
        self.overseaSegment.addTarget(self, action: #selector(overseaValueChange), for: .valueChanged)
    }
    
    //교통카드 세그먼트 값 변동시 실행될 함수
    @objc func trafficValueChange() {
        self.traffic = self.trafficSegment.selectedSegmentIndex == 1 ? true : false
    }
    
    //해외결제 세그먼트 값 변동시 실행될 함수
    @objc func overseaValueChange() {
        self.oversea = self.overseaSegment.selectedSegmentIndex == 1 ? true : false
    }
}
