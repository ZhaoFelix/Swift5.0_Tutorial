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

