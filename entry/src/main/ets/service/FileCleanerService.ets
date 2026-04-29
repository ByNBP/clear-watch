import { fileIo as fs, ListFileOptions } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class FileCleanerService {
  cacheDirPath: string = '';
  deletedFiles: string[] = [];
  listCache: string[] = [];

  async listCacheFiles(context: Context): Promise<string[]> {
    this.cacheDirPath = context.cacheDir;
    let listFileOption: ListFileOptions = {
      recursion: false,
      listNum: 0,
      filter: {
        suffix: ['.tmp', '.cache', '.log', '.bak'],
        displayName: ['*cache*', '*temp*', '*tmp*', '*cleanup*'],
        fileSizeOver: 0
      }
    };

    try {
      let filenames = await fs.listFile(this.cacheDirPath, listFileOption);
      this.listCache = filenames;
      return filenames;
    } catch (err) {
      console.error(`listFile failed. Code: ${(err as BusinessError).code}, message: ${(err as BusinessError).message}`);
      return [];
    }
  }

  async clearCache(context: Context): Promise<string[]> {
    this.cacheDirPath = context.cacheDir;
    this.deletedFiles = [];

    try {
      let filenames = await this.listCacheFiles(context);
      for (let filename of filenames) {
        try {
          await fs.rmdir(`${this.cacheDirPath}/${filename}`);
          this.deletedFiles.push(filename);
        } catch (err) {
          console.error(`Failed to remove ${filename}. Code: ${(err as BusinessError).code}`);
        }
      }
      this.listCache = [];
      return this.deletedFiles;
    } catch (err) {
      console.error(`clearCache failed. Code: ${(err as BusinessError).code}`);
      return [];
    }
  }
}
