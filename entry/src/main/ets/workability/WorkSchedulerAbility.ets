import { workScheduler } from '@kit.BackgroundTasksKit';
import { BackgroundMonitorService } from '../service/BackgroundMonitorService';

export default class WorkSchedulerAbility extends workScheduler.WorkSchedulerExtensionAbility {
  onWorkStart(workInfo: workScheduler.WorkInfo) {
    console.info(`WorkSchedulerAbility onWorkStart workInfo: ${JSON.stringify(workInfo)}`);
    BackgroundMonitorService.getInstance().performAudit();
  }

  onWorkStop(workInfo: workScheduler.WorkInfo) {
    console.info(`WorkSchedulerAbility onWorkStop workInfo: ${JSON.stringify(workInfo)}`);
  }
}
