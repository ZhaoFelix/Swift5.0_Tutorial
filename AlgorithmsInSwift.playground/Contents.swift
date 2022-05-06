import Foundation
var array = [9, 2, 3, 5, 7]
// 类似于指针
bubbleSort(&array)

selectionSort(&array)

insertionSort(&array)


var heap = Heap(sort: >, elements: [10, 4, 3, 2, 7, 1, 8, 5])


//  关于stride方法

// 包括上限值
for i in stride(from: 0, through: 10, by: 2) {
    print(i)
}
// 不包括上限值
print("---------")
for i in stride(from: 0, to: 10, by: 2) {
    print(i)
}

// 关于优先队列的使用

// 1、查询第n小的值
func nextMinValue(n:Int, elements: [Int]) -> Int? {
    var heap = Heap(sort: <, elements: elements)
    var current = 1
    while !heap.isEmpty {
        let element = heap.remove()
        if current == n {
            return element
        }
        current += 1
    }
    return nil
}
// 查询堆中第三小的数字
nextMinValue(n:3, elements: [10, 4, 3, 2, 7, 1, 8, 5])


// 优先队列

var priorityQueue = PriorityQueue(sort: <, elements: [1,12,3,4,1,6,7,8])


let p1 = Person(name: "Josh", age: 21, isMilitary: true)
let p2 = Person(name: "Jake", age: 22, isMilitary: true)
let p3 = Person(name: "Clay", age: 28, isMilitary: false)
let p4 = Person(name: "Cindy", age: 28, isMilitary: false)
let p5 = Person(name: "Sabrina", age: 30, isMilitary: false)

let waitlist = [p1, p2, p3, p4, p5]

var waitlistPriorityQueue = PriorityQueue(sort: tswiftSort, elements: waitlist)

while !waitlistPriorityQueue.isEmpty! {
    print(waitlistPriorityQueue.dequeue())
}

/*
 时间复杂度
 
 1、常数级的时间复杂度
 无论数据如何增加或者减少，算法的时间复杂度都是常数，即O(1)。
 
 2、线性级的时间复杂度
 O(n)，n表示数据量
 
 3、指数级的时间复杂度
 O(n²)
 
 4、对数级的时间复杂度
 O(logn)
 
 5、 准线性的时间复杂度
 O(n logn)
 */

/// 常数级的时间复杂度
func checkFirst(names: [String]) {
    if let first = names.first {
        print(first)
    } else {
        print("no names")
    }
}

/// 线性级的时间复杂度
/// 时间复杂度O(n)，n表示数组的长度
func printNames(names: [String]) {
    for name in names {
        print(name)
    }
}

/// 指数级的时间复杂度
func prinNames(_ names: [String]) {
    for _ in names {
        for name in names {
            print(name)
        }
    }
}

// 判断一个元素是否在数组中
// 对于一个无序的数组，这样查找的时间复杂度是O(n)
// 如果我们对数组排序后，对排序后的数组进行查找的时间复杂度是O(logn)

let numbers = [1, 3, 4, 5, 66, 67, 99, 450]
func naiveContains(_ value: Int, in array: [Int]) -> Bool {
    guard !array.isEmpty else {
        return false
    }
    let middleIndex = array.count / 2
    if value <= array[middleIndex] {
        for i in 0..<middleIndex {
            if array[i] == value {
                return true
            }
        }
    } else {
        for i in middleIndex..<array.count {
            if array[i] == value {
                return true
            }
        }
    }
    return false
}


/*
  时间复杂度比较
 1、计算1到n的累加和
 
 在方法一和方法二时间复杂度相同的情况下，因为方法二调用了标准库中被编译的代码，所以方法二会更快。
 方法三使用等差数列求和公式将时间复杂度优化到O(1)。
 */

/// 方法一
/// 时间复杂度O(n)
func sumFromOne(whithLoop n:Int) -> Int {
    var result = 0
    for i in 1...n {
        result += i
    }
    return result
}

/// 方法二
/// 时间复杂度O(n)
func sumFromOne(withReduce n:Int) -> Int {
    (1...n).reduce(0, +)
}

/// 方法三
/// 时间复杂度O(1)
func sumFromOne(withMath n:Int) -> Int {
    n*(n+1)/2
}



/*
 空间复杂度
 */

/// 空间复杂度为O(n)
/// `array.sorted()`创建了一个和原数组长度相同的数据用来存储排序后的数组对象。
func printSorted(_ array: [Int]) {
    let sorted = array.sorted()
    for element in sorted {
        print(element)
    }
}

func printSorted(array: [Int]) {
    guard !array.isEmpty else {
        return
    }
    
    var currentCount = 0 // 记录输出的个数
    var minValue = Int.min
    
    // 循环遍历打印出最小值
    for value in array {
        if value == minValue {
            print(value)
            currentCount += 1
        }
    }
    
    while currentCount < array.count {
        // 获取数组中的最大值
        var currentValue = array.max()!
        
        
        for value in array {
            if value < currentValue && value > minValue {
                currentValue = value
            }
        }
        
        for value in array {
            if value == currentValue {
                print(value)
                currentCount += 1
            }
        }
        
        minValue = currentValue
    }
    
}


/// 栈相关

var stack = Stack<Int>()
stack.push(1)
stack.push(2)
print(stack)

func example() {
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped: \(poppedElement)")
    }
}


// 栈的相关应用
// 倒置一个数组
func printInReverse<T>(_ array: [T]) {
    var stack = Stack<T>()
    
    for value in array {
        stack.push(value)
    }
    
    while let value  = stack.pop() {
        print(value)
    }
}


// 判断一个字符串中的圆括号是否成对存在
// 时间和空间复杂度均为O(n)
func checkParentheses(_ string: String ) -> Bool {
    var stack = Stack<Character>()
    for character in string {
        if character == "(" {
            stack.push(character)
        } else if character == ")" {
            if stack.isEmpty {
                return false
            } else {
                stack.pop()
            }
        }
    }
    return stack.isEmpty
}

checkParentheses("(34543)")



// 链式表

let node1 = Node(value: 1)
let node2 = Node(value: 2)
node1.next = node2
print(node1)

var linkedList = LinkedList<Int>()
linkedList.push(1)
linkedList.push(2)
linkedList.push(3)
linkedList.append(4)

var middleNode = linkedList.node(at: 1)!
middleNode = linkedList.insert(-1, afater: middleNode)
print(linkedList)
// 通过扩展实现Collection协议，实现链表的索引访问
print(linkedList[linkedList.startIndex])
print(linkedList.startIndex)
print(linkedList.endIndex)
print(Array(linkedList.prefix(3)))

// 判断一个节点是否被引用共享
print(isKnownUniquelyReferenced(&linkedList.head))
var linkedList2 = linkedList
linkedList.append(11)
print(linkedList2)
print(linkedList)

let node = linkedList2.node(at: 0)
linkedList2.remove(after: node!)
print(linkedList2)
