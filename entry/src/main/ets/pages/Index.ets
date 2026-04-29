@Entry
@Component
export struct Index {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  scroll : Scroller = new Scroller()

  build() {
    Navigation(this.pageInfos) {
      Scroll(this.scroll){
        Column({ space: 10 }) {
          Text('ClearWatch').fontSize(24).fontWeight(FontWeight.Bold).margin({ bottom: 20 })

          Button('Dashboard')
            .width('80%').height(40)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'Dashboard' });
            })

          Button('Performance Graph')
            .width('80%').height(40)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'Graph' });
            })

          Button('Cache Cleaner')
            .width('80%').height(40)
            .onClick(() => {
              this.pageInfos.pushPath({ name: 'ClearWatch' });
            })
        }.width('100%').justifyContent(FlexAlign.Center).padding({ top: 40, bottom: 40 })
      }.width('100%').height('100%').backgroundColor(Color.White)
    }.title('NavIndex').hideTitleBar(true)
  }
}
