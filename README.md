





# 送水管理系统



[TOC]



#### 简述

此为数据库实践课程的课程设计，代码比较简单，由于学业繁忙，写得比较粗糙，代码冗余量可能比较大， 细节没有处理好，有时间再处理，在完成该课程时是现学先用的，对`vue`等都是临时学的，可能代码对此理解不清，望指出，同时本项目前端是参考了https://github.com/nmgwap/vue-ManagementPlatform.git，如果有兴趣的同学可以继续往下看。

------

#### 目录简述

- 前端：`vueproject`
- 后端：`myapp`
- SQL资源：`SQL`
  - 数据表创建：`create_tatble.sql`
  - 数据插入：`insert_data.sql`
  - 触发器创建：`triggers.sql`
  - 存储过程创建：`procedures.sql`
- 图片资源：`pictures`

#### 技术栈

1. 前端
   - `vue` + `vuex` + `vue-router` + `element-ui`  + `axios`+`echarts`
2. 后端
   - 框架：`express`
   - 身份验证：`Passport.js`
   - 状态管理：`cookie` + `session`
   - 包管理：`npm`
   - 数据库：`mysql`

#### 使用

- 数据装载

  - 这里推荐使用`navicat`。数据装载请按照如下流程，因为库存等的更新是依赖触发器的

    1. 导入``create.sql`创建表并执行

    2. 导入`triggers.sql`并执行
    3. 导入`procedures.sql`并执行

- 安装和启动

``` bash
# myapp和vueproject目录下分别使用如下命令安装依赖
npm install
```

```bash
# myapp和vueproject目录下分别使用如下命令启动
npm start
```



#### 配置修改

推荐使用`vscode`

前端：`127.0.0.1:8092`

![image-20201121221016825](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121221016825.png)

- `host`: 主机名
- `port`: 端口名

`axios`配置修改

![image-20201124203125997](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201124203125997.png)

- `host`: 请求主机地址
- `port`: 端口
- `withCredentials`：是否携带`cookie`

后端：`127.0.0.1:8890`

![image-20201121221101759](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121221101759.png)

- 主机配置修改
  - `baseUrl`：监听地址
  - `defaultPort`：监听的默认端口
- 数据库配置修改
  - `host`：数据库用户名
  - `password`：数据库密码
  - `database`：使用的数据库名
  - `port`：数据库监听的端口
  - `mutipleStatements`：多SQL语句查询开关



#### 功能简述

- 简单增删查改
- 导出Excel
- 简单统计图

#### 

#### 展示图

- 基本显示

![image-20201121222207009](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222207009.png)

- 编辑

![image-20201121222257828](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222257828.png)

- 封面上传

![image-20201121222351219](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222351219.png)

- 图片预览

![image-20201121222508326](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222508326.png)

- 多选导出Excel

![image-20201121222610432](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222610432.png)

- 简单单项搜索，支持关键词匹配

![image-20201121222735130](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222735130.png)

- 辅助搜索

![image-20201121222818740](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222818740.png)

- 简单统计

![image-20201121222857144](C:\Users\cxj\AppData\Roaming\Typora\typora-user-images\image-20201121222857144.png)



这里只是一些简单的功能，而且没有很完善，例如这里的统计功能，还有系统设置之类的模块并没有写，有兴趣直接加上去就完事了

#### 前端路由设计

------

|     菜单名     |          路径           |   模块名    |            图标             | 级别 | 权限限制  |
| :------------: | :---------------------: | :---------: | :-------------------------: | :--: | :-------: |
|    商品管理    |         /goods          |    Goods    |    el-icon-s-cooperation    |  一  | admin  cs |
|   矿泉水管理   |      /goods/water       |    Water    |        el-icon-goods        |  二  | admin  cs |
| 矿泉水套餐管理 |      /goods/combo       |    Combo    |        el-icon-help         |  二  | admin cs  |
|    信息管理    |          /info          |    Info     |    el-icon-s-management     |  一  | admin cs  |
|   供货商管理   |     /info/suppliers     |  Suppliers  |        el-icon-rank         |  二  | admin cs  |
|  入库信息管理  |      /info/istore       |   Istore    |      el-icon-sort-down      |  二  | admin cs  |
|    人员管理    |         /people         |   People    |       el-icon-s-check       |  一  | admin cs  |
|    用户管理    |     /people/members     |   Members   |     el-icon-coordinate      |  二  | admin cs  |
|    员工管理    |    /people/employees    |  Employees  |     el-icon-data-board      |  二  |   admin   |
|    业务管理    |        /business        |  Business   |     el-icon-s-marketing     |  一  | admin cs  |
|  客户订单管理  |    /business/orders     |   Orders    |      el-icon-finished       |  二  | admin cs  |
|    任务管理    |     /business/tasks     |    Tasks    |   el-icon-document-remove   |  二  | admin cs  |
|    信息统计    |       /statistics       | Statistics  |      el-icon-pie-chart      |  一  | admin cs  |
|    业绩统计    | /statistics/performance | Performance |        el-icon-date         |  二  | admin cs  |
|    用户统计    |  /statistics/userstat   |  Userstat   | el-icon-c-scale-to-original |  二  | ·admin cs |
|    收支统计    |  /statistics/outinput   |  Outinput   |       el-icon-tickets       |  二  | admin cs  |
|    商品统计    |  /statistics/itemstat   |  Itemstat   |       el-icon-tickets       |  二  | admin cs  |
|    系统设置    |         /config         |   Config    |       el-icon-s-tools       |  一  |   admin   |
|    基本设置    |      /config/basec      |    Basec    |       el-icon-monitor       |  二  | admin cs  |
|    权限设置    |    /config/authority    |  Authority  |        el-icon-mouse        |  二  |   admin   |







#### 后端路由

------

|           路由           | 方法 |     请求数据      |         返回数据          |               功能               |
| :----------------------: | :--: | :---------------: | :-----------------------: | :------------------------------: |
|      /getData/tasks      | GET  |                   | {code,message,count,data} |         获取任务列和数目         |
|    /getData/employees    | GET  |                   |    {code,message,data}    |          员工的概要列表          |
|     /getData/deltask     | GET  |                   |      {code,message}       |             删除任务             |
|   /getData/updatetask    | GET  |                   |      {code,message}       |             更新任务             |
|    /getData/instasks     | GET  | {where,values,tb} |   状态码{code,message}    |             插入任务             |
|    /getData/updateit     | GET  | {where,values,tb} |      {code,message}       |           普适更新接口           |
|      /getData/delit      | GET  |    {where,tb}     |      {code,message}       |           普适删除接口           |
|     /getData/waters      | GET  |                   |    {code,message,data}    |       获取所有矿泉水的品牌       |
|      /getData/ishad      | GET  |    {where,tb}     |       {code,count}        |           数据存在与否           |
|    /getData/suppliers    | GET  |                   | {code.message,count,data} |          获取供货商列表          |
|   /getData/inssupplier   | GET  |    {values,tb}    |    {code,message,sno}     |            插入供货商            |
|  /getData/allemployees   | GET  |                   | {code,message,count,data} |             员工列表             |
|  /getData/insemployees   | GET  |    {values,tb}    |    {code,message,eno}     |             插入员工             |
|    /getData/insmember    | GET  |    {values,tb}    |    {code,message,cno}     |             插入会员             |
|     /getData/members     | GET  |                   | {code,message,count,data} |         获取会员列和数目         |
|     /getData/corders     | GET  |                   | {code,message,count,data} |       获取客户订单列和数目       |
|    /getData/inscorder    | GET  |    {values,tb}    |   {code,message,cname}    |           插入客户列表           |
|   /getData/listcombos    | GET  |                   |    {code,message,data}    |        矿泉水套餐概要列表        |
|     /getData/combos      | GET  |                   | {code,message,count,data} |        获取矿泉水套餐列表        |
|    /getData/inscombo     | GET  |                   |      {code,message}       |          插入矿泉水套餐          |
|       /upload/uimg       | POST |                   | {code,message,code,data}  |             图片上传             |
|    /getData/allwaters    | GET  |                   | {code,message,count,data} |             所有的水             |
|    /getData/inswater     | GET  |                   |    {code,message,wno}     |            插入矿泉水            |
|     /getData/iorders     | GET  |                   | {code,message,count,data} |         查找订单及其细节         |
|  /getData/listemployees  | GET  |                   |    {code,message,data}    |           员工列表概要           |
|  /getData/listsuppliers  | GET  |                   |    {code,message,data}    |            供货商概要            |
|    /getData/insiorder    | GET  |                   |    {code,message,ono}     |             插入订单             |
| /getData/insiorderdetail | GET  |                   |      {code,message}       |           插入订单细节           |
|     /getData/hadcono     | GET  |    {cono:cono}    |       {count,data}        | 插入是否有该订单并且返回订单信息 |
|    /getData/hadstore     | GET  |     {num:num}     |        {had,code}         |             有没余量             |
| /getData/getempstattotal | GET  |                   |    {code,xdata,ydata}     |          员工总业绩信息          |
|   /getData/getempyear    | GET  |      {year}       |     {code,data,emps}      |   该年份下每个月份的员工的业绩   |
|     /getData/output      | GET  |      {year}       |        {code,data}        |    该年份下每个月份的进货支出    |
|     /getData/income      | GET  |      {year}       |                           |    该年份下每个月份的订单收入    |
|                          |      |                   |                           |                                  |

