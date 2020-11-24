/**
* 图表界面
*/ 
<template>
  <!-- 组件主盒子 -->
  <div class="stbox">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>员工业绩</el-breadcrumb-item>
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
          <div class="cavasbox" ref="totalchart"></div>
        </div>
      </el-col>
    </el-row>
    <!-- 统计图 -->
    <div>
      <el-row :gutter="23">
        <el-col :span="24" class="text-c">
          <div class="paybox">
            <div class="cavasbox" ref="yearspan"></div>
          </div>
        </el-col>
      </el-row>
    </div>
  </div>
</template>
<script type="text/ecmascript-6">
import Chart from 'echarts'
import {getTotalEmpstat, getYearStat} from '@/api/dataMG' 
import {formatEmpYearSpan} from '@/util/util'

export default {
  name: "Performance",
  data() {
    return {

      s: 0,
      loading: null,
      year: null,

      YEARSPANoption : {
          title: {
              text: '年度员工送水量',
              subtext: '2020年',
          },

          tooltip: {
              trigger: 'axis',
              axisPointer: {
                  type: 'cross',
                  label: {
                      backgroundColor: '#6a7985'
                  }
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
          grid: {
      
          left: '4%',
          right: '4%',
          bottom: '0',
          containLabel: true
          },
          xAxis: [
              {
                  type: 'category',
                  boundaryGap: false,
                  data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
              }
          ],
          yAxis: [
              {
                type: 'value'
              }
          ],
          series: []
      },


      //  员工总业绩
      TOTALoption: {
          title: {
              text: '员工总送水量'

          },
        tooltip: {
          trigger: 'axis',
          formatter: "{a} <br/>{b} : {c}"
        },

        toolbox: {
            feature: {
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },

        grid: {
        left: '4%',
        right: '4%',
        bottom: '3%',
        containLabel: true
        },
        xAxis: {
          type: 'category',
          data: [],
          axisLine: {
            lineStyle: {
              color: "#999999",
              width: 1
            }
          },
          axisLabel: {
            // margin: 14,
            // height: 70,
            // interval: 0,
            textStyle: {
              fontSize: 10,
              color: "#999999"
            }
          }
        },
        yAxis: {
          type: 'value',
          axisLine: {
            lineStyle: {
              color: "#999999",
              width: 1
            }
          },
          axisLabel: {
            margin: 14,
            textStyle: {
              fontSize: 10,
              color: "#999999"
            }
          }
        },
        series: [{
          name: '员工总送水量',
          type: 'bar',
          barGap: 0,
          data: [],
          barWidth: '20%',
          itemStyle: {
            normal: {
              color: new Chart.graphic.LinearGradient(
                0, 0, 0, 1,
                [
                  { offset: 0, color: '#83bff6' },
                  { offset: 0.5, color: '#188df0' },
                  { offset: 1, color: '#188df0' }
                ]
              )
            },
            emphasis: {
              color: new Chart.graphic.LinearGradient(
                0, 0, 0, 1,
                [
                  { offset: 0, color: '#2378f7' },
                  { offset: 0.7, color: '#2378f7' },
                  { offset: 1, color: '#83bff6' }
                ]
              )
            }
          }
        }]
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
        this.getYearSpan(year)
        
      }else{

        this.$message.warning('请先选择一个年份哦')

      }

      },

    getdata: function(){
      this.getTotal()
      this.getYearSpan((new Date()).getFullYear())
    },

    getYearSpan: function(year){
      getYearStat(year, '/getData/getempyear').then(res=>{
        if(res.code==0){
          this.YEARSPANoption.series = formatEmpYearSpan(res.data, res.emps)
          this.YEARSPANoption.title.subtext = `${year}年`
          this.chart = Chart.init(this.$refs.yearspan)
          this.chart.setOption(this.YEARSPANoption)
        }else{
          this.$message.error(`获取失败: ${res.code}`)

        }


      })

    },

    // 获取员工总的业绩信息
    getTotal: function(){
      getTotalEmpstat().then((res)=>{
        if(res.code==0){
          console.log(res)
          this.TOTALoption.xAxis.data = res.xdata
          this.TOTALoption.series[0].data = res.ydata
          this.chart = Chart.init(this.$refs.totalchart)
          this.chart.setOption(this.TOTALoption)
        }else{
          this.$message.error(`获取失败: ${res.code}`)
        }

      })
    },


  }
}
</script>
<style>
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
  height: 30vh;
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
  height: 32vh;
}
</style>