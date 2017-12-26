//: Playground - noun: a place where people can play

import UIKit


//范围匹配
let esports = ["A","B","C","D"]
esports[3...] //索引3之后的所有数据
esports[...2]

let  asciiCode = zip(65..., esports)


func gameRank(_ index:Int) -> String {
    switch index {
    case ...1:
        return "输入的数字小于等于1"
    case 3...:
        return "输入的数字大于等于3"
    default:
        return "其他"
    }
}
/*case ..<1:
        return "输入的数据小于1不包括1"
 */
gameRank(-1)



// 字符串新增特性

let text = "Felix Zhao"
text.count
text.isEmpty
"".isEmpty
" ".isEmpty
String(text.reversed())

for c in text
{
    print(c)
}

let index = text.index(text.startIndex, offsetBy: 2)
print(text[index])

print(text[index...]) //指定索引之后的字符串

/*
 字符串的本质是一个字符数组
 括号也算一个字符
 */
text.uppercased()
text.lowercased()

//类型判断
type(of: 10)
type(of: text)

//多行字符串显示

let firstVerse = """
    Felix
    Zhao
"""

//将数组转换为键是唯一的键值字典
let groceries = Dictionary(uniqueKeysWithValues:zip(1..., ["A","B","C","D"]))


//键值数组转换为字典
let dic1 = [("1","a"),("2","b")]
let newDic = Dictionary(dic1){
    (current,_) in
    current
}

let dic = Dictionary(dic1.map{($0.0,[$0.1])},
                     uniquingKeysWith: { (current, new) in
                     return current + new
                        })
dic


//筛选
let  old = [1:"A",2:"B",3:"C",4:"D"]
let new = old.filter({$0.key % 2 == 1})
let new1 = old.filter({$0.value == "A"})
let mapNew = old.mapValues({String($0.reversed())})

//分组
let names = ["Felix","Fei","Xhao","Yfe"].map{$0.capitalized}
let nameGroup = Dictionary(grouping:names){$0.prefix(1)}//根据首字母相同的进行分组






