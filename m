Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33311 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGESaG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jul 2017 14:30:06 -0400
Received: by mail-wm0-f67.google.com with SMTP id j85so34232003wmj.0
        for <linux-iio@vger.kernel.org>; Wed, 05 Jul 2017 11:30:05 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH v2] iio: accel: st_accel: add SPI-3wire support
Date: Wed,  5 Jul 2017 20:30:01 +0200
Message-Id: <20170705183001.24768-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add SPI Serial Interface Mode (SIM) register information
in st_sensor_settings look up table to support devices
(like LSM303AGR accel sensor) that allow just SPI-3wire
communication mode. SIM mode has to be configured before any
other operation since it is not enabled by default and the driver
is not able to read without that configuration

Fixes: ddc05fa28606 (iio: st-accel: add support for lsm303agr accel)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
Changes since v1:
- move SIM register information in st_sensor_settings look up table
- make st_sensors_init_interface_mode static and use name lookup
  performed by st_sensors_check_device_support
---
 drivers/iio/accel/st_accel_core.c               | 32 +++++++++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_core.c | 29 ++++++++++++++++++++++
 include/linux/iio/common/st_sensors.h           |  7 ++++++
 include/linux/platform_data/st_sensors_pdata.h  |  2 ++
 4 files changed, 70 insertions(+)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 07d1489cd457..e44f62bf9caa 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -166,6 +166,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_ihl = 0x02,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -234,6 +238,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_od = 0x40,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -316,6 +324,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 				.en_mask = 0x08,
 			},
 		},
+		.sim = {
+			.addr = 0x24,
+			.value = BIT(0),
+		},
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
@@ -379,6 +391,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_int1 = 0x04,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
+		.sim = {
+			.addr = 0x21,
+			.value = BIT(1),
+		},
 		.multi_read_bit = true,
 		.bootime = 2, /* guess */
 	},
@@ -437,6 +453,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_od = 0x40,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
+		.sim = {
+			.addr = 0x21,
+			.value = BIT(7),
+		},
 		.multi_read_bit = false,
 		.bootime = 2, /* guess */
 	},
@@ -499,6 +519,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.addr_ihl = 0x22,
 			.mask_ihl = 0x80,
 		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -547,6 +571,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_int1 = 0x04,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
+		.sim = {
+			.addr = 0x21,
+			.value = BIT(1),
+		},
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
@@ -614,6 +642,10 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_ihl = 0x02,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 274868100fd0..d99bb1460fe2 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -581,6 +581,31 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 }
 EXPORT_SYMBOL(st_sensors_read_info_raw);
 
+static int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
+			const struct st_sensor_settings *sensor_settings)
+{
+	struct st_sensor_data *sdata = iio_priv(indio_dev);
+	struct device_node *np = sdata->dev->of_node;
+	struct st_sensors_platform_data *pdata;
+
+	pdata = (struct st_sensors_platform_data *)sdata->dev->platform_data;
+	if (((np && of_property_read_bool(np, "spi-3wire")) ||
+	     (pdata && pdata->spi_3wire)) && sensor_settings->sim.addr) {
+		int err;
+
+		err = sdata->tf->write_byte(&sdata->tb, sdata->dev,
+					    sensor_settings->sim.addr,
+					    sensor_settings->sim.value);
+		if (err < 0) {
+			dev_err(&indio_dev->dev,
+				"failed to init interface mode\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 int st_sensors_check_device_support(struct iio_dev *indio_dev,
 			int num_sensors_list,
 			const struct st_sensor_settings *sensor_settings)
@@ -605,6 +630,10 @@ int st_sensors_check_device_support(struct iio_dev *indio_dev,
 		return -ENODEV;
 	}
 
+	err = st_sensors_init_interface_mode(indio_dev, &sensor_settings[i]);
+	if (err < 0)
+		return err;
+
 	if (sensor_settings[i].wai_addr) {
 		err = sdata->tf->read_byte(&sdata->tb, sdata->dev,
 					   sensor_settings[i].wai_addr, &wai);
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 1f8211b6438b..7b0fa8b5c120 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -105,6 +105,11 @@ struct st_sensor_fullscale {
 	struct st_sensor_fullscale_avl fs_avl[ST_SENSORS_FULLSCALE_AVL_MAX];
 };
 
+struct st_sensor_sim {
+	u8 addr;
+	u8 value;
+};
+
 /**
  * struct st_sensor_bdu - ST sensor device block data update
  * @addr: address of the register.
@@ -197,6 +202,7 @@ struct st_sensor_transfer_function {
  * @bdu: Block data update register.
  * @das: Data Alignment Selection register.
  * @drdy_irq: Data ready register of the sensor.
+ * @sim: SPI serial interface mode register of the sensor.
  * @multi_read_bit: Use or not particular bit for [I2C/SPI] multi-read.
  * @bootime: samples to discard when sensor passing from power-down to power-up.
  */
@@ -213,6 +219,7 @@ struct st_sensor_settings {
 	struct st_sensor_bdu bdu;
 	struct st_sensor_das das;
 	struct st_sensor_data_ready_irq drdy_irq;
+	struct st_sensor_sim sim;
 	bool multi_read_bit;
 	unsigned int bootime;
 };
diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index 79b0e4cdb814..f8274b0c6888 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -17,10 +17,12 @@
  *	Available only for accelerometer and pressure sensors.
  *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
  * @open_drain: set the interrupt line to be open drain if possible.
+ * @spi_3wire: enable spi-3wire mode.
  */
 struct st_sensors_platform_data {
 	u8 drdy_int_pin;
 	bool open_drain;
+	bool spi_3wire;
 };
 
 #endif /* ST_SENSORS_PDATA_H */
-- 
2.13.1

