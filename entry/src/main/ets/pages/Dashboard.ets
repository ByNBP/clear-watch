import { common } from '@kit.AbilityKit';
import { CpuViewModel } from '../viewmodel/CpuViewModel';
import { hidebug } from '@kit.PerformanceAnalysisKit';
import { Cpu } from '../model/Cpu';


@Builder
export function PageOneBuilder(name: string, param: Object) {
  Dashboard()
}

@Component
export struct Dashboard {
  vm: CpuViewModel = new CpuViewModel()
  pageInfos: NavPathStack = new NavPathStack();
  context = this.getUIContext().getHostContext() as common.UIAbilityContext
  cpu: Cpu = new Cpu()

  aboutToAppear(): void {
    this.vm.getCpuUsage().then((ret) => {
      this.cpu.getCpuUsage = ret
    })
    this.vm.getSystemCpuUsage().then((ret) => {
      this.cpu.getSystemCpuUsage = ret
    })

    this.vm.getCpuUsage().then((ret) => {
      this.cpu.getCpuUsage = ret
    })
    this.vm.getGraphicsMemory().then((ret) => {
      this.cpu.getGraphicsMemory = ret
    })
    this.vm.getGraphicsMemory().then((mem) => {
      this.cpu.getGraphicsMemory = mem
    })
  }

  build() {
    NavDestination(){
      Column() {
        Text('Dashboard').fontSize('16px').textAlign(TextAlign.Center)
        Column() {
          Text(`CPU Process Usage: ${this.cpu.getCpuUsage}`).fontSize('16px')
          Text(`System Cpu Usage: ${this.cpu.getSystemCpuUsage}`).fontSize('16px')
        }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

        Column() {
          Text(`Cpu Graphic Memory : ${this.cpu.getGraphicsMemory}`).fontSize('16px')
          Column() {
            Text(`System Total Memory : ${this.cpu.getSystemMemInfo.totalMem}`).fontSize('16px')
            Text(`System Free Memory : ${this.cpu.getSystemMemInfo.freeMem}`).fontSize('16px')
            Text(`System Available Memory : ${this.cpu.getSystemMemInfo.availableMem}`).fontSize('16px')
          }
        }.width('100%').justifyContent(FlexAlign.SpaceEvenly)

      }
      .height('100%')
      .width('100%').alignItems(HorizontalAlign.Center).justifyContent(FlexAlign.Center)
    }.hideBackButton(true)
  }
}