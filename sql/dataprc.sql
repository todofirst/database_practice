/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50730
 Source Host           : localhost:3306
 Source Schema         : dataprc

 Target Server Type    : MySQL
 Target Server Version : 50730
 File Encoding         : 65001

 Date: 15/05/2023 21:44:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of combo
-- ----------------------------
INSERT INTO `combo` VALUES (20, 0, 340.00, 2, '大清宝矿泉水20瓶装');
INSERT INTO `combo` VALUES (3, 0, 240.00, 3, '泉叮咚聚会专用3桶装');
INSERT INTO `combo` VALUES (10, 0, 160.00, 5, '农夫山泉优惠10桶装');
INSERT INTO `combo` VALUES (60, 3, 750.00, 5, '农夫山泉家庭60桶优惠装');
INSERT INTO `combo` VALUES (60, 5, 800.00, 10, '哇哈哈家庭60桶优惠装');
INSERT INTO `combo` VALUES (200, 10, 1998.00, 1, '马巴矿泉水公司套餐200桶');
INSERT INTO `combo` VALUES (200, 1, 240.00, 6, '天地精华桶装水10桶装');
INSERT INTO `combo` VALUES (10, 2, 200.00, 7, '长春桶装水10桶装');

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
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of corder
-- ----------------------------
INSERT INTO `corder` VALUES (1, 1605599090000, 10, 9, 1, 450.00, '巴马桶装水10瓶套餐装', '1', 1);
INSERT INTO `corder` VALUES (1, 1603900800000, 10, 6, 0, 450.00, '', '1', 2);
INSERT INTO `corder` VALUES (2, 1597852800000, 10, 6, 0, 180.00, '厂家直供桶装水 批发15升水批发配送大连桶装水配送 福建送水电话', '0', 3);
INSERT INTO `corder` VALUES (2, 1591027200000, 3, 0, 0, 240.00, '泉叮咚聚会专用3桶装', '1', 4);
INSERT INTO `corder` VALUES (3, 1559577600000, 20, 10, 0, 400.00, '长春桶装水 长春矿泉水直供 泉阳泉大桶水配送 送货上门', '0', 5);
INSERT INTO `corder` VALUES (4, 1588867200000, 10, 0, 0, 880.00, '公司桶装水批发 8L泉水叮咚直供 饮用水批发 瓶装水厂家 矿泉水定制', '0', 6);
INSERT INTO `corder` VALUES (5, 1606492800000, 200, 200, 0, 3600.00, '农夫山泉一次性桶装水天然矿物质水_天然矿泉水_农夫山泉饮用天然矿泉水_桶装矿泉水_企业采购', '0', 7);
INSERT INTO `corder` VALUES (3, 1604332800000, 3, 3, 0, 240.00, '泉叮咚聚会专用3桶装', '1', 8);
INSERT INTO `corder` VALUES (6, 1601913600000, 100, 100, 0, 2800.00, '天地精华桶装水 天地精华-矿泉宝藏 合肥天地精华桶装水旗舰店 免费送桶装水 天地精华桶装水价格', '0', 9);
INSERT INTO `corder` VALUES (5, 1604764800000, 100, 100, 0, 1800.00, '大清宝泉水悟乾坤桶装水 泡茶专用 桶装水配送 附近水站', '0', 10);
INSERT INTO `corder` VALUES (4, 1604332800000, 100, 100, 0, 8800.00, '公司桶装水批发 8L泉水叮咚直供 饮用水批发 瓶装水厂家 矿泉水定制', '0', 11);
INSERT INTO `corder` VALUES (8, 1605617383000, 20, 18, 0, 340.00, '大清宝矿泉水20瓶装', '1', 12);
INSERT INTO `corder` VALUES (9, 1605617407000, 10, 7, 0, 160.00, '农夫山泉优惠10桶装', '1', 13);
INSERT INTO `corder` VALUES (8, 1605618311000, 60, 36, 3, 750.00, '农夫山泉家庭优惠装', '1', 14);
INSERT INTO `corder` VALUES (4, 1602604800000, 60, 60, 3, 750.00, '农夫山泉家庭优惠装', '1', 15);
INSERT INTO `corder` VALUES (4, 1601913600000, 60, 60, 5, 800.00, '哇哈哈家庭60桶优惠装', '1', 16);
INSERT INTO `corder` VALUES (1, 1603382400000, 60, 60, 5, 800.00, '哇哈哈家庭60桶优惠装', '1', 17);
INSERT INTO `corder` VALUES (9, 1600185600000, 60, 60, 3, 750.00, '农夫山泉家庭60桶优惠装', '1', 18);
INSERT INTO `corder` VALUES (7, 1600272000000, 60, 60, 3, 750.00, '农夫山泉家庭60桶优惠装', '1', 19);
INSERT INTO `corder` VALUES (5, 1594656000000, 60, 60, 3, 750.00, '农夫山泉家庭60桶优惠装', '1', 20);
INSERT INTO `corder` VALUES (10, 1600272000000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 21);
INSERT INTO `corder` VALUES (10, 1605110400000, 200, 180, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 22);
INSERT INTO `corder` VALUES (9, 1602086400000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 23);
INSERT INTO `corder` VALUES (1, 1591718400000, 200, 177, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 24);
INSERT INTO `corder` VALUES (2, 1591891200000, 200, 141, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 25);
INSERT INTO `corder` VALUES (3, 1593187200000, 200, 109, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 26);
INSERT INTO `corder` VALUES (4, 1593100800000, 200, 187, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 27);
INSERT INTO `corder` VALUES (5, 1594742400000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 28);
INSERT INTO `corder` VALUES (6, 1594915200000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 29);
INSERT INTO `corder` VALUES (7, 1596124800000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 30);
INSERT INTO `corder` VALUES (8, 1594828800000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 31);
INSERT INTO `corder` VALUES (9, 1595865600000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 32);
INSERT INTO `corder` VALUES (5, 1597852800000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 33);
INSERT INTO `corder` VALUES (7, 1597420800000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 34);
INSERT INTO `corder` VALUES (10, 1598025600000, 200, 200, 10, 1998.00, '马巴矿泉水公司套餐200桶', '1', 35);

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of customer
-- ----------------------------
INSERT INTO `customer` VALUES (1, '信陵君', '男', '广西大学西26栋407', '13478760987', '1', 1589990400000);
INSERT INTO `customer` VALUES (2, '隰朋', '男', '广西大学西26栋408', '13456799876', '1', 1590076800000);
INSERT INTO `customer` VALUES (3, '魏斯', '男', '广西民族大学14栋406', '13454455555', '1', 1592401309000);
INSERT INTO `customer` VALUES (4, '屈原', '男', '广西中医药大学14栋201', '13567677777', '1', 1589299200000);
INSERT INTO `customer` VALUES (5, '龙且', '男', '南宁师范大学19栋305', '13456000999', '1', 1592150400000);
INSERT INTO `customer` VALUES (6, '张仪', '男', '广西民族大学19栋110', '13567687987', '1', 1589904000000);
INSERT INTO `customer` VALUES (7, '李白', '男', '广西大学东校区20栋204', '14534567876', '1', 1587571200000);
INSERT INTO `customer` VALUES (8, '迪丽热巴', '女', '广西大学东21栋307宿舍', '18867285881', '1', 1590068393000);
INSERT INTO `customer` VALUES (9, '李现', '男', '广西大学西26栋407', '15787629815', '1', 1587649262000);
INSERT INTO `customer` VALUES (10, '王一博', '男', '广西大学西26栋401', '17687569871', '1', 1590151584000);
INSERT INTO `customer` VALUES (11, '成儒家', '男', '广西大学西校园26栋406', '14567876543', '1', 1605774423000);
INSERT INTO `customer` VALUES (12, '李青', '女', '广西大学东校园104', '14657876567', '1', 1605797573000);

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
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '扁鹊', '男', 20, '13454567898', '配送员', 1605506661000, 3000.00, '2');
INSERT INTO `employee` VALUES (2, '伍子胥', '男', 20, '13565678765', '配送员', 1605593404000, 3000.00, '1');
INSERT INTO `employee` VALUES (3, '孟尝君', '男', 24, '13656765458', '客服', 1598544000000, 3000.00, '0');
INSERT INTO `employee` VALUES (4, '介子推', '男', 30, '13567678987', '仓库管理', 1605593521000, 4000.00, '1');
INSERT INTO `employee` VALUES (5, '郑忽', '男', 34, '13567876543', '客服', 1589523153000, 4000.00, '1');
INSERT INTO `employee` VALUES (6, '吴王僚', '男', 45, '13567654345', '仓库管理', 1563379200000, 4000.00, '1');
INSERT INTO `employee` VALUES (7, '赵牧', '男', 24, '13457890987', '配送员', 1605593779000, 2800.00, '1');
INSERT INTO `employee` VALUES (8, '田辟疆', '男', 34, '13456787650', '配送员', 1576649829000, 3400.00, '1');
INSERT INTO `employee` VALUES (9, '杨建', '男', 30, '14567876543', '配送员', 1605774694000, 3000.00, '1');

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
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of iorder
-- ----------------------------
INSERT INTO `iorder` VALUES (2, 2, 6, '1', 1604764800000);
INSERT INTO `iorder` VALUES (3, 3, 6, '1', 1606665600000);
INSERT INTO `iorder` VALUES (4, 3, 4, '1', 1591200000000);

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
-- Records of iorderdetail
-- ----------------------------
INSERT INTO `iorderdetail` VALUES (1000, 7000.00, 4, 1);
INSERT INTO `iorderdetail` VALUES (200, 3000.00, 2, 5);
INSERT INTO `iorderdetail` VALUES (200, 3000.00, 2, 6);
INSERT INTO `iorderdetail` VALUES (200, 3200.00, 3, 7);
INSERT INTO `iorderdetail` VALUES (200, 3400.00, 3, 9);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of supplier
-- ----------------------------
INSERT INTO `supplier` VALUES (1, '大理市小宝贝饮料有限公司', '云南省大理州大理市湾桥镇镇政府后', '13434567655', '娃哈哈');
INSERT INTO `supplier` VALUES (2, '福建戴云玉露矿泉水有限公司', '福建省泉州市南安市霞美镇成辉国际17路15/28', '14545656789', '农夫山泉');
INSERT INTO `supplier` VALUES (3, '广西巴马晶硒岩泉水业有限公司', '巴马瑶族自治县那桃乡坡良村重屯', '13454567878', '怡宝');
INSERT INTO `supplier` VALUES (4, '武汉泰诺康泽商贸有限公司', '武汉东湖新技术开发区关南科技工业园现代国际设计城三期6栋508、509', '15656787654', '五大连池');
INSERT INTO `supplier` VALUES (5, '石家庄吉时雨山泉水有限公司', '河北石家庄', '14576758493', '鼎湖山去哪');

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
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of task
-- ----------------------------
INSERT INTO `task` VALUES ('男', '魏斯', 1580400000000, 12, '13454455555', 7, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('男', '维斯', 1581350400000, 12, '13454455555', 9, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('男', '屈原', 1582819200000, 13, '13567677777', 2, 1, 4, '广西中医药大学14栋201', '1', 27);
INSERT INTO `task` VALUES ('男', '魏斯', 1583856000000, 12, '13454455555', 8, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('男', '魏斯', 1584028800000, 14, '13454455555', 1, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('男', '魏斯', 1584633600000, 12, '13454455555', 7, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('男', '魏斯', 1585238400000, 11, '13454455555', 9, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('男', '隰朋', 1587632046000, 15, '13456799876', 2, 1, 2, '广西大学西26栋408', '1', 25);
INSERT INTO `task` VALUES ('男', '隰朋', 1593100800000, 12, '13456799876', 9, 1, 2, '广西大学西26栋408', '1', 25);
INSERT INTO `task` VALUES ('男', '屈原', 1593187200000, 10, '13567677777', 8, 3, 4, '广西中医药大学14栋201', '1', 6);
INSERT INTO `task` VALUES ('男', '隰朋', 1593446400000, 12, '13456799876', 2, 1, 2, '广西大学西26栋408', '1', 25);
INSERT INTO `task` VALUES ('男', '信陵君', 1593792000000, 12, '13478760987', 7, 1, 1, '广西大学西26栋407', '1', 24);
INSERT INTO `task` VALUES ('男', '魏斯', 1594137600000, 10, '13454455555', 1, 7, 3, '广西民族大学14栋406', '1', 5);
INSERT INTO `task` VALUES ('男', '隰朋', 1596124800000, 20, '13456799876', 1, 1, 2, '广西大学西26栋408', '1', 25);
INSERT INTO `task` VALUES ('男', '隰朋', 1596184597000, 3, '13456799876', 2, 3, 2, '广西大学西26栋408', '1', 4);
INSERT INTO `task` VALUES ('男', '魏斯', 1598025600000, 14, '13454455555', 8, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('女', '迪丽热巴', 1598889600000, 14, '18867285881', 7, 5, 8, '广西大学东21栋307宿舍', '1', 14);
INSERT INTO `task` VALUES ('女', '迪丽热巴', 1602086400000, 10, '18867285881', 8, 5, 8, '广西大学东21栋307宿舍', '1', 14);
INSERT INTO `task` VALUES ('女', '迪丽热巴', 1603209600000, 8, '18867285881', 1, 5, 8, '广西大学东21栋307宿舍', '0', 14);
INSERT INTO `task` VALUES ('男', '王一博', 1603382400000, 20, '17687569871', 8, 1, 10, '广西大学西26栋401', '1', 22);
INSERT INTO `task` VALUES ('男', '隰朋', 1604851200000, 2, '13456799876', 8, 4, 2, '广西大学西26栋408', '1', 3);
INSERT INTO `task` VALUES ('男', '信陵君', 1605614830000, 1, '13478760987', 2, 1, 1, '广西大学西26栋407', '1', 1);
INSERT INTO `task` VALUES ('男', '李现', 1605617738000, 3, '15787629815', 1, 5, 9, '广西大学西26栋407', '1', 13);
INSERT INTO `task` VALUES ('女', '迪丽热巴', 1605628800000, 2, '18867285881', 2, 2, 8, '广西南宁市广西大学东21栋307宿舍', '1', 12);
INSERT INTO `task` VALUES ('男', '信陵君', 1605775657000, 11, '13478760987', 8, 1, 1, '广西大学西26栋407', '1', 24);
INSERT INTO `task` VALUES ('男', '魏斯', 1605847788000, 4, '13454455555', 2, 1, 3, '广西民族大学14栋406', '1', 26);
INSERT INTO `task` VALUES ('男', '隰朋', 1606233600000, 2, '13456799876', 2, 4, 2, '广西大学西26栋408', '1', 3);
INSERT INTO `task` VALUES ('男', '信陵君', 1606492800000, 2, '13478760987', 2, 1, 1, '广西大学西26栋407', '0', 2);
INSERT INTO `task` VALUES ('男', '信陵君', 1606492800000, 2, '13478760987', 7, 1, 1, '广西大学西26栋407', '1', 2);
INSERT INTO `task` VALUES ('男', '信陵君', 1608134400000, 2, '13478760987', 1, 1, 1, '广西大学西26栋407', '1', 2);

-- ----------------------------
-- Table structure for test
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `a` int(11) NOT NULL,
  PRIMARY KEY (`id`, `a`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_bin ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES (1, 1);
INSERT INTO `test` VALUES (2, 1);
INSERT INTO `test` VALUES (3, 1);
INSERT INTO `test` VALUES (4, 2);
INSERT INTO `test` VALUES (5, 2);
INSERT INTO `test` VALUES (6, 2);
INSERT INTO `test` VALUES (7, 3);
INSERT INTO `test` VALUES (8, 3);
INSERT INTO `test` VALUES (9, 3);
INSERT INTO `test` VALUES (10, 4);
INSERT INTO `test` VALUES (11, 4);
INSERT INTO `test` VALUES (12, 5);
INSERT INTO `test` VALUES (13, 5);
INSERT INTO `test` VALUES (14, 2);
INSERT INTO `test` VALUES (15, 2);
INSERT INTO `test` VALUES (16, 3);
INSERT INTO `test` VALUES (17, 3);
INSERT INTO `test` VALUES (18, 3);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role` varchar(14) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('123', '123', 'admin');
INSERT INTO `users` VALUES ('cs', 'cs', 'cs');
INSERT INTO `users` VALUES ('sm', 'sm', 'sm');
INSERT INTO `users` VALUES ('dm', 'dm', 'dm');
INSERT INTO `users` VALUES ('配送员', '123', 'dm');

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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of water
-- ----------------------------
INSERT INTO `water` VALUES (1, 'http://localhost:8890/public/images/7_QNXuBhLyqU.jpg', '巴马矿泉水 一次性桶装水4.68L', '巴马矿泉水', 14.00, 1889, 0);
INSERT INTO `water` VALUES (2, 'http://localhost:8890/public/images/2_cMSEQt4KR4.jpg', '大清宝泉水悟乾坤桶装水 泡茶专用 桶装水配送 附近水站', '大清宝', 18.00, 98, 0);
INSERT INTO `water` VALUES (3, 'http://localhost:8890/public/images/3_rnlckV3IR.jpg', '公司桶装水批发 8L泉水叮咚直供 饮用水批发 瓶装水厂家 矿泉水定制', '泉水叮咚', 88.00, 27, 0);
INSERT INTO `water` VALUES (4, 'http://localhost:8890/public/images/4_k7puPsMGiD.jpg', '厂家直供桶装水 批发15升水批发配送大连桶装水配送 福建送水电话', '大连桶装水', 18.00, 46, 0);
INSERT INTO `water` VALUES (5, 'http://localhost:8890/public/images/5_cYDCJJTxY3.jpg', '农夫山泉一次性桶装水天然矿物质水_天然矿泉水_农夫山泉饮用天然矿泉水_桶装矿泉水_企业采购', '农夫山泉', 18.00, 423, 0);
INSERT INTO `water` VALUES (6, 'http://localhost:8890/public/images/6_S4oKS1QPDf.jpg', '天地精华桶装水 天地精华-矿泉宝藏 合肥天地精华桶装水旗舰店 免费送桶装水 天地精华桶装水价格', '天地精华', 28.00, 250, 0);
INSERT INTO `water` VALUES (7, 'http://localhost:8890/public/images/7_6SBvbVNQyO.jpg', '长春桶装水 长春矿泉水直供 泉阳泉大桶水配送 送货上门', '泉阳泉', 20.00, 240, 0);
INSERT INTO `water` VALUES (8, 'http://localhost:8890/public/images/8_nwzF0kyE6.jpg', '南充桶装水批发价格 蓝光青城山泉 配送矿泉水电话 桶装纯净水批发配送', '青城山泉', 28.00, 50, 0);
INSERT INTO `water` VALUES (9, 'http://localhost:8890/public/images/9_vw2mFxQoTI.jpg', '太原桶装水水站纯净水 饮料批发 恒大矿泉水 物业用水 酒店定制 快速送水', '恒大', 20.00, 250, 0);
INSERT INTO `water` VALUES (10, 'http://localhost:8890/public/images/10_nkzJa53rOV.jpg', '厦门娃哈哈饮用桶装水 厦门矿泉水大桶水2桶', '娃哈哈', 18.00, 300, 0);
INSERT INTO `water` VALUES (11, 'http://localhost:8890/public/images/11_oWbfdRZoDF.jpg', '广州怡宝桶装水', '怡宝', 13.00, 50, 0);

-- ----------------------------
-- Procedure structure for income_span_year
-- ----------------------------
DROP PROCEDURE IF EXISTS `income_span_year`;
delimiter ;;
CREATE PROCEDURE `income_span_year`(IN YEAR INT)
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for output_span_year
-- ----------------------------
DROP PROCEDURE IF EXISTS `output_span_year`;
delimiter ;;
CREATE PROCEDURE `output_span_year`(IN YEAR INT)
BEGIN
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
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for staff_span_year
-- ----------------------------
DROP PROCEDURE IF EXISTS `staff_span_year`;
delimiter ;;
CREATE PROCEDURE `staff_span_year`(IN YEAR INT)
BEGIN
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
			task
			INNER JOIN employee ON task.eno = employee.eno 
		WHERE
			YEAR (
			FROM_UNIXTIME( task.time / 1000 ))= YEAR 
			AND MONTH (
			FROM_UNIXTIME( task.time / 1000 ))= mon
			AND task.status='1'
		GROUP BY
			( task.eno );
		FETCH monList INTO mon;
		
	END WHILE;
	CLOSE monList;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for stu_inout
-- ----------------------------
DROP PROCEDURE IF EXISTS `stu_inout`;
delimiter ;;
CREATE PROCEDURE `stu_inout`(inout n int)
begin
    select n;
    set n=500;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sum_mon_send_total
-- ----------------------------
DROP PROCEDURE IF EXISTS `sum_mon_send_total`;
delimiter ;;
CREATE PROCEDURE `sum_mon_send_total`(IN mo VARCHAR(2), OUT total INT)
BEGIN


	SELECT id, SUM(num) INTO total FROM Task WHERE MONTH(FROM_UNIXTIME(time))=mo GROUP BY(id);
	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sum_mon_use_total
-- ----------------------------
DROP PROCEDURE IF EXISTS `sum_mon_use_total`;
delimiter ;;
CREATE PROCEDURE `sum_mon_use_total`(IN mo VARCHAR(2), OUT total INT)
BEGIN


	SELECT ctel, SUM(num) AS sum INTO total FROM Task WHERE MONTH(FROM_UNIXTIME(time))=mo GROUP BY(ctel) ORDER BY sum DESC LIMIT 10;
	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for toni
-- ----------------------------
DROP PROCEDURE IF EXISTS `toni`;
delimiter ;;
CREATE PROCEDURE `toni`(IN mo VARCHAR(2), OUT total INT)
BEGIN
	DECLARE m VARCHAR(2);

	SELECT id, SUM(num)  FROM test WHERE FROM_UNIXTIME(time,"%m")=mo GROUP BY(id);
	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for tonji
-- ----------------------------
DROP PROCEDURE IF EXISTS `tonji`;
delimiter ;;
CREATE PROCEDURE `tonji`()
begin
	SELECT * FROM test;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table employee
-- ----------------------------
DROP TRIGGER IF EXISTS `emp_limit_tri`;
delimiter ;;
CREATE TRIGGER `emp_limit_tri` BEFORE INSERT ON `employee` FOR EACH ROW BEGIN
	IF
		( NEW.age < 18 OR NEW.age > 65 ) THEN
		DELETE 
		FROM
			Employee 
		WHERE
			eno = NEW.age;
		
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table iorderdetail
-- ----------------------------
DROP TRIGGER IF EXISTS `insert_in_water_tri`;
delimiter ;;
CREATE TRIGGER `insert_in_water_tri` AFTER INSERT ON `iorderdetail` FOR EACH ROW BEGIN
	IF
		( NEW.num >= 0 ) THEN
			UPDATE Water 
			SET store = store + NEW.num 
		WHERE
			wno = NEW.wno;
		
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table iorderdetail
-- ----------------------------
DROP TRIGGER IF EXISTS `update_in_water_tri`;
delimiter ;;
CREATE TRIGGER `update_in_water_tri` AFTER UPDATE ON `iorderdetail` FOR EACH ROW BEGIN
	IF
		( NEW.num >= 0 ) THEN
			UPDATE Water 
			SET store = store - OLD.num + NEW.NUM 
		WHERE
			wno = NEW.wno;
		
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table iorderdetail
-- ----------------------------
DROP TRIGGER IF EXISTS `del_in_water_tri`;
delimiter ;;
CREATE TRIGGER `del_in_water_tri` AFTER DELETE ON `iorderdetail` FOR EACH ROW BEGIN
	IF
		( OLD.num >= 0 ) THEN
			UPDATE Water 
			SET store = store - OLD.num 
		WHERE
			wno = OLD.wno;
		
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table task
-- ----------------------------
DROP TRIGGER IF EXISTS `insert_out_water_tri`;
delimiter ;;
CREATE TRIGGER `insert_out_water_tri` AFTER INSERT ON `task` FOR EACH ROW BEGIN
	IF
		( NEW.num >= 0 AND NEW.status = "1" ) THEN
			UPDATE Water 
			SET store = store - NEW.num 
		WHERE
			wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav - NEW.num 
		WHERE
			cono = NEW.cono;
		
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table task
-- ----------------------------
DROP TRIGGER IF EXISTS `update_out_water_tri`;
delimiter ;;
CREATE TRIGGER `update_out_water_tri` AFTER UPDATE ON `task` FOR EACH ROW BEGIN
	IF
		( NEW.num >= 0 AND NEW.status = "1" AND OLD.status = "1" ) THEN
			UPDATE Water 
			SET store = store + OLD.num - NEW.num 
		WHERE
			wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav + OLD.num - NEW.num 
		WHERE
			cono = OLD.cono;
		
		ELSEIF ( NEW.num >= 0 AND NEW.status = "1" AND OLD.status = "0" ) THEN
		UPDATE Water 
		SET store = store - NEW.num 
		WHERE wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav - NEW.num 
		WHERE cono = OLD.cono;
			
		ELSEIF ( NEW.num >= 0 AND NEW.status = "0" AND OLD.status = "1" ) THEN
		UPDATE Water 
		SET store = store + OLD.num 
		WHERE
			wno = NEW.wno;
		UPDATE COrder 
		SET leav = leav + OLD.num 
		WHERE
			cono = OLD.cono;
		
	END IF;
	
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table task
-- ----------------------------
DROP TRIGGER IF EXISTS `del_out_water_tri`;
delimiter ;;
CREATE TRIGGER `del_out_water_tri` AFTER DELETE ON `task` FOR EACH ROW BEGIN
	IF
		( OLD.num >= 0 AND OLD.status = "1" ) THEN
			UPDATE Water 
			SET store = store + OLD.num 
		WHERE
			wno = OLD.wno;
		UPDATE COrder 
		SET leav = leav + OLD.num 
		WHERE
			cono = OLD.cono;
		
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table water
-- ----------------------------
DROP TRIGGER IF EXISTS `water_limit_tri`;
delimiter ;;
CREATE TRIGGER `water_limit_tri` BEFORE INSERT ON `water` FOR EACH ROW BEGIN
	IF
		( NEW.price <= 0.01 OR NEW.price >= 99 ) THEN
		DELETE 
		FROM
			Employee 
		WHERE
			wno = NEW.wno;
		
	END IF;
	
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
