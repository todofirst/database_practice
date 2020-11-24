/**
* 图表界面
*/ 
<template>
  <!-- 组件主盒子 -->
  <div class="stbox">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>收支统计</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 搜索，切换 -->
    <el-row :gutter="23" style="margin-top:6px">
      <el-col :span="18">
        <div class="stbgc">
          <el-row :gutter="23">
            <el-col :span="6">
            <el-date-picker
              v-model="year"
              type="year"
              placeholder="选择显示的年份">
            </el-date-picker>
            </el-col>
            <el-col :span="2" class="stsearch">
              <el-button size="small" type="primary" @click="getYearData">搜索</el-button>
            </el-col>
            <el-col :span="2" class="stsearch">
              <el-button size="small" type="primary" @click="getdata();year=''">刷新数据</el-button>
            </el-col>
          </el-row>
        </div>
      </el-col>
    </el-row>




    <!-- 统计图 -->
    <el-row :gutter="23">
      <el-col :span="24" class="text-c">
        <div class="st-gbox">
        <div class="cavasbox" ref="yearspan"></div>

        </div>
      </el-col>
    </el-row>
    <!-- 统计图 -->

    <el-row :gutter="23">
      <el-col :span="24" class="text-c">
        <div class="paybox">
          <div class="cavasbox" ref="totalchart"></div>
        </div>
      </el-col>
    </el-row>
   
  </div>
</template>
<script type="text/ecmascript-6">
import Chart from 'echarts'
import {getTotalEmpstat, getYearStat} from '@/api/dataMG' 
import {getOutIn} from '@/api/axioFun'
import {formatEmpYearSpan,} from '@/util/util'

export default {
  name: "Outinput",
  data() {
    return {

      year: null,

      YEARSPANoption : {
          title: {
              text: '年度收支差',
              subtext: '2020年',
          },
        tooltip: {
            trigger: 'axis',
            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        
            toolbox: {
                feature: {
                    dataView: {show: true, readOnly: false},
                    magicType: {show: true, type: ['line', 'bar']},
                    restore: {show: true},
                    saveAsImage: {show: true}
                }
            },
        legend: {
            data: ['收支差', '订货支出', '订单收入']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true,
            height: "86%"
        },
        xAxis: [
            {
                type: 'value'
            }
        ],
        yAxis: [
            {
                type: 'category',
                axisTick: {
                    show: false
                },
                data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
            }
        ],
        series: [
            {
                name: '收支差',
                type: 'bar',
                barWidth : 10,
                label: {
                    show: true,
                    position: 'inside'
                },
                data: []
            },
            {
                name: '订单收入',
                type: 'bar',
                barWidth : 10,
                stack: '总量',
                label: {
                    show: true
                },
                data: []
            },
            {
                name: '订货支出',
                type: 'bar',
                barWidth : 10,
                stack: '总量',
                label: {
                    show: true,
                    position: 'left'
                },
                data: []
            }
        ]

      },


      //  员工总业绩
      TOTALoption: {

      },

    }
  },
  // 导入组件
  components: {
    // 点聚合组件
  },

  created() { },

  mounted() {
    this.getdata();
  },
  // 里面的函数只有调用才会执行
  methods: {


    getYearData: function(){

      if(this.year != null){
        let year = new Date(this.year).getFullYear()
        getOutIn(year)
        .then((list)=>{
          this.YEARSPANoption.series[0].data = list[0]
          this.YEARSPANoption.series[1].data = list[1]
          this.YEARSPANoption.series[2].data = list[2]
          this.YEARSPANoption.title.subtext = `${year}年`
          this.chart = Chart.init(this.$refs.yearspan)
          this.chart.setOption(this.YEARSPANoption)
        })
        .catch(err=>{
          this.$message.error('网络有点问题哦')
        })
        
      }else{

        this.$message.warning('请先选择一个年份哦')

      }

      },

    getdata: function(){
      let year = (new Date()).getFullYear()
      getOutIn(year)
      .then((list)=>{
        this.YEARSPANoption.series[0].data = list[0]
        this.YEARSPANoption.series[1].data = list[1]
        this.YEARSPANoption.series[2].data = list[2]
        this.YEARSPANoption.title.subtext = `${year}年`
        this.chart = Chart.init(this.$refs.yearspan)
        this.chart.setOption(this.YEARSPANoption)
      })
      .catch(err=>{
        this.$message.error('网络有点问题哦')
      })


    },




  }
}
</script>
<style scoped>
.stbox {
  width: 100%;
  height: 100%;
  box-sizing: border-box;
}
.stbgc {
  background-color: #fff;
  height: 60px;
  line-height: 60px;
  border-radius: 5px;
  padding: 0px 16px;
}
.stsearch {
  text-align: center;
}
.text-c {
  text-align: center;
}
.st-gbox {
  background-color: #fff;
  border-radius: 5px;
  height: 76vh;
  box-sizing: border-box;
  padding: 10px;
}
.cavasbox {
  box-sizing: border-box;
  width: 100%;
  height: 100%;
}
.paybox {
  width: 100%;
  background-color: #fff;
  box-sizing: border-box;
  border-radius: 5px;
  margin-top: 20px;
  height: 20vh;
}
</style>