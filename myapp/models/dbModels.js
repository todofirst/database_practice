

export const GET_ALL_TASKS = 
`
SELECT task.cono,task.cno,task.cname,task.eno,task.wno,task.sex,ctel,task.address,task.time,employee.name as name,water.wname,task.num,task.status FROM task  INNER JOIN customer ON task.cno=customer.cno INNER JOIN employee ON task.eno=employee.eno INNER JOIN water ON water.wno=task.wno;`

export const GET_ALL_NOWEMPLOYEES = 
`
SELECT eno, name FROM employee WHERE job=?;
`

export const GET_LIST_WATERS = 
`
SELECT wno,wname,price FROM water
`

export const GET_ALL_WATERS = 
`
SELECT * FROM water
`

export const GET_ALL_SUPPLIERS =
`
SELECT * FROM supplier
`

export const GET_ALL_ALLEMYLOYEES =
`
SELECT eno,name,sex,age,tel,job,etime as time, salary, status FROM employee
`

export const GET_ALL_CUSTOMER =
`
SELECT * FROM customer
`

export const GET_ALL_CORDERS =
`
SELECT corder.cono,corder.cno,customer.name,corder.cflag, corder.time,corder.name as gname,corder.total,leav,corder.gnum,corder.price FROM corder INNER JOIN customer ON corder.cno=customer.cno `

export const GET_LIST_COMBOS =
`
SELECT * FROM combo
`

export const GET_ALL_COMBOS =
`
SELECT tnum,gnum,combo.price,combo.wno,combo.wname, water.wname as linkname FROM combo INNER JOIN water ON combo.wno=water.wno;

`

export const GET_ALL_IORDERS =
`
SELECT ono,iorder.sno,supplier.name as sname,iorder.eno,employee.name as ename,iorder.status, iorder.time FROM iorder INNER JOIN supplier ON iorder.sno=supplier.sno INNER JOIN employee ON iorder.eno=employee.eno;`

export const GET_LIST_EMPLOYEES = 
`
SELECT eno,name FROM employee;
`

export const GET_LIST_SUPPLIERS = 
`
SELECT sno,name FROM supplier;
`

export const GET_ALL_IORDERDETAILS =
`
SELECT iorderdetail.ono,wname,iorderdetail.wno,iorderdetail.price,iorderdetail.num FROM iorderdetail INNER JOIN water ON iorderdetail.wno=water.wno;

`

export const GET_NOW_ORDER =
`
SELECT corder.cno,customer.name as cname,customer.sex,customer.tel as ctel,customer.address,corder.name as wname,corder.cflag  FROM corder  INNER JOIN  customer ON customer.cno=corder.cno WHERE cono=?;
`

export const GET_EMP_STAT = 
`
SELECT task.eno,employee.name,SUM(num) as total FROM task INNER JOIN employee ON employee.eno=task.eno AND employee.status <> '0' GROUP BY eno;
`