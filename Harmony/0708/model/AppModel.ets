export interface SwiperModel {
  id: number;
  title: string;
  url?: string;
  imgurl: string;
  state?: number;
  order?: number;
  createdAt?: string;
  updatedAt?: string;
}
export interface CategoryModel{
  name:string;
}
export interface GoodsModel{
  id: number;
  title: string;
  imgurl: string;
  price: string;
  market_price: string;
  stock: number;
  is_hot: number;
  look_num: number;
  sales: number;
  state: number;
  order: number;
  rating_ratio: number;
  createdAt: string;
  updatedAt: string;
  categoryId: number;
  category: CategoryModel;


}