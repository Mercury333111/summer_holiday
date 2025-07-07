@Entry
@Component
struct SwiperDemo {
  private swiperBackgroundColors: Color[] = [Color.Blue, Color.Brown, Color.Gray, Color.Green, Color.Orange,
    Color.Pink, Color.Red, Color.Yellow];
  private swiperAnimationMode: (SwiperAnimationMode | boolean | undefined)[] = [undefined, true, false,
    SwiperAnimationMode.NO_ANIMATION, SwiperAnimationMode.DEFAULT_ANIMATION, SwiperAnimationMode.FAST_ANIMATION];
  private swiperController: SwiperController = new SwiperController();
  private animationModeIndex: number = 0;
  private animationMode: (SwiperAnimationMode | boolean | undefined) = undefined;
  @State animationModeStr: string = 'undefined';
  @State targetIndex: number = 0;


  aboutToAppear(): void {
    this.toSwiperAnimationModeStr();
  }


  build() {
    Column({ space: 5 }) {
      Swiper(this.swiperController) {
        ForEach(this.swiperBackgroundColors, (backgroundColor: Color, index: number) => {
          Text(index.toString())
            .width(250)
            .height(250)
            .backgroundColor(backgroundColor)
            .textAlign(TextAlign.Center)
            .fontSize(30)
        })
      }
      .indicator(true)


      Row({ space: 12 }) {
        Button('showNext')
          .onClick(() => {
            this.swiperController.showNext(); // 通过controller切换到后一页
          })
        Button('showPrevious')
          .onClick(() => {
            this.swiperController.showPrevious(); // 通过controller切换到前一页
          })
      }.margin(5)


      Row({ space: 12 }) {
        Text('Index:')
        Button(this.targetIndex.toString())
          .onClick(() => {
            this.targetIndex = (this.targetIndex + 1) % this.swiperBackgroundColors.length;
          })
      }.margin(5)
      Row({ space: 12 }) {
        Text('AnimationMode:')
        Button(this.animationModeStr)
          .onClick(() => {
            this.animationModeIndex = (this.animationModeIndex + 1) % this.swiperAnimationMode.length;
            this.toSwiperAnimationModeStr();
          })
      }.margin(5)


      Row({ space: 12 }) {
        Button('changeIndex(' + this.targetIndex + ', ' + this.animationModeStr + ')')
          .onClick(() => {
            this.swiperController.changeIndex(this.targetIndex, this.animationMode); // 通过controller切换到指定页
          })
      }.margin(5)
    }.width('100%')
    .margin({ top: 5 })
  }


  private toSwiperAnimationModeStr() {
    this.animationMode = this.swiperAnimationMode[this.animationModeIndex];
    if ((this.animationMode === true) || (this.animationMode === false)) {
      this.animationModeStr = '' + this.animationMode;
    } else if ((this.animationMode === SwiperAnimationMode.NO_ANIMATION) ||
      (this.animationMode === SwiperAnimationMode.DEFAULT_ANIMATION) ||
      (this.animationMode === SwiperAnimationMode.FAST_ANIMATION)) {
      this.animationModeStr = SwiperAnimationMode[this.animationMode];
    } else {
      this.animationModeStr = 'undefined';
    }
  }
}