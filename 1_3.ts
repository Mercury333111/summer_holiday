//函数
//一个普通的加法函数
function add1(a:number,b:number):number {
    return a + b;
}
console.log(add1(1,2)); //调用函数，传入参数1和2，返回3
//函数表达式，匿名函数
let add2 = function (a:number,b:number):number {
    return a + b;
};
console.log(add2(3,4)); //调用函数表达式，传入参数3和4，返回7
//箭头函数，常见
let add3 = (a:number,b:number):number => {
    return a + b;
}
console.log(add3(5,6)); //调用箭头函数，传入参数5和6，返回11
//箭头函数，省略大括号
//let add3 = (a:number,b:number):number => a + b; 
//自执行函数
(function (a:number,b:number):number {
    return a + b;
})(7,8); //立即执行函数，传入参数7和8
//回调函数
function callbackExample(callback: (a: number, b: number) => number, a: number, b: number): number {
    return callback(a, b); // 调用回调函数
}
callbackExample((x, y) => x + y, 9, 10); //传入回调函数和参数9和10，返回19
//其本质是函数也是一种数据类型，可以作为参数传递或返回值
//使用回调的filter方法
const numbers = [1, 2, 3, 4, 5];
const evenNumbers = numbers.filter((num) => num % 2 === 0); // 过滤出偶数
console.log(evenNumbers); // 输出: [2, 4]




//函数参数
//默认参数，可选参数
const add4 = (a: number, b: number = 0, c?: number): number => {
    return a + b + (c || 0); // 如果c未传入，则默认为0
}
console.log(add4(1)); // 输出: 1
console.log(add4(1, 2)); // 输出: 3
console.log(add4(1, 2, 3)); // 输出: 6
//剩余参数
const add5 = (...args: number[]): number => {
    return args.reduce((sum, current) => sum + current, 0); // 使用reduce方法计算总和
}
console.log(add5(1, 2, 3, 4)); // 输出: 10,args参数可以接收任意数量的数字，此时args是一个数组，内容是[1, 2, 3, 4]


const array: number[] = [1, 2, 8, 444, 52];
console.log(Math.max(...array)); // 使用扩展运算符将数组展开为参数列表，输出: 444



//函数类型type
type AddFunction = (a: number, b: number) => number; // 定义一个函数类型
const add6: AddFunction = (a, b) => a + b; // 使用




//练习
//函数实现判断输出质数
function isPrime(num: number): boolean {
    if (num <= 1) return false; // 0和1不是质数
    for (let i = 2; i <= Math.sqrt(num); i++) {
        if (num % i === 0) return false; // 如果能被整除，则不是质数
    }
    return true; // 否则是质数
}
//函数实现判断回文
function isPalindrome(str: string): boolean {
    const cleanedStr = str.replace(/[^a-zA-Z0-9]/g, '').toLowerCase(); // 清除非字母数字字符并转换为小写
    const reversedStr = cleanedStr.split('').reverse().join(''); // 反转字符串
    return cleanedStr === reversedStr; // 比较原字符串和反转后的字符串
}
//将字符串中小写字母转换为大写字母
function toUpperCase(str: string): string {
    return str.replace(/[a-z]/g, (char) => char.toUpperCase()); // 使用正则表达式匹配小写字母并转换为大写
}
//斐波那契数列
function fibonacci(n: number): number[] {
    const fib: number[] = [0, 1]; // 初始化斐波那契数列
    for (let i = 2; i < n; i++) {
        fib[i] = fib[i - 1] + fib[i - 2]; // 计算下一个斐波那契数
    }
    return fib.slice(0, n); // 返回前n个斐波那契数
}
//滚动数组方法
function fibonacciRollingArray(n: number): number[] {
    if (n === 0) return [];
    if (n === 1) return [0];
    if (n === 2) return [0, 1];

    let fib: number[] = [0, 1];
    for (let i = 2; i < n; i++) {
        fib[i % 2] = fib[0] + fib[1]; // 使用滚动数组
        fib=[fib[1],fib[i%2]]
    }
    return fib.slice(0, n);
}
//s = a + aa + aaa + aaaa + aaaaa + ... + a(n个a)求和
function sumOfRepeated_a(a: number, n: number): number {
    let sum = 0;
    let mid = 0;
    for (let i = 1; i <= n; i++) {
        mid = mid * 10 + a; // 计算每一项的值
        sum += mid; // 累加到总和
    }
    return sum; // 返回总和
}