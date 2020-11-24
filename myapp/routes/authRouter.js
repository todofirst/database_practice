

import express from 'express' ;
import passport from 'passport' ;
import {query, mysql} from '../api/dbBase' ;
import serverlog from 'serverlog-node' ;

import {Strategy as LocalStrategy} from 'passport-local' ;

const router = express.Router() ;

const logger = serverlog.getLogger('auth') ;

const autority = require('../config/authority.json') ;
// passport配置
passport.use(new LocalStrategy(
  {
    usernameField: 'username',
    passwordField: 'password'
  },

  function(username, password, done) {
    // password = md5(password) ;

    let sql = mysql.format('SELECT * FROM users WHERE username=? AND password=?',[username,password]) ;

    query(sql)
    .then(function(user){

      if(user.length === 0){
        return done(null, false) ;
      }
      done(null, user[0]) ;
    })
    .catch(function(err){
      done(err) ;
    })

  }
));

// 序列化
passport.serializeUser(function(user, done) {

  done(null, user) ;
});

// 反序列化
passport.deserializeUser(function(user, done) {

  done(null, user) ;
});

router.post('/login', function(req, res, next){
  console.log(req.body);
  passport.authenticate('local', function(err, user, info) {

    if (err) { 
      logger.error(err.message) ;
      return next(err) ; }

    if (!user) {

      return  res.json({
      code: 1,
      message: "用户名或者密码不正确"
    })  
   }

  req.logIn(user, function(err) {
    
    if (err) { return next(err) ; }
    return res.status(201).json({
      "code": 0,
      "message": "登录成功",
      "user": user.username,
      "permissionList": autority[user.role]
  })
  })

  console.log(req.user)

  })(req, res, next) ;
})


router.get('/logout', function(req, res, next){
  console.log( req.user)
  req.logout();
  req.session.destroy(function (err) {
      if (!err) {
          res.status(200).clearCookie('connect.sid').json({code: 0, message:'退出登陆'});
      } else {
          next(err)
      }

  });


})

router.post('/test', function(req, res, next){
  console.log(req.body)
  if(req.user){
    res.json({
      msg: 'live'
    })
  }else{
    res.json({
      msg: 'die'
    })
  }
})

module.exports = router ;