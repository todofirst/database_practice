

<template>

  <el-container  style="height: 100vh;">

  <el-aside :class="showclass">
    <laside :collapse.sync="collapse"></laside>
  </el-aside>

  <el-container>

    <el-header style="padding:0;text-align:center;">
      <rheader :fold.sync="fold" @toggle="toggle"></rheader>
    </el-header>

    <el-main>
      <router-view/>
    </el-main>
    
  </el-container>
</el-container>

</template>

<script>
import laside from '@/components/Laside'
import rheader from '@/components/Header'
import rfooter from '@/components/Footer'

export default {
  name: 'Index',

  components: {
    laside,
    rheader,
    rfooter
  },

  data: function(){

    return {
      showclass: 'asideshow',
      collapse: false,
      fold: false
    }
  },

  methods: {

    toggle: function(){
      this.collapse = !this.collapse ;
      this.fold = !this.fold ;
      this.showclass = this.collapse? 'aside':'asideshow'
    }
  }
  
}
</script>

<style scoped>
.el-footer{
  background-color:#545c64;
}

.aside {
  width: 64px !important;
  height: 100%;
  background-color:#545c64;
  margin: 0px;
  text-align: center;
  overflow-x: hidden;
}
.asideshow {
  width: 240px !important;
  height: 100%;
  background-color:#545c64;
  margin: 0px;
  text-align: center;
}

</style>