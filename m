Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37565 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753465AbdHQRhf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Aug 2017 13:37:35 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com, devicetree@vger.kernel.org
Subject: [PATCH v2 1/5] iio: st_sensors: decouple irq1 configuration parameters from the irq2 ones
Date: Thu, 17 Aug 2017 19:37:25 +0200
Message-Id: <20170817173729.10899-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170817173729.10899-1-lorenzo.bianconi@st.com>
References: <20170817173729.10899-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Separate data-ready configuration parameters for INT1 and INT2 pins in
st_sensor_data_ready_irq data structure. That change will be use to
properly support LIS2DW12 accel sensor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel_core.c               | 66 ++++++++++++++++---------
 drivers/iio/common/st_sensors/st_sensors_core.c | 28 ++++++-----
 drivers/iio/gyro/st_gyro_core.c                 | 18 ++++---
 drivers/iio/magnetometer/st_magn_core.c         |  6 ++-
 drivers/iio/pressure/st_pressure_core.c         | 31 +++++++-----
 include/linux/iio/common/st_sensors.h           | 16 +++---
 6 files changed, 104 insertions(+), 61 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 752856b3a849..9fac5a41bacd 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -159,9 +159,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask = 0x80,
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int1 = 0x10,
-			.mask_int2 = 0x00,
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
 			.addr_ihl = 0x25,
 			.mask_ihl = 0x02,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
@@ -229,9 +230,14 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask = 0x80,
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int1 = 0x02,
-			.mask_int2 = 0x10,
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x02,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
 			.addr_od = 0x22,
@@ -313,9 +319,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask = 0x08,
 		},
 		.drdy_irq = {
-			.addr = 0x23,
-			.mask_int1 = 0x80,
-			.mask_int2 = 0x00,
+			.int1 = {
+				.addr = 0x23,
+				.mask = 0x80,
+			},
 			.addr_ihl = 0x23,
 			.mask_ihl = 0x40,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
@@ -387,8 +394,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask = 0x01,
 		},
 		.drdy_irq = {
-			.addr = 0x21,
-			.mask_int1 = 0x04,
+			.int1 = {
+				.addr = 0x21,
+				.mask = 0x04,
+			},
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.sim = {
@@ -444,9 +453,14 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			},
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int1 = 0x04,
-			.mask_int2 = 0x20,
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x04,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x20,
+			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
 			.addr_od = 0x22,
@@ -513,9 +527,14 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask = 0x80,
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int1 = 0x02,
-			.mask_int2 = 0x10,
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x02,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
 		},
@@ -567,8 +586,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.bdu = {
 		},
 		.drdy_irq = {
-			.addr = 0x21,
-			.mask_int1 = 0x04,
+			.int1 = {
+				.addr = 0x21,
+				.mask = 0x04,
+			},
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.sim = {
@@ -635,9 +656,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			},
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int1 = 0x10,
-			.mask_int2 = 0x00,
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x10,
+			},
 			.addr_ihl = 0x25,
 			.mask_ihl = 0x02,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index d99bb1460fe2..a26217b0604f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -283,7 +283,8 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	/* Sensor does not support interrupts */
-	if (sdata->sensor_settings->drdy_irq.addr == 0) {
+	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
+	    !sdata->sensor_settings->drdy_irq.int2.addr) {
 		if (pdata->drdy_int_pin)
 			dev_info(&indio_dev->dev,
 				 "DRDY on pin INT%d specified, but sensor "
@@ -294,7 +295,7 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 
 	switch (pdata->drdy_int_pin) {
 	case 1:
-		if (sdata->sensor_settings->drdy_irq.mask_int1 == 0) {
+		if (!sdata->sensor_settings->drdy_irq.int1.mask) {
 			dev_err(&indio_dev->dev,
 					"DRDY on INT1 not available.\n");
 			return -EINVAL;
@@ -302,7 +303,7 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 		sdata->drdy_int_pin = 1;
 		break;
 	case 2:
-		if (sdata->sensor_settings->drdy_irq.mask_int2 == 0) {
+		if (!sdata->sensor_settings->drdy_irq.int2.mask) {
 			dev_err(&indio_dev->dev,
 					"DRDY on INT2 not available.\n");
 			return -EINVAL;
@@ -460,10 +461,11 @@ EXPORT_SYMBOL(st_sensors_init_sensor);
 int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 {
 	int err;
-	u8 drdy_mask;
+	u8 drdy_addr, drdy_mask;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	if (!sdata->sensor_settings->drdy_irq.addr)
+	if (!sdata->sensor_settings->drdy_irq.int1.addr &&
+	    !sdata->sensor_settings->drdy_irq.int2.addr)
 		return 0;
 
 	/* Enable/Disable the interrupt generator 1. */
@@ -476,18 +478,20 @@ int st_sensors_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
 			goto st_accel_set_dataready_irq_error;
 	}
 
-	if (sdata->drdy_int_pin == 1)
-		drdy_mask = sdata->sensor_settings->drdy_irq.mask_int1;
-	else
-		drdy_mask = sdata->sensor_settings->drdy_irq.mask_int2;
+	if (sdata->drdy_int_pin == 1) {
+		drdy_addr = sdata->sensor_settings->drdy_irq.int1.addr;
+		drdy_mask = sdata->sensor_settings->drdy_irq.int1.mask;
+	} else {
+		drdy_addr = sdata->sensor_settings->drdy_irq.int2.addr;
+		drdy_mask = sdata->sensor_settings->drdy_irq.int2.mask;
+	}
 
 	/* Flag to the poll function that the hardware trigger is in use */
 	sdata->hw_irq_trigger = enable;
 
 	/* Enable/Disable the interrupt generator for data ready. */
-	err = st_sensors_write_data_with_mask(indio_dev,
-					sdata->sensor_settings->drdy_irq.addr,
-					drdy_mask, (int)enable);
+	err = st_sensors_write_data_with_mask(indio_dev, drdy_addr,
+					      drdy_mask, (int)enable);
 
 st_accel_set_dataready_irq_error:
 	return err;
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index e366422e8512..764306378b20 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -111,8 +111,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 			.mask = 0x80,
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int2 = 0x08,
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x08,
+			},
 			/*
 			 * The sensor has IHL (active low) and open
 			 * drain settings, but only for INT1 and not
@@ -181,8 +183,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 			.mask = 0x80,
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int2 = 0x08,
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x08,
+			},
 			/*
 			 * The sensor has IHL (active low) and open
 			 * drain settings, but only for INT1 and not
@@ -246,8 +250,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 			.mask = 0x80,
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int2 = 0x08,
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x08,
+			},
 			/*
 			 * The sensor has IHL (active low) and open
 			 * drain settings, but only for INT1 and not
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index e68368b5b2a3..2c465cbe3b0a 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -355,8 +355,10 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 			.mask = 0x10,
 		},
 		.drdy_irq = {
-			.addr = 0x62,
-			.mask_int1 = 0x01,
+			.int1 = {
+				.addr = 0x62,
+				.mask = 0x01,
+			},
 			.addr_stat_drdy = 0x67,
 		},
 		.multi_read_bit = false,
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index c84eea73b3ae..240fa9f3ee3b 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -280,9 +280,14 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.mask = 0x04,
 		},
 		.drdy_irq = {
-			.addr = 0x22,
-			.mask_int1 = 0x04,
-			.mask_int2 = 0x20,
+			.int1 = {
+				.addr = 0x22,
+				.mask = 0x04,
+			},
+			.int2 = {
+				.addr = 0x22,
+				.mask = 0x20,
+			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
 			.addr_od = 0x22,
@@ -335,9 +340,6 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.addr = 0x20,
 			.mask = 0x04,
 		},
-		.drdy_irq = {
-			.addr = 0,
-		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -388,9 +390,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.mask = 0x04,
 		},
 		.drdy_irq = {
-			.addr = 0x23,
-			.mask_int1 = 0x01,
-			.mask_int2 = 0x00,
+			.int1 = {
+				.addr = 0x23,
+				.mask = 0x01,
+			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
 			.addr_od = 0x22,
@@ -447,9 +450,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.mask = 0x02,
 		},
 		.drdy_irq = {
-			.addr = 0x12,
-			.mask_int1 = 0x04,
-			.mask_int2 = 0x00,
+			.int1 = {
+				.addr = 0x12,
+				.mask = 0x04,
+			},
 			.addr_ihl = 0x12,
 			.mask_ihl = 0x80,
 			.addr_od = 0x12,
@@ -605,7 +609,8 @@ int st_press_common_probe(struct iio_dev *indio_dev)
 	press_data->odr = press_data->sensor_settings->odr.odr_avl[0].hz;
 
 	/* Some devices don't support a data ready pin. */
-	if (!pdata && press_data->sensor_settings->drdy_irq.addr)
+	if (!pdata && (press_data->sensor_settings->drdy_irq.int1.addr ||
+		       press_data->sensor_settings->drdy_irq.int2.addr))
 		pdata =	(struct st_sensors_platform_data *)&default_press_pdata;
 
 	err = st_sensors_init_sensor(indio_dev, press_data->dev->platform_data);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 7b0fa8b5c120..ac3aa89518ca 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -132,9 +132,8 @@ struct st_sensor_das {
 
 /**
  * struct st_sensor_data_ready_irq - ST sensor device data-ready interrupt
- * @addr: address of the register.
- * @mask_int1: mask to enable/disable IRQ on INT1 pin.
- * @mask_int2: mask to enable/disable IRQ on INT2 pin.
+ * struct int1 - data-ready configuration register for INT1 pin.
+ * struct int2 - data-ready configuration register for INT2 pin.
  * @addr_ihl: address to enable/disable active low on the INT lines.
  * @mask_ihl: mask to enable/disable active low on the INT lines.
  * @addr_od: address to enable/disable Open Drain on the INT lines.
@@ -145,9 +144,14 @@ struct st_sensor_das {
  * @en_mask: mask to write the on/off value for enable.
  */
 struct st_sensor_data_ready_irq {
-	u8 addr;
-	u8 mask_int1;
-	u8 mask_int2;
+	struct {
+		u8 addr;
+		u8 mask;
+	} int1;
+	struct {
+		u8 addr;
+		u8 mask;
+	} int2;
 	u8 addr_ihl;
 	u8 mask_ihl;
 	u8 addr_od;
-- 
2.14.0

