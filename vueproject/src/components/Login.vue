<template>

  <div class="login-container">
    <div class="login">
      <el-form :model="formData" :rules="rules" ref="form">

        <el-form-item label="用户名">
          <el-input
          v-model="formData.username"
          prop="username"
          ></el-input>
        </el-form-item>

        <el-form-item label="密码">
          <el-input
          v-model="formData.password"
          prop="password"
          show-password
          ></el-input>
        </el-form-item>

        <el-button type="primary" @click="toLogin('form')" :loading="loading">登陆</el-button>
        <el-button type="primary" @click="show">显示</el-button>
        <el-button type="primary" @click="logout">退出</el-button>

      </el-form>
    </div>
  </div>



  

</template>

  
<script>

import axios from "../api/axioBase" ;

export default {

  name: 'Login',

  data: function(){

    return {

      loading : false,

      formData:{
        username: '',
        password: ''
      },

      rules :{
        username: [
          {required: true, min:2, message:'输入用户名哦', trigger: 'blur'}
        ],

        password: [
          {required: true, min:2, message:'输入密码哦', trigger: 'blur'}
        ]

      }
    }

  },

  methods: {

        logout: function(){
          axios({
            method: 'get',
            url: 'http://localhost:8890/logout',
            withCredentials: true,
            traditional: true,
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
            ],

          }).then(res=>{
            console.log(res.data) ;

            this.$router.push({ path: '/login' })
            
          })
    },



    toLogin: function(formName){


      this.$refs[formName].validate(valid => {

        if (valid) {
          this.loading = false

          console.log(this.formData) ;

          axios({

            method: 'post',
            url: 'http://localhost:8890/login',
            withCredentials: true,

            traditional: true,
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
            ],
            headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
            },
            data: this.formData
          }).then(res=>{
            console.log(res.data) ;
          })
          
        }



      })

    }
  
  }

  }

</script>

<style scoped>



</style>


