Return-Path: <SRS0=/wsa=AS=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	devicetree@vger.kernel.org
Subject: [PATCH 1/4] iio: st_sensors: split open-drain parameters for irq1 and irq2
Date: Sun, 17 Sep 2017 18:17:09 +0200
Message-Id: <20170917161712.14645-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170917161712.14645-1-lorenzo.bianconi@st.com>
References: <20170917161712.14645-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Define st_sensor_int_drdy structure in st_sensor_data_ready_irq in order
to contain irq line parameters of the device.
Moreover separate data-ready open-drain configuration parameters for INT1
and INT2 pins in st_sensor_data_ready_irq data structure.
That change will be used to properly support LIS3DHH accel sensor.

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/accel/st_accel_core.c               | 18 ++++++++++------
 drivers/iio/common/st_sensors/st_sensors_core.c | 21 ++++++++++++++-----
 drivers/iio/pressure/st_pressure_core.c         | 14 +++++++------
 include/linux/iio/common/st_sensors.h           | 28 ++++++++++++++-----------
 4 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 731ec3a4c82b..c88db25a1aff 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -236,15 +236,17 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.int1 = {
 				.addr = 0x22,
 				.mask = 0x02,
+				.addr_od = 0x22,
+				.mask_od = 0x40,
 			},
 			.int2 = {
 				.addr = 0x22,
 				.mask = 0x10,
+				.addr_od = 0x22,
+				.mask_od = 0x40,
 			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
-			.addr_od = 0x22,
-			.mask_od = 0x40,
 			.stat_drdy = {
 				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
 				.mask = 0x07,
@@ -468,15 +470,17 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.int1 = {
 				.addr = 0x22,
 				.mask = 0x04,
+				.addr_od = 0x22,
+				.mask_od = 0x40,
 			},
 			.int2 = {
 				.addr = 0x22,
 				.mask = 0x20,
+				.addr_od = 0x22,
+				.mask_od = 0x40,
 			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
-			.addr_od = 0x22,
-			.mask_od = 0x40,
 			.stat_drdy = {
 				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
 				.mask = 0x07,
@@ -750,15 +754,17 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.int1 = {
 				.addr = 0x23,
 				.mask = 0x01,
+				.addr_od = 0x22,
+				.mask_od = 0x20,
 			},
 			.int2 = {
 				.addr = 0x24,
 				.mask = 0x01,
+				.addr_od = 0x22,
+				.mask_od = 0x20,
 			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x08,
-			.addr_od = 0x22,
-			.mask_od = 0x20,
 			.stat_drdy = {
 				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
 				.mask = 0x01,
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 6657160b5a73..40dfdfc0906b 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -319,7 +319,8 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 	}
 
 	if (pdata->open_drain) {
-		if (!sdata->sensor_settings->drdy_irq.addr_od)
+		if (!sdata->sensor_settings->drdy_irq.int1.addr_od &&
+		    !sdata->sensor_settings->drdy_irq.int2.addr_od)
 			dev_err(&indio_dev->dev,
 				"open drain requested but unsupported.\n");
 		else
@@ -446,11 +447,21 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 	}
 
 	if (sdata->int_pin_open_drain) {
+		u8 addr, mask;
+
+		if (sdata->drdy_int_pin == 1) {
+			addr = sdata->sensor_settings->drdy_irq.int1.addr_od;
+			mask = sdata->sensor_settings->drdy_irq.int1.mask_od;
+		} else {
+			addr = sdata->sensor_settings->drdy_irq.int2.addr_od;
+			mask = sdata->sensor_settings->drdy_irq.int2.mask_od;
+		}
+
 		dev_info(&indio_dev->dev,
-			 "set interrupt line to open drain mode\n");
-		err = st_sensors_write_data_with_mask(indio_dev,
-				sdata->sensor_settings->drdy_irq.addr_od,
-				sdata->sensor_settings->drdy_irq.mask_od, 1);
+			 "set interrupt line to open drain mode on pin %d\n",
+			 sdata->drdy_int_pin);
+		err = st_sensors_write_data_with_mask(indio_dev, addr,
+						      mask, 1);
 		if (err < 0)
 			return err;
 	}
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 15ad6054d9f6..349e5c713c03 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -283,15 +283,17 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.int1 = {
 				.addr = 0x22,
 				.mask = 0x04,
+				.addr_od = 0x22,
+				.mask_od = 0x40,
 			},
 			.int2 = {
 				.addr = 0x22,
 				.mask = 0x20,
+				.addr_od = 0x22,
+				.mask_od = 0x40,
 			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
-			.addr_od = 0x22,
-			.mask_od = 0x40,
 			.stat_drdy = {
 				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
 				.mask = 0x03,
@@ -404,11 +406,11 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.int1 = {
 				.addr = 0x23,
 				.mask = 0x01,
+				.addr_od = 0x22,
+				.mask_od = 0x40,
 			},
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
-			.addr_od = 0x22,
-			.mask_od = 0x40,
 			.stat_drdy = {
 				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
 				.mask = 0x03,
@@ -473,11 +475,11 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.int1 = {
 				.addr = 0x12,
 				.mask = 0x04,
+				.addr_od = 0x12,
+				.mask_od = 0x40,
 			},
 			.addr_ihl = 0x12,
 			.mask_ihl = 0x80,
-			.addr_od = 0x12,
-			.mask_od = 0x40,
 			.stat_drdy = {
 				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
 				.mask = 0x03,
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index e6c646d5d6d4..f9bd6e8ab138 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -130,32 +130,36 @@ struct st_sensor_das {
 	u8 mask;
 };
 
+/**
+ * struct st_sensor_int_drdy - ST sensor device drdy line parameters
+ * @addr: address of INT drdy register.
+ * @mask: mask to enable drdy line.
+ * @addr_od: address to enable/disable Open Drain on the INT line.
+ * @mask_od: mask to enable/disable Open Drain on the INT line.
+ */
+struct st_sensor_int_drdy {
+	u8 addr;
+	u8 mask;
+	u8 addr_od;
+	u8 mask_od;
+};
+
 /**
  * struct st_sensor_data_ready_irq - ST sensor device data-ready interrupt
  * struct int1 - data-ready configuration register for INT1 pin.
  * struct int2 - data-ready configuration register for INT2 pin.
  * @addr_ihl: address to enable/disable active low on the INT lines.
  * @mask_ihl: mask to enable/disable active low on the INT lines.
- * @addr_od: address to enable/disable Open Drain on the INT lines.
- * @mask_od: mask to enable/disable Open Drain on the INT lines.
  * struct stat_drdy - status register of DRDY (data ready) interrupt.
  * struct ig1 - represents the Interrupt Generator 1 of sensors.
  * @en_addr: address of the enable ig1 register.
  * @en_mask: mask to write the on/off value for enable.
  */
 struct st_sensor_data_ready_irq {
-	struct {
-		u8 addr;
-		u8 mask;
-	} int1;
-	struct {
-		u8 addr;
-		u8 mask;
-	} int2;
+	struct st_sensor_int_drdy int1;
+	struct st_sensor_int_drdy int2;
 	u8 addr_ihl;
 	u8 mask_ihl;
-	u8 addr_od;
-	u8 mask_od;
 	struct {
 		u8 addr;
 		u8 mask;
-- 
2.14.1
