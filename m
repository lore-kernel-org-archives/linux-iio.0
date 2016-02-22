Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9254 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755663AbcBVVjK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 22 Feb 2016 16:39:10 -0500
From: Matt Ranostay <matt.ranostay@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, daniel.baluta@intel.com,
	adriana.reus@intel.com, Matt Ranostay <matt.ranostay@intel.com>
Subject: [PATCH 3/5] iio: imu: mpu6050: add missing docstring for int_pin_cfg
Date: Mon, 22 Feb 2016 13:39:09 -0800
Message-Id: <1456177151-15881-4-git-send-email-matt.ranostay@intel.com>
In-Reply-To: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
References: <1456177151-15881-1-git-send-email-matt.ranostay@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 243324dd78de..a6c45ce459ee 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -39,6 +39,7 @@
  *  @int_enable:	Interrupt enable register.
  *  @pwr_mgmt_1:	Controls chip's power state and clock source.
  *  @pwr_mgmt_2:	Controls power state of individual sensors.
+ *  @int_pin_cfg;	Controls interrupt pin configuration.
  */
 struct inv_mpu6050_reg_map {
 	u8 sample_rate_div;
-- 
1.9.1

