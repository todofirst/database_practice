
/**
 * 递归匹配用户路由
 * @param Array userRouter 授权路由
 * @param Array allRouter 所有路由
 * @return Array 最终授权路由 
 */
export const recursionRouter = function(userRouter = [], allRouter = []) {

  var realRoutes = []
  allRouter.forEach((v, i) => {
      userRouter.forEach((item, index) => {
          if (item.name === v.meta.name) {
              if (item.children && item.children.length > 0) {
                  v.children = recursionRouter(item.children, v.children)
              }
              realRoutes.push(v)
          }
      })
  })
  return realRoutes
}

export const objToArr = function(obj){
  let keys = Object.keys(obj) ;
  let arr = [] ;
  keys.forEach((key)=>{
    arr = arr.concat(obj[key]) ;
  })

  return arr ;
}

// 正整数验证器
export const pnV = function(rule, value, callback){

    var regPos = /^\d+$/; 
    if(regPos.test(value))
           return callback() ;
    return callback(new Error('请输入正整数')) ;
    
}

// 年龄验证器
export const ageV = function(rule, value, callback){

  var regPos = /^\d+$/; 
  if(regPos.test(value)){
    let age = parseInt(value)
    if(age>=18 && age <=65){
      callback()
    }else{
      callback(new Error('年龄不符合'))
    }
  }
      
  return callback(new Error('请输入正整数')) ;
  
}


// 正浮点数验证器
export const pfV = function(rule, value, callback){

  var regPos = /^(\d+)(\.\d+)?$/; 
  if(regPos.test(value))
         return callback() ;
  return callback(new Error('请输入正整数')) ;
  
}

export const formatEmpYearSpan = function(months, emps){
  let baseObj =  {
    name: '',
    type: 'line',
    stack: '总量',
    areaStyle: {},
    data: []
  }

  let series = []


  emps.forEach((emp)=>{
    baseObj.name = emp.name
    months.forEach((month)=>{
      let flag = false;

      month.forEach((m)=>{
        if(m.eno == emp.eno){
          baseObj.data.push(m.total)
          flag = true
        }
      })

      if(!flag){
        baseObj.data.push(0)
      }

    })

    series.push({...baseObj}) ;
    baseObj.name = '',
    baseObj.data = []

  })


  return series

}

export const formatIOYearSpan = function(results){

  let data = results.map((res)=>{

    return res[0].total==null? 0 : res[0].total

  })

  return data

}





