
import fs from 'fs' ;
import path from 'path' ;

export const mysql = require('mysql') ;

const config  = JSON.parse(fs.readFileSync(path.join(__dirname, '../config.json'))) ;

export const pool    = mysql.createPool(config.mysql) ;


// 一般查询
export const query = function( sql ){

  return new Promise(function(resolve, reject){

    pool.getConnection(function(err, connection) {

      connection.query(sql, function (err, results, fields) {

        if(err){
          reject(err) ;
        } 

        resolve(results) ;
        connection.release();
     
      }) ;
    }) ;
  })
}


