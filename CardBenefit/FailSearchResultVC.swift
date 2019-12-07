//
//  SearchResultVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 08/11/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class FailSearchResultVC: UITableViewController {
    
    //검색옵션에서 선택한 값들을 넘겨받을 변수를 정의한다
    var cardName: Bool!
    var nickName: Bool!
    var memo: Bool!
    var condition: Bool!
    var shop: Bool!
    var restriction: Bool!
    var benefit: Bool!
    //검색창에 입력한 검색어
    var keyWord: String!
    
    //디비사용하기 위한 객체 선언
    let cardDAO = CardDAO()
    
    //디비입력을 받으려고 정의한 객체들
    typealias CardRecord = (Int, String, String?, String?, Int, Int, String?, Int)
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //넘겨받은 검색조건들에 해당하는 sql문을 실행하고 검색결과를 받는다.
        
    }


    
    //테이블 섹션의 개수를 결정하는 메소드...
    //맨 첨에는 검색설정에 따라 반환값바뀌게 하였으나 에러나서 고정값으로 설정함
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 7
        /*
        var count = 0
        if(self.cardName == true){
            count = count + 1
        }else if(self.nickName == true){
        count = count + 1
        }else if(self.memo == true){
            count = count + 1
        }else if(self.condition == true){
            count = count + 1
        }else if(self.shop == true){
            count = count + 1
        }else if(self.restriction == true){
            count = count + 1
        }
        //혹시라도 카운트가 0이면 1을 반환하고(최소한 1개의 섹션은 있어야하기때문) 0이 아니면 카운트를 반환한다
        if(count == 0){
            return 1
        }else{
            return count
        }
 */
    }
    
    //각각의 테이블 행을 구성하는 메소드
    //override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    //}
    
    //테이블의 특정 행이 선택되었을때 호출되는 메소드
    //override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    //}
    
    //각 행 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        print("\(indexPath)행높이값 : \(UITableView.automaticDimension)")
        //시스템이 알이서 정하게 두는 방법
        return UITableView.automaticDimension
        //각 섹션별로 다르게 주고싶은경우 알아서 숫자 입력
        /*
        switch indexPath.section {
        case 0 :
            return UITableView.automaticDimension
        case 1 :
            return UITableView.automaticDimension
        case 2 :
            return UITableView.automaticDimension
        case 3 :
            return UITableView.automaticDimension
        case 4 :
            return UITableView.automaticDimension
        case 5 :
            return UITableView.automaticDimension
        default :
            return UITableView.automaticDimension
        }
 */
    }
    
    //테이블 행의 개수를 결정하는 메소드
    //각각의 섹션에 해당하는 검색결과의 갯수만큼을 return 해야 한다.
    //지금은 에러안뜨게 하드코딩해논상태임
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        /*
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
            return 1
        case 6:
            return 1
        default:
            return 1
        }
 */
    }
    
    //각 섹션 헤더에 들어갈 뷰를 정의하는 메소드. 섹션별 타이틀을 뷰 형태로 구성하는 메소드 1080 뷰형태이기때문에 이미지도 넣을수 있는 커스텀이 가능하나 복잡하므로 난 타이틀만 넣고싶다고 하면 titleForHeaderInSection을 사용해야함
    //detailBenefitVC참고하삼
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //헤더에 들어갈 레이블 객체 정의
        let textHeader = UILabel(frame: CGRect(x: 35, y: 5, width: 200, height: 30))
        textHeader.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 2.5))
        textHeader.textColor = UIColor(red: 0.03, green: 0.28, blue: 0.71, alpha: 1.0)
        
        //헤더에 들어갈 버튼 정의
        let addButton = UIButton(type: .custom)
        //x좌표는 동적으로 실행하기 위해서 이러케 해놈
        addButton.frame = CGRect(x: self.view.frame.size.width - 150, y: 5, width: 200, height: 30)
        addButton.setTitleColor(UIColor.black, for: .normal)
        //섹션에 따라 타이틀 다르게 설정
        switch section {
        case 0:
            textHeader.text = "카드이름"
        case 1:
            textHeader.text = "별칭"
        case 2:
            textHeader.text = "메모"
        case 3:
            textHeader.text = "카드사용조건"
        case 4:
            textHeader.text = "상점명"
        case 5:
            textHeader.text = "혜택"
        case 6:
            textHeader.text = "제약"
        default:
            textHeader.text = "KissMyAss"
        }
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
        v.backgroundColor = UIColor(red: 0.93, green: 0.96, blue: 0.99, alpha: 1.0)
        v.addSubview(textHeader)
        v.addSubview(addButton)
        
        
        return v
    }
    
    //각 섹션 헤더의 높이를 결정하는 메소드
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
