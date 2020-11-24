import express from 'express' ;
const router = express.Router() ;
const multer = require('multer');
const shortid = require('shortid');

const fs = require('fs');
const path = require('path');

const config = require('../config.json') ;

// 图片上传配置
const storageImg = multer.diskStorage({
  destination(req, file, cb) {
    let dirPathParent = path.join(__dirname, '../public/images')
    let exist = fs.existsSync(dirPathParent) ;
    if(!exist){
      fs.mkdir(dirPathParent, err => {
        if (err && err.code !== 'EEXIST') {
            cb(err);
        } else {
          cb(null, dirPathParent);
        }
      });
    }else{
      cb(null, dirPathParent);
    }

  },
  filename(req, file, cb) {
      const fileName = `${file.originalname.substring(0, file.originalname.lastIndexOf('.'))}_${shortid.generate()}`;
      const ext = file.originalname.substr(file.originalname.lastIndexOf('.'));
      const fullName = fileName + ext;
      cb(null, fullName);
  }
});


router.post('/uimg', function(req, res, next){

  let uploadFile = multer({ storage: storageImg })
  .single('file');
    uploadFile(req, res, err => {
      if (err) {
          next(err);
      } else {
          res.json({
              code: 0,
              message: '成功上传',
              url: `${config.index.baseUrl}:${config.index.defaultPort}/public/images/${req.file.filename}`, // 此处不能用path.join，因为path会使用'\'分隔符，而url地址必须是'/'分隔符
              originalname: req.file.originalname,
          });
  }
});

})

module.exports = router ;