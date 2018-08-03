Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:33970 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727355AbeHCCMi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 2 Aug 2018 22:12:38 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Cc: jonathan@marek.ca, jmaneyrol@invensense.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mkelly@xevo.com,
        fischerdouglasc@gmail.com, bshah@kde.org, ctatlor97@gmail.com
Subject: [PATCH v3 1/9] iio: imu: mpu6050: add support for regulator framework
Date: Thu,  2 Aug 2018 20:18:52 -0400
Message-Id: <20180803001900.25371-2-masneyb@onstation.org>
In-Reply-To: <20180803001900.25371-1-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for the regulator framework to the mpu6050
driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Signed-off-by: Jonathan Marek <jonathan@marek.ca>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes since v2:
- Dropped regulator_enabled value since it is not needed.

Changes since v1:
- Use devm_regulator_get() instead of devm_regulator_get_optional()
- Use devm_add_action() for cleaning up the regulator.
- Correct ordering of resume code.
- Add regulator_enabled flag to ensure regulator is not disabled twice,
  specifically the case where the device is suspended and then the
  driver is removed.

Original extra changelog from v1:

This is a variation of Jonathan Marek's patch from postmarketOS
https://gitlab.com/postmarketOS/linux-postmarketos/commit/b8ad1ec1859c8bbcbce94944b3f4dd68f8f9fc37
with the following changes:

- Stripped out 6515 variant code.
- Add the regulator to the mpu core instead of only the i2c variant.
- Add error handling.
- Release the regulator on suspend, device remove, etc.
- Device tree documentation.

 .../bindings/iio/imu/inv_mpu6050.txt          |  1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 62 +++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 +
 3 files changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index b2f27da847b8..6ab9a9d196b0 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -20,6 +20,7 @@ Required properties:
   bindings.
 
 Optional properties:
+ - vddio-supply: regulator phandle for VDDIO supply
  - mount-matrix: an optional 3x3 mounting rotation matrix
  - i2c-gate node.  These devices also support an auxiliary i2c bus.  This is
    simple enough to be described using the i2c-gate binding. See
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index d80ef468508a..1e428c196a82 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -23,6 +23,7 @@
 #include <linux/iio/iio.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include "inv_mpu_iio.h"
 
 /*
@@ -926,6 +927,39 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	return result;
 }
 
+static int inv_mpu_core_enable_regulator(struct inv_mpu6050_state *st)
+{
+	int result;
+
+	result = regulator_enable(st->vddio_supply);
+	if (result) {
+		dev_err(regmap_get_device(st->map),
+			"Failed to enable regulator: %d\n", result);
+	} else {
+		/* Give the device a little bit of time to start up. */
+		usleep_range(35000, 70000);
+	}
+
+	return result;
+}
+
+static int inv_mpu_core_disable_regulator(struct inv_mpu6050_state *st)
+{
+	int result;
+
+	result = regulator_disable(st->vddio_supply);
+	if (result)
+		dev_err(regmap_get_device(st->map),
+			"Failed to disable regulator: %d\n", result);
+
+	return result;
+}
+
+static void inv_mpu_core_disable_regulator_action(void *_data)
+{
+	inv_mpu_core_disable_regulator(_data);
+}
+
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
 {
@@ -992,6 +1026,28 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		return -EINVAL;
 	}
 
+	st->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(st->vddio_supply)) {
+		if (PTR_ERR(st->vddio_supply) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get vddio regulator %d\n",
+				(int)PTR_ERR(st->vddio_supply));
+
+		return PTR_ERR(st->vddio_supply);
+	}
+
+	result = inv_mpu_core_enable_regulator(st);
+	if (result)
+		return result;
+
+	result = devm_add_action(dev, inv_mpu_core_disable_regulator_action,
+				 st);
+	if (result) {
+		inv_mpu_core_disable_regulator_action(st);
+		dev_err(dev, "Failed to setup regulator cleanup action %d\n",
+			result);
+		return result;
+	}
+
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st);
 	if (result)
@@ -1051,7 +1107,12 @@ static int inv_mpu_resume(struct device *dev)
 	int result;
 
 	mutex_lock(&st->lock);
+	result = inv_mpu_core_enable_regulator(st);
+	if (result)
+		goto out_unlock;
+
 	result = inv_mpu6050_set_power_itg(st, true);
+out_unlock:
 	mutex_unlock(&st->lock);
 
 	return result;
@@ -1064,6 +1125,7 @@ static int inv_mpu_suspend(struct device *dev)
 
 	mutex_lock(&st->lock);
 	result = inv_mpu6050_set_power_itg(st, false);
+	inv_mpu_core_disable_regulator(st);
 	mutex_unlock(&st->lock);
 
 	return result;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e69a59659dbc..6bcc11fc1b88 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -129,6 +129,7 @@ struct inv_mpu6050_hw {
  *  @chip_period:	chip internal period estimation (~1kHz).
  *  @it_timestamp:	timestamp from previous interrupt.
  *  @data_timestamp:	timestamp for next data sample.
+ *  @vddio_supply	voltage regulator for the chip.
  */
 struct inv_mpu6050_state {
 	struct mutex lock;
@@ -149,6 +150,7 @@ struct inv_mpu6050_state {
 	s64 chip_period;
 	s64 it_timestamp;
 	s64 data_timestamp;
+	struct regulator *vddio_supply;
 };
 
 /*register and associated bit definition*/
-- 
2.17.1

