Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Ge Gao <GGao@invensense.com>
Subject: [PATCH 6/7] iio: inv_mpu6050: Check channel configuration on preenable
Date: Fri, 29 Apr 2016 22:02:35 +0300
Message-Id: <d1135276814b870a7b0e7e079e47c625b25c4ad9.1461953982.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461953982.git.leonard.crestez@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461953982.git.leonard.crestez@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Right now it is possible to only enable some of the x/y/z channels, for
example you can enable accel_z without x or y. If you actually do that
what you get is actually only the x channel.

In theory the device supports selecting gyro x/y/z channels
individually. It would also be possible to selectively enable x/y/z
accel by unpacking the data read from the hardware into a format the iio
core accepts.

It is easier to simply refuse incorrect configuration.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  4 ++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 31 ++++++++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 064fc07..712e901 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1130,7 +1130,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	result = iio_triggered_buffer_setup(indio_dev,
 					    inv_mpu6050_irq_handler,
 					    inv_mpu6050_read_fifo,
-					    NULL);
+					    &inv_mpu_buffer_ops);
 	if (result) {
 		dev_err(dev, "configure buffer fail %d\n", result);
 		return result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 9d15633..9d406df 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -284,6 +284,9 @@ enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_TIMESTAMP,
 };
 
+#define INV_MPU6050_SCAN_MASK_ACCEL	0x07
+#define INV_MPU6050_SCAN_MASK_GYRO	0x38
+
 enum inv_mpu6050_filter_e {
 	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
 	INV_MPU6050_FILTER_188HZ,
@@ -340,3 +343,4 @@ int inv_mpu_core_remove(struct device *dev);
 int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
 extern const struct dev_pm_ops inv_mpu_pmops;
 extern const struct regmap_config inv_mpu_regmap_config;
+extern const struct iio_buffer_setup_ops inv_mpu_buffer_ops;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 56ee1e2..e8bda7f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -222,3 +222,34 @@ flush_fifo:
 
 	return IRQ_HANDLED;
 }
+
+/* Validate channels are set in a correct configuration */
+static int inv_mpu_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	unsigned long mask = *indio_dev->active_scan_mask;
+
+	if ((mask & INV_MPU6050_SCAN_MASK_GYRO) &&
+	    (mask & INV_MPU6050_SCAN_MASK_GYRO) != INV_MPU6050_SCAN_MASK_GYRO)
+	{
+		dev_warn(regmap_get_device(st->map),
+			 "Gyro channels can only be enabled together\n");
+		return -EINVAL;
+	}
+
+	if ((mask & INV_MPU6050_SCAN_MASK_ACCEL) &&
+	    (mask & INV_MPU6050_SCAN_MASK_ACCEL) != INV_MPU6050_SCAN_MASK_ACCEL)
+	{
+		dev_warn(regmap_get_device(st->map),
+			 "Accel channels can only be enabled together\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+const struct iio_buffer_setup_ops inv_mpu_buffer_ops = {
+	.preenable = inv_mpu_buffer_preenable,
+	.postenable = iio_triggered_buffer_postenable,
+	.predisable = iio_triggered_buffer_predisable,
+};
-- 
2.5.5
