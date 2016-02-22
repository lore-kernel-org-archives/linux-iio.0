Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9254 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742AbcBVVjJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 22 Feb 2016 16:39:09 -0500
From: Matt Ranostay <matt.ranostay@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com, Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH 0/5] mpu6050: code clean and calibration support
Date: Mon, 22 Feb 2016 13:39:06 -0800
Message-Id: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patchset series cleans up several documentation, return
code issues, incorrect timing delays, and adds accl/gyro offset
support.

Matt Ranostay (5):
  iio: imu: mpu6050: use inv_mpu6050_sensor_show return code
  iio: imu: mpu6050: fix INV_MPU6050_REG_UP_TIME delay
  iio: imu: mpu6050: add missing docstring for int_pin_cfg
  iio: imu: mpu6050: add calibration offset support
  iio: imu: mpu6050: add mpu6500 register settings

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 88 +++++++++++++++++++++++++++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  6 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 20 ++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  3 +-
 4 files changed, 105 insertions(+), 12 deletions(-)

-- 
1.9.1

