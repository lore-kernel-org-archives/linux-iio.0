Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63374 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbaHVUsL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Aug 2014 16:48:11 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1 7/8] iio: inv_mpu6050: Fix indio_dev->trig assignment
Date: Fri, 22 Aug 2014 13:48:35 -0700
Message-Id: <1408740516-31261-8-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This can result in wrong reference count for trigger device, call
iio_trigger_get to increment reference.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 03b9372..926fcce 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -135,7 +135,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	ret = iio_trigger_register(st->trig);
 	if (ret)
 		goto error_free_irq;
-	indio_dev->trig = st->trig;
+	indio_dev->trig = iio_trigger_get(st->trig);
 
 	return 0;
 
-- 
1.9.3

