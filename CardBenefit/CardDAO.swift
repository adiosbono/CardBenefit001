//
//  CardDAO.swift
//  CardBenefit
//
//  Created by Bono b Bono on 16/09/2019.
//  Copyright © 2019 Bono b Bono. All rights reserved.
//

import Foundation
import UIKit
//FMDB를 cocoapods를 이용하여 설치하였으므로 브릿징헤더파일도 필요가 없고 사용할땐 아래 임포트 구문만 작성하면 된다.
import FMDB

class CardDAO {
    //CardVO에 들어있는순서대로 cardId, cardName, image, nickName, traffic, oversea, memo
    //차이점이라고 한다면 image가 데이터베이스에는 이름만 저장되므로 여기선 String?이지만 CardVO에선 UIImage?임
    //튜플객체임
    typealias CardRecord = (Int, String, String?, String?, Int, Int, String?, Int) //메인테이블용
    //순서대로 condition
    typealias ConditionRecord = String?//컨디션테이블용
    //순서대로 shop, advantage, restrict
    typealias SAR = (String?, String?, String?)
    
    
    //SQLite 연결 및 초기화
    lazy var fmdb : FMDatabase! = {
        //파일매니저객체 생성(1022)
        let fileMgr = FileManager.default
        //샌드박스 내 문서디렉토리 주소를 따서 데이터베이스 파일 경로를 만든다
        let docPath = fileMgr.urls(for: .documentDirectory, in: .userDomainMask).first
        let dbPath = docPath!.appendingPathComponent("db.sqlite").path
        
        //위에서 만든 경로에 파일이 없다면 메인 번들에 만들어 둔 db.sqlite를 가져와 복사
        if fileMgr.fileExists(atPath: dbPath) == false {
            let dbSource = Bundle.main.path(forResource: "db", ofType: "sqlite")
            try! fileMgr.copyItem(atPath: dbSource!, toPath: dbPath)
            print("번들에 들어있는 템플릿용 디비파일을 복사해서 문서디렉토리에 저장햇습니다")
        }
        
        //준비된 데이터베이스 파일을 바탕으로 FMDatabase객체 생성
        let db = FMDatabase(path: dbPath)
        //임시로 디비가 저장된 경로를 표시함...찾아볼껴 수정되는지 진짜로
        print(dbPath)
        
        
        return db
        
    }()
    
    //생성자와 소멸자를 정의 1024
    init() {
        self.fmdb.open()
    }
    deinit {
        self.fmdb.close()
    }
    
    
    //디비의 메인테이블 목록을 읽어올 메소드 정의
    func findMain() -> [CardRecord] {
        //반환할 데이터를 담을 [CardRecord] 타입의 객체 정의
        var cardList = [CardRecord]()
        
        do{
            //카드목록을 가져올 sql작성 및 쿼리 실행
            let sql = """
                SELECT card_id, card_name, image_name, nick_name, transportation, foreign_use, memo, orders
                FROM main
                ORDER BY orders ASC
"""
            
            let rs = try self.fmdb.executeQuery(sql, values: nil)

            //결과 집합 추출
            while rs.next() {
                let cardId = rs.int(forColumn: "card_id")
                let cardName = rs.string(forColumn: "card_name")
                let imageName = rs.string(forColumn: "image_name")
                let nickName = rs.string(forColumn: "nick_name")
                let transport = rs.int(forColumn: "transportation")
                let foreign = rs.int(forColumn: "foreign_use")
                let memo = rs.string(forColumn: "memo")
                let orders = rs.int(forColumn: "orders")
                //CardVO에 들어있는순서대로 cardId, cardName, image, nickName, traffic, oversea, memo
                cardList.append((Int(cardId), cardName!, imageName, nickName, Int(transport), Int(foreign), memo, Int(orders) ))
            }
            
        }catch let error as NSError {
            print("Failed: \(error.localizedDescription)")
        }
        return cardList
    }
    
    //디비의 컨티션테이블 읽어올 메소드 정의...cardId값을 인자로 받아 해당하는 Id와 일치하는 녀석만 가져온다.
    func findCondition(cardId: Int) -> [ConditionRecord] {
        //반환할 데이터를 담을 [ConditionRecord] 타입의 객체 정의
        var conditionList = [ConditionRecord]()
        
        do{
            //컨디션목록을 가져올 sql작성 및 쿼리 실행
            let sql = """
                SELECT condition
                FROM conditions
                WHERE card_id = ?
"""
            
            let rs = try self.fmdb.executeQuery(sql, values: [cardId])
            
            //결과 집합 추출
            while rs.next() {
                
                let conditions = rs.string(forColumn: "condition")//현재 반환되어 conditions에 저장된 값은 옵셔널로된 String? 임
               
                
                conditionList.append(conditions)
            }
            
        }catch let error as NSError {
            print("Failed: \(error.localizedDescription)")
        }
        return conditionList
    }
    
    //디비의 SAR 테이블 읽어올 메소드 정의 ...cardId값을 인자로 받아 해당하는 Id와 일치하는 녀석만 가져온다.
    func findSAR(cardId: Int) -> [SAR] {
        //반환할 데이터를 담을 [ConditionRecord] 타입의 객체 정의
        var SARList = [SAR]()
        
        do{
            //컨디션목록을 가져올 sql작성 및 쿼리 실행
            let sql = """
                SELECT shop, advantage, restrict
                FROM shop_adv_res
                WHERE card_id = ?
"""
            
            let rs = try self.fmdb.executeQuery(sql, values: [cardId])
            
            //결과 집합 추출
            while rs.next() {
                
                let shop = rs.string(forColumn: "shop")
                let advantage = rs.string(forColumn: "advantage")
                let restrict = rs.string(forColumn: "restrict")
                
                
                SARList.append((shop, advantage, restrict))
            }
            
        }catch let error as NSError {
            print("Failed: \(error.localizedDescription)")
        }
        return SARList
    }
    
    //orders 컬럼의 값을 수정할 함수. 인자값으로 cardId(레코드특정위함)와 order(수정하려는 순서값)를 받는다. 데이터베이스 수정이 목표기 때문에 값을 따로 반환할 필요는 없다.
    func reorder(cardId: Int, order: Int){
        
        do{
            //cardId를 통해 특정한 레코드를 찾아 그 레코드의 orders 컬럼의 값을 인자로 받은 order값으로 바꾼다
            let sql = """
                UPDATE main
                SET orders = ?
                WHERE card_id = ?
"""
            
            try self.fmdb.executeUpdate(sql, values: [order, cardId])
            print("디비수정되엇숩니다")
        
        }catch let error as NSError {
            print("Failed: \(error.localizedDescription)")
        }
    }
    
    
    //카드정보 삭제할 함수. 인자값으로 cardId를 받는다
    func delete(cardId: Int){
        
        do{
            //cardId를 통해 특정한 레코드를 찾아 그 레코드의 orders 컬럼의 값을 인자로 받은 order값으로 바꾼다
            let sql = """
                DELETE FROM main
                WHERE card_id = ?
"""
            
            try self.fmdb.executeUpdate(sql, values: [cardId])
            print("디비내 데이터 한줄이 삭제되엇숩니다")
            
        }catch let error as NSError {
            print("Failed: \(error.localizedDescription)")
        }
        
    }
}
