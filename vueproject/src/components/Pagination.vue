/**
* 分页组件
*/ 
<template>
  <el-pagination class="page-box" @size-change="handleSizeChange($event)" @current-change="handleCurrentChange" background :current-page.sync="pageparm.currentPage" :page-sizes.sync="pageparm.pageSizes" :page-size.sync="pageparm.pageSize" layout="total, sizes, prev, pager, next, jumper" :total.sync="childMsg.total">
  </el-pagination>
</template>
<script>
export default {
  name: 'Pagination',
  props: ['childMsg'],
  data() {
    return {
      pageparm: {
        currentPage: this.childMsg.currentPage,
        pageSize: this.childMsg.pageSize,
        total: this.childMsg.total,
        prePage: -1,
        pageSizes: this.childMsg.pageSizes
      }
    }
  },
  created: function(){

  },
  methods: {
    handleSizeChange(val) {
      this.pageparm.prePage = -1 ;
      this.pageparm.pageSize = val ;
      this.pageparm.currentPage = 1
      this.pageparm.total = this.childMsg.total ;
      this.$emit('callFather', this.pageparm) ;
    },

    handleCurrentChange(cSize) {
      this.pageparm.prePage = this.pageparm.currentPage ;
      this.pageparm.currentPage = cSize ;
      this.pageparm.total = this.childMsg.total ;
      this.$emit('callFather', this.pageparm) ;
    }
  }
}
</script>

<style>
.page-box {
  margin: 10px auto;
}
</style>
