Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28439 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936157AbcCQQad (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 17 Mar 2016 12:30:33 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, matt.ranostay@intel.com,
	lucas.demarchi@intel.com, cmo@melexis.com,
	linux-iio@vger.kernel.org, ggao@invensense.com,
	srinivas.pandruvada@linux.intel.com, adi.reus@gmail.com
Subject: [PATCH 2/3] iio: imu: mpu6050: Move request IRQ outside of probe trigger
Date: Thu, 17 Mar 2016 18:32:45 +0200
Message-Id: <1458232366-12773-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Besides signalling data ready, IRQ line of Invensense MPU
can also signal the status of slaves attached on secondary
I2C bus.

In order to prepare supporting secondary I2C interface we need
to detach IRQ request from data ready trigger creation.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 8 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index d192953..659a4be 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -823,6 +823,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		goto out_unreg_ring;
 	}
 
+	result = devm_request_irq(&indio_dev->dev, st->irq,
+				  &iio_trigger_generic_data_rdy_poll,
+				  IRQF_TRIGGER_RISING, "inv_mpu", st->trig);
+	if (result) {
+		dev_err(dev, "request irq fail %d\n", result);
+		goto out_remove_trigger;
+	}
+
 	INIT_KFIFO(st->timestamps);
 	spin_lock_init(&st->time_stamp_lock);
 	result = iio_device_register(indio_dev);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index e8818d4..acfa513 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -123,14 +123,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = devm_request_irq(&indio_dev->dev, st->irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_TRIGGER_RISING,
-			       "inv_mpu",
-			       st->trig);
-	if (ret)
-		return ret;
-
 	st->trig->dev.parent = regmap_get_device(st->map);
 	st->trig->ops = &inv_mpu_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
-- 
2.5.0

