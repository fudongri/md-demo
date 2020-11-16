
-- ----------------------------
-- Table structure for cncs_address_info
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_address_info`;
CREATE TABLE `cncs`.`cncs_address_info` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `bvn` varchar(64) NOT NULL DEFAULT '' COMMENT 'BVN',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'work（工作地址），family（家庭地址）',
  `state` varchar(128) NOT NULL DEFAULT '-1' COMMENT '州',
  `town` varchar(128) NOT NULL DEFAULT '' COMMENT '城镇',
  `area` varchar(128) NOT NULL DEFAULT '' COMMENT '区域',
  `street` varchar(255) NOT NULL DEFAULT '' COMMENT '街道',
  `detail` varchar(500) NOT NULL DEFAULT '' COMMENT '详细地址',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);

-- ----------------------------
-- Table structure for cncs_batch_data_check
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_batch_data_check`;
CREATE TABLE `cncs`.`cncs_batch_data_check` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `table_name` varchar(64) NOT NULL DEFAULT '' COMMENT '表名',
  `record_num` int(11) NOT NULL DEFAULT '0' COMMENT '记录数',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);

-- ----------------------------
-- Table structure for cncs_case_task
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_case_task`;
CREATE TABLE `cncs`.`cncs_case_task` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `channel` varchar(64) NOT NULL DEFAULT '' COMMENT '渠道，PC-XCross， EB-XCross， EasyBuy， PalmCredit',
  `bvn` varchar(64) NOT NULL DEFAULT '' COMMENT 'BVN',
  `cust_name` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名',
  `cust_id` varchar(64) NOT NULL DEFAULT '' COMMENT '客户id',
  `collector_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '催收员id',
  `call_day` varchar(32) NOT NULL DEFAULT '' COMMENT '业务日期',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);

-- ----------------------------
-- Table structure for cncs_case_task_history
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_case_task_history`;
CREATE TABLE `cncs`.`cncs_case_task_history` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `channel` varchar(64) NOT NULL DEFAULT '' COMMENT '渠道，PC-XCross， EB-XCross， EasyBuy， PalmCredit',
  `bvn` varchar(64) NOT NULL DEFAULT '' COMMENT 'BVN',
  `cust_name` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名',
  `cust_id` varchar(64) NOT NULL DEFAULT '' COMMENT '客户id',
  `collector_id` bigint(20) NOT NULL DEFAULT '-1' COMMENT '催收员id',
  `call_day` varchar(32) NOT NULL DEFAULT '' COMMENT '业务日期',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);

-- ----------------------------
-- Table structure for cncs_contact_info
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_contact_info`;
CREATE TABLE `cncs`.`cncs_contact_info` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `bvn` varchar(64) NOT NULL DEFAULT '' COMMENT 'BVN',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT '姓名',
  `relationship` varchar(64) NOT NULL DEFAULT '' COMMENT '关系',
  `mobile` varchar(64) NOT NULL DEFAULT '' COMMENT '手机号',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);

-- ----------------------------
-- Table structure for cncs_customer_info
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_customer_info`;
CREATE TABLE `cncs`.`cncs_customer_info` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `bvn` varchar(64) NOT NULL DEFAULT '' COMMENT 'BVN',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '姓名',
  `gender` varchar(32) NOT NULL DEFAULT '' COMMENT '客户id',
  `birthday` varchar(32) NOT NULL DEFAULT '' COMMENT '生日',
  `industry_category` varchar(64) NOT NULL DEFAULT '' COMMENT '行业分类',
  `company_name` varchar(255) NOT NULL DEFAULT '' COMMENT '公司名称',
  `marriage_status` varchar(32) NOT NULL DEFAULT '' COMMENT '婚姻状态',
  `total_loan_quantity` int(11) NOT NULL DEFAULT '-1' COMMENT '总贷款次数',
  `current_overdue_quantity` int(11) NOT NULL DEFAULT '-1' COMMENT '当前逾期次数',
  `longest_overdue_days` int(11) NOT NULL DEFAULT '-1' COMMENT '最长逾期天数',
  `overdue_total_amount` varchar(32) NOT NULL DEFAULT '' COMMENT '逾期总金额',
  `religion` varchar(64) NOT NULL DEFAULT '' COMMENT '宗教',
  `pay_method` varchar(64) NOT NULL DEFAULT '' COMMENT '支薪方式',
  `monthly_income` varchar(32) NOT NULL DEFAULT '' COMMENT '月收入',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);

-- ----------------------------
-- Table structure for cncs_loan_detail
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_loan_detail`;
CREATE TABLE `cncs`.`cncs_loan_detail` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `channel` varchar(64) NOT NULL DEFAULT '' COMMENT '渠道，PC-XCross， EB-XCross， EasyBuy， PalmCredit',
  `loan_id` varchar(64) NOT NULL DEFAULT '' COMMENT '借据id',
  `terms` varchar(64) NOT NULL DEFAULT '' COMMENT '期数',
  `due_date` varchar(32) NOT NULL DEFAULT '' COMMENT '当期到期还款日',
  `rec_total_amount` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '当期应收总金额',
  `rec_principal` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '应收本金',
  `rec_interest` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '应收利息',
  `rec_overdue_int` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '应收罚息',
  `outstd_overdue_int` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '应还罚息',
  `paid_amount` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '当期还款金额',
  `outstd_total_amount` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '当期应还总金额',
  `outstd_principal` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '应还本金',
  `outstd_interest` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '应还利息',
  `overdue_days` int(11) NOT NULL DEFAULT '-1' COMMENT '当期逾期天数',
  `amount_exemption` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '可豁免罚息,界面需需实时查询大数据',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);

-- ----------------------------
-- Table structure for cncs_loan_info
-- ----------------------------
DROP TABLE IF EXISTS `cncs`.`cncs_loan_info`;
CREATE TABLE `cncs`.`cncs_loan_info` (
  `id` bigint(20) NOT NULL COMMENT 'id',
  `channel` varchar(64) NOT NULL DEFAULT '' COMMENT '渠道，PC-XCross， EB-XCross， EasyBuy， PalmCredit',
  `bvn` varchar(64) NOT NULL DEFAULT '' COMMENT 'BVN',
  `loan_id` varchar(64) NOT NULL DEFAULT '' COMMENT '借据id',
  `contract_no` varchar(64) NOT NULL DEFAULT '' COMMENT '合同号',
  `loan_date` varchar(32) NOT NULL DEFAULT '' COMMENT '借款日期',
  `loan_terms` int(11) NOT NULL DEFAULT '-1' COMMENT '借款期数',
  `overdue_days` int(11) NOT NULL DEFAULT '-1' COMMENT '借据逾期天数',
  `brand` varchar(64) NOT NULL DEFAULT '' COMMENT '手机品牌',
  `model` varchar(64) NOT NULL DEFAULT '' COMMENT '手机型号',
  `price` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '手机总价格',
  `downpayment` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '首付',
  `overdue_amount` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '逾期总金额',
  `paid_amount` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '总还款金额',
  `loan_amount` decimal(16,6) NOT NULL DEFAULT '0.000000' COMMENT '贷款金额',
  `outstanding` varchar(32) NOT NULL DEFAULT '' COMMENT '在途：O；全部：F(结清），N（正常），O（逾期）',
  `create_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '创建人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(255) NOT NULL DEFAULT 'sys' COMMENT '修改人',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
);
