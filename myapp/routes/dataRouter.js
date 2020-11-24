import express from 'express' ;
const router = express.Router() ;

import {query, mysql} from '../api/dbBase' ;

import {
GET_ALL_TASKS,GET_ALL_NOWEMPLOYEES,GET_LIST_WATERS,
GET_ALL_SUPPLIERS,GET_ALL_ALLEMYLOYEES,GET_ALL_CUSTOMER,
GET_ALL_CORDERS,GET_LIST_COMBOS,GET_ALL_COMBOS,
GET_ALL_WATERS,GET_ALL_IORDERS,GET_LIST_EMPLOYEES,
GET_LIST_SUPPLIERS,GET_ALL_IORDERDETAILS,GET_NOW_ORDER,
GET_EMP_STAT
} from '../models/dbModels' ;



import ensureLogin from '../api/ensurelogin' ;

// 获取所有的订单
router.get('/iorders', function(req, res, next){



  ensureLogin(req)
  .then(()=>{

  let GET_COUNT =  'SELECT COUNT(*) as count FROM iorder;'

  query(GET_COUNT + GET_ALL_IORDERS+GET_ALL_IORDERDETAILS).then(function(results){
  
    let count = results[0][0].count ;
    let data = results[1] ;
    let details = results[2] ;

    details.forEach((detail)=>{

      data.forEach(item=>{
        item.details = item.details==undefined? []:item.details
        if(item.ono == detail.ono){
          item.details.push({...detail})
        }
      })

    })

    res.json({
      code: 0,
      message: '没毛病',
      count,
      data
    })

  })
  })
  .catch((err)=>{
    res.json(err)
  })

})

// 获取所有的套餐
router.get('/allwaters', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM water;'
    query(GET_COUNT+GET_ALL_WATERS).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 获取所有的套餐
router.get('/combos', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM combo;'
    query(GET_COUNT+GET_ALL_COMBOS).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})


// 获取所有的会员
router.get('/members', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM customer;'
    query(GET_COUNT+GET_ALL_CUSTOMER).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 获取所有的客户订单
router.get('/corders', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM corder;'
    query(GET_COUNT+GET_ALL_CORDERS).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 获取所有的会员
router.get('/members', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM customer;'
    query(GET_COUNT+GET_ALL_CUSTOMER).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 获取所有员工列表
router.get('/allemployees', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM employee;'
    query(GET_COUNT+GET_ALL_ALLEMYLOYEES).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 获取所有的供货商
router.get('/suppliers', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM supplier;'
    query(GET_COUNT+GET_ALL_SUPPLIERS).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})


// 获取所有的任务
router.get('/tasks', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    let GET_COUNT =  'SELECT COUNT(*) as count FROM task;'
    query(GET_COUNT+GET_ALL_TASKS).then(function(results){
    
      let count = results[0][0].count ;
      let data = results[1] ;
  
      res.json({
        code: 0,
        message: '没毛病',
        count,
        data
      })
  
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})


// 获取简易套餐列表
router.get('/listcombos', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    query(GET_LIST_COMBOS)
    .then(function(results){

      let data = results ;
  
      res.json({
        code: 0,
        message: '没毛病',
        data
      })
  
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})


// 获取全部员工的列表
router.get('/employees', function(req, res, next){
  let job = req.query.job==undefined?'配送员':req.query.job 
  let SQL = mysql.format(GET_ALL_NOWEMPLOYEES,job)
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(results){

      let data = results ;
  
      res.json({
        code: 0,
        message: '没毛病',
        data
      })
  
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 供货商列表概要
router.get('/listsuppliers', function(req, res, next){
  ensureLogin(req)
  .then(()=>{
    query(GET_LIST_SUPPLIERS)
    .then(function(results){

      let data = results ;
  
      res.json({
        code: 0,
        message: '没毛病',
        data
      })
  
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 员工列表概要
router.get('/listemployees', function(req, res, next){
  ensureLogin(req)
  .then(()=>{
    query(GET_LIST_EMPLOYEES)
    .then(function(results){

      let data = results ;
  
      res.json({
        code: 0,
        message: '没毛病',
        data
      })
  
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 获取全部水的品牌
router.get('/waters', function(req, res, next){
  ensureLogin(req)
  .then(()=>{
    query(GET_LIST_WATERS)
    .then(function(results){

      let data = results ;
  
      res.json({
        code: 0,
        message: '没毛病',
        data
      })
  
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/delit', function(req, res, next){

  let parseWhere = JSON.parse(req.query.where) ;
  let where = mysql.format('?', parseWhere).split(',').join(' AND ') ;

  let DEL_TASK = `DELETE FROM ${req.query.tb} WHERE ${where}` ;

  ensureLogin(req)
  .then(()=>{
    query(DEL_TASK)
    .then(function(result){

     if(result.affectedRows != 0){
      res.json({
        code: 0,
        message: '删除成功',
      })
     }else{
      res.json({
        code: 1,
        message: '删除失败',
      })
     }
  

  
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/updateit', function(req, res, next){

  let parseWhere = JSON.parse(req.query.where) ;
  let parsevalues = JSON.parse(req.query.values) ;

  let where = mysql.format('?', parseWhere).split(',').join(' AND ') ;
  let values = mysql.format('?', parsevalues) ;
  let SQL = `UPDATE ${mysql.format('??',req.query.tb)} SET ${values} WHERE ${where}` ;
  
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      res.json({
        code: 0,
        message: `${req.query.op}成功`,
      })


    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/inscombo', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO combo VALUES
 (${parsevalues.tnum},${parsevalues.gnum},${parsevalues.price},${parsevalues.wno},'${parsevalues.wname}');`

  console.log(SQL) ;
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){

     if(result.serverStatus == 2){
      res.json({
        code: 0,
        message: `${req.query.op}成功`,
      })
     }else{
      res.json({
        code: 1,
        message: `${req.query.op}失败`,
      })
     }

    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/inscorder', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO corder VALUES
 (${parsevalues.cno},${parsevalues.time},${parsevalues.total},${parsevalues.leav},${parsevalues.gnum},${parsevalues.price},'${parsevalues.name}','${parsevalues.cflag}',null);`
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      let s = mysql.format('SELECT name FROM customer WHERE cno=?',parsevalues.cno)
      query(s+';SELECT MAX(cono) as lastid FROM corder')
      .then(function(r){
        res.json({
          code: 0,
          message: `${req.query.op}成功`,
          cname : r[0][0].name,
          cono: r[1][0].lastid
        })
      })
    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})


router.get('/insmember', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO customer VALUES
 (null,'${parsevalues.name}','${parsevalues.sex}','${parsevalues.address}','${parsevalues.tel}','${parsevalues.status}',${parsevalues.time});`
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      

      query('SELECT MAX(cno) as lastid FROM customer').then(function(r){
      res.json({
        code: 0,
        cno: r[0].lastid,
        message: `${req.query.op}成功`,
      })
      })


    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/insemployees', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO employee VALUES
 (null,'${parsevalues.name}','${parsevalues.sex}',${parsevalues.age},${parsevalues.tel},'${parsevalues.job}','${parsevalues.etime}',${parsevalues.salary},'${parsevalues.status}');`
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      

      query('SELECT MAX(eno) as lastid FROM employee').then(function(r){
      res.json({
        code: 0,
        eno: r[0].lastid,
        message: `${req.query.op}成功`,
      })
      })



    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/inswater', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO water VALUES
 (null,'${parsevalues.picture}','${parsevalues.wname}','${parsevalues.wbrand}',${parsevalues.price},${parsevalues.store},${parsevalues.sale});`
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      
      query('SELECT MAX(wno) as lastid FROM water').then(function(r){
        res.json({
          code: 0,
          wno: r[0].lastid,
          message: `${req.query.op}成功`,
        })
        })
        // res.json({
        //   code: 0,
        //   wno: 0,
        //   message: `${req.query.op}成功`,
        // })


    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/insiorder', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO iorder VALUES
 (null,${parsevalues.sno},${parsevalues.eno},'${parsevalues.status}', ${parsevalues.time});`
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      
      query('SELECT MAX(ono) as lastid FROM iorder').then(function(r){
      res.json({
        code: 0,
        ono: r[0].lastid,
        message: `${req.query.op}成功`,
      })
      })

     

    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/inssupplier', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO supplier VALUES
 (null,'${parsevalues.name}','${parsevalues.address}','${parsevalues.tel}','${parsevalues.brand}');`
  console.log(SQL)
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      
      query('SELECT MAX(sno) as lastid FROM supplier').then(function(r){
      res.json({
        code: 0,
        sno: r[0].lastid,
        message: `${req.query.op}成功`,
      })
      })

    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

router.get('/insiorderdetail', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO iorderdetail VALUES
 (${parsevalues.num},${parsevalues.price},${parsevalues.ono},${parsevalues.wno});`

  console.log(SQL) ;
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){

      res.json({
        code: 0,
        message: `${req.query.op}成功`,
      })
     

    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '已经存在该商品项了'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})


router.get('/instasks', function(req, res, next){

  let parsevalues = JSON.parse(req.query.values) ;

 let SQL = `INSERT INTO task VALUES
 ('${parsevalues.sex}','${parsevalues.cname}',${parsevalues.time},${parsevalues.num},'${parsevalues.ctel}',${parsevalues.eno},${parsevalues.wno},${parsevalues.cno},'${parsevalues.address}','${parsevalues.status}',${parsevalues.cono});`

  console.log(SQL) ;
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){

      res.json({
        code: 0,
        message: `${req.query.op}成功`,
      })
     

    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '请检查字段是否符合要求'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 是否有订单
router.get('/hadcono', function(req, res, next){

  let cono = req.query.cono

  let SQL = mysql.format(GET_NOW_ORDER, cono) ;
  
  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){

      console.log(result)
      if(result.length == 0){
        res.json({
          code: 0,
          count: 0,
          data: []
        })
      }else{

        let cflag = result[0].cflag
        let name = result[0].wname
        // 套餐
        if(cflag == "1"){
          query(`SELECT * FROM combo WHERE wname='${name}'`).then(function(r){
            console.log(r[0].wno )
            let wno = r[0].wno 
            result[0].wno = wno
            console.log(result[0])
            res.json({
              code: 0,
              count: result.length,
              data: result[0]
            })

          })
        }else{
          query(`SELECT * FROM water WHERE wname='${name}'`).then(function(r){
            let wno = r[0].wno 
            result[0].wno = wno
            res.json({
              code: 0,
              count: result.length,
              data: result[0]
            })
          })
        }



      }

    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 验证是否有余量
router.get('/hadstore', function(req, res, next){

  let num = req.query.num
  let cono = req.query.cono

  let SQL = mysql.format(`SELECT leav FROM corder WHERE cono=?`,cono)

  console.log(SQL)

  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      res.json({
        code: 0,
        had: result[0].leav>=num? true:false 
      })
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})


// 验证是否存在该段数据
router.get('/ishad', function(req, res, next){

  let parseWhere = JSON.parse(req.query.where) ;

  let where = mysql.format('?', parseWhere).split(',').join(' AND ') ;
  let SQL = `SELECT COUNT(*) as count FROM ${mysql.format('??',req.query.tb)} WHERE ${where}` ;
  

  ensureLogin(req)
  .then(()=>{
    query(SQL)
    .then(function(result){
      res.json({
        code: 0,
        count: result[0].count 
      })
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 员工总业绩
// 获取简易套餐列表
router.get('/getempstattotal', function(req, res, next){

  ensureLogin(req)
  .then(()=>{
    query(GET_EMP_STAT)
    .then(function(results){

      let xdata = results.map((item)=>{
        return item.name
      })

      let ydata = results.map((item)=>{
        return item.total
      })

      // let data = results ;
  
      res.json({
        code: 0,
        message: '没毛病',
        xdata,
        ydata
      })
  
    })
    .catch(err=>{
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })

})

// 获取选择年份下的1到12月的员工的业绩
router.get('/getempyear', function(req, res, next){

  let year = req.query.year

  ensureLogin(req)
  .then(()=>{
    query(`CALL staff_span_year(${year});SELECT eno, name FROM employee WHERE job='配送员' AND status <> '0'`)
    .then(function(results){
      let data = []
      let emps = []
      for(let i=0; i< results.length-2; i++){
        data.push(results[i])
      }
      emps = results[results.length-1]

      res.json({
        code: 0,
        data: data,
        emps: emps
      })
  
    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })


})

// 进货支出
router.get('/output', function(req, res, next){


  let year = req.query.year

  ensureLogin(req)
  .then(()=>{
    query(`CALL output_span_year(${year})`)
    .then(function(results){


      res.json({
        code: 0,
        data: results.slice(0,12)
        })
  
    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })



})

// 订单收入
router.get('/income', function(req, res, next){
  
  let year = req.query.year

  ensureLogin(req)
  .then(()=>{
    query(`CALL income_span_year(${year})`)
    .then(function(results){


      res.json({
        code: 0,
        data: results.slice(0,12)
        })
  
    })
    .catch(err=>{
      console.log(err)
      res.json({
        code:-1,
        message: '错误'
      })
    })
  })

  .catch((err)=>{
    res.json(err)
  })


})









module.exports = router ;