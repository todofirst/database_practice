import Vue from 'vue'
import Router from 'vue-router'
import Index from '@/views/index'
import Login from '@/views/login'
import Outline from '@/components/Outline'
import NotFound from '@/views/404'
import Water from '@/views/water'
import Basec from '@/views/basec'
import Combo from '@/views/combo'
import Employees from '@/views/employees'
import Istore from '@/views/istore'
import Members from '@/views/members'
import Orders from '@/views/orders'
import Suppliers from '@/views/suppliers'
import Tasks from '@/views/tasks'
import Authority from '@/views/authority'
import Performance from '@/views/performance'
import Outinput from '@/views/outinput'
import Userstat from '@/views/userstat'
import Itemstat from '@/views/itemstat'



Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path:'/login',
      name: 'login',
      meta: {
        name: '登陆'
      },
      component: Login
    }
  ]

})

export const DynamicRoutes = [
  {
      path: '/',
      component: Outline,
      name: 'container',
      meta: {
          requiresAuth: true,
          name: '首页'
      },
      children: []
  },

  {
      path: '*',
      component: NotFound
  }
]

export const allRoutes = [

  {
    path: '/goods',
    component: Index,
    name: 'goods',
    meta: {
        name: '商品管理'
    },
    children: [
        {
            path: 'water',
            name: 'water',
            component: Water,
            meta: {
                name: '矿泉水管理'
            }
        },
        {
            path: 'combo',
            name: 'combo',
            component: Combo,
            meta: {
                name: '矿泉水套餐管理'
            }
        }
    ]
},

{
    path: '/info',
    component: Index,
    name: 'info',
    meta: {
        name: '信息管理'
    },
    children: [
        {
            path: 'suppliers',
            name: 'suppliers',
            component: Suppliers,
            meta: {
                name: '供货商管理'
            }
        },
        {
            path: 'istore',
            name: 'istore',
            component: Istore,
            meta: {
                name: '入库信息管理'
            }
        }
    ]
},

{
    path: '/people',
    component: Index,
    name: 'people',
    meta: {
        name: '人员管理'
    },
    children: [
        {
            path: 'members',
            name: 'members',
            component: Members,
            meta: {
                name: '用户管理'
            }
        },
        {
            path: 'employees',
            name: 'employees',
            component: Employees,
            meta: {
                name: '员工管理'
            }
        }
    ]
},

{
    path: '/business',
    component: Index,
    name: 'business',
    meta: {
        name: '业务管理'
    },
    children: [
        {
            path: 'orders',
            name: 'orders',
            component: Orders,
            meta: {
                name: '客户订单管理'
            }
        },
        {
            path: 'tasks',
            name: 'tasks',
            component: Tasks,
            meta: {
                name: '任务管理'
            }
        }
    ]
},


{
    path: '/statistics',
    component: Index,
    name: 'statistics',
    meta: {
        name: '信息统计'
    },
    children: [
        {
            path: 'employees',
            name: 'employees',
            component: Performance,
            meta: {
                name: '员工业绩'
            }
        },
        {
            path: 'outinput',
            name: 'outinput',
            component: Outinput,
            meta: {
                name: '收支统计'
            }
        },
        {
            path: 'itemstat',
            name: 'itemstat',
            component: Itemstat,
            meta: {
                name: '商品统计'
            }
        },
        {
            path: 'userstat',
            name: 'userstat',
            component: Userstat,
            meta: {
                name: '用户统计'
            }
        }
    ]
},

{
    path: '/config',
    component: Index,
    name: 'config',
    meta: {
        name: '系统设置'
    },
    children: [
        {
            path: 'basec',
            name: 'basec',
            component: Basec,
            meta: {
                name: '基本设置'
            }
        },
        {
            path: 'authority',
            name: 'authority',
            component: Authority,
            meta: {
                name: '权限管理'
            }
        }
    ]
}


]
