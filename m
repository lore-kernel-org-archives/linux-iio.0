Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10020 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbcDSMYh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Apr 2016 08:24:37 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Giuseppe Barba <giuseppe.barba@st.com>
Subject: [RFC v2] iio: st_sensors: Add lsm9ds0-accel and lsm9ds0-magn support
Date: Tue, 19 Apr 2016 15:24:25 +0300
Message-Id: <9aff7fc834e3015d27fd1fb303803fa7586941f8.1461068089.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Because these devices shared the same I2C address/SPI chipselect they can't be
used at the same time.

The proper way to do this is as a single iio device but that requires
larger changes to st_sensors infrastructure.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---

I'm only posting this as a reference point. When a combo device is supported it
won't make sense to also support the -accel and -magn parts separately. So it
would be better if this support never makes it upstream.

Changes since v1:
* Fix ST_MAGN_4_DRDY_INT_MASK value
* Mention device ids are also mentioned in Kconfig

 .../devicetree/bindings/iio/st-sensors.txt         |   2 +
 drivers/iio/accel/Kconfig                          |   3 +-
 drivers/iio/accel/st_accel.h                       |   1 +
 drivers/iio/accel/st_accel_core.c                  | 122 ++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c                   |   5 +
 drivers/iio/accel/st_accel_spi.c                   |   1 +
 drivers/iio/magnetometer/Kconfig                   |   2 +-
 drivers/iio/magnetometer/st_magn.h                 |   1 +
 drivers/iio/magnetometer/st_magn_core.c            | 123 +++++++++++++++++++++
 drivers/iio/magnetometer/st_magn_i2c.c             |   5 +
 drivers/iio/magnetometer/st_magn_spi.c             |   1 +
 11 files changed, 264 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index 5844cf7..511c550 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -42,6 +42,7 @@ Accelerometers:
 - st,lsm303agr-accel
 - st,lis2dh12-accel
 - st,h3lis331dl-accel
+- st,lsm9ds0-accel
 
 Gyroscopes:
 - st,l3g4200d-gyro
@@ -59,6 +60,7 @@ Magnetometers:
 - st,lsm303dlhc-magn
 - st,lsm303dlm-magn
 - st,lis3mdl-magn
+- st,lsm9ds0-magn
 
 Pressure sensors:
 - st,lps001wp-press
diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index e4a758c..cbbed00 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -64,7 +64,8 @@ config IIO_ST_ACCEL_3AXIS
 	help
 	  Say yes here to build support for STMicroelectronics accelerometers:
 	  LSM303DLH, LSM303DLHC, LIS3DH, LSM330D, LSM330DL, LSM330DLC,
-	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL.
+	  LIS331DLH, LSM303DL, LSM303DLM, LSM330, LIS2DH12, H3LIS331DL,
+	  LSM9DS0.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 57f83a6..e90cd6a 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -29,6 +29,7 @@
 #define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
 #define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
 #define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
+#define LSM9DS0_ACCEL_DEV_NAME		"lsm9ds0_accel"
 
 /**
 * struct st_sensors_platform_data - default accel platform data
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index dc73f2d..ee4b373 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -215,6 +215,50 @@
 #define ST_ACCEL_6_IHL_IRQ_MASK			0x80
 #define ST_ACCEL_6_MULTIREAD_BIT		true
 
+/* CUSTOM VALUES FOR SENSOR 7 */
+#define ST_ACCEL_7_WAI_EXP			0x49
+#define ST_ACCEL_7_ODR_ADDR			0x20
+#define ST_ACCEL_7_ODR_MASK			0xf0
+#define ST_ACCEL_7_ODR_AVL_3HZ_VAL		0x01
+#define ST_ACCEL_7_ODR_AVL_6HZ_VAL		0x02
+#define ST_ACCEL_7_ODR_AVL_12HZ_VAL		0x03
+#define ST_ACCEL_7_ODR_AVL_25HZ_VAL		0x04
+#define ST_ACCEL_7_ODR_AVL_50HZ_VAL		0x05
+#define ST_ACCEL_7_ODR_AVL_100HZ_VAL		0x06
+#define ST_ACCEL_7_ODR_AVL_200HZ_VAL		0x07
+#define ST_ACCEL_7_ODR_AVL_400HZ_VAL		0x08
+#define ST_ACCEL_7_ODR_AVL_800HZ_VAL		0x09
+#define ST_ACCEL_7_ODR_AVL_1600HZ_VAL		0x0a
+#define ST_ACCEL_7_FS_ADDR			0x21
+#define ST_ACCEL_7_FS_MASK			0x38
+#define ST_ACCEL_7_FS_AVL_2_VAL			0x00
+#define ST_ACCEL_7_FS_AVL_4_VAL			0x01
+#define ST_ACCEL_7_FS_AVL_6_VAL			0x02
+#define ST_ACCEL_7_FS_AVL_8_VAL			0x03
+#define ST_ACCEL_7_FS_AVL_16_VAL		0x04
+#define ST_ACCEL_7_FS_AVL_2_GAIN		IIO_G_TO_M_S_2(61)
+#define ST_ACCEL_7_FS_AVL_4_GAIN		IIO_G_TO_M_S_2(122)
+#define ST_ACCEL_7_FS_AVL_6_GAIN		IIO_G_TO_M_S_2(183)
+#define ST_ACCEL_7_FS_AVL_8_GAIN		IIO_G_TO_M_S_2(244)
+#define ST_ACCEL_7_FS_AVL_16_GAIN		IIO_G_TO_M_S_2(732)
+#define ST_ACCEL_7_BDU_ADDR			0x20
+#define ST_ACCEL_7_BDU_MASK			0x08
+#define ST_ACCEL_7_DRDY_IRQ_ADDR		0x22
+#define ST_ACCEL_7_DRDY_IRQ_INT1_MASK		0x04
+/* INT2 is actually at another address. Not supported by driver */
+/*
+#define ST_ACCEL_7_DRDY_IRQ_INT2_ADDR		0x23
+#define ST_ACCEL_7_DRDY_IRQ_INT2_MASK		0x08
+ */
+/* Common to magnetometer so not supported */
+/*
+#define ST_ACCEL_7_IHL_IRQ_ADDR			0x12
+#define ST_ACCEL_7_IHL_IRQ_MASK			0x80
+ */
+#define ST_ACCEL_7_IG1_EN_ADDR			0x22
+#define ST_ACCEL_7_IG1_EN_MASK			0x20
+#define ST_ACCEL_7_MULTIREAD_BIT		true
+
 static const struct iio_chan_spec st_accel_8bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_ACCEL,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -662,6 +706,84 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.multi_read_bit = ST_ACCEL_6_MULTIREAD_BIT,
 		.bootime = 2,
 	},
+	{
+		.wai = ST_ACCEL_7_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LSM9DS0_ACCEL_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_accel_16bit_channels,
+		.odr = {
+			.addr = ST_ACCEL_7_ODR_ADDR,
+			.mask = ST_ACCEL_7_ODR_MASK,
+			.odr_avl = {
+				{ 3, ST_ACCEL_7_ODR_AVL_3HZ_VAL },
+				{ 6, ST_ACCEL_7_ODR_AVL_6HZ_VAL, },
+				{ 12, ST_ACCEL_7_ODR_AVL_12HZ_VAL, },
+				{ 25, ST_ACCEL_7_ODR_AVL_25HZ_VAL, },
+				{ 50, ST_ACCEL_7_ODR_AVL_50HZ_VAL, },
+				{ 100, ST_ACCEL_7_ODR_AVL_100HZ_VAL, },
+				{ 200, ST_ACCEL_7_ODR_AVL_200HZ_VAL, },
+				{ 400, ST_ACCEL_7_ODR_AVL_400HZ_VAL, },
+				{ 800, ST_ACCEL_7_ODR_AVL_800HZ_VAL, },
+				{ 1600, ST_ACCEL_7_ODR_AVL_1600HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_ACCEL_7_ODR_ADDR,
+			.mask = ST_ACCEL_7_ODR_MASK,
+			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
+		},
+		.enable_axis = {
+			.addr = ST_SENSORS_DEFAULT_AXIS_ADDR,
+			.mask = ST_SENSORS_DEFAULT_AXIS_MASK,
+		},
+		.fs = {
+			.addr = ST_ACCEL_7_FS_ADDR,
+			.mask = ST_ACCEL_7_FS_MASK,
+			.fs_avl = {
+				[0] = {
+					.num = ST_ACCEL_FS_AVL_2G,
+					.value = ST_ACCEL_7_FS_AVL_2_VAL,
+					.gain = ST_ACCEL_7_FS_AVL_2_GAIN,
+				},
+				[1] = {
+					.num = ST_ACCEL_FS_AVL_4G,
+					.value = ST_ACCEL_7_FS_AVL_4_VAL,
+					.gain = ST_ACCEL_7_FS_AVL_4_GAIN,
+				},
+				[2] = {
+					.num = ST_ACCEL_FS_AVL_6G,
+					.value = ST_ACCEL_7_FS_AVL_6_VAL,
+					.gain = ST_ACCEL_7_FS_AVL_6_GAIN,
+				},
+				[3] = {
+					.num = ST_ACCEL_FS_AVL_8G,
+					.value = ST_ACCEL_7_FS_AVL_8_VAL,
+					.gain = ST_ACCEL_7_FS_AVL_8_GAIN,
+				},
+				[4] = {
+					.num = ST_ACCEL_FS_AVL_16G,
+					.value = ST_ACCEL_7_FS_AVL_16_VAL,
+					.gain = ST_ACCEL_7_FS_AVL_16_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_ACCEL_7_BDU_ADDR,
+			.mask = ST_ACCEL_7_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_ACCEL_7_DRDY_IRQ_ADDR,
+			.mask_int1 = ST_ACCEL_7_DRDY_IRQ_INT1_MASK,
+			.ig1 = {
+				.en_addr = ST_ACCEL_7_IG1_EN_ADDR,
+				.en_mask = ST_ACCEL_7_IG1_EN_MASK,
+			},
+		},
+		.multi_read_bit = ST_ACCEL_7_MULTIREAD_BIT,
+		.bootime = 2,
+	},
 };
 
 static int st_accel_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 7333ee9..7a2a3ab 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -80,6 +80,10 @@ static const struct of_device_id st_accel_of_match[] = {
 		.compatible = "st,h3lis331dl-accel",
 		.data = H3LIS331DL_DRIVER_NAME,
 	},
+	{
+		.compatible = "st,lsm9ds0-accel",
+		.data = LSM9DS0_ACCEL_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_accel_of_match);
@@ -130,6 +134,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
 	{ LIS2DH12_ACCEL_DEV_NAME },
+	{ LSM9DS0_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index fcd5847..2fc32c92f 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -59,6 +59,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LSM330_ACCEL_DEV_NAME },
 	{ LSM303AGR_ACCEL_DEV_NAME },
 	{ LIS2DH12_ACCEL_DEV_NAME },
+	{ LSM9DS0_ACCEL_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_accel_id_table);
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 84e6559..e0ba94f6 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -106,7 +106,7 @@ config IIO_ST_MAGN_3AXIS
 	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
 	help
 	  Say yes here to build support for STMicroelectronics magnetometers:
-	  LSM303DLHC, LSM303DLM, LIS3MDL.
+	  LSM303DLHC, LSM303DLM, LIS3MDL, LSM9DS0.
 
 	  This driver can also be built as a module. If so, these modules
 	  will be created:
diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 06a4d9c..2176064 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -19,6 +19,7 @@
 #define LSM303DLM_MAGN_DEV_NAME		"lsm303dlm_magn"
 #define LIS3MDL_MAGN_DEV_NAME		"lis3mdl"
 #define LSM303AGR_MAGN_DEV_NAME		"lsm303agr_magn"
+#define LSM9DS0_MAGN_DEV_NAME		"lsm9ds0_magn"
 
 int st_magn_common_probe(struct iio_dev *indio_dev);
 void st_magn_common_remove(struct iio_dev *indio_dev);
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 62036d2..e8ab1ac 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -36,6 +36,7 @@
 /* FULLSCALE */
 #define ST_MAGN_FS_AVL_1300MG			1300
 #define ST_MAGN_FS_AVL_1900MG			1900
+#define ST_MAGN_FS_AVL_2000MG			2000
 #define ST_MAGN_FS_AVL_2500MG			2500
 #define ST_MAGN_FS_AVL_4000MG			4000
 #define ST_MAGN_FS_AVL_4700MG			4700
@@ -183,6 +184,50 @@
 #define ST_MAGN_3_OUT_Y_L_ADDR			0x6a
 #define ST_MAGN_3_OUT_Z_L_ADDR			0x6c
 
+/* CUSTOM VALUES FOR SENSOR 4 */
+#define ST_MAGN_4_WAI_EXP			0x49
+#define ST_MAGN_4_ODR_ADDR			0x24
+#define ST_MAGN_4_ODR_MASK			0x1c
+#define ST_MAGN_4_ODR_AVL_3HZ_VAL		0x00
+#define ST_MAGN_4_ODR_AVL_6HZ_VAL		0x01
+#define ST_MAGN_4_ODR_AVL_12HZ_VAL		0x02
+#define ST_MAGN_4_ODR_AVL_25HZ_VAL		0x03
+#define ST_MAGN_4_ODR_AVL_50HZ_VAL		0x04
+#define ST_MAGN_4_ODR_AVL_100HZ_VAL		0x05
+#define ST_MAGN_4_PW_ADDR			0x26
+#define ST_MAGN_4_PW_MASK			0x03
+#define ST_MAGN_4_PW_ON				0x00
+#define ST_MAGN_4_PW_OFF			0x03
+#define ST_MAGN_4_FS_ADDR			0x25
+#define ST_MAGN_4_FS_MASK			0x60
+#define ST_MAGN_4_FS_AVL_2000_VAL		0x00
+#define ST_MAGN_4_FS_AVL_4000_VAL		0x01
+#define ST_MAGN_4_FS_AVL_8000_VAL		0x02
+#define ST_MAGN_4_FS_AVL_12000_VAL		0x03
+#define ST_MAGN_4_FS_AVL_2000_GAIN		73
+#define ST_MAGN_4_FS_AVL_4000_GAIN		146
+#define ST_MAGN_4_FS_AVL_8000_GAIN		292
+#define ST_MAGN_4_FS_AVL_12000_GAIN		438
+/* Shared with accelerometer */
+#define ST_MAGN_4_BDU_ADDR			0x20
+#define ST_MAGN_4_BDU_MASK			0x08
+#define ST_MAGN_4_DRDY_IRQ_ADDR			0x22
+#define ST_MAGN_4_DRDY_INT_MASK			0x02
+/* INT2 is actually at another address. Not supported by driver */
+/*
+#define ST_MAGN_4_DRDY_IRQ_INT2_ADDR		0x23
+#define ST_MAGN_4_DRDY_IRQ_INT2_MASK		0x04
+ */
+/* Common to accelerometer so not supported */
+/*
+#define ST_MAGN_4_IHL_IRQ_ADDR			0x12
+#define ST_MAGN_4_IHL_IRQ_MASK			0x80
+ */
+#define ST_MAGN_4_MULTIREAD_BIT			true
+#define ST_MAGN_4_OUT_X_L_ADDR			0x08
+#define ST_MAGN_4_OUT_Y_L_ADDR			0x0a
+#define ST_MAGN_4_OUT_Z_L_ADDR			0x0c
+
 static const struct iio_chan_spec st_magn_16bit_channels[] = {
 	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
 			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
@@ -231,6 +276,22 @@ static const struct iio_chan_spec st_magn_3_16bit_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
+static const struct iio_chan_spec st_magn_4_16bit_channels[] = {
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_X, 1, IIO_MOD_X, 's', IIO_LE, 16, 16,
+			ST_MAGN_4_OUT_X_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Y, 1, IIO_MOD_Y, 's', IIO_LE, 16, 16,
+			ST_MAGN_4_OUT_Y_L_ADDR),
+	ST_SENSORS_LSM_CHANNELS(IIO_MAGN,
+			BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+			ST_SENSORS_SCAN_Z, 1, IIO_MOD_Z, 's', IIO_LE, 16, 16,
+			ST_MAGN_4_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
 static const struct st_sensor_settings st_magn_sensors_settings[] = {
 	{
 		.wai = 0, /* This sensor has no valid WhoAmI report 0 */
@@ -489,6 +550,68 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 		.multi_read_bit = ST_MAGN_3_MULTIREAD_BIT,
 		.bootime = 2,
 	},
+	{
+		.wai = ST_MAGN_4_WAI_EXP,
+		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
+		.sensors_supported = {
+			[0] = LSM9DS0_MAGN_DEV_NAME,
+		},
+		.ch = (struct iio_chan_spec *)st_magn_4_16bit_channels,
+		.odr = {
+			.addr = ST_MAGN_4_ODR_ADDR,
+			.mask = ST_MAGN_4_ODR_MASK,
+			.odr_avl = {
+				{ 3, ST_MAGN_4_ODR_AVL_3HZ_VAL, },
+				{ 6, ST_MAGN_4_ODR_AVL_6HZ_VAL, },
+				{ 12, ST_MAGN_4_ODR_AVL_12HZ_VAL, },
+				{ 25, ST_MAGN_4_ODR_AVL_25HZ_VAL, },
+				{ 50, ST_MAGN_4_ODR_AVL_50HZ_VAL, },
+				{ 100, ST_MAGN_4_ODR_AVL_100HZ_VAL, },
+			},
+		},
+		.pw = {
+			.addr = ST_MAGN_4_PW_ADDR,
+			.mask = ST_MAGN_4_PW_MASK,
+			.value_on = ST_MAGN_4_PW_ON,
+			.value_off = ST_MAGN_4_PW_OFF,
+		},
+		.fs = {
+			.addr = ST_MAGN_4_FS_ADDR,
+			.mask = ST_MAGN_4_FS_MASK,
+			.fs_avl = {
+				[0] = {
+					.num = ST_MAGN_FS_AVL_2000MG,
+					.value = ST_MAGN_4_FS_AVL_2000_VAL,
+					.gain = ST_MAGN_4_FS_AVL_2000_GAIN,
+				},
+				[1] = {
+					.num = ST_MAGN_FS_AVL_4000MG,
+					.value = ST_MAGN_4_FS_AVL_4000_VAL,
+					.gain = ST_MAGN_4_FS_AVL_4000_GAIN,
+				},
+				[2] = {
+					.num = ST_MAGN_FS_AVL_8000MG,
+					.value = ST_MAGN_4_FS_AVL_8000_VAL,
+					.gain = ST_MAGN_4_FS_AVL_8000_GAIN,
+				},
+				[3] = {
+					.num = ST_MAGN_FS_AVL_12000MG,
+					.value = ST_MAGN_4_FS_AVL_12000_VAL,
+					.gain = ST_MAGN_4_FS_AVL_12000_GAIN,
+				},
+			},
+		},
+		.bdu = {
+			.addr = ST_MAGN_4_BDU_ADDR,
+			.mask = ST_MAGN_4_BDU_MASK,
+		},
+		.drdy_irq = {
+			.addr = ST_MAGN_4_DRDY_IRQ_ADDR,
+			.mask_int1 = ST_MAGN_4_DRDY_INT_MASK,
+		},
+		.multi_read_bit = ST_MAGN_4_MULTIREAD_BIT,
+		.bootime = 2,
+	},
 };
 
 static int st_magn_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/magnetometer/st_magn_i2c.c b/drivers/iio/magnetometer/st_magn_i2c.c
index 8aa37af..1c7c487 100644
--- a/drivers/iio/magnetometer/st_magn_i2c.c
+++ b/drivers/iio/magnetometer/st_magn_i2c.c
@@ -40,6 +40,10 @@ static const struct of_device_id st_magn_of_match[] = {
 		.compatible = "st,lsm303agr-magn",
 		.data = LSM303AGR_MAGN_DEV_NAME,
 	},
+	{
+		.compatible = "st,lsm9ds0-magn",
+		.data = LSM9DS0_MAGN_DEV_NAME,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_magn_of_match);
@@ -84,6 +88,7 @@ static const struct i2c_device_id st_magn_id_table[] = {
 	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
+	{ LSM9DS0_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, st_magn_id_table);
diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 6325e7d..8c4e1d6 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -52,6 +52,7 @@ static const struct spi_device_id st_magn_id_table[] = {
 	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
+	{ LSM9DS0_MAGN_DEV_NAME },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, st_magn_id_table);
-- 
2.5.5

