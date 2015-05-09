//
//  SwiftDataWrapper.swift
//  GoldWords
//
//  Created by yokota on 2015/04/18.
//  Copyright (c) 2015年 yokota. All rights reserved.
//

import Foundation
import Darwin

class SwiftDataWrapper {
    
    // コンストラクタ
    init(){
        if(!self.isExistsDataBase()){
            // 基本テーブルがなかったら作る
            let(result, msg) = self.create_basic_tables();
        }else{
            println("you are already created table");
        }
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as! Array<String>;
        println(paths)
        
    }
    
    //  テーブルの存在確認
    func isExistsDataBase() ->Bool{
        let (tb, err) = SwiftData.existingTables();
        if(!contains(tb,"gold_word")){
            //  hoge_mstがない
            return false;
        }else{
            return true;
        }
        
    }
    
    // テーブルを作る
    func create_basic_tables() ->(Bool, String){
        
        //  gold_wordを作る
        if let err = SwiftData.createTable("gold_word", withColumnNamesAndTypes: ["name" : .StringVal, "created_on":.DateVal]){
            //  エラー発生
            println(SwiftData.errorMessageForCode(err));
            return(false, "error ocured in creating_hoge_mst");
        }else{
            println("you created table!");
        }
        
        return (true,"schema initialize succeeded");
    }
    
    // 名言と名言を言った人を取得
    func getOneGoldWord() -> (String, String){
        let query = "select * from goldwords as g inner join tags on g.id = tags.mid where tags.tags in ('マネージメント','自己','人生')"
        let (resultSet, err) = SwiftData.executeQuery(query)
        var greatman = "よこたガガーリン";
        var goldword = "地球は丸かった。\"海\"\"陸\"が見えなくなるくらい。いいこと、づくしだった。  ";
        if err != nil{
            println(err)
        }else{
            
            if resultSet.isEmpty {
                println("データがありません")
                return (goldword, greatman)
            }
            
            let random_int = Int(arc4random_uniform(UInt32(resultSet.count)));
            for (index,row) in enumerate(resultSet){
                if let name = row["name"]?.asString(){
                    greatman = name;
                }else{
                    println("database has no column name 'name'");
                }
                
                if index == random_int{
                    break
                }
                
                if let word = row["goldwords"]?.asString(){
                    goldword = word;
                    goldword = goldword.stringByReplacingOccurrencesOfString("\n", withString: "", options: nil, range: nil);
                    goldword = goldword.stringByReplacingOccurrencesOfString("。", withString: "。\n", options: nil, range: nil);
                    goldword = goldword.stringByReplacingOccurrencesOfString("、", withString: "、\n", options: nil, range: nil);
                    goldword = goldword.stringByReplacingOccurrencesOfString(".", withString: ".\n", options: nil, range: nil);
                    let pattern = "(\".*?\")"
                    goldword = goldword.stringByReplacingOccurrencesOfString(pattern, withString: "$1\n", options: NSStringCompareOptions.RegularExpressionSearch, range: nil);
                    goldword = goldword.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet());
                }else{
                    println("database has no column name 'goldwords'");
                }
            }
            
        }
        return (goldword, greatman)
    }
    
}