@Entry
@Component
//相对布局
struct MyRelative {
  build() {
    RelativeContainer(){
      Text('1')
        .width(100)
        .height(100)
        .backgroundColor(Color.Red)
        .textAlign(TextAlign.Center)
        .alignRules({
          'center':{'anchor':'__container__','align':VerticalAlign.Center},
          'middle':{'anchor':'__container__','align':HorizontalAlign.Center}
        })
        .id('text1')

      Text('2')
        .width(100)
        .height(100)
        .backgroundColor(Color.Green)
        .textAlign(TextAlign.Center)
        .alignRules({
          'right':{'anchor':'text1','align':HorizontalAlign.End},
          'top':{'anchor':'text1','align':VerticalAlign.Bottom}
        })
        .id('text2')
    }
  }
}