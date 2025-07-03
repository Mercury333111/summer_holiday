//模块
export function add(a: number, b: number): number {
  return a + b;
}

export function multiply(a: number, b: number): number {
  return a * b;
}

//默认导出
export default class Calculator {
  static PI = 3.14;
}