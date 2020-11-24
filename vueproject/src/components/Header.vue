
<template>

  <el-row type="flex" class="row-bg" justify="space-around">
    <el-col :span="2" class="big">
      <i :class="fold?'el-icon-s-fold':'el-icon-s-unfold'"
      @click="toggleFold"></i>
    </el-col>

    <el-col :span="2">
      <el-dropdown @command="handleCommand">
      <span class="el-dropdown-link" >
        {{$store.state.username}}<i class="el-icon-arrow-down el-icon--right"></i>
      </span>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item icon="el-icon-house" command="logout">退出</el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
    </el-col>
  </el-row>

</template>

<script>
import store from '@/vuex/store' ;
import {logout} from '@/api/userMG' ;
export default {
  name: 'rheader',

  props: [
    'fold'
  ],

  data: function(){

    return {
    }
  },

  methods: {

    toggleFold: function(){
      this.$emit('toggle')
    },

    handleCommand: function(command){
      
      logout().then(data => {
        if(data.code==0){
          this.$store.commit('LOGOUT') ;
        }
      })
    }

  }
}
</script>

<style  scoped>
.big{
  font-size: 25px;
  cursor: pointer;
}
.row-bg{
  background: #545c64;
  height: 100%;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.el-dropdown-link{
  color: white; 
  cursor: pointer;
}

.el-header{
  padding-left: 0;
}

</style>