Return-Path: <SRS0=gZRN=YN=linaro.org=linus.walleij@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Lorenzo Bianconi <lorenzo.bianconi@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio: accel: st_accel: fix LIS3LV02 reading and scaling
Date: Fri, 30 Dec 2016 23:54:18 +0100
Message-Id: <20161230225418.11733-1-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The LIS3LV02 has a special bit that need to be set to get the
read values left aligned. Before this patch we get gibberish
like this:

iio_generic_buffer -a -c10 -n lis3lv02dl_accel
(...)
0.000000 -0.010042 -0.642688 19155832931907
0.000000 -0.010042 -0.642688 19155858751073

Which is because we read a raw value for 1g as 64 which is
the nominal 1024 for 1g shifted 4 bits to the left by being
right-aligned rather than left aligned.

Since all other sensors are left aligned, add some code to
set the special DAS (data alignment setting) bit to 1 so that
the right value is now read like this:

iio_generic_buffer -a -c10 -n lis3lv02dl_accel
(...)
0.000000 -0.147095 -10.120135 24761614364956
-0.029419 -0.176514 -10.120135 24761631624540

The scaling was weird as well: we have a gain of 1000 for 1g
and 3000 for 6g. I don't even remember how I came up with the
old values but they are wrong.

Fixes: 3acddf74f807 ("iio: st-sensors: add support for lis3lv02d accelerometer")
Cc: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I wouldn't bother with stable-tagging this, but queueuing for
fixes would be nice. I plan to phase over the old misc driver
to this later.
---
 drivers/iio/accel/st_accel_core.c               | 12 ++++++++++--
 drivers/iio/common/st_sensors/st_sensors_core.c |  9 +++++++++
 include/linux/iio/common/st_sensors.h           | 12 ++++++++++++
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index f6b6d42385e1..784670e2736b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -353,12 +353,12 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 				[0] = {
 					.num = ST_ACCEL_FS_AVL_2G,
 					.value = 0x00,
-					.gain = IIO_G_TO_M_S_2(1024),
+					.gain = IIO_G_TO_M_S_2(1000),
 				},
 				[1] = {
 					.num = ST_ACCEL_FS_AVL_6G,
 					.value = 0x01,
-					.gain = IIO_G_TO_M_S_2(340),
+					.gain = IIO_G_TO_M_S_2(3000),
 				},
 			},
 		},
@@ -366,6 +366,14 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.addr = 0x21,
 			.mask = 0x40,
 		},
+		/*
+		 * Data Alignment Setting - needs to be set to get
+		 * left-justified data like all other sensors.
+		 */
+		.das = {
+			.addr = 0x21,
+			.mask = 0x01,
+		},
 		.drdy_irq = {
 			.addr = 0x21,
 			.mask_int1 = 0x04,
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index d5cf7f31eaf9..79c8c7cd70d5 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -401,6 +401,15 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 			return err;
 	}
 
+	/* set DAS */
+	if (sdata->sensor_settings->das.addr) {
+		err = st_sensors_write_data_with_mask(indio_dev,
+					sdata->sensor_settings->das.addr,
+					sdata->sensor_settings->das.mask, 1);
+		if (err < 0)
+			return err;
+	}
+
 	if (sdata->int_pin_open_drain) {
 		dev_info(&indio_dev->dev,
 			 "set interrupt line to open drain mode\n");
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 228bd44efa4c..497f2b3a5a62 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -116,6 +116,16 @@ struct st_sensor_bdu {
 };
 
 /**
+ * struct st_sensor_das - ST sensor device data alignment selection
+ * @addr: address of the register.
+ * @mask: mask to write the das flag for left alignment.
+ */
+struct st_sensor_das {
+	u8 addr;
+	u8 mask;
+};
+
+/**
  * struct st_sensor_data_ready_irq - ST sensor device data-ready interrupt
  * @addr: address of the register.
  * @mask_int1: mask to enable/disable IRQ on INT1 pin.
@@ -185,6 +195,7 @@ struct st_sensor_transfer_function {
  * @enable_axis: Enable one or more axis of the sensor.
  * @fs: Full scale register and full scale list available.
  * @bdu: Block data update register.
+ * @das: Data Alignment Selection register.
  * @drdy_irq: Data ready register of the sensor.
  * @multi_read_bit: Use or not particular bit for [I2C/SPI] multi-read.
  * @bootime: samples to discard when sensor passing from power-down to power-up.
@@ -200,6 +211,7 @@ struct st_sensor_settings {
 	struct st_sensor_axis enable_axis;
 	struct st_sensor_fullscale fs;
 	struct st_sensor_bdu bdu;
+	struct st_sensor_das das;
 	struct st_sensor_data_ready_irq drdy_irq;
 	bool multi_read_bit;
 	unsigned int bootime;
-- 
2.9.3
