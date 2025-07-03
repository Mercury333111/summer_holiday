//泛型
//函数泛型
function foo<T>(a:T,b:T):void{
    console.log(a,b)
}
foo<number>(1,2)
foo(1,2) //类型推断
foo<string>('x','y') //类型推断

//类泛型
class Persona<T>{
    name:T
    constructor(name:T){
        this.name = name
    }
    getName():T{
        return this.name
    }
}
const p1 = new Persona<string>('张三')
console.log(p1.getName()) // 张三
console.log(p1.name) // 张三
const p2 = new Persona<number>(123)
console.log(p2.getName()) // 123
console.log(p2.name) // 123

//接口泛型
interface Iinfo<T>{
    name:T
    age:T
}
const p3:Iinfo<number> = {
    name: 18,
    age: 18,
}
const p4:Iinfo<string> = {
    name: '张三',
    age: '18',
}
//用泛型可以避免在声明时指定类型，
//而是在使用时指定类型，增加了代码的灵活性和可重用性。

//泛型约束
// 定义约束接口
interface ILength {
  length: number;
}

function logLength<T extends ILength>(arg: T): T {
  console.log(`Length: ${arg.length}`);
  return arg;
}

const strx = "hello"; // 字符串有 length 属性
const arrx = [1, 2, 3]; // 数组有 length 属性
const objx = { length: 10, name: "test" }; // 自定义对象满足约束

logLength(strx); // 输出: Length: 5
logLength(arrx); // 输出: Length: 3
logLength(objx); // 输出: Length: 10

// 以下调用会报错，因为数字没有 length 属性
// logLength(42); // 错误: 类型 'number' 不满足约束 'ILength'


//装饰器
//类装饰
function addTimeLog(constructor:Function) {
    console.log('this is timeLog')
    console.log(new Date())
}
@addTimeLog
class MyClass1{
    constructor(){

    }
}

const myclass = new MyClass1()

//装饰器方法
function first(x:string){
    return function(target:any,methodName:string,descriptor:PropertyDescriptor){
        console.log("first:"+x)
    }
}
function second(){
    return function(target:any,methodName:string,descriptor:PropertyDescriptor){
        console.log(`second:${methodName}`)
    }
}
class MyClass2{
    @first('Hello')
    @second()   //从下向上执行调取
    public myMethod():void{
        console.log("开始执行")
    }
}

//闭包：延长局部变量的作用，实现计数、缓存
function createCounter(): () => number {
  let count = 0; // 局部变量，会被闭包捕获

  return function counter(): number {
    count += 1; // 访问并修改外部函数的局部变量
    return count;
  };
}

// 使用示例
const counter1 = createCounter();
console.log(counter1()); // 输出: 1
console.log(counter1()); // 输出: 2
console.log(counter1()); // 输出: 3

const counter2 = createCounter(); // 创建新的独立计数器
console.log(counter2()); // 输出: 1
console.log(counter1()); // 输出: 4 (counter1 继续独立计数)