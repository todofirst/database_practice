import axios from '@/api/axioBase' ;

// export const getAllData = (url,params) => {

//   return axios.get(url).then(res => res.data)
// }

export const getAllData = (url,params, method=null) => {
  return axios({
  method: method? method:'GET',
  url,
  params,
}).then(res => res.data)
}

export const delIt = (url,params, method=null) => {
  return axios({
  method: method? method:'GET',
  url,
  params,
}).then(res => res.data)
}

/**
 * 
 * @param  url 
 * @param  params e.g. {where:{name:123}, values: {psd:123}, op:'添加'}
 */
export const updateIt = (url,params,method=null) => {return axios({
  method: method? method:'GET',
  url,
  params,
}).then(res => res.data)}

export const hadData = (params,method=null) => {return axios({
  method: method? method:'GET',
  url: '/getData/ishad',
  params,
}).then(res => res.data)}

// 获取员工总业绩信息
export const getTotalEmpstat = () => {return axios({
  method: 'GET',
  url: '/getData/getempstattotal',
}).then(res => res.data)}

export const getYearStat = (year, url) => {return axios({
  method: 'GET',
  params: {
    year,
  },
  url,
}).then(res => res.data)}

export const hadCorders = (cono,method=null) => {return axios({
  method: method? method:'GET',
  url: '/getData/hadcono',
  params:{
    cono: cono
  },
}).then(res => res.data)}

export const hadleav = (params,method=null,cno) => {return axios({
  method: method? method:'GET',
  url: '/getData/hadstore',
  params
}).then(res => res.data)}






// 是否有顾客
export const hadCustomer = function(rule, value ,callback){
  if(value==''){
    return callback(new Error('没有该用户'))
  }
  hadData({
    where: {
      'cno': value
    },
    tb: 'customer'
  }).then(data=>{
    try{
      if((data.count==0&&data.code ==0)||(data.code!=0)){
        callback(new Error('没有该用户'))
      }else{

        if(data.count==undefined){
          callback(new Error('没有该用户'))
        }else{
          callback() 
        }
      }
    }catch(err){

      callback(err)
    }

  }).catch(err=>{


    callback(err) ;
  })
}

// 已经有这个商品了
export const hadWater = function(rule, value ,callback){
  if(value==''){
    return callback(new Error('啥都没输入'))
  }
  hadData({
    where: {
      'wname': value
    },
    tb: 'water'
  }).then(data=>{
    console.log(data)
    try{
      if((data.count!=0&&data.code ==0)||(data.code!=0)){
        callback(new Error('已经存在了'))
      }else{

        if(data.count==undefined){
          callback(new Error('啥也不是'))
        }else{
          callback() 
        }
      }
    }catch(err){

      callback(err)
    }

  }).catch(err=>{


    callback(err) ;
  })
}

// 是否有这个套餐
export const hasWname = function(rule, value ,callback){
  if(value==''){
    return callback(new Error('啥都没输入'))
  }
  hadData({
    where: {
      'wname': value
    },
    tb: 'combo'
  }).then(data=>{
    console.log(data)
    try{
      if((data.count!=0&&data.code ==0)||(data.code!=0)){
        callback(new Error('已经存在该套餐了'))
      }else{

        if(data.count==undefined){
          callback(new Error('啥也不是'))
        }else{
          callback() 
        }
      }
    }catch(err){

      callback(err)
    }

  }).catch(err=>{


    callback(err) ;
  })
}




