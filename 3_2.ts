//import导入
//按需导入
import {add,multiply} from './+xpi'
//全部导入
import * as module from './+xpi'

//默认导入
import fn from './+xpi'

console.log(add(2, 3)); // 5
console.log(multiply(4, 5)); // 20
console.log(module.add(1,1)) // 2
console.log(fn.PI); // 3.14


//泛型工具
//Partial可选
interface U1 {
    name : string,
    id : number
}
type PartialU1 = Partial<U1>
/*
interface U1 {
    name? : string;
    id? : number;
}
*/
const u1 : PartialU1={
    name:"Tom"
}
console.log(u1)

//只读
type ReadonlyU1 = Readonly<U1>
const u2 : ReadonlyU1={
    name : "Kobe",
    id : 24
}
console.log(u2)
//u2.name = "Zobayan"


//Promise对象 作用：解决回调地狱（异步用同步实现）、异步并发
//异步：axios,setTimeout,setInterval
const promise = new Promise((resolve,reject)=>{
    setTimeout(()=>{
        resolve('mission 1')
    },1000)
})
promise.then(res=>{
    console.log(res)
    return new Promise((resolve,reject)=>{
        setTimeout(()=>{
            resolve('mission 2')
        },1000)
    })
}).then(res=>{
    console.log(res)
})


//简单封装
function axios(options:any){
    return new Promise ((resolve,reject)=>{
        setTimeout(()=>{
            resolve('ok')
        },1000)
    })
}
axios('http://localhost:3000/getSwiper')
.then(res=>{
    console.log(res)
})

/*funtion getPromise(num:number){
    return new Promise((resolve,reject)=>{
        if(num>0){
            resolve('ok')
        }else{
            reject('no')
        }
    })  
}
*/
//状态 pending-->fulfilled-->resolved
//状态 pending-->rejected
//状态是不可逆的