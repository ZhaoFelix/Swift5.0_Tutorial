var array = [9, 2, 3, 5, 7]
// 类似于指针
bubbleSort(&array)

selectionSort(&array)

insertionSort(&array)


var heap = Heap(sort: >, elements: [10, 4, 3, 2, 7, 1, 8, 5])
print(heap[heap.parentIndex(ofChildAt: 4)])

