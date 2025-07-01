let message:string = "hello";
let count:number = 10;
let isdone:boolean = false;
console.log(message,count,isdone);

let l1:number[] = [1,2,3];
let l2:Array<number> = [1,2,3];
let l3:Array<string> = ['a','b','c'];
console.log(l1,l2,l3);
//字面量对象
interface Person{
    name:string;
    age:number;
}
const boy:Person={name:'Tom',age:19}
console.log(boy);
//联合
let union:number | string = "Tom"
union = 19;
//交叉
let inter:{name:string}&{age:number}={name:"Tom",age:18}
console.log(union,inter)

//枚举
enum color{red,blue,green} //从0赋值
let c1:color = color.blue;
console.log(c1,color.blue)
//any 纯血鸿蒙是不允许的
let notsure:any = 4;
notsure = true;
console.log(notsure)
//void 没有任何返回值
function f():void{
    console.log("六")
}
f()
//null 空对象
let n:null = null;

//undefined 返回值是undefined 或 参数传递值未定义   JavaScript独有的
console.log(f())
let ud:undefined = undefined;
console.log(ud)

/*特殊值
let a:number = NaN;  //非数字，not a number
let b:number = Infinity;  //无穷大
*/
//三元运算符
let score =70
let grade = (score>=90)?"A":(score>=80)?"B":(score>=70)?"C":"D";
console.log(grade)
