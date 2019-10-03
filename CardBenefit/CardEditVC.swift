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
    //시발 에러원인은 바로 여기였음....시벌시벌 대입을 해서 초기화를 해놔야 되는데....타입어노테이션만 해놈 멍청이
    let cardDAO = CardDAO()
    
    
    
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
    var image: String! //원래는 옵셔널이엇으나 디비에서 가져오는값에는 nil이 없으므로...
    var nickName: String! //원래는 옵셔널이엇으나 디비에서 가져오는값에는 nil이 없으므로...
    var traffic: Bool!
    var oversea: Bool!
    
    //리턴키 눌럿을때 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //우측 바버튼(done버튼)을 눌럿을때 실행될 함수임
    @objc func finished() {
        //사용자가 텍스트 입력후 엔터키 안치고 바로 done버튼 누르는 경우가 있는데 이때도 입력한것이 저장되도록 해놔야 디비에 반영됨
        if cardNameField.hasText == true {
            cardName = cardNameField.text
        }
        if nickNameField.hasText == true {
            nickName = nickNameField.text
        }
        
        //오류나는 이유는 바로 DAO클라스의 함수를 실행할 때에 nil값이 쳐 들어가기 때문임...
        //이걸 잡기 위해선 DAO클라스 내에 입력값 검사 로직을 둬서 값이 nil일땐 디비 수정을 안하도록
        //디버깅을 위해서 변수에 있는 값들을 출력하도록 해봄
        //출력해보았더니...값들이 역시나 전부 다 옵셔널값으로 나오길래(위의 변수 설정값은 깡그리 무시되고 옵셔널로 찍힘)강제로 캐스팅해봤더니 옵셔널이 풀리긴 함...
        //신기한걸 깨달았다. 디비내에서 아무 값도 없는 상태를 읽어와서 변수에 대입하면...변수는 어떤 값을 가질것 같은가? 정답은 '빈값'이다. 즉 "" 이자식이 들어가는 것이다. 맨 처음부터 데이터베이스를 설계할때 빈 값을 가져올 것을 대비해서 옵셔널을 제공했던것은 미련했던 짓이다. nil값을 반환하는 경우가 아예 없기 때문이다시부러러러러러러러러럴
        //결국 editCardAttribute함수가 제대로 실행되지 않는 것은.... 그 함수 내에 문제가 있는거라고 생각된다....어휴
        print(self.cardId)
        print(self.cardName)
        print(self.nickName)
        print(self.image)
        print(self.traffic)
        print(self.oversea)
        
        if(cardDAO == nil){
            print("cardDAO is nill");
        } else {
            print("cardDAO is not nill")
        }
        
        //잠깐만 주석처리해놈...실행되나좀 보게
        cardDAO.editCardAttribute(
            cardId: self.cardId,
            cardName: self.cardName,
            nickName: self.nickName,
            image: self.image,
            traffic: self.traffic,
            oversea: self.oversea
        )
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
    
    //텍스트필드에 입력된 값을 임시변수에 집어넣는다
    func textFieldDidEndEditing(_ textField: UITextField) {
        if cardNameField.hasText == true {
            cardName = cardNameField.text
        }
        if nickNameField.hasText == true {
            nickName = nickNameField.text
        }
    }
}
