//元组  本质也是一种数组,不同点在于元组中元素个数和类型是固定的
let a: [number, string,boolean] = [1, 'AAA😫', true];
//访问
console.log(a[1]); // 结果: AAA😫
//解构赋值
let [number, str, bool] = a;
console.log(num); // 1
//增删元素
a.push('😓')
console.log(a) //结果: [1, 'AAA😫', true, '😓']
a.pop
console.log(a) //结果: [1, 'AAA😫', true]
//交换元素
let tuple: [any, any] = [1, 'A'];
tuple = [tuple[1], tuple[0]];
//函数返回元组，可以返回多个值
function getTuple(): [number, string] {
    return [1, 'A'];
}
const [x, y] = getTuple();
console.log(x, y); // 1 A



//Map 键值对集合
let map1 = new Map<string, number>();
map1.set("a", 1);
map1.set("b", 2);
map1.set("c", 3);
console.log(map1); // Map(3) { 'a' => 1, 'b' => 2, 'c' => 3 }
map1.delete("b");
console.log(map1); // Map(2) { 'a' => 1, 'c' => 3 }
console.log(map1.get("a")); // 1
//另一种定义方式
let map2 = new Map([
  ["a", 1],
  ["b", 2],
  ["c", 3],
]);
//循环
for (let [key, value] of map2) {
  console.log(key,value); // a 1, b 2, c 3
}
for (let [key, value] of map2.entries()) {
  console.log(key,value); // a 1, b 2, c 3
}
for (let key of map2.keys()) {
  console.log(key); // a, b, c
}





//Set集合 可去重
let set1 = new Set<number>([1, 2, 3, 4, 5, 1, 2]);
console.log(set1); // Set(5) { 1, 2, 3, 4, 5 }
set1.add(6);
console.log(set1); // Set(6) { 1, 2, 3, 4, 5, 6 }
set1.delete(2); 
console.log(set1); // Set(5) { 1, 3, 4, 5, 6 }
console.log(set1.has(3)); // true   
for (let item of set1) {
  console.log(item); // 1, 3, 4, 5, 6
}
for (let item of set1.values()) {
  console.log(item); // 1, 3, 4, 5, 6
}
for (let item of set1.entries()) {
  console.log(item); // [ 1, 1 ], [ 3, 3 ], [ 4, 4 ], [ 5, 5 ], [ 6, 6 ]
  // 注意：Set 的 entries() 方法返回的每个元素是一个数组，数组的两个元素都是相同的值
}
for (let item of set1.keys()) {
  console.log(item); // 1, 3, 4, 5, 6
}
for (let item of set1) {
  console.log(item); // 1, 3, 4, 5, 6
}


//练习：两个数组的交集
//Set方法
let intersection1 = (arr1: number[], arr2: number[])=> {
    return [...new Set(arr1)].filter((item => arr2.indexOf(item) !== -1));
};
console.log(intersection1([1, 1, 2, 3, 3, 4], [2, 3, 4, 5, 6])); // 结果: [2, 3, 4]
//Map方法
let intersection2 = (arr1: number[], arr2: number[]) => {
    let map = new Map();
    let result: number[] = [];
    arr1.forEach(item => map.set(item, true));
    arr2.forEach(item => {
        if (map.has(item)) {
            result.push(item);
            map.delete(item); // 确保结果中没有重复元素
        }
    });
    return result;
};