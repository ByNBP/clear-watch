import { CpuHelper } from '../util/CpuHelper';

export class CpuViewModel {
  async getCpuUsage(): Promise<number> {
    let cpu = new CpuHelper()
    return cpu.getCpuUsage()
  }

  async getSystemCpuUsage(): Promise<number> {
    let cpu = new CpuHelper()
    return cpu.getSystemCpuUsage()
  }

  async getSystemMemInfo() {
    let cpu = new CpuHelper()
    return cpu.getSystemMemInfo()
  }

  async getGraphicsMemory(): Promise<number> {
    let cpu = new CpuHelper()
    return cpu.getGraphicsMemory()
  }
}