



<template>
  <div>
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>员工管理</el-breadcrumb-item>
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
        <el-form-item label="在现有数据筛选" prop="had">
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
        <el-form-item label="入职时间" prop="timespan">
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
      <el-table-column  prop="eno" label="工号" width="300">
      </el-table-column>
      <el-table-column  prop="name" label="员工姓名" width="300">
      </el-table-column>
      <el-table-column 
      :filters="[{ text: '男', value: '男' }, { text: '女', value: '女' }]"
       column-key="sex"
      :filter-multiple="false"
       prop="sex" label="员工性别" width="300">
      </el-table-column>
      <el-table-column  prop="tel" label="联系电话" width="300">
      </el-table-column>
      <el-table-column  prop="job" label="职位" width="300">
      </el-table-column>
      <el-table-column  sortable="custom" prop="time" label="入职时间" width="300">
        <template slot-scope="scope">
          <div>{{scope.row.time|timestampToTime}}</div>
        </template>
      </el-table-column>
      <el-table-column  prop="name" label="薪水" width="300">
      </el-table-column>
      <el-table-column  prop="status" label="状态" width="300"
      :filters="[{ text: '离职', value: '0' }, { text: '在职', value: '1' },{ text: '休假', value: '2' }]"
      :filter-multiple="false"
      column-key="status"
      >
        <template slot-scope="scope">
          <div>
            <el-tag type="danger" v-if="scope.row.status=='0'">离职</el-tag>
            <el-tag type="success" v-else-if="scope.row.status=='1'">在职</el-tag>
            <el-tag v-else>休假</el-tag>
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
        <el-form-item label="工号" v-if="title=='编辑'" prop="eno">
          <el-input clearable size="small" :disabled="title=='编辑'?true:false" v-model="editForm.eno" auto-complete="off" placeholder="请输入客户编号"></el-input>
        </el-form-item>
        <el-form-item label="员工姓名" prop="name">
          <el-input size="small" clearable  v-model="editForm.name" auto-complete="off" placeholder="请输入员工姓名"></el-input>
        </el-form-item>
        <el-form-item label="员工性别" prop="sex">
            <el-select clearable v-model="editForm.sex" placeholder="请选择性别">
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
        <el-form-item label="年龄" prop="age">
          <el-input clearable size="small" v-model="editForm.age" auto-complete="off" placeholder="请输入年龄"></el-input>
        </el-form-item>  
        <el-form-item label="联系电话" prop="tel" >
          <el-input clearable size="small"  v-model="editForm.tel" auto-complete="off" placeholder="请输入联系电话"></el-input>
        </el-form-item>
        <el-form-item label="职位" prop="job">
          <el-select clearable v-model="editForm.job" placeholder="请选择职位">
            <el-option
              v-for="job in jobs"
              :key="job.value"
              :label="job.label"
              :value="job.value">
            </el-option>
          </el-select>
        </el-form-item> 
        <el-form-item label="入职时间" prop="time">
          <el-date-picker
            clearable
            v-model="editForm.time"
            type="datetime"
            placeholder="请选择日期时间">
          </el-date-picker>
        </el-form-item>    
        <el-form-item label="薪水" prop="salary">
          <el-input clearable size="small" v-model="editForm.salary" auto-complete="off" placeholder="请输入薪水"></el-input>
        </el-form-item>  
        <el-form-item label="状态" prop="status">
          <el-select clearable v-model="editForm.status" placeholder="请选择任务状态">
            <el-option
              key="0"
              label="离职"
              value="0">
            </el-option>
            <el-option
              key="1"
              label="在职"
              value="1">
            </el-option>
            <el-option
              key="2"
              label="休假"
              value="2">
            </el-option>
          </el-select>
        </el-form-item>                   
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="closeDialog">取消</el-button>
        <el-button size="small" type="primary" :loading="loading" class="title" @click="submitForm('editForm')">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import Pagination from '@/components/Pagination' ;
import  ExportExcel from '@/components/ExportExcel'
import {getAllData, delIt, updateIt, hadCustomer} from '@/api/dataMG' ;
import {timestampToTime} from '@/util/filters' ;
import {objToArr,pnV,ageV} from '@/util/util' ;
export default {
  name: 'employees',

  components: {Pagination, ExportExcel},

  data() {
    return {  
// -----------------受限制部分
      // 编辑前的数据-----这里因为是主键，在编辑后可能会改变的，所以记录下来，可以在修改数据后再在数据库中找到原来的数据
      oldEditData: {

      },
// -----------------
// -----------------可动态修改部分
      // 编辑页面的数据设置还有添加页面的一些默认的选项
      editForm: {
        sex:'男',
        status:'0',
        job: '配送员'
      },

      jobs: [
        {label: '配送员', value:'配送员'},
        {label: '仓库管理', value:'仓库管理'},
        {label: '客服', value:'客服'}
      ],


      // 添加列表规则
      editRules:{
        'name':{required: true, message: '不能为空', trigger: 'blur'},
        'sex':{required: true, message: '不能为空', trigger: 'blur'},
        'tel':[
          {validator:pnV, required: true, message: '仅能为正整数', trigger: 'blur'},
          {message: '最长11位', trigger: 'blur', max:11},
          {required: true, message: '不能为空', trigger: 'blur'}
          ],
        'job':{required: true, message: '不能为空', trigger: 'blur'},
        'time':{required: true, message: '不能为空', trigger: 'blur'},
        'age':[
          {validator:ageV, required: true, message: '年龄在18到65之间', trigger: 'blur'},
          {required: true, message: '不能为空', trigger: 'blur'}
        ],
        'salary':[
          {validator:pnV, required: true, message: '仅能为正整数', trigger: 'blur'},
        ],
        'status':{required: true, message: '不能为空', trigger: 'blur'}
      },
      // 导出为Excel的参数
      excelConfig:{
        list:[],
        tHeader:['员工编号','员工姓名','员工性别','员工年龄','联系电话','职位','入职时间','薪资','状态'],
        tValue:['eno', 'name', 'sex', 'age', 'tel', 'job', 'time', 'salary','status'],
        filename: '导出数据'
      },
      
      // 单项搜索关键字集合      // canBlur 开启模糊匹配
      ssKeys: [
        {key: 'eno', label: '工号', canBlur: false},
        {key: 'name', label: '员工姓名', canBlur: true},
        {key: 'tel', label: '联系电话', canBlur: true},
        {key: 'job', label: '职位', canBlur: true},
      ],

      // 单项搜索存储对象
      singleCon: {
        sskey: 'eno',
        value: '',
        had: false
      },

      // 辅助搜索对象存储集合
      auSearch:{
        timespan: [],
        had: false
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
      this.loading = true
      this.totalData = []
      // 模拟数据开始
      getAllData('/getData/allemployees').then(res=>{
        setTimeout(()=>{
          
          if(res.code==0){
            this.loading = false
            this.totalData.push(...res.data)
            this.pageparm.currentPage = this.initData.currentPage
            this.pageparm.pageSize = this.initData.pageSize,
            this.pageparm.pageSizes = this.initData.pageSizes
            this.pageparm.total = res.count
            this.setPageData(this.pageparm)
            sessionStorage.setItem('employees', JSON.stringify({
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

    // 导出按钮
    toOutputExcel: function(){
      this.outExcel = true ;
      let totalData = [] ;

      if(this.selectAll){
        // 可修改：全部的任务
        totalData = JSON.parse(sessionStorage.getItem('employees')).totalData ;
      }else{
        let keys = Object.keys(this.selectedObj)
        // 表示啥都没选，所以直接导出去哪不
        if(keys.length==0){
          totalData = JSON.parse(sessionStorage.getItem('employees')).totalData ;
        }else{
        // 可修改：零散选择的选项并且可以导出的
        totalData = objToArr(this.selectedObj) ;
        }
      }

  
      this.excelConfig.list = totalData.map(data=>{
        // 可修改：导出之前格式化数据
        data.time = timestampToTime(data.time) ;
        data.status = data.status=='0'?'离职':data.status=='1'?'在职':'休假' ;
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
      this.editForm.status = '1'
      this.editForm.job = '配送员'
      // 清除表单验证信息的驻留
      this.flush = false 

    },

    // 列表的整体排序
    tableSortChange:function({column,order,prop}){

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
      let employees = JSON.parse(sessionStorage.getItem('employees')) ;
      let totalData = [...employees.totalData] ;
      let pageparm = {...employees.pageparm} ;

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
        let employees = JSON.parse(sessionStorage.getItem('employees')) ;
        totalData = employees.totalData ;
        pageparm = employees.pageparm ;
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
      let employees =  JSON.parse(sessionStorage.getItem('employees')) ;
      // 是否在现有数据拉取数据
      if(!this.auSearch.had){
        copy = employees.totalData ;
        pageparm = employees.pageparm ;
      }
      // 可修改：这里只是针对该页面的筛选条件
      let timepsan = this.auSearch.timespan ;
      let total = [] ;

      let tmp = [] ;
 
      if(timepsan.length != 0){

        let start  = this.auSearch.timespan[0].getTime() ;
        let end = this.auSearch.timespan[1].getTime() ;
        copy = copy.filter(function(item){
          return item.time>=start&&item.time<=end
        })
      }


      // 设置页面参数
      this.totalData = copy ;
      pageparm.total = this.totalData.length ;
      this.setPageData(pageparm) ;
      this.flexSearch = false ;

      this.auSearch.timespan = [] ;

    },

    // 可修改：页面编辑和添加的方法
    submitForm(editData) {
      this.flush = true
      this.$nextTick(()=>{
        this.$refs[editData].validate(valid => {
          if (valid) {
            this.editForm.time = this.editForm.time.getTime()
            console.log(this.editForm)
            let url = this.title == '编辑'? '/getData/updateit':'/getData/insemployees'
            updateIt(url, {
              where:{
                eno: this.editForm.eno,
              },
              values: {
                eno: this.editForm.eno,
                name : this.editForm.name,
                sex: this.editForm.sex,
                age : this.editForm.age,
                tel: this.editForm.tel,
                salary : this.editForm.salary,
                job : this.editForm.job,
                status: this.editForm.status,
                etime: this.editForm.time
                },
              op: this.title,
              tb: 'employee'
            }).then(res=>{
              this.editFormVisible = false
              let nindex = this.startIndex + this.currentIndex 
              if(res.code==0){
                this.$message.success(res.message)
                if(this.title == '编辑'){
                  this.totalData[nindex] = {...this.editForm}
                }else{
                  this.editForm.eno = res.eno 
                  this.totalData.unshift({...this.editForm})
                  this.pageparm.total += 1
                }
                  this.setPageData(this.pageparm)
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
              eno: row.eno
            },
            tb: 'employee'

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