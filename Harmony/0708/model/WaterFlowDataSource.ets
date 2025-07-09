import { GoodsModel } from './AppModel';

export class  WaterFlowDataSource implements IDataSource{
  //数据
  private dataArray: GoodsModel[] = []
  //监听器
  private listeners: DataChangeListener[] = []

  //获取总数量的方法
  totalCount(): number {
    return this.dataArray.length
  }
  //固定的获取数据的方法
  getData(index: number) {
    return this.dataArray[index]
  }
  //自定义增加数据的方法 (重要)
  addData(item:GoodsModel){
    this.dataArray.push(item)
    this.notifyDataAdd(this.dataArray.length-1)  // IDataSource 数据源
  }
  // 自定义通知控制器数据增加
  notifyDataAdd(index: number): void {
    this.listeners.forEach(listener => {
      listener.onDataAdd(index)
    })
  }

  // 注册改变数据的控制器
  registerDataChangeListener(listener: DataChangeListener): void {
    if (this.listeners.indexOf(listener) < 0) {
      this.listeners.push(listener)
    }
  }

  // 注销改变数据的控制器
  unregisterDataChangeListener(listener: DataChangeListener): void {
    const pos = this.listeners.indexOf(listener)
    if (pos >= 0) {
      this.listeners.splice(pos, 1)
    }
  }


}