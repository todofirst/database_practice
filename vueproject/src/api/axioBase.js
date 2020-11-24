
import axios from 'axios' ;
import { Loading, Message, MessageBox } from 'element-ui' ;
import router from '@/router' ;
import store from '@/vuex/store' ;

const aConfig = require('../../setting.json').axios ;


let instance = axios.create({
  timeout: aConfig.timeout,
  baseURL: `${aConfig.host}:${aConfig.port}`,
  withCredentials: aConfig.withCredentials
})


// http请求拦截器
instance.interceptors.request.use(config => {
   // element ui Loading方法
  return config
}, error => {
   Message.error({
         message: '网络不给力,请稍后再试'
     })
   return Promise.reject(error)
})


//   http响应拦截器
instance.interceptors.response.use(res => {

  // 响应成功关闭loading
  const code = res.data.code;
  if(code == 601) { //未登录
      MessageBox.alert('请先登录', '提示', {
          confirmButtonText: '确定',
          callback: action => {
            store.commit('LOGOUT', router.currentRoute.fullPath) ;
            // router.push({
            //     name: 'login',
            //     query: {redirect: router.currentRoute.fullPath} //登录后再跳回此页面时要做的配置
            // })
          }
      });
  }
  return res
}, error => {
  loadinginstace.close();
  Message.error({
       message: '网络不给力,请稍后再试'
   })
  return Promise.reject(error)
})

export default instance ;

