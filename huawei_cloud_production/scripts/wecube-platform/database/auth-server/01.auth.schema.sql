/*
Navicat MariaDB Data Transfer

Source Server         : smoke1
Source Server Version : 100109
Source Host           : tdsql-66a3mko1.sql.tencentcdb.com:75
Source Database       : smoke2_auth_server

Target Server Type    : MariaDB
Target Server Version : 100109
File Encoding         : 65001

Date: 2020-02-06 16:29:24
*/

CREATE DATABASE IF NOT EXISTS `auth_server` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `auth_server`;

SET FOREIGN_KEY_CHECKS=0;
SET NAMES utf8;
-- ----------------------------
-- Table structure for auth_sys_api
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_api`;
CREATE TABLE `auth_sys_api` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `api_url` varchar(255) DEFAULT NULL,
  `http_method` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `system_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_sys_authority
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_authority`;
CREATE TABLE `auth_sys_authority` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `scope` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_sys_role
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_role`;
CREATE TABLE `auth_sys_role` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `email_addr` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_sys_role_authority
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_role_authority`;
CREATE TABLE `auth_sys_role_authority` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `authority_code` varchar(255) DEFAULT NULL,
  `authority_id` varchar(255) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_sys_sub_system
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_sub_system`;
CREATE TABLE `auth_sys_sub_system` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `api_key` varchar(500) DEFAULT NULL,
  `is_blocked` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `pub_api_key` varchar(500) DEFAULT NULL,
  `system_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_sys_sub_system_authority
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_sub_system_authority`;
CREATE TABLE `auth_sys_sub_system_authority` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `authority_code` varchar(255) DEFAULT NULL,
  `authority_id` varchar(255) DEFAULT NULL,
  `sub_system_code` varchar(255) DEFAULT NULL,
  `sub_system_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_sys_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_user`;
CREATE TABLE `auth_sys_user` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_blocked` bit(1) DEFAULT NULL,
  `cell_phone_no` varchar(255) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `dept` varchar(255) DEFAULT NULL,
  `email_addr` varchar(255) DEFAULT NULL,
  `english_name` varchar(255) DEFAULT NULL,
  `local_name` varchar(255) DEFAULT NULL,
  `office_tel_no` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `auth_ctx` varchar(512) DEFAULT NULL,
  `auth_src` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `auth_sys_user_role`;
CREATE TABLE `auth_sys_user_role` (
  `id` varchar(255) NOT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  `created_time` datetime DEFAULT NULL,
  `updated_by` varchar(255) DEFAULT NULL,
  `updated_time` datetime DEFAULT NULL,
  `is_active` bit(1) DEFAULT NULL,
  `is_deleted` bit(1) DEFAULT NULL,
  `role_id` varchar(255) DEFAULT NULL,
  `role_name` varchar(255) DEFAULT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS=1;