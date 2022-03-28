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

