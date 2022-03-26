/** 冒泡排序
 - note: 时间复杂度：
 * 最好的表现是O(n)，在数组已经排好序的情况下。
 * 最差的表现是O(n²)。
 
*/
public func bubbleSort<Element>(_ array: inout [Element]) where Element: Comparable {
// 元素数量少于两个无需进行排序
    guard array.count >= 2 else {
        return
    }
    for end in (1..<array.count).reversed() {
        var swapped = false
        for current in 0..<end {
            if array[current] > array[current+1] {
                array.swapAt(current, current + 1)
                swapped = true
            }
        }
        if !swapped {
            return
        }
    }
}

