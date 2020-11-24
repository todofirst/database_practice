
import path from 'path' ;
import express from 'express' ;
import cookieParser from 'cookie-parser' ;
import session from 'express-session' ;
import bodyParser from 'body-parser' ;
import helmet from 'helmet' ;
import createError from 'http-errors' ;
import serverlog from 'serverlog-node' ;
import passport from 'passport' ;


import tool from './util/util' ;
import * as log from './api/logFun' ;

// 配置文件
const config = require('./config.json') ;

const authRouter = require('./routes/authRouter') ;
const dataRouter = require('./routes/dataRouter') ;
const ueRouter = require('./routes/ueRouter') ;


// logger
const logger = serverlog.getLogger('app') ;

var app = express();

// 注册 ServerLog 中间件以注入 req 对象给日志
app.use(serverlog.middleware());

// 路由模块导入
app.use(express.json());
app.use(express.urlencoded({ extended: false })) ;
app.use(cookieParser());


// 处理跨域
app.all('*', function(req, res, next) {
    res.header("Access-Control-Allow-Origin", req.headers.origin); //需要显示设置来源
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.header("Access-Control-Allow-Methods","PUT,POST,GET,DELETE,OPTIONS");
    res.header("Access-Control-Allow-Credentials",true); //带cookies7 
    res.header("X-Powered-By",' 3.2.1');    
    res.header("Content-Type", "application/json;charset=utf-8");
    next();
  });


// bodyParser配置
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

// 设置 Session
app.use(session({
  secret: 'dataprc-exp-session',
  cookie: {
      maxAge: 24 * 60 * 60 * 1000,
      httpOnly: true
  },
  resave: false,
  saveUninitialized: false
}));

// 解析cookie
app.use(cookieParser());


// 记录所有请求
app.use((req, res, next) => {
 
  logger.info(`${req.method.toUpperCase()} ${tool.getFullUrl(req)}`);
  next()
  
});

// app.get('/public/images/*', function (req, res) {
//   console.log(req.url)
//   res.setHeader('Content-type','images/jpeg;charset=utf-8')
//   res.sendFile( __dirname + "/" + req.url );
// })

// 静态文件
app.use('/public', express.static(path.join(__dirname, '/public')));


// 增加安全性头部
app.use(helmet());

// 初始化调用passport

// initialize方法是为了让passport模块能在express中使用
app.use(passport.initialize());

// 使用持久化日志
app.use(passport.session());


// 路由挂载
app.use('/getData', dataRouter) ;
app.use('/', authRouter) ;
app.use('/upload', ueRouter) ;



/**
 * 记录未捕获异常
 * 
 */
process.on('uncaughtException', err => {
  // 日志信息存储到数据库
  log.store('Error', err);
  // 记录一条错误日志
  logger.error(err);
});

/**
 * 记录未处理的Promise失败
 */
process.on('unhandledRejection', reason => {
  log.store('Error', reason);
  logger.error(reason);
});



// 404
app.use(function(req, res, next) {
  next(createError(404));
  logger.error('404')
});

// 全局错误处理
app.use(function(err, req, res, next) {

  // render the error page
  res.status(err.status || 500);

  logger.error('服务器错误：'+err.message) ;

  res.end('服务端出现错误') ;

});

module.exports = app;
