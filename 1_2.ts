//数组
let arr1:number[] = [1,2,3]
let arr2:Array<number> =[1,2,3]
let arr3:Array<number|string> =[1,2,3,"A"]
//二维数组
interface Person{
    name:string;
    age:number;
}
let arr4:Person[]=[
    {name:'a',age:1},
    {name:'b',age:2},
]
console.log(arr4)
//访问一个数据
console.log(arr4[0].name)
console.log(arr4[1]['name'])



//循环
for(let i=0;i<arr4.length;i++){
    console.log(arr4[i].name);
}
//迭代循环
for(let item of arr4){
    console.log(item.age);
}
//forEach高阶函数，老式的写法
arr4.forEach(function(item){
    console.log(item.name);
})

//ES6箭头函数写法
arr4.forEach((item)=>{
    console.log(item.age);
})
//省略大括号
arr4.forEach(item => console.log(item.name));


//数组方法
let arr5:number[] = [1,2,3,4,5];
//join
console.log(arr5.join('-')); //连接数组元素,使用'-'分隔
//slice
console.log(arr5.slice(1,3)); //截取数组元素,从索引1开始到索引3（不包括3）
//splice
console.log(arr5.splice(1,2)); //删除数组元素,从索引1开始删除2个元素
//reverse
console.log(arr5.reverse()); //反转数组
//concat
console.log(arr5.concat([6,7,8])); //连接数组,将[6,7,8]添加到arr5的末尾
//indexOf
console.log(arr5.indexOf(1)); //查找元素1在数组中的索引
//lastIndexOf
console.log(arr5.lastIndexOf(3)); //查找元素3在数组中的最后一个索引
//push
console.log(arr5.push(6,6,6)); //向数组末尾添加元素6,返回新数组长度
//unshift
arr5.unshift(-1,0) //向数组开头添加元素-1和0,返回新数组长度
//shift
console.log(arr5.shift()); //删除数组开头的元素,返回被删除的元素
//pop
console.log(arr5.pop()); //删除数组末尾的元素,返回被删除的元素
console.log(arr5);

//排序
arr5.sort((a, b) => a - b); //升序排序
console.log(arr5);
arr5.sort((a, b) => b - a); //降序排序
console.log(arr5);

//其他高级函数
//filter筛选
interface Goods {
    name: string;
    price: number;
    count: number;
}
const goods :Goods[] = [
    { name: 'apple', price: 11, count: 2 },
    { name: 'banana', price: 5, count: 3 },
    { name: 'orange', price: 8, count: 1 },
    {name: 'pear', price: 12, count: 4 }
];
//筛选价格大于10的商品
let expensiveGoods0 = goods.filter(item=>{
    return item.price > 10;
})
console.log(expensiveGoods0);
//或
let expensiveGoods1 = goods.filter(item => item.price > 10);
console.log(expensiveGoods1);



//map映射
let arrayscore:number[] = [85,95,55];
let result = arrayscore.map(item => {
    return item > 60 ? '及格' : '不及格';
} );
console.log(result); // ['及格', '及格', '不及格']

const res = goods.map(item => ({    
    ...item,
    price: item.price * 0.8 // 直接返回新对象，不修改原对象
}));
console.log(res); // 正确的一次性 8 折

const res1 = goods.map(item => ({
    name: item.name,
    price: item.price * 0.8, // 基于原始价格计算
    count: item.count,
    checked: true
}));
console.log(res1); // 正确的一次性 8 折 + 新增属性

//映射和筛选一起使用
const res2 = goods.filter(item => item.price > 10).map(item => {
    return {
        name: item.name,
        price: item.price * 0.8, //打8折
        count: item.count,
        checked: true //新增属性
    }
});
console.log(res2); // 筛选价格大于10的商品并打折，新增checked属性

//find查找
//let index = goods.findIndex(item => item.name === 'banana');
//splice删除
//goods.splice(index, 1); //删除香蕉
//console.log(goods); // 删除香蕉后的商品列表

//some函数和every函数
console.log(goods.some(item=>item.price>100))
console.log(goods.every(item=>item.price>100))

//reduce聚合
//普通写法
let arr:number[] = [1,2,3,4,5,6,7,8,9,10];
let num:number = 0;
for(let i = 1;i<arr.length;i++){
    num += arr[i]
}
console.log(num)
/*reduce写法
let num1:number = a.reduce((pre,cur)=>{
    return pre + cur;  //pre是上一次的返回值（累加器），cur是当前值
},0);  //0是初始值
console.log(num1); // 55
//省去大括号
//let numnum:number =a.reduce((pre, cur) => pre + cur, 0);
*/

