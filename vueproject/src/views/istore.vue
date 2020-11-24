



<template>
  <div>
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>入库信息管理</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索筛选 -->
    <el-row class="user-search">
      <el-col :span="2">
        <el-button size="small" type="primary" icon="el-icon-search" @click="handleSingleSearch">单项搜索</el-button>
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
      <!-- <el-col :span="2">
        <el-popover
          placement="top-start"
          width="200"
          trigger="hover"
          content="导出为Excel文件">
          <el-button size="small" v-if="excelConfig.list!=null" slot="reference" type="primary" icon="el-icon-printer" @click="toOutputExcel">导出为Excel</el-button>
        </el-popover>
      </el-col> -->
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
    <el-table-column type="expand">
      <template slot-scope="scope">
        <el-table max-height="500" size="small" :data="scope.row.details" highlight-current-row 
        border 
        stripe style="width: 100%;"  
        @sort-change='tableSortChange'
        ref="table"
        >

          <el-table-column align="center" label="序号" type="index" width="60"
          >
            <template slot-scope="scope">
              {{scope.$index+1+startIndex}}
            </template>
          </el-table-column>
          <el-table-column  prop="wname" label="商品名" width="300">
          </el-table-column>
          <el-table-column  prop="wno" label="商品编号" width="300">
          </el-table-column>
          <el-table-column  prop="num" label="总数" width="300">
          </el-table-column>
          <el-table-column  prop="price" label="合计" width="300">
          </el-table-column>

          <el-table-column align="center" fixed="left" label="操作" width="150">
            <template slot-scope="scope">
              <el-button size="mini" @click="handleEditDetail(scope.$index, scope.row)">编辑</el-button>
              <el-button size="mini" type="danger" @click="handleDelDetail(scope.$index, scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>

      </template>
    </el-table-column>
      <el-table-column align="center" label="序号" type="index" width="60"
      >
        <template slot-scope="scope">
          {{scope.$index+1+startIndex}}
        </template>
      </el-table-column>
      <el-table-column  prop="ono" label="订单编号" width="300">
      </el-table-column>
      <el-table-column  prop="sno" label="供货商编号" width="300">
      </el-table-column>
      <el-table-column  prop="sname" label="供货商名称" width="300">
      </el-table-column>
      <el-table-column  prop="eno" label="负责人工号" width="300">
      </el-table-column>
      <el-table-column  prop="ename" label="负责人" width="300">
      </el-table-column>
      <el-table-column  sortable="custom" prop="time" label="注册时间" width="300">
        <template slot-scope="scope">
          <div>{{scope.row.time|timestampToTime}}</div>
        </template>
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
      <el-table-column align="center" fixed="right" label="操作" min-width="250">
        <template slot-scope="scope">
          <el-button size="mini" @click="handleEditDetail(scope.$index, scope.row.ono)">添加记录</el-button>
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
        <el-form-item label="订单编号" prop="sno" v-if="this.title=='添加'?false:true">
          <el-input size="small" :disabled="title=='编辑'?true:false" v-model="editForm.ono" auto-complete="off" placeholder="请输入客户编号"></el-input>
        </el-form-item>
        <el-form-item label="供货商编号" prop="name">
          <el-input size="small" :disabled="true" clearable placeholder="请输入供货商编号"  v-model="editForm.sno" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="供货商" prop="address" >
          <el-autocomplete
          
            class="inline-input"
            v-model="editForm.sname"
            :fetch-suggestions="supplierQuery"
            placeholder="请输入供货商"
            @select="handleSelectSupplier"
            clearable
          ></el-autocomplete>
        </el-form-item>
        <el-form-item label="负责人工号" prop="tel">
          <el-input clearable size="small" :disabled="true" v-model="editForm.eno" auto-complete="off" placeholder="请输入负责人工号"></el-input>
        </el-form-item>  
        <el-form-item label="负责人" prop="tel">
          <el-autocomplete
            class="inline-input"
            v-model="editForm.ename"
            :fetch-suggestions="employeeQuery"
            placeholder="请输入负责人姓名"
            @select="handleSelectEmployee"
            clearable
          ></el-autocomplete>        
        </el-form-item>
        <el-form-item label="完成时间" prop="time">
          <el-date-picker
            clearable
            v-model="editForm.time"
            type="datetime"
            placeholder="请选择日期时间">
          </el-date-picker>
        </el-form-item>
        <el-form-item label="订单状态" prop="status">
          <el-select v-model="editForm.status" placeholder="请选择任务状态" clearable>
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
        <el-button size="small" type="primary" :loading="loading" class="title" @click="submitForm('editForm')">保存</el-button>
      </div>
    </el-dialog>
    <!-- 记录编辑界面 -->
    <el-dialog :title="title" :visible.sync="detailEditFormVisible" @closed="afterClose" width="30%" >
      <el-form label-width="120px" :model="detailEditForm" :rules="title=='添加'&&flush?detailEditRules:{}" ref="detailEditForm">
        <el-form-item label="所属订单" prop="ono" >
          <el-input size="small" clearable :disabled="true" v-model="detailEditForm.ono" auto-complete="off" placeholder="请输入所属订单编号"></el-input>
        </el-form-item>
        <el-form-item label="关联商品编号" prop="wno">
          <el-input clearable placeholder="请输入关联商品编号" size="small" :disabled="true"  v-model="detailEditForm.wno" auto-complete="off"></el-input>
        </el-form-item>
        <el-form-item label="关联商品" prop="wname" >
          <el-autocomplete
            
            class="inline-input"
            v-model="detailEditForm.wname"
            :fetch-suggestions="waterQuery"
            placeholder="请输入内容"
            @select="handleSelectWater"
            clearable
          ></el-autocomplete>
        </el-form-item>
        <el-form-item label="数量" prop="num">
          <el-input size="small" clearable  v-model="detailEditForm.num" auto-complete="off" placeholder="请输入数量"></el-input>
        </el-form-item>  
        <el-form-item label="总价" prop="price">
          <el-input size="small" clearable v-model="detailEditForm.price" auto-complete="off" placeholder="请输入总价"></el-input>
        </el-form-item>  
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button size="small" @click="closeDialog">取消</el-button>
        <el-button size="small" type="primary" :loading="loading" class="title" @click="submitDetailForm('detailEditForm')">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import Pagination from '@/components/Pagination' ;
import  ExportExcel from '@/components/ExportExcel'
import {getAllData, delIt, updateIt} from '@/api/dataMG' ;
import {timestampToTime} from '@/util/filters' ;
import {objToArr,pnV,pfV} from '@/util/util' ;
export default {
  name: 'iorders',

  components: {Pagination, ExportExcel},

  data() {
    return {  
// -----------------受限制部分
      // 编辑前的数据-----这里因为是主键，在编辑后可能会改变的，所以记录下来，可以在修改数据后再在数据库中找到原来的数据
      oldEditDetailData: {
        wno:0
      },
// -----------------
// -----------------可动态修改部分
      // 编辑页面的数据设置还有添加页面的一些默认的选项
      editForm: {
        status: '0'
      },

      // 订单细节存储对象
      detailEditForm:{

      },

      employees: [],
      waters: [],
      suppliers: [],

      // 记录验证规则
      detailEditRules:{
        'wname':[
          {required: true, message: '不能为空', trigger: 'blur'}
          ],
        'num':[
          {validator:pnV, required: true, message: '仅能为正整数', trigger: 'blur'},
          ],
        'price':[
          {validator:pfV, required: true, message: '仅能为正小数', trigger: 'blur'},
          ],
      },

      // 添加列表规则
      editRules:{
        'sno':[
          {required: true, message: '不能为空', trigger: 'blur'}
          ],
        'eno':[
          {required: true, message: '不能为空', trigger: 'blur'}
          ],
        'status':{required: true, message: '不能为空', trigger: 'blur'}
      },
      // 导出为Excel的参数
      excelConfig:{
        list:[],
        tHeader:['订单编号','供货商编号','供货商名称','负责人工号','负责人姓名','订单状态'],
        tValue:['ono', 'sno', 'sname', 'eno', 'ename','status'],
        filename: '导出数据'
      },
      
      // 单项搜索关键字集合      // canBlur 开启模糊匹配
      ssKeys: [
        {key: 'sno', label: '供货商编号', canBlur: false},
        {key: 'ono', label: '订单编号', canBlur: false},
        {key: 'eno', label: '负责人工号', canBlur: false},
        {key: 'sname', label: '供货商名称', canBlur: true},
        {key: 'ename', label: '负责人姓名', canBlur: true},
      ],

      // 单项搜索存储对象
      singleCon: {
        sskey: 'ename',
        value: '',
        // 远程搜索开启
        had: false
      },

// -----------------可动态修改部分


// -----------------开关集合

      // Excel显示
      outExcel: false,

      // 全选标志
      selectAll: false,
      singleSearch: false, //单项搜索显示
      loading: false, //列表显示加载
      singleLoading: false, //单项搜索按钮加载显示
      editFormVisible: false, //控制编辑页面显示与隐藏
      detailEditFormVisible: false, //控制记录编辑页面的显示和隐藏
// -----------------


      // 选择对象---用于单选行的时候，在已选中的页面显示选中项
      selectedObj : {},

      flush: false,
      //当前被选中的序号-------startIndex+currentIndex-----用于序号的正确显示
      currentIndex: 0,

      // 编辑状态下记录所属订单的下标
      nowIndex: 0,

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
      // 刷新后重置
      this.totalData = []
      // 获取员工概要
      // 获取仓库管理
      getAllData('/getData/employees',{job:'仓库管理'}).then(res=>{

          if(res.code==0){
            this.employees = res.data
            this.employees.forEach(item=>{
              item.value = item.name
            })
          }else{
            this.$message.error('获取数据失败')
          }
      })
      // 获取供货商概要
      getAllData('/getData/listsuppliers',{job:'仓库管理'}).then(res=>{

          if(res.code==0){
            this.suppliers = res.data
            this.suppliers.forEach(item=>{
              item.value = item.name
            })
          }else{
            this.$message.error('获取数据失败')
          }
      })
      // 获取矿泉水
      getAllData('/getData/waters').then(res=>{
          if(res.code==0){
            this.waters = res.data
            this.waters.forEach(item=>{
              item.value = item.wname
            })
          }else{
            this.$message.error('获取数据失败')
          }
      })
      // 获取供货商
      getAllData("/getData/iorders").then(res=>{
        setTimeout(()=>{
          if(res.code==0){
            this.loading = false
            this.totalData.push(...res.data)
            this.pageparm.currentPage = this.initData.currentPage
            this.pageparm.pageSize = this.initData.pageSize,
            this.pageparm.pageSizes = this.initData.pageSizes
            this.pageparm.total = res.count
            this.setPageData(this.pageparm)
            console.log(this.totalData)
            sessionStorage.setItem('iorders', JSON.stringify({
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

    // 矿泉水查询建议返回
    waterQuery: function(queryString, cb){
        let water = this.waters;
        let results = queryString ? water.filter(this.createFilter(queryString,'wname')) : water;
        // 调用 callback 返回建议列表的数据
        cb(results);
    },

    // 员工查询建议返回
    employeeQuery: function(queryString, cb){
        let employees = this.employees;
        let results = queryString ? employees.filter(this.createFilter(queryString,'name')) : employees;
        // 调用 callback 返回建议列表的数据
        cb(results);
    },
    // 订单查询建议返回
    supplierQuery: function(queryString, cb){
        console.log(queryString)
        let suppliers = this.suppliers;
        let results = queryString ? suppliers.filter(this.createFilter(queryString,'name')) : suppliers;
        // 调用 callback 返回建议列表的数据
        cb(results);
    },

    handleSelectEmployee: function(employee){
      this.editForm.eno = employee.eno ;
    },

    // 订单选择处理
    handleSelectWater: function(water){
      this.detailEditForm.wno = water.wno ;
    },

    // 订单选择处理
    handleSelectSupplier: function(supplier){
      this.editForm.sno = supplier.sno ;
    },

    // 创建查询过滤器
    createFilter(queryString,key) {
      return (item) => {
        return (item[key].toLowerCase().indexOf(queryString.toLowerCase()) === 0);
      };
    },

    // 导出按钮
    toOutputExcel: function(){
      this.outExcel = true ;
      let totalData = [] ;

      if(this.selectAll){
        // 可修改：全部的任务
        totalData = JSON.parse(sessionStorage.getItem('iorders')).totalData ;
      }else{
        let keys = Object.keys(this.selectedObj)
        if(keys.length==0){
          totalData = JSON.parse(sessionStorage.getItem('iorders')).totalData ;
        }else{
        // 可修改：零散选择的选项并且可以导出的
        totalData = objToArr(this.selectedObj) ;
        }
      }

      this.excelConfig.list = totalData ;
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
      this.editForm = {}
      this.detailEditForm = {}
      if(this.$refs['editForm']==undefined){
        this.$refs['detailEditForm'].clearValidate()

      }else{
        this.$refs['editForm'].clearValidate()
      }
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
      let iorders = JSON.parse(sessionStorage.getItem('iorders')) ;
      let totalData = [...iorders.totalData] ;
      let pageparm = {...iorders.pageparm} ;

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

    //显示记录编辑界面
    handleEditDetail: function(index, row) {
      // 这里要么是点编辑的时候记录的下标，要么就是点击添加的时候所属订单的下标
      this.nowIndex= index
      // 通过row对象的传入判断是添加还是编辑
      if(typeof(row)=='number'){
        this.title = '添加'
        this.detailEditForm.ono = row
      }else{
        this.title = '编辑'

        // 可修改：这里是设置之前的数据，保存的旧数据是用来做字段匹配的
        this.oldEditDetailData.wno = row.wno
        let oldEditData = {...row}
        this.detailEditForm = oldEditData
      }

        this.detailEditFormVisible = true
      
    },

    //显示编辑界面
    handleEdit: function(index, row) {
      let uoa = Object.keys(row)
      // 通过row对象的传入判断是添加还是编辑
      if(uoa.length==0){
        this.title = '添加'

      }else{
        this.title = '编辑'
        row.time = new Date(parseInt(row.time))
        // 可修改：这里是设置之前的数据，保存的旧数据是用来做字段匹配的
        let oldEditData = {...row}
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
        let iorders = JSON.parse(sessionStorage.getItem('iorders')) ;
        totalData = iorders.totalData ;
        pageparm = iorders.pageparm ;
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

      console.log(total)

/**
 *                             _ooOoo_
 *                            o8888888o
 *                            88" . "88
 *                            (| -_- |)
 *                            O\  =  /O
 *                         ____/`---'\____
 *                       .'  \\|     |//  `.
 *                      /  \\|||  :  |||//  \
 *                     /  _||||| -:- |||||-  \
 *                     |   | \\\  -  /// |   |
 *                     | \_|  ''\---/''  |   |
 *                     \  .-\__  `-`  ___/-. /
 *                   ___`. .'  /--.--\  `. . __
 *                ."" '<  `.___\_<|>_/___.'  >'"".
 *               | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *               \  \ `-.   \_ __\ /__ _/   .-` /  /
 *          ======`-.____`-.___\_____/___.-`____.-'======
 *                             `=---='
 *          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *                     佛祖保佑        永无BUG
 *            佛曰:
 *                   写字楼里写字间，写字间里程序员；
 *                   程序人员写程序，又拿程序换酒钱。
 *                   酒醒只在网上坐，酒醉还来网下眠；
 *                   酒醉酒醒日复日，网上网下年复年。
 *                   但愿老死电脑间，不愿鞠躬老板前；
 *                   奔驰宝马贵者趣，公交自行程序员。
 *                   别人笑我忒疯癫，我笑自己命太贱；
 *                   不见满街漂亮妹，哪个归得程序员？
*/

console.log(`-`)


      this.pageparm.total = total.length ;
      this.totalData = [...total] ;
      this.setPageData(this.pageparm) ;
      this.loading = false ;
      this.singleSearch = false ;

    },

    submitDetailForm(formname){
      this.flush = true
      this.$nextTick(()=>{
      this.$refs[formname].validate(valid => {
        console.log(this.detailEditForm)
        if (valid) {
          let url = this.title == '编辑'? '/getData/updateit':'/getData/insiorderdetail'
          updateIt(url, {
            where:{
              ono: this.detailEditForm.ono,
              wno: this.oldEditDetailData.wno
            },
            values: {
              ono: this.detailEditForm.ono,
              price: this.detailEditForm.price,
              num: this.detailEditForm.num,
              wno: this.detailEditForm.wno
            },
            op: this.title,
            tb: 'iorderdetail'
          }).then(res=>{
            this.detailEditFormVisible = false
            if(res.code==0){
              this.$message.success(res.message)
              if(this.title == '编辑'){
                this.totalData.forEach((data,index)=>{
                  if(data.ono == this.detailEditForm.ono){
                    // 这里改变
                    this.totalData[index-this.startIndex].details = [...this.totalData[index-this.startIndex].details]
                    // this.$forceUpdate();
                    this.totalData[index].details[this.nowIndex] = {...this.detailEditForm}
  
                  }
                })

              }else{
                this.totalData[this.nowIndex].details.unshift({...this.detailEditForm})
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

    // 可修改：页面编辑和添加的方法
    submitForm(formname) {
      this.flush = true
      this.$nextTick(()=>{
      this.$refs[formname].validate(valid => {
        if (valid) {
          console.log(this.editForm)
          this.editForm.time = this.editForm.time.getTime()
          let url = this.title == '编辑'? '/getData/updateit':'/getData/insiorder'
          updateIt(url, {
            where:{
              ono: this.editForm.ono 
            },
            values: {
              ono: this.editForm.ono,
              sno : this.editForm.sno,
              eno: this.editForm.eno,
              time: this.editForm.time,
              status: this.editForm.status
            },
            op: this.title,
            tb: 'iorder'
          }).then(res=>{
            this.editFormVisible = false
            let nindex = this.startIndex + this.currentIndex 
            if(res.code==0){
              this.$message.success(res.message)
              if(this.title == '编辑'){
                this.totalData[nindex] = {...this.editForm}
              }else{
                this.editForm.ono = res.ono 
                this.pageparm.total += 1 ;
                this.totalData.unshift({...this.editForm})
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
    handleDelDetail(index, row) {
      this.$confirm('确定要删除吗?', '信息', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      })
        .then(() => {
          delIt('/getData/delit',{
            // 可修改：具体匹配删除的关键字还有表名
            where: {
              ono: row.ono,
              wno: row.wno
            },
            tb: 'iorderdetail'

          }).then(res=>{
            if(res.code==0){
                this.totalData.forEach((data,iindex)=>{
                  if(data.ono == row.ono){

                    this.totalData[iindex].details.splice(index,1) ;
  
                  }
                })
            }else{
              this.$message.error('该商品已在订单上')
            }
          })
          .catch(err=>{
            this.$message.error('发生错误')
          })
          
        })
        .catch(() => {

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
              ono: row.ono,
            },
            tb: 'iorder'

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
      this.detailEditFormVisible = false
    },
    // 关闭单项搜索对话框
    closeSingleSearch: function(){
      this.singleSearch = false
    },

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