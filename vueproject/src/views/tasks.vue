



<template>
  <div>
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>任务管理</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索筛选 -->
    <el-row class="user-search">
      <el-col :span="2">
        <el-button size="small" type="primary" icon="el-icon-search" @click="handleSingleSearch">单项搜索</el-button>
      </el-col>
      <el-col :span="2">
        <el-button size="small" type="primary" icon="el-icon-search" @click="handleFlexSearch">辅助搜索</el-button>
      </el-col>
      <el-col :span="2">
        <el-button size="small" type="primary" icon="el-icon-plus" @click="handleEdit(null,{})">添加数据</el-button>
      </el-col>
      <el-col :span="2">
          <el-popover
          placement="top-start"
          width="200"
          trigger="hover"
          content="从远端重新拉取数据">
          <el-button size="small" slot="reference" type="primary" icon="el-icon-refresh" @click="getdata">刷新数据</el-button>
        </el-popover>
      </el-col>
      <!-- 导出为Excel -->
      <el-col :span="2">
        <el-popover
          placement="top-start"
          width="200"
          trigger="hover"
          content="导出为Excel文件">
          <el-button size="small" v-if="excelConfig.list!=null" slot="reference" type="primary" icon="el-icon-printer" @click="toOutputExcel">导出为Excel</el-button>
        </el-popover>
      </el-col>
    </el-row>
    <!-- 导出Excel选项 -->
      <el-dialog title="导出Excel" @closed="excelConfig.filename = '导出数据';" :visible.sync="outExcel" width="30%" >
      <el-form label-width="120px"  ref="outExcel">
        <el-form-item label="导出文件名" prop="list">
          <el-input size="small" v-model="excelConfig.filename" auto-complete="off" placeholder="请输入导出的文件名">
          </el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="outExcel=false">取消</el-button>
        <ExportExcel :list="excelConfig.list" @closeExcelDialog="closeExcelDialog" :tHeader="excelConfig.tHeader" :tValue="excelConfig.tValue" :filename="excelConfig.filename"></ExportExcel>
      </div>
    </el-dialog>
    <!-- 单项搜索 -->
    <el-dialog title="单项搜索" @closed="singleCon.value = ''" :visible.sync="singleSearch" width="30%" >
      <el-form label-width="120px"  ref="singleSearch">
        <el-form-item label="在现有数据筛选" prop="eno">
          <el-select  v-model="singleCon.had" placeholder="请选择筛选条件">
            <el-option
              :key="true"
              label="是"
              :value="true">
            </el-option>
            <el-option
              :key="false"
              label="否"
              :value="false">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="字段名称" prop="prop">
            <el-select  v-model="singleCon.sskey" placeholder="请选择查询的值">
              <el-option
                v-for="ssKey in ssKeys"
                :key="ssKey.key"
                :label="ssKey.label"
                :value="ssKey.key">
              </el-option>
            </el-select>
        </el-form-item>      
        <el-form-item label="字段值" prop="prop">
          <el-input size="small" v-model="singleCon.value" auto-complete="off" placeholder="请输入要查询的值">
          </el-input>
        </el-form-item>     
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="closeSingleSearch">取消</el-button>
        <el-button size="small" type="primary" :loading="singleLoading" class="title" @click="submitSingleForm('singleSearch')">查询</el-button>
      </div>
    </el-dialog>
    <!-- 辅助搜索 -->
    <el-dialog title="辅助搜索" :visible.sync="flexSearch" width="38%" >
      <el-form label-width="120px"   ref="flexSearch">
        <el-form-item label="在现有数据筛选" prop="eno">
          <el-select  v-model="auSearch.had" placeholder="请选择筛选条件">
            <el-option
              :key="true"
              label="是"
              :value="true">
            </el-option>
            <el-option
              :key="false"
              label="否"
              :value="false">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="时间段" prop="timespan">
          <el-date-picker
            v-model="auSearch.timespan"
            type="datetimerange"
            unlink-panels
            :picker-options="pickerOptions"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"

            >
          </el-date-picker>
        </el-form-item>
        <el-form-item label="员工" prop="eno">
          <el-select  v-model="auSearch.eno" placeholder="请选择负责员工">
            <el-option
              v-for="employee in employees"
              :key="employee.eno"
              :label="employee.name"
              :value="employee.eno">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="closeFlexSearch">取消</el-button>
        <el-button size="small" type="primary" :loading="singleLoading" class="title" @click="submitFlexForm('singleSearch')">查询</el-button>
      </div>
    </el-dialog>
    <!--列表-->
    <el-table max-height="500" size="small" :data="listData" highlight-current-row v-loading="loading"
     border element-loading-text="拼命加载中"
     stripe style="width: 100%;"  
     @filter-change="filterChange"
     @sort-change='tableSortChange'
     @select="selectRow"
     @select-all="selectAllRow"
     ref="table"

     >
      <el-table-column align="center" type="selection" width="60">
      </el-table-column>
      <el-table-column align="center" label="序号" type="index" width="60"
      >
        <template slot-scope="scope">
          {{scope.$index+1+startIndex}}
        </template>
      </el-table-column>
      <el-table-column  prop="cono" label="所属订单编号" width="300">
      </el-table-column>
      <el-table-column  prop="cno" label="客户编号" width="300">
      </el-table-column>
      <el-table-column  prop="cname" label="客户姓名" width="300">
      </el-table-column>
      <el-table-column 
      :filters="[{ text: '男', value: '男' }, { text: '女', value: '女' }]"
       column-key="sex"
      :filter-multiple="false"
       prop="sex" label="客户性别" width="300">
      </el-table-column>
      <el-table-column  prop="ctel" label="客户电话" width="300">
      </el-table-column>
      <el-table-column  prop="address" label="客户地址" width="300">
      </el-table-column>
      <el-table-column  prop="name" label="负责员工" width="300">
      </el-table-column>
      <el-table-column  sortable="custom" prop="time" label="送货时间" width="300">
        <template slot-scope="scope">
          <div>{{scope.row.time|timestampToTime}}</div>
        </template>
      </el-table-column>
      <el-table-column  prop="wname" label="矿泉水名称" width="300">
      </el-table-column>
      <el-table-column sortable="custom" prop="num" label="数量" width="300">
      </el-table-column>
      <el-table-column  prop="status" label="任务状态" width="300"
      :filters="[{ text: '已完成', value: '1' }, { text: '进行中', value: '0' }]"
      :filter-multiple="false"
      column-key="status"
      >
        <template slot-scope="scope">
          <div>
            <el-tag type="danger" v-if="scope.row.status=='0'">进行中</el-tag>
            <el-tag type="success" v-else>已完成</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column align="center" fixed="right" label="操作" min-width="150">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
          <el-button size="mini" type="danger" @click="handleDel(scope.$index, scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页组件 -->
    <Pagination v-bind:child-msg.sync="pageparm" @callFather="setPageData"></Pagination>
    <!-- 编辑界面 -->
    <el-dialog :title="title" :visible.sync="editFormVisible" @closed="afterClose" width="30%" >
      <el-form label-width="120px" :model="editForm" :rules="title=='添加'&&flush?editRules:{}" ref="editForm">
        <el-form-item label="所属订单编号" prop="cono">
          <el-input size="small" @change="hadCorder" :disabled="title=='编辑'?true:false" v-model="editForm.cono" auto-complete="off" clearable placeholder="请输入所属编号"></el-input>
        </el-form-item>
        <el-form-item label="客户编号" prop="cno">
          <el-input size="small" :disabled="true" v-model="editForm.cno" auto-complete="off" clearable placeholder="请输入客户编号"></el-input>
        </el-form-item>
        <el-form-item label="客户姓名" prop="cname">
          <el-input size="small"  v-model="editForm.cname" auto-complete="off" clearable placeholder="请输入客户姓名"></el-input>
        </el-form-item>
        <el-form-item label="客户性别" prop="sex">
            <el-select v-model="editForm.sex" clearable placeholder="请选择性别">
              <el-option
                key="男"
                label="男"
                value="男">
              </el-option>
              <el-option
                key="女"
                label="女"
                value="女">
              </el-option>
            </el-select>
        </el-form-item>
        <el-form-item label="客户电话" prop="ctel" >
          <el-input size="small" clearable  v-model="editForm.ctel" auto-complete="off" placeholder="请输入客户电话"></el-input>
        </el-form-item>
        <el-form-item label="客户地址" prop="address">
          <el-input size="small" v-model="editForm.address" auto-complete="off" clearable placeholder="请输入客户地址"></el-input>
        </el-form-item>  
        <el-form-item label="负责员工" prop="name">
            <el-select @change="selectEm($event,'employees')" clearable v-model="editForm.eno" placeholder="请选择负责员工">
              <el-option
                v-for="employee in employees"
                :key="employee.eno"
                :label="employee.name"
                :value="employee.eno">
              </el-option>
            </el-select>
        </el-form-item>    
        <el-form-item label="送货时间" prop="time">
          <el-date-picker
            clearable
            v-model="editForm.time"
            type="datetime"
            placeholder="请选择日期时间">
          </el-date-picker>
        </el-form-item>    
        <el-form-item label="矿泉水名称" prop="wname">
          <!-- <el-select @change="selectWater" :disabled="title=='编辑'?true:false" v-model="editForm.wno" placeholder="请选择一种矿泉水">
            <el-option
              v-for="water in waters"
              :key="water.wno"
              :label="water.wname"
              :value="water.wno">
            </el-option>
          </el-select> -->
            <el-input clearable size="small" v-model="editForm.wname" :disabled="true" auto-complete="off" placeholder="请输入矿泉水名称"></el-input>
        </el-form-item>  
        <el-form-item label="数量" prop="num">
          <el-input clearable @input="hadleavs" size="small" v-model="editForm.num" auto-complete="off" placeholder="请输入数量"></el-input>
        </el-form-item>    
        <el-form-item label="任务状态" prop="status">
          <el-select  clearable v-model="editForm.status" placeholder="请选择任务状态">
            <el-option
              key="0"
              label="进行中"
              value="0">
            </el-option>
            <el-option
              key="1"
              label="已完成"
              value="1">
            </el-option>
          </el-select>
        </el-form-item>                   
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="closeDialog">取消</el-button>
        <el-button size="small" type="primary" :disabled="submitDisabled" :loading="loading" class="title" @click="submitForm('editForm')">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import Pagination from '@/components/Pagination' ;
import  ExportExcel from '@/components/ExportExcel'
import {getAllData, delIt, updateIt, hadCustomer, hadCorders, hadleav} from '@/api/dataMG' ;
import {timestampToTime} from '@/util/filters' ;
import {objToArr,pnV} from '@/util/util' ;
export default {
  name: 'Tasks',

  components: {Pagination, ExportExcel},

  data() {



    return {  


// -----------------受限制部分
      // 编辑前的数据-----这里因为是主键，在编辑后可能会改变的，所以记录下来，可以在修改数据后再在数据库中找到原来的数据
      oldEditData: {
        eno: 0,
        time: 0
      },
// -----------------
// -----------------可动态修改部分
      // 编辑页面的数据设置还有添加页面的一些默认的选项
      editForm: {
        sex:'男',
        status:'0'
      },

      submitDisabled: false,

      // 可选数据列表
      employees: [],
      waters: [],

      // 添加列表规则
      editRules:{
        'cno':[
          {validator:hadCustomer, message: '没有此用户', trigger: 'blur'},
          {required: true, message: '不能为空', trigger: 'blur'}
          ],
        'cname':{required: true, message: '不能为空', trigger: 'blur'},
        'sex':{required: true, message: '不能为空', trigger: 'blur'},
        'ctel':[
          {validator:pnV, required: true, message: '仅能为正整数', trigger: 'blur'},
          {message: '最长11位', trigger: 'blur', max:11},
          {required: true, message: '不能为空', trigger: 'blur'}
          ],
        'address':{required: true, message: '不能为空', trigger: 'blur'},
        'name':{required: true, message: '不能为空', trigger: 'blur'},
        'time':{required: true, message: '不能为空', trigger: 'blur'},
        'wname':{required: true, message: '不能为空', trigger: 'blur'},
        'num':[
          {validator:pnV, required: true, message: '仅能为正整数', trigger: 'blur'},
          {required: true, message: '不能为空', trigger: 'blur'}
        ],
        'status':{required: true, message: '不能为空', trigger: 'blur'}
      },
      // 导出为Excel的参数
      excelConfig:{
        list:[],
        tHeader:['所属订单编号','客户编号','客户姓名','客户性别','客户电话','客户地址','负责员工','送货时间','矿泉水名称','数量','任务状态'],
        tValue:['cono','cno', 'cname', 'sex', 'ctel', 'address', 'name', 'time', 'wname', 'num', 'status'],
        filename: '导出数据'
      },
      
      // 单项搜索关键字集合      // canBlur 开启模糊匹配
      ssKeys: [
        {key: 'cname', label: '客户姓名', canBlur: true},
        {key: 'ctel', label: '客户电话', canBlur: true},
        {key: 'address', label: '客户地址', canBlur: true},
        {key: 'wname', label: '矿泉水名称', canBlur: true},
        {key: 'cno', label: '客户编号', canBlur: true},
      ],

      // 单项搜索存储对象
      singleCon: {
        sskey: 'cname',
        value: '',
        had: false
      },

      // 辅助搜索对象存储集合
      auSearch:{
        timespan: [],
        eno: '',
        had: true
      },

// -----------------可动态修改部分


// -----------------开关集合

      // Excel显示
      outExcel: false,

      flush: false,

      // 全选标志
      selectAll: false,
      singleSearch: false, //单项搜索显示
      flexSearch: false, //组合搜索显示
      loading: false, //列表显示加载
      singleLoading: false, //单项搜索按钮加载显示
      flexLoading: false, //组合搜索按钮加载显示
      editFormVisible: false, //控制编辑页面显示与隐藏
// -----------------


      // 选择对象---用于单选行的时候，在已选中的页面显示选中项
      selectedObj : {},

      pickerOptions: {
        shortcuts: [{
          text: '最近一周',
          onClick(picker) {
            const end = new Date();
            const start = new Date();
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 7);
            picker.$emit('pick', [start, end]);
          }
        }, {
          text: '最近一个月',
          onClick(picker) {
            const end = new Date();
            const start = new Date();
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 30);
            picker.$emit('pick', [start, end]);
          }
        }, {
          text: '最近三个月',
          onClick(picker) {
            const end = new Date();
            const start = new Date();
            start.setTime(start.getTime() - 3600 * 1000 * 24 * 90);
            picker.$emit('pick', [start, end]);
          }
        }]
      },

      //当前被选中的序号-------startIndex+currentIndex-----用于序号的正确显示
      currentIndex: 0,

      // 序号开始
      startIndex: 0,

      // 数据库显示数据列表
      listData: [],
      // 总获取数据列表
      totalData: [],

      title: '添加',

      // 分页的初始化数据
      initData: {
        currentPage: 1,
        pageSize: 10,
        name: '',
        tel:'',
        pageSizes: [1, 2, 3, 10, 15, 20]

      },

      // 实际分页参数
      pageparm: {
        currentPage: 1,
        pageSize: 10,
        total: 0,
        pageSizes: [1, 2, 3, 10, 15, 20]
      }
    }
  },


  

  methods: {

    // 可修改：初始化数据获取
    getdata() {
      this.totalData = []
      this.loading = true
      // 获取矿泉水
      getAllData('/getData/waters').then(res=>{
          if(res.code==0){
            this.waters = res.data
          }else{
            this.$message.error('获取数据失败')
          }
      })
      // 获取员工
      getAllData('/getData/employees').then(res=>{

          if(res.code==0){
            this.employees = res.data
          }else{
            this.$message.error('获取数据失败')
          }
      })
      // 模拟数据开始
      getAllData('/getData/tasks').then(res=>{

        setTimeout(()=>{
          
          if(res.code==0){
            this.loading = false
            this.totalData.push(...res.data)
            this.pageparm.currentPage = this.initData.currentPage
            this.pageparm.pageSize = this.initData.pageSize,
            this.pageparm.pageSizes = this.initData.pageSizes
            this.pageparm.total = res.count
            this.setPageData(this.pageparm)
            sessionStorage.setItem('tasks', JSON.stringify({
              totalData: this.totalData ,
              pageparm : this.pageparm
            }))
          }else{
            this.$message.error('获取数据失败')
          }

        }, 400)

      }).catch(err => {
          this.loading = false
          this.$message.error('菜单加载失败，请稍后再试！')
        })

    },


// 判断是否有余量
  hadleavs : function(value){
    // if(this.editForm.cono==undefined)
    //   return this.$message.error('请先填写套餐哦')
    let num = parseInt(value)

    if(isNaN(num)&&value !== ''){

        this.$refs['editForm'].fields[9].validateMessage = '整点正常的吧'
        this.$refs['editForm'].fields[9].validateState = 'error'
        this.submitDisabled = true
        
    }else{

      if(this.editForm.cono==undefined){

        this.$message.warning('请先选择订单')
        this.submitDisabled = true
      }else{

      hadleav({
        num: num,
        cono: this.editForm.cono
      }).then((res)=>{
        if(!res.had&&res.code==0){
          this.submitDisabled = true
          this.$refs['editForm'].fields[9].validateMessage = '没有余量了'
          this.$refs['editForm'].fields[9].validateState = 'error'

        }else if(res.had&&res.code==0){
          this.submitDisabled = false
          this.$refs['editForm'].fields[9].validateState = 'success'

        }else{

          this.$message.error(`网络好像有点问题,${res.code}`)
        }
      }).catch(err=>{
        console.log(err)

        this.$message.error('网络好像有点问题')
      })
      // this.$forceUpdate()

      }
    }



},
    // 判断是否存在该订单
    hadCorder: function(value){
      console.log(this.$refs['editForm'].fields[9])
      hadCorders(value).then((res)=>{
        if(res.count==0&&res.code==0){

          this.$refs['editForm'].fields[0].validateMessage = '没有这个订单'
          this.$refs['editForm'].fields[0].validateState = 'error'
          this.editForm = {}

        }else if(res.count>0&&res.code==0){
          this.$refs['editForm'].fields[0].validateState = 'success'
          res.data.address = res.data.address=='undefined'?'':res.data.address
          this.editForm = {...Object.assign(this.editForm,res.data)}
        }else{
          this.$message.error(`网络好像有点问题,${res.code}`)
        }

      }).catch((err)=>{
        console.log(err)
        this.$message.error('网络好像有点问题')
      })
      this.$forceUpdate()
    },

    // 导出按钮
    toOutputExcel: function(){
      this.outExcel = true ;
      let totalData = [] ;

      if(this.selectAll){
        // 可修改：全部的任务
        totalData = JSON.parse(sessionStorage.getItem('tasks')).totalData ;
      }else{
        let keys = Object.keys(this.selectedObj)
        if(keys.length==0){
          totalData = JSON.parse(sessionStorage.getItem('tasks')).totalData ;
        }else{
        // 可修改：零散选择的选项并且可以导出的
        totalData = objToArr(this.selectedObj) ;
        }
      }

      this.excelConfig.list = totalData.map(data=>{
        // 可修改：导出之前格式化数据
        data.time = timestampToTime(data.time) ;
        data.status = data.status=='0'?'进行中':'已完成' ;
        return data ;
      })
    },
    // 关闭excel对话窗口
    closeExcelDialog: function(){
      this.outExcel = false ;
      this.selectedObj = {} ;
      this.selectAll = false ;
    },
    // 设置选中
    recoverSelect: function(rows){
      this.$nextTick(()=>{
        rows.forEach(row => {
          this.$refs['table'].toggleRowSelection(row);
        });
      })

    },
    // 选择行的时候触发
    selectRow: function(selection, row){
      console.log(row,selection)
      this.selectedObj[this.pageparm.currentPage] = [...selection] ;
    },

    // 全选触发
    selectAllRow: function(selection){
      if(selection.length == this.listData.length){
        this.selectAll = true ;
      }else{
        this.selectAll = false ;
        this.selectedObj = {} ;
      }
    },

    // 在对话框关闭后恢复editForm的默认值
    afterClose: function(){

      // 可修改：设置编辑页面的显示还有一些默认数据
      this.$refs['editForm'].clearValidate()
      this.editForm = {}
      this.editForm.sex = '男'
      this.editForm.status = '0'
      // 清除表单验证信息的驻留
      this.flush = false 

    },

    // 列表的整体排序
    tableSortChange:function({column,order,prop}){
      console.log('column', column)
      this.totalData.sort(function(a,b){

        if(order == 'ascending'){
          return a[prop] - b[prop] ;
        }else{
          return b[prop] - a[prop] ;
        }
      })

      this.setPageData(this.pageparm) ;
    } ,

    // 过滤方法，用于过滤选项
    filterChange(filters){
      /**
       * filters:{sex: ['男']}
       */
      let key = Object.keys(filters)[0] ;
      let obj = filters[key] ;

      // 可修改：totalData:总体的数据 pageparm：页面参数
      let tasks = JSON.parse(sessionStorage.getItem('tasks')) ;
      let totalData = [...tasks.totalData] ;
      let pageparm = {...tasks.pageparm} ;

      // 有选中筛选筛选条件的
      if(obj.length != 0){

        let value = obj[0] ;
        // 过滤剩下对应的对象
        totalData = totalData.filter((data)=>{
          return data[key] == value
        })
      }

      // 重新设置分页参数
      pageparm.total = totalData.length ;
      this.totalData = totalData ;
      this.setPageData(pageparm) ;

    },
    // 显示单项搜索页面
    handleSingleSearch: function(){
      this.singleSearch = true
    },
    // 显示组合搜索页面
    handleFlexSearch: function(){
      this.flexSearch = true
    },

    // 可修改：编辑页面，选择员工后渲染员工列表
    /**
     * val：表示选中的值，这里是是选中的值
     * key: 表示可供该选择的数据。例如这里是员工列表
     */
    selectEm: function(val,key){
      // 在employees中筛选跟选中的值相同的数据对象
      let employee = this[key].filter((ele,index,arr)=>{
        return ele.eno === val
      });

      if(employee.length !== 0){
        this.editForm.name = employee[0].name ;
      }else{
        this.$message.error('出错了')
      }
    },

    // 可修改：在选中对应的水品牌后设置提交表单editForm中的数据
    selectWater: function(val){

      let water = this.waters.filter((ele,index,arr)=>{
        return ele.wno === val
      });

      if(water.length !== 0){
        this.editForm.wname=water[0].wname
      }else{
        this.$message.error('出错了')
      }

    },


    // 设置分页
    setPageData(parm) {

      // 重置分页参数 
      this.pageparm = parm ;
      let pre = (parm.currentPage-1)*parm.pageSize ;
      let next = parm.currentPage*parm.pageSize>=parm.total?parm.total:parm.pageSize*parm.currentPage
      this.startIndex = pre ;
      
      this.listData = this.totalData.slice(pre,next) ;
      // 设置选中状态
      // 如果全选了
      if(this.selectAll){
        this.recoverSelect(this.listData) ;
      }else{
        // 重置了页面尺寸
        if(parm.prePage == -1){

          this.selectedObj = {} ;
          this.selectAllRow = false ;
          this.recoverSelect([]) ;

        }else{

          if(this.selectedObj[parm.currentPage] != undefined && this.selectedObj[parm.currentPage].length != 0){
            this.recoverSelect([...this.selectedObj[parm.currentPage]])
          }
        }
      }
    },

    //显示编辑界面
    handleEdit: function(index, row) {

      let uoa = Object.keys(row)
      // 通过row对象的传入判断是添加还是编辑
      if(uoa.length==0){
        this.title = '添加'
      }else{

        this.title = '编辑'
        // 可修改：这里是设置之前的数据，保存的旧数据是用来做字段匹配的
        this.oldEditData.eno = row.eno
        this.oldEditData.time = row.time
        let oldEditData = {...row}
        oldEditData.time = new Date(parseInt(row.time))
        this.editForm = oldEditData
        this.currentIndex = index 
      }
      this.editFormVisible = true
    },

    // 提交单项搜索
    submitSingleForm(form){
      
      this.loading = true ;
      let canBlur ;
      let totalData = this.totalData ;
      let pageparm = this.pageparm ;

      // 判断能否进行模糊匹配
      this.ssKeys.forEach(obj=>{
        if(obj.key== this.singleCon.sskey){
          canBlur = obj.canBlur ;
        }
      })

      // 是否在现有数据进行匹配，是的直接拉去totalData，不是的话就获取本来获取的数据
      if(!this.singleCon.had){
        let tasks = JSON.parse(sessionStorage.getItem('tasks')) ;
        totalData = tasks.totalData ;
        pageparm = tasks.pageparm ;
      }

      let total = [] ;
      if(canBlur){
        totalData.forEach(data=>{
          if(data[this.singleCon.sskey].indexOf(this.singleCon.value) != -1){
            total.push(data)
          }    
        })
      }else{
        totalData.forEach(data=>{
          if(data[this.singleCon.sskey] == this.singleCon.value){
            total.push(data) ;
          }    
        })
      }
      this.pageparm.total = total.length ;
      this.totalData = [...total] ;
      this.setPageData(this.pageparm) ;
      this.loading = false ;
      this.singleSearch = false ;

    },

    // 辅助搜索提交表单
    submitFlexForm: function(form){
      let copy = [...this.totalData] ;
      let pageparm = {...this.pageparm} ;
      let tasks =  JSON.parse(sessionStorage.getItem('tasks')) ;
      // 是否在现有数据拉取数据
      if(!this.auSearch.had){
        copy = tasks.totalData ;
        pageparm = tasks.pageparm ;
      }
      // 可修改：这里只是针对该页面的筛选条件
      let timepsan = this.auSearch.timespan ;
      let eno = this.auSearch.eno ;
      let total = [] ;

      let tmp = [] ;
 
      if(timepsan.length != 0){

        let start  = this.auSearch.timespan[0].getTime() ;
        let end = this.auSearch.timespan[1].getTime() ;
        copy = copy.filter(function(item){
          return item.time>=start&&item.time<=end
        })
      }

      // 可修改：在时间筛选的基础上进一步筛选
      if(typeof(eno) == 'number'){
        copy = copy.filter((item)=>{
        return item.eno == eno ;
        })
      }

      // 设置页面参数
      this.totalData = copy ;
      pageparm.total = this.totalData.length ;
      this.setPageData(pageparm) ;
      this.flexSearch = false ;

      this.auSearch.timespan = [] ;
      this.auSearch.eno = '' ;

    },

    // 可修改：页面编辑和添加的方法
    submitForm(editData) {
      this.flush = true
      console.log('进来了')
      this.$nextTick(()=>{
        
        this.$refs[editData].validate(valid => {
          console.log('验证',valid)
          if (valid) {
            this.editForm.time = this.editForm.time.getTime()
            let url = this.title == '编辑'? '/getData/updateit':'/getData/instasks'
            updateIt(url, {
              where:{
                time: this.title=='编辑'?  this.oldEditData.time:this.editForm.time,
                cno: this.editForm.cno,
                eno : this.title=='编辑'?  this.oldEditData.eno :this.editForm.eno
              },
              values: {
                time: this.editForm.time,
                num : this.editForm.num,
                ctel: this.editForm.ctel,
                cno : this.editForm.cno,
                address: this.editForm.address,
                eno : this.editForm.eno,
                wno : this.editForm.wno,
                status: this.editForm.status,
                sex: this.editForm.sex,
                cname: this.editForm.cname,
                cono :this.editForm.cono,
              },
              op: this.title,
              tb: 'task'
            }).then(res=>{
              this.editFormVisible = false
              let nindex = this.startIndex + this.currentIndex 
              if(res.code==0){
                this.$message.success(res.message)
                if(this.title == '编辑'){
                  this.totalData[nindex] = {...this.editForm}
                  this.setPageData(this.pageparm)
                }else{
                  this.totalData.unshift({...this.editForm})
                  this.pageparm.total += 1 ;
                  this.setPageData(this.pageparm)
                }

              }else{
                this.$message.error(res.message)
              }
            })
            .catch(err=>{
              this.editFormVisible = false
              this.$message.error('发生错误')
            })
          } 
        })


      })

    },
    // 可修改：删除信息操作
    handleDel(index, row) {
      this.$confirm('确定要删除吗?', '信息', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
        .then(() => {
          let nindex = this.startIndex + index ;
          delIt('/getData/delit',{
            // 可修改：具体匹配删除的关键字还有表名
            where: {
              cno: row.cno,
              time: row.time,
              eno : row.eno
            },
            tb: 'task'

          }).then(res=>{
            if(res.code==0){
              this.$message.success('删除成功')
              this.totalData.splice(nindex,1)
              this.pageparm.total -= 1
              this.setPageData(this.pageparm)
            }else{
              this.$message.error('删除失败')
            }
          })
          .catch(err=>{
            this.$message.error('发生错误')
          })
          
        })
        .catch(() => {

        })
    },
    // 关闭编辑、增加弹出框
    closeDialog: function(){
      this.editFormVisible = false
    },
    // 关闭单项搜索对话框
    closeSingleSearch: function(){
      this.singleSearch = false
    },
    // 关闭辅助搜索对话框
    closeFlexSearch: function(){
      this.flexSearch = false
    }

  },

  // 实例创建的时候初始化数据
  created() {
    this.getdata()
  }


}
</script>

<style scoped>
.tasks-container{
  width: 100%;
  height: 100%;

}

.el-date-editor{
  cursor: pointer;
}

.el-range-editor .el-range-input{
  cursor: pointer;
}

.user-search{
  margin:14px 0;
}

.el-form-item{
  margin-bottom: 16px;
  margin-top: 16px;
}
</style>