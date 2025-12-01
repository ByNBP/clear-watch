import { FileCleanerService } from '../service/FileCleanerService';

export class ClearWatchViewModel {
  private fileCleanerService: FileCleanerService;
  cacheFiles: string[] = [];
  deletedFiles: string[] = [];
  status: string = '';

  constructor() {
    this.fileCleanerService = new FileCleanerService()
  }

  async loadCacheFiles(context: Context, updateCallBack: (status: string) => void) {
    this.cacheFiles = await this.fileCleanerService.listCacheFiles(context);
    this.status = `Total ${this.cacheFiles.length} file found.`;
    updateCallBack(this.status)
  }

  async clearCache(context: Context, updateCallBack: (status: string) => void) {
    this.cacheFiles = await this.fileCleanerService.listCacheFiles(context);
    this.deletedFiles = await this.fileCleanerService.clearCache(context);

    if (this.cacheFiles.length > 0) {
      this.status = `${this.cacheFiles.length} file clear.`;
    } else {

      this.status = 'there is no file to clear .';
    }
    updateCallBack(this.status)
  }
}