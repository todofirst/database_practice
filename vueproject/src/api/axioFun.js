
import caxios from '@/api/axioBase'
import axios from 'axios'

import {getYearStat} from '@/api/dataMG'

import {formatIOYearSpan} from '@/util/util'


// 表单验证相关         url="/login"  data={usename,password}
export const formReq = (url, data) => {
  return caxios({
      method: 'POST',
      url:'/login',
      headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
      },
      data: data,
      traditional: true,
      withCredentials: true,
      transformRequest: [
          function(data) {
              let ret = ''
              for (let it in data) {
                  ret +=
                      encodeURIComponent(it) +
                      '=' +
                      encodeURIComponent(data[it]) +
                      '&'
              }
              return ret
          }
      ]
  }).then(res => res.data);
};


export const getOutIn = function(year){
    return new Promise((resolve, reject)=>{
        axios.all([getYearStat(year,'/getData/income' ),getYearStat(year, '/getData/output')])
        .then(axios.spread(function(res1, res2){
            if(res1.code==0&&res2.code==0){
                let r1 = formatIOYearSpan(res1.data)
                let r2 = formatIOYearSpan(res2.data)
                let r3  = []
        
                r2 = r2.map((item)=>{
                    return item*-(1)
                })
        
                for(let i = 0 ; i<12; i++){
                    r3.push( r1[i]+r2[i] )
                }
                
                resolve([r3,r1,r2])

            }else{
                reject(new Error(`错误：${res1.code} ${res1.code}`))
            }

        }))
        .catch(err=>{
            reject(err)
            console.log(err)
        })
    })


}
