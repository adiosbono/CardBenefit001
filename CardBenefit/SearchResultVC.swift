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
        switch indexPath.row {
        case 0:
            return
        case 1:
            return
        case 2:
            return
        case 3:
            return
        case 4:
            return
        case 5:
            return
        case 6:
            return
        default:
            return
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
}
