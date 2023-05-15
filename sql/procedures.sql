-- ----------------------------
-- Table structure for mons
-- ----------------------------
DROP TABLE IF EXISTS `mons`;
CREATE TABLE `mons`  (
  `id` int(11) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of mons
-- ----------------------------
INSERT INTO `mons` VALUES (1);
INSERT INTO `mons` VALUES (2);
INSERT INTO `mons` VALUES (3);
INSERT INTO `mons` VALUES (4);
INSERT INTO `mons` VALUES (5);
INSERT INTO `mons` VALUES (6);
INSERT INTO `mons` VALUES (7);
INSERT INTO `mons` VALUES (8);
INSERT INTO `mons` VALUES (9);
INSERT INTO `mons` VALUES (10);
INSERT INTO `mons` VALUES (11);
INSERT INTO `mons` VALUES (12);




-- 员工各个月份的业绩
DROP PROCEDURE
IF
	EXISTS staff_span_year;
CREATE PROCEDURE staff_span_year ( IN YEAR INT ) BEGIN
	DECLARE
		flag INT DEFAULT 0;
	DECLARE
		mon INT;
	DECLARE
		monList CURSOR FOR ( SELECT id FROM mons );
	DECLARE
		CONTINUE HANDLER FOR NOT FOUND 
		SET flag = 1;
	OPEN monList;
	FETCH monList INTO mon;
	WHILE
			flag != 1 DO
		SELECT
			task.eno,
			employee.NAME,
			SUM( num ) AS total 
		FROM
			Task
			INNER JOIN employee ON task.eno = employee.eno 
		WHERE
			YEAR (
			FROM_UNIXTIME( task.time / 1000 ))= YEAR 
			AND MONTH (c
			AND task.status='1'
		GROUP BY
			( task.eno );
		FETCH monList INTO mon;
		
	END WHILE;
	CLOSE monList;
	
END;-- 购货支出
DROP PROCEDURE
IF
	EXISTS output_span_year;
CREATE PROCEDURE output_span_year ( IN YEAR INT ) BEGIN
	DECLARE
		flag INT DEFAULT 0;
	DECLARE
		mon INT;
	DECLARE
		monList CURSOR FOR ( SELECT id FROM mons );
	DECLARE
		CONTINUE HANDLER FOR NOT FOUND 
		SET flag = 1;
	OPEN monList;
	FETCH monList INTO mon;
	WHILE
			flag != 1 DO
		SELECT
			Sum( price ) AS total 
		FROM
			iorderdetail
			INNER JOIN iorder ON iorder.ono = iorderdetail.ono 
		WHERE
			YEAR (
			FROM_UNIXTIME( time / 1000 ))= YEAR 
			AND MONTH (
			FROM_UNIXTIME( time / 1000 ))= mon;
		FETCH monList INTO mon;
		
	END WHILE;
	CLOSE monList;
	
END;-- 客户订单收入
DROP PROCEDURE
IF
	EXISTS income_span_year;
CREATE PROCEDURE income_span_year ( IN YEAR INT ) BEGIN
	DECLARE
		flag INT DEFAULT 0;
	DECLARE
		mon INT;
	DECLARE
		monList CURSOR FOR ( SELECT id FROM mons );
	DECLARE
		CONTINUE HANDLER FOR NOT FOUND 
		SET flag = 1;
	OPEN monList;
	FETCH monList INTO mon;
	WHILE
			flag != 1 DO
		SELECT
			Sum( price ) AS total 
		FROM
			corder 
		WHERE
			YEAR (
			FROM_UNIXTIME( time / 1000 ))= YEAR 
			AND MONTH (
			FROM_UNIXTIME( time / 1000 ))= mon;
		FETCH monList INTO mon;
		
	END WHILE;
	CLOSE monList;
	
END;-- 用数量前10用户
(
	SELECT
		task.cno,
		customer.NAME,
		SUM( num ) AS total 
	FROM
		task
		INNER JOIN customer ON customer.cno = task.cno 
	GROUP BY
		cno 
	) 
ORDER BY
	total DESC 
	LIMIT 10;