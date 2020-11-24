



<template>

  <el-menu
    class="el-menu-vertical-demo"
    @open="handleOpen"
    @close="handleClose"
    :collapse-transition="false"
    :collapse="collapse"
    unique-opened
    background-color="#545c64"
    text-color="#fff"
    active-text-color="#ffd04b"
    router
    :default-active="$route.path"
    >

    <el-submenu v-for="menu in menus" :key="menu.name" :index="menu.name">
      <template slot="title">
        <i :class="menu.icon"></i>
        <span>{{menu.name}}</span>
      </template>
      <el-menu-item-group>
          <el-menu-item v-for="submenu in menu.children" :key="submenu.name" :index="submenu.url">{{submenu.name}}</el-menu-item>
      </el-menu-item-group>

    </el-submenu>

  </el-menu>

</template>


<script>

import store from '@/vuex/store' ;


export default {
  name: 'laside',

  props: [
    'collapse'
  ],

  data: function(){
    return {
      menus: store.state.menus
    }
  },

  methods: {

    handleOpen: function(){

    },

    handleClose: function(){

    }

  }
}
</script>

<style  scoped>
  .el-menu-vertical-demo{
    height: 100%;
  }

  
</style>