//类class
class Person{
    name : string;
    age : number;

    constructor(name:string,age:number){
        this.name = name;
        this.age = age;
    }
    //实例方法 行为
    greet() : void {
        console.log(`Hello, I am ${this.name}, and I am ${this.age} years old.`);
    }
}

//实例化内容
const person1 = new Person('Alice', 30);
const person2 = new Person('Bob', 25);
person1.greet()
person2.greet()

//静态属性 静态方法 访问控制符
class Car{
    static carCount: number = 0; // 静态属性
    private _name: string = '';
    private _model: string = '';
    private _year: number = 0;
    constructor(name: string, model: string, year: number) {
        this._name = name;
        this._model = model;
        this._year = year;
        Car.carCount++; // 每次创建新实例时增加计数
    }
    //实例方法
    public carInfo():void {
        console.log(`Car Name: ${this._name}, Model: ${this._model}, Year: ${this._year}`);
    }
    //静态方法
    static getCarCount(): number {
        return Car.carCount;    //不使用this，因为这是静态方法
    }
}
const car1 = new Car('Toyota', 'Corolla', 2020);
const car2 = new Car('Honda', 'Civic', 2021);
car1.carInfo();
//console.log(car1._name); // 访问私有属性会报错，私有的实例属性类外不能访问
//car1._name = 'New Name'; // 访问私有属性会报错
car2.carInfo();
console.log(`Total cars created: ${Car.getCarCount()}`); // 输出静态属性值




//继承
//父类
class Animal {
    name: string;
    constructor(name: string) {
        this.name = name
    }
    
    move(distance:number = 0):void{
        console.log(`${this.name} moved ${distance}m.`);
    }
}
//子类
class Bird extends Animal {
    wingSpan: number;
    constructor(name: string, wingSpan: number) {
        super(name); // 调用父类构造函数，得写在前面
        this.wingSpan = wingSpan;
    }
    //子类实例方法
    makesounds() {
        console.log(`${this.name} made sounds.`);
    }
    fly(distance:number = 0):void{
        console.log(`${this.name} with ${this.wingSpan}m wing span flied ${distance}m.`)
    }
    //重写父类的方法
    move(distance = 0): void {
        console.log(`${this.name} with ${this.wingSpan}m wing span moved ${distance}m.`);
        super.move(distance); // 调用父类的move方法
    }
}
const polly = new Bird('Polly', 0.5);
polly.move(10); // 调用重写后的move方法
polly.fly(20); // 调用子类特有的方法
polly.makesounds(); // 调用子类特有的方法


//oop三大特性：封装、继承、多态
class Animal1{
    methodSound():void{
        console.log('Animal makes sound');
    }
}
class Dog extends Animal1{
    methodSound():void{
        console.log('Dog barks');
    }
}
class Cat extends Animal1{
    methodSound():void{
        console.log('Cat meows');
    }
}
//多态同一个方法在不同的类中有不同的实现
function makeSound(animal: Animal1): void {
    animal.methodSound();
}
const dog = new Dog();
const cat = new Cat();
makeSound(dog); // 输出: Dog barks
makeSound(cat); // 输出: Cat meows

//抽象类：不能被实例化，只能被继承，若有抽象方法必须子类实现抽象方法
abstract class Shape {
    abstract area(): number; // 抽象方法
    display(): void {
        console.log(`Area: ${this.area()}`);
    }
}
class Circle extends Shape {
    radius: number;
    constructor(radius: number) {
        super();
        this.radius = radius;
    }
    area(): number {
        return Math.PI * this.radius * this.radius; // 实现抽象方法
    }
}
let circle = new Circle(5);
circle.display(); // 输出: Area: 78.53981633974483