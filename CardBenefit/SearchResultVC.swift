//
//  SearchResultVC.swift
//  CardBenefit
//
//  Created by Bono b Bono on 2019/12/07.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit

class SearchResultVC: UITableViewController{

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //넘겨받은 검색조건들에 해당하는 sql문을 실행하고 검색결과를 받는다.
        
    }
    
    //테이블 섹션의 개수를 결정하는 메소드...
    //맨 첨에는 검색설정에 따라 반환값바뀌게 하였으나 에러나서 고정값으로 설정함
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 7
    
    }
    
    //테이블 행의 개수를 결정하는 메소드
    //각각의 섹션에 해당하는 검색결과의 갯수만큼을 return 해야 한다.
    //우선은 하드코딩해놈
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //각행에 어떤녀석들이 들어갈것인지!!
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultNameCell") as! ResultNameCell
            
            //여기안에 디비에서 받아온 정보를 가지고 각 셀 안의 데이터를 입력해준다.
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultNickNameCell") as! ResultNickNameCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultMemoCell") as! ResultMemoCell
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultConditionCell") as! ResultConditionCell
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultShopCell") as! ResultShopCell
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultBenefitCell") as! ResultBenefitCell
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultRestrictionCell") as! ResultRestrictionCell
            return cell
        default:
            //그냥 쓸거없어서 카드이름으로 찾는녀석으로해놈
            let cell = tableView.dequeueReusableCell(withIdentifier: "resultNickNameCell") as! ResultNickNameCell
            return cell
        }
    }
    
    
    //섹션에 타이틀만 넣을것이므로 다음의 메소드 사용한다
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "카드이름"
        case 1:
            return "별칭"
        case 2:
            return "메모"
        case 3:
            return "카드사용조건"
        case 4:
            return "상점명"
        case 5:
            return "혜택"
        case 6:
            return "제약"
        default:
            return "eat my shorts"
        }
    }
    
    //각행의 높이를 설정한다....셀안잘리게 해야됨
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           
           print("\(indexPath)행높이값 : \(UITableView.automaticDimension)")
           //시스템이 알이서 정하게 두는 방법
        return 90.0
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
}
