Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0058.outbound.protection.outlook.com ([104.47.42.58]:43075
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbeDFST7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Apr 2018 14:19:59 -0400
From: Martin Kelly <mkelly@xevo.com>
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        Martin Kelly <mkelly@xevo.com>
Subject: [PATCH v2 1/2] iio:imu: inv_mpu6050: support more interrupt types
Date: Fri,  6 Apr 2018 11:19:41 -0700
Message-Id: <20180406181942.1365-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently, we support only rising edge interrupts, and in fact we assume
that the interrupt we're given is rising edge (and things won't work if
it's not). However, the device supports rising edge, falling edge, level
low, and level high interrupts.

Empirically, on my system, switching to level interrupts has fixed a
problem I had with significant (~40%) interrupt loss with edge
interrupts, as well as bus errors at high frequencies (possibly a
concurrency issue, which I will look into separately). This issue is
likely related to the SoC I'm using (Allwinner H3), but being able to
switch the interrupt type is still a very useful workaround.

I tested this with each interrupt type and verified correct behavior in
a logic analyzer.

Add support for these interrupt types while also eliminating the error
case of the device tree and driver using different interrupt types.

Signed-off-by: Martin Kelly <mkelly@xevo.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 36 +++++++++++++++++++++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  5 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     | 12 ++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 14 ++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  2 +-
 5 files changed, 63 insertions(+), 6 deletions(-)

v2:
- Changed to ACK level interrupts at the start of the bottom half thread instead
  of at the end of it. Without this, the sample timestamps get distorted because
  the time to handle the bottom half thread delays future interrupts. With this
  change, the timestamps appear evenly distributed at the right frequency.

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 7d64be353403..869768d08802 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -24,6 +24,7 @@
 #include <linux/spinlock.h>
 #include <linux/iio/iio.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include "inv_mpu_iio.h"
 
 /*
@@ -52,6 +53,7 @@ static const struct inv_mpu6050_reg_map reg_set_6500 = {
 	.raw_accl               = INV_MPU6050_REG_RAW_ACCEL,
 	.temperature            = INV_MPU6050_REG_TEMPERATURE,
 	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
+	.int_status             = INV_MPU6050_REG_INT_STATUS,
 	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
 	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
 	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
@@ -281,6 +283,10 @@ static int inv_mpu6050_init_config(struct iio_dev *indio_dev)
 	memcpy(&st->chip_config, hw_info[st->chip_type].config,
 	       sizeof(struct inv_mpu6050_chip_config));
 	result = inv_mpu6050_set_power_itg(st, false);
+	if (result)
+		return result;
+
+	result = regmap_write(st->map, st->reg->int_pin_cfg, st->irq_mask);
 
 	return result;
 }
@@ -882,6 +888,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	struct inv_mpu6050_platform_data *pdata;
 	struct device *dev = regmap_get_device(regmap);
 	int result;
+	struct irq_data *desc;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
@@ -913,6 +920,35 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		st->plat_data = *pdata;
 	}
 
+	desc = irq_get_irq_data(irq);
+	if (!desc) {
+		dev_err(dev, "Could not find IRQ %d\n", irq);
+		return -EBUSY;
+	}
+
+	st->irq_type = irqd_get_trigger_type(desc);
+	if (st->irq_type == IRQF_TRIGGER_RISING) {
+		st->irq_mask = INV_MPU6050_ACTIVE_HIGH |
+				INV_MPU6050_EDGE_TRIGGERED;
+		st->irq_level_triggered = false;
+	} else if (st->irq_type == IRQF_TRIGGER_FALLING) {
+		st->irq_mask = INV_MPU6050_ACTIVE_LOW |
+				INV_MPU6050_EDGE_TRIGGERED;
+		st->irq_level_triggered = false;
+	} else if (st->irq_type == IRQF_TRIGGER_HIGH) {
+		st->irq_mask = INV_MPU6050_ACTIVE_HIGH |
+				INV_MPU6050_LEVEL_TRIGGERED;
+		st->irq_level_triggered = true;
+	} else if (st->irq_type == IRQF_TRIGGER_LOW) {
+		st->irq_mask = INV_MPU6050_ACTIVE_LOW |
+				INV_MPU6050_LEVEL_TRIGGERED;
+		st->irq_level_triggered = true;
+	} else {
+		dev_err(dev, "Invalid interrupt type 0x%x specified\n",
+			st->irq_type);
+		return -EBUSY;
+	}
+
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st);
 	if (result)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index fcd7a92b6cf8..bb3064537943 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -44,8 +44,7 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 	if (!ret) {
 		st->powerup_count++;
 		ret = regmap_write(st->map, st->reg->int_pin_cfg,
-				   INV_MPU6050_INT_PIN_CFG |
-				   INV_MPU6050_BIT_BYPASS_EN);
+			   st->irq_mask | INV_MPU6050_BIT_BYPASS_EN);
 	}
 write_error:
 	mutex_unlock(&st->lock);
@@ -60,7 +59,7 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_core *muxc, u32 chan_id)
 
 	mutex_lock(&st->lock);
 	/* It doesn't really mattter, if any of the calls fails */
-	regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU6050_INT_PIN_CFG);
+	regmap_write(st->map, st->reg->int_pin_cfg, 0);
 	st->powerup_count--;
 	if (!st->powerup_count)
 		regmap_write(st->map, st->reg->pwr_mgmt_1,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 065794162d65..2822b638804f 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -40,6 +40,7 @@
  *  @raw_accl:		Address of first accel register.
  *  @temperature:	temperature register
  *  @int_enable:	Interrupt enable register.
+ *  @int_status:	Interrupt status register.
  *  @pwr_mgmt_1:	Controls chip's power state and clock source.
  *  @pwr_mgmt_2:	Controls power state of individual sensors.
  *  @int_pin_cfg;	Controls interrupt pin configuration.
@@ -60,6 +61,7 @@ struct inv_mpu6050_reg_map {
 	u8 raw_accl;
 	u8 temperature;
 	u8 int_enable;
+	u8 int_status;
 	u8 pwr_mgmt_1;
 	u8 pwr_mgmt_2;
 	u8 int_pin_cfg;
@@ -143,6 +145,9 @@ struct inv_mpu6050_state {
 	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
 	struct regmap *map;
 	int irq;
+	int irq_type;
+	u16 irq_mask;
+	bool irq_level_triggered;
 };
 
 /*register and associated bit definition*/
@@ -159,6 +164,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BITS_GYRO_OUT           0x70
 
 #define INV_MPU6050_REG_INT_ENABLE          0x38
+#define INV_MPU6050_REG_INT_STATUS          0x3a
 #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
 #define INV_MPU6050_BIT_DMP_INT_EN          0x02
 
@@ -190,6 +196,11 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_FIFO_COUNT_BYTE          2
 #define INV_MPU6050_FIFO_THRESHOLD           500
 
+#define INV_MPU6050_ACTIVE_HIGH             0x00
+#define INV_MPU6050_ACTIVE_LOW              0x80
+#define INV_MPU6050_EDGE_TRIGGERED          0x00
+#define INV_MPU6050_LEVEL_TRIGGERED         0x20
+
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
@@ -216,7 +227,6 @@ struct inv_mpu6050_state {
 
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_BIT_BYPASS_EN	0x2
-#define INV_MPU6050_INT_PIN_CFG		0
 
 /* init parameters */
 #define INV_MPU6050_INIT_FIFO_RATE           50
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index ff81c6aa009d..15bd36385f1d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -128,6 +128,14 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	s64 timestamp;
 
+	if (st->irq_level_triggered) {
+		result = regmap_read(st->map, st->reg->int_status,
+				(int *) data);
+		if (result)
+			dev_err(regmap_get_device(st->map),
+				"failed to ack interrupt\n");
+	}
+
 	mutex_lock(&st->lock);
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable))
@@ -181,7 +189,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
-	return IRQ_HANDLED;
+	goto out;
 
 flush_fifo:
 	/* Flush HW and SW FIFOs. */
@@ -189,5 +197,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
 
+	/* Fall through */
+	return IRQ_HANDLED;
+
+out:
 	return IRQ_HANDLED;
 }
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index f963f9fc98c0..1e7201a43e34 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -131,7 +131,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 
 	ret = devm_request_irq(&indio_dev->dev, st->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_TRIGGER_RISING,
+			       st->irq_type,
 			       "inv_mpu",
 			       st->trig);
 	if (ret)
-- 
2.11.0

