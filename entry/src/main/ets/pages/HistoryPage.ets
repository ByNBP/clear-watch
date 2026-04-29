import { HistoryViewModel, PerformanceSnapshot } from '../viewmodel/HistoryViewModel';

@Builder
export function HistoryPageBuilder() {
  HistoryPage()
}

@Component
export struct HistoryPage {
  @State history: PerformanceSnapshot[] = [];
  private vm: HistoryViewModel = new HistoryViewModel();

  async aboutToAppear() {
    this.history = await this.vm.getHistory();
  }

  build() {
    NavDestination() {
      Column() {
        Text('📈 Performance History')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 10 });

        if (this.history.length === 0) {
          Text('No history available yet.')
            .fontSize(14)
            .fontColor(Color.Gray)
            .margin({ top: 50 });
        } else {
          List({ space: 10 }) {
            ForEach(this.history.reverse(), (item: PerformanceSnapshot) => {
              ListItem() {
                Row() {
                  Column() {
                    Text(new Date(item.timestamp).toLocaleTimeString())
                      .fontSize(12)
                      .fontColor(Color.Black);
                  }.width('40%')
                  Column() {
                    Text(`CPU: ${item.cpuUsage.toFixed(1)}%`)
                      .fontSize(12)
                      .fontColor(item.cpuUsage > 50 ? Color.Red : Color.Green);
                    Text(`MEM: ${item.memUsage}KB`)
                      .fontSize(12)
                      .fontColor(Color.Blue);
                  }.width('60%').alignItems(HorizontalAlign.Start)
                }
                .width('100%')
                .padding(10)
                .backgroundColor('#FFFFFF')
                .borderRadius(10)
              }
            })
          }
          .width('100%')
          .height('80%')
          .padding({ left: 10, right: 10 })
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }
    .title('History')
  }
}
