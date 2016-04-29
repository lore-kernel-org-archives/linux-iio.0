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
Subject: [PATCH 2/7] iio: inv_mpu6050: Initial regcache support
Date: Fri, 29 Apr 2016 22:02:31 +0300
Message-Id: <f2950ebbb5468c8b7fbcfb8213ba9ebfd2133b8a.1461953982.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461953982.git.leonard.crestez@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461953982.git.leonard.crestez@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 47 ++++++++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  5 ----
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 ----
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b269b37..5918c23 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -116,6 +116,53 @@ static const struct inv_mpu6050_hw hw_info[] = {
 	},
 };
 
+static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
+{
+	if (reg >= INV_MPU6050_REG_RAW_ACCEL && reg < INV_MPU6050_REG_RAW_ACCEL + 6)
+		return true;
+	if (reg >= INV_MPU6050_REG_RAW_GYRO && reg < INV_MPU6050_REG_RAW_GYRO + 6)
+		return true;
+	switch (reg) {
+	case INV_MPU6050_REG_TEMPERATURE:
+	case INV_MPU6050_REG_TEMPERATURE + 1:
+	case INV_MPU6050_REG_USER_CTRL:
+	case INV_MPU6050_REG_PWR_MGMT_1:
+	case INV_MPU6050_REG_FIFO_COUNT_H:
+	case INV_MPU6050_REG_FIFO_COUNT_H + 1:
+	case INV_MPU6050_REG_FIFO_R_W:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool inv_mpu6050_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case INV_MPU6050_REG_FIFO_R_W:
+		return true;
+	default:
+		return false;
+	}
+}
+
+/*
+ * Common regmap config for inv_mpu devices
+ *
+ * The current volatile/precious registers are common among supported devices.
+ * When that changes the volatile/precious callbacks should go through the
+ * inv_mpu6050_reg_map structs.
+ */
+const struct regmap_config inv_mpu_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_reg = inv_mpu6050_volatile_reg,
+	.precious_reg = inv_mpu6050_precious_reg,
+};
+EXPORT_SYMBOL_GPL(inv_mpu_regmap_config);
+
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 {
 	unsigned int d, mgmt_1;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 1a424a6..1a8d1a5 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -20,11 +20,6 @@
 #include <linux/module.h>
 #include "inv_mpu_iio.h"
 
-static const struct regmap_config inv_mpu_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 /*
  * The i2c read/write needs to happen in unlocked mode. As the parent
  * adapter is common. If we use locked versions, it will fail as
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 47ca25b..297b0ef 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -291,3 +291,4 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 int inv_mpu_core_remove(struct device *dev);
 int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
 extern const struct dev_pm_ops inv_mpu_pmops;
+extern const struct regmap_config inv_mpu_regmap_config;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
index 190a4a5..b3bd977 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -17,11 +17,6 @@
 #include <linux/iio/iio.h>
 #include "inv_mpu_iio.h"
 
-static const struct regmap_config inv_mpu_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-
 static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-- 
2.5.5
