import { PreferenceManager } from '../util/PreferenceManager';

export interface PerformanceSnapshot {
  timestamp: number;
  cpuUsage: number;
  memUsage: number;
}

export class HistoryViewModel {
  private readonly HISTORY_KEY = 'perf_history';
  private readonly MAX_ENTRIES = 24;

  async getHistory(): Promise<PerformanceSnapshot[]> {
    const historyStr = await PreferenceManager.getInstance().getValue(this.HISTORY_KEY, '[]') as string;
    try {
      return JSON.parse(historyStr) as PerformanceSnapshot[];
    } catch (e) {
      return [];
    }
  }

  async addSnapshot(cpuUsage: number, memUsage: number): Promise<void> {
    let history = await this.getHistory();
    const newSnapshot: PerformanceSnapshot = {
      timestamp: Date.now(),
      cpuUsage: cpuUsage,
      memUsage: memUsage
    };

    history.push(newSnapshot);
    if (history.length > this.MAX_ENTRIES) {
      history = history.slice(-this.MAX_ENTRIES);
    }

    await PreferenceManager.getInstance().putValue(this.HISTORY_KEY, JSON.stringify(history));
  }
}
