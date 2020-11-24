
let ensureLogin = function(req){
  return new Promise((resolve, reject)=>{
    if(req.user){
      resolve() ;
    }else{
      reject({
        code:601,
        message: '未登录'
      }) ;
    }
  })
}

module.exports = ensureLogin