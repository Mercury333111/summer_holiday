//接口
//字面量对象数组接口，简便
interface User {
    name: string;
    age: number;
}
let user: User = {
    name: 'Alice',
    age: 30
};
console.log(user)

const user2: User[] = [
    {
        name: 'Bob',
        age: 25
    },
    {
        name: 'Charlie',
        age: 28
    }   
]
console.log(user2)



//类接口
interface User2{
    name: string;
    age: number;
}
class User3 implements User2 {
    name: string;
    age: number;

    constructor(mode: User2) {
        this.name = mode.name;
        this.age = mode.age;
    }
}
const user3 = new User3({name: 'Dave', age: 22});
console.log(user3);
let user4: User2[] = [
    { name: 'Eve', age: 20 },
    { name: 'Frank', age: 35 }  
]
console.log(user4);

//接口的继承
interface Content {
    id: number;
    title: string;
    createtime: Date;
}
interface Article extends Content {
    content: string;
}
interface Video extends Content {
    duration: number;
}
class ContentManager {
    public contents: Content[] = [];
    addContent(con: Article): void {    //添加内容
        this.contents.push(con);
    }
}

const article = new ContentManager();
article.addContent({
    id: 1,
    title: 'tralaleo tralala',
    createtime: new Date(),
    content: 'tung tung tung tung tung tung tung tung tung sahur',
});
console.log(article.contents);

//动态接口
interface IUser1{
    [key:string]:any
}
let userInfo1 : IUser1 = {
    name:'Alice',
    age:18,
    sex:'female',
    height:60
}
//接口参数：可选 必填 只读
interface IUser2{
    readonly name:string,
    age?:number,
    sex:string,
    greet:(x:string)=>void
}
let userInfo2 : IUser2 = {
    name: 'Bob',
    sex: 'male',
    greet: (x: string) => {
        console.log(`Hello, ${x}`);
    }   
};
//userInfo2.name = 'Zedd'         只读，所以不能赋值
//接口断言  
interface IUser3 {
    name:string
    age:number
}
let user5 = {};
(user5 as IUser3).name = 'Charlie';
(user5 as IUser3).age = 20;
console.log(user5)