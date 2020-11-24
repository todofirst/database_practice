// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue' ;
import App from './App' ;
import router from '@/router' ;
import ElementUI from 'element-ui' ;
import 'element-ui/lib/theme-chalk/index.css' ;
import store from '@/vuex/store' ;
import * as filters from '@/util/filters'



import axios from '@/api/axioBase' ;
Vue.prototype.$axios = axios ;

import echarts from 'echarts' ;
Vue.prototype.$echarts = echarts ;

// 绑定过滤器
Object.keys(filters).forEach(key => {
    Vue.filter(key, filters[key])
})

Vue.use(ElementUI) ;

Vue.config.productionTip = false ;

// 路由拦截器
router.beforeEach((to, from, next) => {
    console.log(store.state.user, to.fullPath, to)
    // 登录成功

  if (JSON.parse(sessionStorage.getItem('user'))) {
    if (to.matched.length != 0) { 
        if(to.path == '/login' || to.path=='/'){
            next({
                path: '/business/tasks'
            })
        }else{
            next();  
        }
 

    } else {

        store.dispatch('FETCH_PERMISSION', 
        {
            permissionList:JSON.parse(sessionStorage.getItem('permissionList')),
            user: true,
            username: sessionStorage.getItem('username')
          }
        ).then(()=>{
            router.replace({
                path: to.path
            })
        })

    }
      
  } else {
      if(to.path == '/login'){
          next() ;
      }else{
        
        next({
            path: '/login',
            query: {redirect: to.fullPath}
        })
      }

  }
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  store,
  router,
  components: { App },
  template: '<App/>'
})

