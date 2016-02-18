Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:32180 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426612AbcBRPvU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Feb 2016 10:51:20 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	adi.reus@gmail.com, cmo@melexis.com, mwelling@ieee.org
Subject: [RFC PATCH 6/9] iio: imu: inv_mpu6050: Fix code indent for if statement
Date: Thu, 18 Feb 2016 17:53:11 +0200
Message-Id: <1455810794-3188-7-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This fixes the following checkpatch.pl warning:

WARNING: suspect code indent for conditional statements (8, 24)
+       if (kfifo_len(&st->timestamps) >
[...]
+                       goto flush_fifo;

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 441080b..0bc5091 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -158,8 +158,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		goto flush_fifo;
 	/* Timestamp mismatch. */
 	if (kfifo_len(&st->timestamps) >
-		fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
-			goto flush_fifo;
+	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
+		goto flush_fifo;
 	while (fifo_count >= bytes_per_datum) {
 		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
 					  data, bytes_per_datum);
-- 
2.5.0

