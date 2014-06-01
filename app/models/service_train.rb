# class service train. wishplz-train. 
# @author ninoy.arnaldo@gmail.com for wishplz.com
class ServiceTrain < Service
  self.command = 'wishplz-train'
  self.dir = APP_CONFIG['wishplz_detect']['bin_dir']
  self.options = {
    #'all' => "",
    #'--config' => ' "/Users/ninoy/Documents/workspace/WishPlzLocal/ocr-detection-test/trainer.conf"'
  }
end