Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47094 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932143AbcA3Joy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 30 Jan 2016 04:44:54 -0500
From: Adriana Reus <adriana.reus@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 2/5] iio: inv_mpu6050: Remove unused parameter
Date: Sat, 30 Jan 2016 11:43:45 +0200
Message-Id: <1454147028-22449-3-git-send-email-adriana.reus@intel.com>
In-Reply-To: <1454147028-22449-1-git-send-email-adriana.reus@intel.com>
References: <1454147028-22449-1-git-send-email-adriana.reus@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The inv_check_and_setup_chip function does not use the i2c_device_id
parameter. Therefore remove it.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5fe1dd8..1121f4e 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -727,8 +727,7 @@ static const struct iio_info mpu_info = {
 /**
  *  inv_check_and_setup_chip() - check and setup chip.
  */
-static int inv_check_and_setup_chip(struct inv_mpu6050_state *st,
-		const struct i2c_device_id *id)
+static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 {
 	int result;
 
@@ -795,7 +794,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 	if (pdata)
 		st->plat_data = *pdata;
 	/* power is turned on inside check chip type*/
-	result = inv_check_and_setup_chip(st, id);
+	result = inv_check_and_setup_chip(st);
 	if (result)
 		return result;
 
-- 
1.9.1

