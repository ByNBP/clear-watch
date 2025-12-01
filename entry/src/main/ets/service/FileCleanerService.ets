import { fileIo as fs, ListFileOptions } from '@kit.CoreFileKit';
import { BusinessError } from '@kit.BasicServicesKit';

export class FileCleanerService {
  cacheDirPath: string = ''; // HarmonyOS'ta tipik cache dizini
  deletedFiles: string[] = [];
   listCache = ['']
  async listCacheFiles(context: Context): Promise<string[]> {

    let listFileOption: ListFileOptions = {
      recursion: false,
      listNum: 0,
      filter: {
        suffix: ['.tmp', '.cache', '.log', '.bak'],
        displayName: ['*cache*', '*temp*', '*tmp*', '*cleanup*'],
        fileSizeOver: 0
      }
    }
    this.cacheDirPath = context.cacheDir
    fs.listFile(this.cacheDirPath, listFileOption).then((filenames: Array<string>) => {
      console.info('listFile succeed');
      for (let i = 0; i < filenames.length; i++) {
        console.info('fileName: %s', filenames[i]);
        this.listCache[i] = filenames[i]
        this.deletedFiles[i]=filenames[i]
      }
    }).catch((err: BusinessError) => {

    });
    return this.listCache
  }

  async clearCache(context: Context): Promise<string[]> {

    this.cacheDirPath = context.cacheDir

    try {
      let listFileOption: ListFileOptions = {
        recursion: false,
        listNum: 0,
        filter: {
          suffix: ['.tmp', '.cache', '.log', '.bak'],
          displayName: ['*cache*', '*temp*', '*tmp*', '*cleanup*'],
          fileSizeOver: 0
        }
      }
      fs.listFile(this.cacheDirPath, listFileOption).then((filenames: Array<string>) => {
        console.info('listFile succeed');
        for (let i = 0; i < filenames.length; i++) {
          console.info('fileName: %s', filenames[i]);
          fs.rmdir(`${this.cacheDirPath}/${filenames[i]}`).then(() => {
            console.info('File removed');
            this.listCache=[]
          }).catch((err: BusinessError) => {

          });
        }
      }).catch((err: BusinessError) => {

      });

    } catch (err) {

    }

    return this.deletedFiles;
  }
}
