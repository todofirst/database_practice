

SET NAMES utf8mb4;


-- ----------------------------
-- Table structure for water
-- ----------------------------
DROP TABLE IF EXISTS `water`;
CREATE TABLE `water`  (
  `wno` int(11) NOT NULL AUTO_INCREMENT,
  `picture` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wname` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `wbrand` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `store` int(11) NULL DEFAULT 0,
  `sale` int(11) NULL DEFAULT 0,
  PRIMARY KEY (`wno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;

CREATE TABLE `supplier`  (
  `sno` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `brand` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`sno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `eno` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `age` tinyint(4) NOT NULL,
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `job` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `etime` bigint(20) NOT NULL,
  `salary` decimal(8, 2) NULL DEFAULT NULL,
  `status` enum('0','1','2') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '2',
  PRIMARY KEY (`eno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer`  (
  `cno` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `time` bigint(20) NOT NULL,
  PRIMARY KEY (`cno`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for iorder
-- ----------------------------
DROP TABLE IF EXISTS `iorder`;
CREATE TABLE `iorder`  (
  `ono` int(11) NOT NULL AUTO_INCREMENT,
  `sno` int(11) NOT NULL,
  `eno` int(11) NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `time` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`ono`) USING BTREE,
  INDEX `sno`(`sno`) USING BTREE,
  INDEX `eno`(`eno`) USING BTREE,
  CONSTRAINT `iorder_ibfk_1` FOREIGN KEY (`sno`) REFERENCES `supplier` (`sno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `iorder_ibfk_2` FOREIGN KEY (`eno`) REFERENCES `employee` (`eno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for task
-- ----------------------------
DROP TABLE IF EXISTS `task`;
CREATE TABLE `task`  (
  `sex` enum('男','女') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '男',
  `cname` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '匿名',
  `time` bigint(20) NOT NULL,
  `num` int(11) NOT NULL,
  `ctel` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `eno` int(11) NOT NULL,
  `wno` int(11) NULL DEFAULT NULL,
  `cno` int(11) NOT NULL,
  `address` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `status` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0',
  `cono` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`time`, `cno`, `eno`) USING BTREE,
  INDEX `cno`(`cno`) USING BTREE,
  INDEX `eno`(`eno`) USING BTREE,
  INDEX `wno`(`wno`) USING BTREE,
  INDEX `cono`(`cono`) USING BTREE,
  CONSTRAINT `task_ibfk_1` FOREIGN KEY (`cno`) REFERENCES `customer` (`cno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `task_ibfk_2` FOREIGN KEY (`eno`) REFERENCES `employee` (`eno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `task_ibfk_3` FOREIGN KEY (`wno`) REFERENCES `water` (`wno`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `task_ibfk_4` FOREIGN KEY (`cono`) REFERENCES `corder` (`cono`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for combo
-- ----------------------------
DROP TABLE IF EXISTS `combo`;
CREATE TABLE `combo`  (
  `tnum` int(11) NOT NULL,
  `gnum` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `wno` int(11) NOT NULL,
  `wname` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  INDEX `wno`(`wno`) USING BTREE,
  CONSTRAINT `combo_ibfk_1` FOREIGN KEY (`wno`) REFERENCES `water` (`wno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for iorderdetail
-- ----------------------------
DROP TABLE IF EXISTS `iorderdetail`;
CREATE TABLE `iorderdetail`  (
  `num` int(11) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `ono` int(11) NOT NULL,
  `wno` int(11) NOT NULL,
  PRIMARY KEY (`wno`, `ono`) USING BTREE,
  INDEX `ono`(`ono`) USING BTREE,
  CONSTRAINT `iorderdetail_ibfk_1` FOREIGN KEY (`ono`) REFERENCES `iorder` (`ono`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `iorderdetail_ibfk_2` FOREIGN KEY (`wno`) REFERENCES `water` (`wno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for corder
-- ----------------------------
DROP TABLE IF EXISTS `corder`;
CREATE TABLE `corder`  (
  `cno` int(11) NOT NULL,
  `time` bigint(20) NOT NULL,
  `total` int(11) NOT NULL,
  `leav` int(11) NOT NULL,
  `gnum` int(11) NULL DEFAULT 0,
  `price` decimal(10, 2) NOT NULL,
  `name` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cflag` enum('0','1') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cono` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`cono`) USING BTREE,
  INDEX `cno`(`cno`) USING BTREE,
  CONSTRAINT `corder_ibfk_1` FOREIGN KEY (`cno`) REFERENCES `customer` (`cno`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;





