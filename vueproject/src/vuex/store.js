import Vue from 'vue' 
import Vuex from 'vuex'
import {recursionRouter} from '../util/util'
// import {fetchPermission} from '../api/axioFun'
import router from '../router'
// import createPersistedState from 'vuex-persistedstate'

// const allRouters = require('../../setting.json').allRouters 
import {DynamicRoutes, allRoutes} from '../router/index'

Vue.use(Vuex);
// 登录验证
export default new Vuex.Store({
    state: {
        user: false,
        username: '',
        collapse: false,
        menus: []
    },

    mutations: {
        // 登录
        LOGIN(state, user) {
            state.user = user
        },
        // 退出
        LOGOUT(state, redirect) {
            state.user = false ;
            state.username = '',
            state.menus = []
            sessionStorage.setItem('username', '') ;
            sessionStorage.setItem('user', false) ;
            sessionStorage.setItem('permissionList', []) ;
            router.replace({
                path: '/login',
                query: {redirect}
            })

        }
    },

    actions: {

        
        async FETCH_PERMISSION({ commit, state }, pyload) {

             /*  根据后台权限跟我们定义好的权限对比，筛选出对应的路由并加入到path=''的children */
             let routes = recursionRouter(pyload.permissionList, allRoutes)
 
             let MainContainer = DynamicRoutes.find(v => v.path === '/')
             let children = MainContainer.children
             children.push(...routes)
     
            state.menus = pyload.permissionList
            state.user = pyload.user
            state.username = pyload.username

            
             /*  动态添加路由 */
             router.addRoutes(DynamicRoutes)
 
         }
    },
    plugins: []
})