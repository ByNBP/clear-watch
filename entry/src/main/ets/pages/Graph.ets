import { VChart } from '@visactor/harmony-vchart';
import { Cpu } from '../model/Cpu';
import { CpuViewModel } from '../viewmodel/CpuViewModel'

interface Event {
  item: ItemType
}

interface ItemType {
  addState(str: string): void
}


@Builder
export function PageTwoBuilder(name: string, param: Object) {
  Graph()
}

@Component
export struct Graph {
  cpu: Cpu = new Cpu()
  vm: CpuViewModel = new CpuViewModel()

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

  @State spec: Record<string, string | ESObject> = {
    'type': 'bar',
    'data': {
      values: ([
        {
          'type': 'Total Memory',
          'value': Number(this.cpu.getSystemMemInfo.totalMem)
        },
        {
          'type': 'Free Memory',
          'value': Number(this.cpu.getSystemMemInfo.freeMem)
        },
        {
          'type': 'Available Memory',
          'value': Number(this.cpu.getSystemMemInfo.availableMem)
        },
        {
          'type': 'Cpu Usage',
          'value': this.cpu.getCpuUsage
        },
        {
          'type': 'System Cpu Usage',
          'value': this.cpu.getSystemCpuUsage
        },
        {
          'type': 'Graphics Memory',
          'value': this.cpu.getGraphicsMemory
        }
      ]) as ESObject
    },
    'xField': ['type'],
    'yField': 'value',
    'seriesField': 'type',
    'bar': {
      'state': ({
        'aaa': ({
          'fill': 'red'
        } as ESObject)
      } as ESObject),
      'style': ({
        'stroke': '#000',
        'lineWidth': 1
      } as ESObject)
    },
    'legends': {
      'visible': true,
      'position': 'start',
      'orient': 'top'
    }
  }

  build() {
    NavDestination() {
      Row() {
        Column() {
          VChart({
            spec: this.spec,
            w: 200,
            h: 200,
            onChartInitCb: (vchart) => {
              return
            },
            onChartReadyCb: (vchart) => {
              vchart.on('touchstart', { level: 'mark', type: 'bar' }, (e: Event) => {
                e.item.addState('aaa')
              })
            },
            initOption: {
              beforeRender: () => {

              },
              afterRender: () => {

              }
            }
          });
        }
        .width('100%')
      }
      .height('100%')
    }.hideBackButton(true)
  }
}