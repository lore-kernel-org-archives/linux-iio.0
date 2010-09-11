Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com,
	Robin.Getz@analog.com,
	manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/6] staging:iio:adis16400 merge into adis16350 driver
Date: Sat, 11 Sep 2010 15:58:20 +0100
Message-Id: <1284217100-2469-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
References: <1284217100-2469-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Results in a subtle change to numbering of scan elements on
the adis16350. This does not technically change the abi as
these numbers are only guaranteed to be in the correct order,
not to have particular values.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/Kconfig          |   13 +-
 drivers/staging/iio/imu/Makefile         |    4 -
 drivers/staging/iio/imu/adis16350.h      |   18 +-
 drivers/staging/iio/imu/adis16350_core.c |   69 +++
 drivers/staging/iio/imu/adis16350_ring.c |   33 ++-
 drivers/staging/iio/imu/adis16400.h      |  208 --------
 drivers/staging/iio/imu/adis16400_core.c |  752 ------------------------------
 drivers/staging/iio/imu/adis16400_ring.c |  231 ---------
 8 files changed, 116 insertions(+), 1212 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index ca433d8..9853fb3 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -10,8 +10,8 @@ config ADIS16350
 	select IIO_SW_RING if IIO_RING_BUFFER
 	help
 	  Say yes here to build support for Analog Devices adis16300, adis16350,
-	  adis16354, adis16355, adis16360, adis16362 and adis16364,
-	  high precision tri-axis inertial sensor.
+	  adis16354, adis16355, adis16360, adis16362, adis16364, adis16400 and
+	  adis16405 high precision tri-axis inertial sensor.
 
 if ADIS16350
 config ADIS16350_EVENT
@@ -19,12 +19,3 @@ config ADIS16350_EVENT
        help
 	 Threshold and rate of change events for all channels.
 endif #ADIS16350
-
-config ADIS16400
-	tristate "Analog Devices ADIS16400/5 IMU SPI driver"
-	depends on SPI
-	select IIO_SW_RING if IIO_RING_BUFFER
-	select IIO_TRIGGER if IIO_RING_BUFFER
-	help
-	  Say yes here to build support for Analog Devices adis16400/5 triaxial
-	  inertial sensor with Magnetometer.
diff --git a/drivers/staging/iio/imu/Makefile b/drivers/staging/iio/imu/Makefile
index f27f896..0c15d6e 100644
--- a/drivers/staging/iio/imu/Makefile
+++ b/drivers/staging/iio/imu/Makefile
@@ -6,7 +6,3 @@ adis16350-y             := adis16350_core.o
 adis16350-$(CONFIG_ADIS16350_EVENT) += adis16350_event.o
 adis16350-$(CONFIG_IIO_RING_BUFFER) += adis16350_ring.o adis16350_trigger.o
 obj-$(CONFIG_ADIS16350) += adis16350.o
-
-adis16400-y             := adis16400_core.o
-adis16400-$(CONFIG_IIO_RING_BUFFER) += adis16400_ring.o adis16400_trigger.o
-obj-$(CONFIG_ADIS16400) += adis16400.o
diff --git a/drivers/staging/iio/imu/adis16350.h b/drivers/staging/iio/imu/adis16350.h
index b7c9052..ab98d6c 100644
--- a/drivers/staging/iio/imu/adis16350.h
+++ b/drivers/staging/iio/imu/adis16350.h
@@ -19,6 +19,11 @@
 #define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
 #define ADIS16350_AUX_ADC   0x16 /* Auxiliary ADC measurement */
 
+#define ADIS16400_XMAGN_OUT 0x10 /* X-axis magnetometer measurement */
+#define ADIS16400_YMAGN_OUT 0x12 /* Y-axis magnetometer measurement */
+#define ADIS16400_ZMAGN_OUT 0x14 /* Z-axis magnetometer measurement */
+
+
 #define ADIS16300_TEMP_OUT  0x10 /* Temperature output */
 #define ADIS16300_XINCLI_OUT 0x12 /* X-axis inclinometer output measurement */
 #define ADIS16300_YINCLI_OUT 0x14 /* Y-axis inclinometer output measurement */
@@ -104,10 +109,12 @@ enum adis16350_chip_variants {
 	adis16300,
 	adis16350,
 	adis16360,
+	adis16400,
 };
 
 extern struct attribute_group adis16300_scan_el_group;
 extern struct attribute_group adis16350_scan_el_group;
+extern struct attribute_group adis16400_scan_el_group;
 
 /**
  * struct adis16350_chip_info - chip type specific parameters
@@ -165,8 +172,8 @@ struct adis16350_state {
 	int				event_irq;
 	s64				event_timestamp;
 	struct work_struct		work_event;
-	s16				thresh_cache[44];
-	u8				smpl_cache[22];
+	s16				thresh_cache[48];
+	u8				smpl_cache[24];
 	int				active_alarms[2];
 	unsigned int			oldest_alarm:1;
 	u8				alarm_on[2];
@@ -208,13 +215,16 @@ static inline void adis16350_unconfigure_event_line(struct adis16350_state *st)
 #define ADIS16350_SCAN_ACCEL_X		4
 #define ADIS16350_SCAN_ACCEL_Y		5
 #define ADIS16350_SCAN_ACCEL_Z		6
-#define ADIS16300_SCAN_TEMP		7
 #define ADIS16350_SCAN_TEMP_X		7
+#define ADIS16400_SCAN_MAGN_X		7
 #define ADIS16350_SCAN_TEMP_Y		8
 #define ADIS16300_SCAN_INCLI_X		8
+#define ADIS16400_SCAN_MAGN_Y		8
 #define ADIS16350_SCAN_TEMP_Z		9
 #define ADIS16300_SCAN_INCLI_Y		9
-#define ADIS16350_SCAN_IN0		10
+#define ADIS16400_SCAN_MAGN_Z		9
+#define ADIS16300_SCAN_TEMP		10
+#define ADIS16350_SCAN_IN0		11
 
 #ifdef CONFIG_IIO_RING_BUFFER
 
diff --git a/drivers/staging/iio/imu/adis16350_core.c b/drivers/staging/iio/imu/adis16350_core.c
index f154886..d8f76c6 100644
--- a/drivers/staging/iio/imu/adis16350_core.c
+++ b/drivers/staging/iio/imu/adis16350_core.c
@@ -25,6 +25,7 @@
 #include "../accel/inclinometer.h"
 #include "../adc/adc.h"
 #include "../gyro/gyro.h"
+#include "../magnetometer/magnet.h"
 
 #include "adis16350.h"
 
@@ -672,6 +673,51 @@ static const struct attribute_group adis16300_attribute_group = {
 	.attrs = adis16300_attributes,
 };
 
+static IIO_DEV_ATTR_MAGN_X(adis16350_read_14bit_signed,
+		ADIS16400_XMAGN_OUT);
+static IIO_DEV_ATTR_MAGN_Y(adis16350_read_14bit_signed,
+		ADIS16400_YMAGN_OUT);
+static IIO_DEV_ATTR_MAGN_Z(adis16350_read_14bit_signed,
+		ADIS16400_ZMAGN_OUT);
+static IIO_CONST_ATTR(magn_scale, "0.0005 Gs");
+
+static struct attribute *adis16400_attributes[] = {
+	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
+	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
+	&iio_dev_attr_in_supply_raw.dev_attr.attr,
+	&iio_const_attr_in_supply_scale.dev_attr.attr,
+	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
+	&iio_dev_attr_gyro_scale.dev_attr.attr,
+	&iio_dev_attr_accel_x_raw.dev_attr.attr,
+	&iio_dev_attr_accel_y_raw.dev_attr.attr,
+	&iio_dev_attr_accel_z_raw.dev_attr.attr,
+	&iio_dev_attr_accel_scale.dev_attr.attr,
+	&iio_dev_attr_magn_x_raw.dev_attr.attr,
+	&iio_dev_attr_magn_y_raw.dev_attr.attr,
+	&iio_dev_attr_magn_z_raw.dev_attr.attr,
+	&iio_const_attr_magn_scale.dev_attr.attr,
+	&iio_dev_attr_temp_raw.dev_attr.attr,
+	&iio_const_attr_temp_scale.dev_attr.attr,
+	&iio_const_attr_temp_offset.dev_attr.attr,
+	&iio_dev_attr_in0_raw.dev_attr.attr,
+	&iio_const_attr_in0_scale.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_reset.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adis16400_attribute_group = {
+	.attrs = adis16400_attributes,
+};
+
 static struct adis16350_chip_info adis16350_variants[] = {
 	[adis16300] = {
 		.attribute_group = &adis16300_attribute_group,
@@ -730,6 +776,27 @@ static struct adis16350_chip_info adis16350_variants[] = {
 		BIT(ADIS16350_SCAN_TEMP_Z) |
 		BIT(ADIS16350_SCAN_IN0),
 	},
+	[adis16400] = {
+		.attribute_group = &adis16400_attribute_group,
+		.scan_el_group = &adis16400_scan_el_group,
+		.burst_available = 1,
+		.gyro_scale = "0.0008726646",
+		.accel_scale = "0.0326561445",
+		.burst_length = 24,
+		.all_mask =
+		BIT(ADIS16350_SCAN_IN_SUPPLY) |
+		BIT(ADIS16350_SCAN_GYRO_X) |
+		BIT(ADIS16350_SCAN_GYRO_Y) |
+		BIT(ADIS16350_SCAN_GYRO_Z) |
+		BIT(ADIS16350_SCAN_ACCEL_X) |
+		BIT(ADIS16350_SCAN_ACCEL_Y) |
+		BIT(ADIS16350_SCAN_ACCEL_Z) |
+		BIT(ADIS16400_SCAN_MAGN_X) |
+		BIT(ADIS16400_SCAN_MAGN_Y) |
+		BIT(ADIS16400_SCAN_MAGN_Z) |
+		BIT(ADIS16300_SCAN_TEMP) |
+		BIT(ADIS16350_SCAN_IN0),
+	}
 };
 
 static int __devinit adis16350_probe(struct spi_device *spi)
@@ -872,6 +939,8 @@ static const struct spi_device_id adis16350_id[] = {
 	{"adis16362", adis16360},
 	{"adis16364", adis16360},
 	{"adis16365", adis16360},
+	{"adis16400", adis16400},
+	{"adis16405", adis16400},
 	{}
 };
 
diff --git a/drivers/staging/iio/imu/adis16350_ring.c b/drivers/staging/iio/imu/adis16350_ring.c
index 37ec884..f8b08e9 100644
--- a/drivers/staging/iio/imu/adis16350_ring.c
+++ b/drivers/staging/iio/imu/adis16350_ring.c
@@ -34,6 +34,13 @@ static IIO_SCAN_EL_C(accel_y, ADIS16350_SCAN_ACCEL_Y, IIO_SIGNED(14),
 static IIO_SCAN_EL_C(accel_z, ADIS16350_SCAN_ACCEL_Z, IIO_SIGNED(14),
 		ADIS16350_ZACCL_OUT, NULL);
 
+static IIO_SCAN_EL_C(magn_x, ADIS16400_SCAN_MAGN_X, IIO_SIGNED(14),
+		     ADIS16400_XMAGN_OUT, NULL);
+static IIO_SCAN_EL_C(magn_y, ADIS16400_SCAN_MAGN_Y, IIO_SIGNED(14),
+		     ADIS16400_YMAGN_OUT, NULL);
+static IIO_SCAN_EL_C(magn_z, ADIS16400_SCAN_MAGN_Z, IIO_SIGNED(14),
+		     ADIS16400_ZMAGN_OUT, NULL);
+
 static IIO_SCAN_EL_C(temp_x, ADIS16350_SCAN_TEMP_X, IIO_SIGNED(12),
 		ADIS16350_XTEMP_OUT, NULL);
 static IIO_SCAN_EL_C(temp_y, ADIS16350_SCAN_TEMP_Y, IIO_SIGNED(12),
@@ -44,7 +51,7 @@ static IIO_SCAN_EL_C(temp_z, ADIS16350_SCAN_TEMP_Z, IIO_SIGNED(12),
 static IIO_SCAN_EL_C(in0, ADIS16350_SCAN_IN0, IIO_UNSIGNED(12),
 		ADIS16350_AUX_ADC, NULL);
 
-static IIO_SCAN_EL_TIMESTAMP(11);
+static IIO_SCAN_EL_TIMESTAMP(12);
 
 static struct attribute *adis16350_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
@@ -75,7 +82,7 @@ static IIO_SCAN_EL_C(temp, ADIS16300_SCAN_TEMP, IIO_UNSIGNED(12),
 
 static struct attribute *adis16300_scan_el_attrs[] = {
 	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_scan_el_gyro_x.dev_attr.attr,
+	&iio_scan_el_gyro_z.dev_attr.attr,
 	&iio_scan_el_temp.dev_attr.attr,
 	&iio_scan_el_accel_x.dev_attr.attr,
 	&iio_scan_el_accel_y.dev_attr.attr,
@@ -92,6 +99,28 @@ struct attribute_group adis16300_scan_el_group = {
 	.name = "scan_elements",
 };
 
+static struct attribute *adis16400_scan_el_attrs[] = {
+	&iio_scan_el_in_supply.dev_attr.attr,
+	&iio_scan_el_gyro_x.dev_attr.attr,
+	&iio_scan_el_gyro_y.dev_attr.attr,
+	&iio_scan_el_gyro_z.dev_attr.attr,
+	&iio_scan_el_accel_x.dev_attr.attr,
+	&iio_scan_el_accel_y.dev_attr.attr,
+	&iio_scan_el_accel_z.dev_attr.attr,
+	&iio_scan_el_magn_x.dev_attr.attr,
+	&iio_scan_el_magn_y.dev_attr.attr,
+	&iio_scan_el_magn_z.dev_attr.attr,
+	&iio_scan_el_temp.dev_attr.attr,
+	&iio_scan_el_in0.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	NULL,
+};
+
+struct attribute_group adis16400_scan_el_group = {
+	.attrs = adis16400_scan_el_attrs,
+	.name = "scan_elements",
+};
+
 /**
  * adis16350_poll_func_th() top half interrupt handler called by trigger
  * @private_data:	iio_dev
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
deleted file mode 100644
index 6ff33e1..0000000
--- a/drivers/staging/iio/imu/adis16400.h
+++ /dev/null
@@ -1,208 +0,0 @@
-/*
- * adis16400.h	support Analog Devices ADIS16400
- *		3d 18g accelerometers,
- *		3d gyroscopes,
- *		3d 2.5gauss magnetometers via SPI
- *
- * Copyright (c) 2009 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
- * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
- *
- * Loosely based upon lis3l02dq.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef SPI_ADIS16400_H_
-#define SPI_ADIS16400_H_
-
-#define ADIS16400_STARTUP_DELAY	220 /* ms */
-
-#define ADIS16400_READ_REG(a)    a
-#define ADIS16400_WRITE_REG(a) ((a) | 0x80)
-
-#define ADIS16400_FLASH_CNT  0x00 /* Flash memory write count */
-#define ADIS16400_SUPPLY_OUT 0x02 /* Power supply measurement */
-#define ADIS16400_XGYRO_OUT 0x04 /* X-axis gyroscope output */
-#define ADIS16400_YGYRO_OUT 0x06 /* Y-axis gyroscope output */
-#define ADIS16400_ZGYRO_OUT 0x08 /* Z-axis gyroscope output */
-#define ADIS16400_XACCL_OUT 0x0A /* X-axis accelerometer output */
-#define ADIS16400_YACCL_OUT 0x0C /* Y-axis accelerometer output */
-#define ADIS16400_ZACCL_OUT 0x0E /* Z-axis accelerometer output */
-#define ADIS16400_XMAGN_OUT 0x10 /* X-axis magnetometer measurement */
-#define ADIS16400_YMAGN_OUT 0x12 /* Y-axis magnetometer measurement */
-#define ADIS16400_ZMAGN_OUT 0x14 /* Z-axis magnetometer measurement */
-#define ADIS16400_TEMP_OUT  0x16 /* Temperature output */
-#define ADIS16400_AUX_ADC   0x18 /* Auxiliary ADC measurement */
-
-/* Calibration parameters */
-#define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
-#define ADIS16400_YGYRO_OFF 0x1C /* Y-axis gyroscope bias offset factor */
-#define ADIS16400_ZGYRO_OFF 0x1E /* Z-axis gyroscope bias offset factor */
-#define ADIS16400_XACCL_OFF 0x20 /* X-axis acceleration bias offset factor */
-#define ADIS16400_YACCL_OFF 0x22 /* Y-axis acceleration bias offset factor */
-#define ADIS16400_ZACCL_OFF 0x24 /* Z-axis acceleration bias offset factor */
-#define ADIS16400_XMAGN_HIF 0x26 /* X-axis magnetometer, hard-iron factor */
-#define ADIS16400_YMAGN_HIF 0x28 /* Y-axis magnetometer, hard-iron factor */
-#define ADIS16400_ZMAGN_HIF 0x2A /* Z-axis magnetometer, hard-iron factor */
-#define ADIS16400_XMAGN_SIF 0x2C /* X-axis magnetometer, soft-iron factor */
-#define ADIS16400_YMAGN_SIF 0x2E /* Y-axis magnetometer, soft-iron factor */
-#define ADIS16400_ZMAGN_SIF 0x30 /* Z-axis magnetometer, soft-iron factor */
-
-#define ADIS16400_GPIO_CTRL 0x32 /* Auxiliary digital input/output control */
-#define ADIS16400_MSC_CTRL  0x34 /* Miscellaneous control */
-#define ADIS16400_SMPL_PRD  0x36 /* Internal sample period (rate) control */
-#define ADIS16400_SENS_AVG  0x38 /* Dynamic range and digital filter control */
-#define ADIS16400_SLP_CNT   0x3A /* Sleep mode control */
-#define ADIS16400_DIAG_STAT 0x3C /* System status */
-
-/* Alarm functions */
-#define ADIS16400_GLOB_CMD  0x3E /* System command */
-#define ADIS16400_ALM_MAG1  0x40 /* Alarm 1 amplitude threshold */
-#define ADIS16400_ALM_MAG2  0x42 /* Alarm 2 amplitude threshold */
-#define ADIS16400_ALM_SMPL1 0x44 /* Alarm 1 sample size */
-#define ADIS16400_ALM_SMPL2 0x46 /* Alarm 2 sample size */
-#define ADIS16400_ALM_CTRL  0x48 /* Alarm control */
-#define ADIS16400_AUX_DAC   0x4A /* Auxiliary DAC data */
-
-#define ADIS16400_PRODUCT_ID 0x56 /* Product identifier */
-#define ADIS16400_PRODUCT_ID_DEFAULT 0x4015	/* Datasheet says 0x4105, I get 0x4015 */
-
-#define ADIS16400_ERROR_ACTIVE			(1<<14)
-#define ADIS16400_NEW_DATA			(1<<14)
-
-/* MSC_CTRL */
-#define ADIS16400_MSC_CTRL_MEM_TEST		(1<<11)
-#define ADIS16400_MSC_CTRL_INT_SELF_TEST	(1<<10)
-#define ADIS16400_MSC_CTRL_NEG_SELF_TEST	(1<<9)
-#define ADIS16400_MSC_CTRL_POS_SELF_TEST	(1<<8)
-#define ADIS16400_MSC_CTRL_GYRO_BIAS		(1<<7)
-#define ADIS16400_MSC_CTRL_ACCL_ALIGN		(1<<6)
-#define ADIS16400_MSC_CTRL_DATA_RDY_EN		(1<<2)
-#define ADIS16400_MSC_CTRL_DATA_RDY_POL_HIGH	(1<<1)
-#define ADIS16400_MSC_CTRL_DATA_RDY_DIO2	(1<<0)
-
-/* SMPL_PRD */
-#define ADIS16400_SMPL_PRD_TIME_BASE	(1<<7)
-#define ADIS16400_SMPL_PRD_DIV_MASK	0x7F
-
-/* DIAG_STAT */
-#define ADIS16400_DIAG_STAT_ZACCL_FAIL	(1<<15)
-#define ADIS16400_DIAG_STAT_YACCL_FAIL	(1<<14)
-#define ADIS16400_DIAG_STAT_XACCL_FAIL	(1<<13)
-#define ADIS16400_DIAG_STAT_XGYRO_FAIL	(1<<12)
-#define ADIS16400_DIAG_STAT_YGYRO_FAIL	(1<<11)
-#define ADIS16400_DIAG_STAT_ZGYRO_FAIL	(1<<10)
-#define ADIS16400_DIAG_STAT_ALARM2	(1<<9)
-#define ADIS16400_DIAG_STAT_ALARM1	(1<<8)
-#define ADIS16400_DIAG_STAT_FLASH_CHK	(1<<6)
-#define ADIS16400_DIAG_STAT_SELF_TEST	(1<<5)
-#define ADIS16400_DIAG_STAT_OVERFLOW	(1<<4)
-#define ADIS16400_DIAG_STAT_SPI_FAIL	(1<<3)
-#define ADIS16400_DIAG_STAT_FLASH_UPT	(1<<2)
-#define ADIS16400_DIAG_STAT_POWER_HIGH	(1<<1)
-#define ADIS16400_DIAG_STAT_POWER_LOW	(1<<0)
-
-/* GLOB_CMD */
-#define ADIS16400_GLOB_CMD_SW_RESET	(1<<7)
-#define ADIS16400_GLOB_CMD_P_AUTO_NULL	(1<<4)
-#define ADIS16400_GLOB_CMD_FLASH_UPD	(1<<3)
-#define ADIS16400_GLOB_CMD_DAC_LATCH	(1<<2)
-#define ADIS16400_GLOB_CMD_FAC_CALIB	(1<<1)
-#define ADIS16400_GLOB_CMD_AUTO_NULL	(1<<0)
-
-/* SLP_CNT */
-#define ADIS16400_SLP_CNT_POWER_OFF	(1<<8)
-
-#define ADIS16400_MAX_TX 24
-#define ADIS16400_MAX_RX 24
-
-#define ADIS16400_SPI_SLOW	(u32)(300 * 1000)
-#define ADIS16400_SPI_BURST	(u32)(1000 * 1000)
-#define ADIS16400_SPI_FAST	(u32)(2000 * 1000)
-
-/**
- * struct adis16400_state - device instance specific data
- * @us:			actual spi_device
- * @work_trigger_to_ring: bh for triggered event handling
- * @inter:		used to check if new interrupt has been triggered
- * @last_timestamp:	passing timestamp from th to bh of interrupt handler
- * @indio_dev:		industrial I/O device structure
- * @trig:		data ready trigger registered with iio
- * @tx:			transmit buffer
- * @rx:			recieve buffer
- * @buf_lock:		mutex to protect tx and rx
- **/
-struct adis16400_state {
-	struct spi_device		*us;
-	struct work_struct		work_trigger_to_ring;
-	s64				last_timestamp;
-	struct iio_dev			*indio_dev;
-	struct iio_trigger		*trig;
-	u8				*tx;
-	u8				*rx;
-	struct mutex			buf_lock;
-};
-
-int adis16400_set_irq(struct device *dev, bool enable);
-
-#ifdef CONFIG_IIO_RING_BUFFER
-/* At the moment triggers are only used for ring buffer
- * filling. This may change!
- */
-
-#define ADIS16400_SCAN_SUPPLY	0
-#define ADIS16400_SCAN_GYRO_X	1
-#define ADIS16400_SCAN_GYRO_Y	2
-#define ADIS16400_SCAN_GYRO_Z	3
-#define ADIS16400_SCAN_ACC_X	4
-#define ADIS16400_SCAN_ACC_Y	5
-#define ADIS16400_SCAN_ACC_Z	6
-#define ADIS16400_SCAN_MAGN_X	7
-#define ADIS16400_SCAN_MAGN_Y	8
-#define ADIS16400_SCAN_MAGN_Z	9
-#define ADIS16400_SCAN_TEMP	10
-#define ADIS16400_SCAN_ADC_0	11
-
-void adis16400_remove_trigger(struct iio_dev *indio_dev);
-int adis16400_probe_trigger(struct iio_dev *indio_dev);
-
-ssize_t adis16400_read_data_from_ring(struct device *dev,
-				      struct device_attribute *attr,
-				      char *buf);
-
-
-int adis16400_configure_ring(struct iio_dev *indio_dev);
-void adis16400_unconfigure_ring(struct iio_dev *indio_dev);
-
-#else /* CONFIG_IIO_RING_BUFFER */
-
-static inline void adis16400_remove_trigger(struct iio_dev *indio_dev)
-{
-}
-
-static inline int adis16400_probe_trigger(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline ssize_t
-adis16400_read_data_from_ring(struct device *dev,
-			      struct device_attribute *attr,
-			      char *buf)
-{
-	return 0;
-}
-
-static int adis16400_configure_ring(struct iio_dev *indio_dev)
-{
-	return 0;
-}
-
-static inline void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
-{
-}
-
-#endif /* CONFIG_IIO_RING_BUFFER */
-#endif /* SPI_ADIS16400_H_ */
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
deleted file mode 100644
index 5f1643a..0000000
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ /dev/null
@@ -1,752 +0,0 @@
-/*
- * adis16400.c	support Analog Devices ADIS16400/5
- *		3d 2g Linear Accelerometers,
- *		3d Gyroscopes,
- *		3d Magnetometers via SPI
- *
- * Copyright (c) 2009 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
- * Copyright (c) 2007 Jonathan Cameron <jic23@cam.ac.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- */
-
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/delay.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../ring_generic.h"
-#include "../accel/accel.h"
-#include "../adc/adc.h"
-#include "../gyro/gyro.h"
-#include "../magnetometer/magnet.h"
-
-#include "adis16400.h"
-
-#define DRIVER_NAME		"adis16400"
-
-static int adis16400_check_status(struct device *dev);
-
-/* At the moment the spi framework doesn't allow global setting of cs_change.
- * It's in the likely to be added comment at the top of spi.h.
- * This means that use cannot be made of spi_write etc.
- */
-
-/**
- * adis16400_spi_write_reg_8() - write single byte to a register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @reg_address: the address of the register to be written
- * @val: the value to write
- **/
-static int adis16400_spi_write_reg_8(struct device *dev,
-		u8 reg_address,
-		u8 val)
-{
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_WRITE_REG(reg_address);
-	st->tx[1] = val;
-
-	ret = spi_write(st->us, st->tx, 2);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-/**
- * adis16400_spi_write_reg_16() - write 2 bytes to a pair of registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @reg_address: the address of the lower of the two registers. Second register
- *               is assumed to have address one greater.
- * @val: value to be written
- **/
-static int adis16400_spi_write_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 value)
-{
-	int ret;
-	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		}, {
-			.tx_buf = st->tx + 2,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_WRITE_REG(lower_reg_address);
-	st->tx[1] = value & 0xFF;
-	st->tx[2] = ADIS16400_WRITE_REG(lower_reg_address + 1);
-	st->tx[3] = (value >> 8) & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
-}
-
-/**
- * adis16400_spi_read_reg_16() - read 2 bytes from a 16-bit register
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @reg_address: the address of the lower of the two registers. Second register
- *               is assumed to have address one greater.
- * @val: somewhere to pass back the value read
- **/
-static int adis16400_spi_read_reg_16(struct device *dev,
-		u8 lower_reg_address,
-		u16 *val)
-{
-	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	int ret;
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		}, {
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_READ_REG(lower_reg_address);
-	st->tx[1] = 0;
-	st->tx[2] = 0;
-	st->tx[3] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
-		dev_err(&st->us->dev,
-			"problem when reading 16 bit register 0x%02X",
-			lower_reg_address);
-		goto error_ret;
-	}
-	*val = (st->rx[0] << 8) | st->rx[1];
-
-error_ret:
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
-
-static ssize_t adis16400_spi_read_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf,
-		unsigned bits)
-{
-	int ret;
-	s16 val = 0;
-	unsigned shift = 16 - bits;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16400_spi_read_reg_16(dev, this_attr->address, (u16 *)&val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16400_ERROR_ACTIVE)
-		adis16400_check_status(dev);
-	val = ((s16)(val << shift) >> shift);
-	return sprintf(buf, "%d\n", val);
-}
-
-static ssize_t adis16400_read_12bit_unsigned(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret;
-	u16 val = 0;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-
-	ret = adis16400_spi_read_reg_16(dev, this_attr->address, &val);
-	if (ret)
-		return ret;
-
-	if (val & ADIS16400_ERROR_ACTIVE)
-		adis16400_check_status(dev);
-
-	return sprintf(buf, "%u\n", val & 0x0FFF);
-}
-
-static ssize_t adis16400_read_14bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16400_spi_read_signed(dev, attr, buf, 14);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16400_read_12bit_signed(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	ssize_t ret;
-
-	/* Take the iio_dev status lock */
-	mutex_lock(&indio_dev->mlock);
-	ret =  adis16400_spi_read_signed(dev, attr, buf, 12);
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret;
-}
-
-static ssize_t adis16400_write_16bit(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret;
-	long val;
-
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		goto error_ret;
-	ret = adis16400_spi_write_reg_16(dev, this_attr->address, val);
-
-error_ret:
-	return ret ? ret : len;
-}
-
-static ssize_t adis16400_read_frequency(struct device *dev,
-		struct device_attribute *attr,
-		char *buf)
-{
-	int ret, len = 0;
-	u16 t;
-	int sps;
-	ret = adis16400_spi_read_reg_16(dev,
-			ADIS16400_SMPL_PRD,
-			&t);
-	if (ret)
-		return ret;
-	sps =  (t & ADIS16400_SMPL_PRD_TIME_BASE) ? 53 : 1638;
-	sps /= (t & ADIS16400_SMPL_PRD_DIV_MASK) + 1;
-	len = sprintf(buf, "%d SPS\n", sps);
-	return len;
-}
-
-static ssize_t adis16400_write_frequency(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	long val;
-	int ret;
-	u8 t;
-
-	ret = strict_strtol(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	mutex_lock(&indio_dev->mlock);
-
-	t = (1638 / val);
-	if (t > 0)
-		t--;
-	t &= ADIS16400_SMPL_PRD_DIV_MASK;
-	if ((t & ADIS16400_SMPL_PRD_DIV_MASK) >= 0x0A)
-		st->us->max_speed_hz = ADIS16400_SPI_SLOW;
-	else
-		st->us->max_speed_hz = ADIS16400_SPI_FAST;
-
-	ret = adis16400_spi_write_reg_8(dev,
-			ADIS16400_SMPL_PRD,
-			t);
-
-	mutex_unlock(&indio_dev->mlock);
-
-	return ret ? ret : len;
-}
-
-static int adis16400_reset(struct device *dev)
-{
-	int ret;
-	ret = adis16400_spi_write_reg_8(dev,
-			ADIS16400_GLOB_CMD,
-			ADIS16400_GLOB_CMD_SW_RESET);
-	if (ret)
-		dev_err(dev, "problem resetting device");
-
-	return ret;
-}
-
-static ssize_t adis16400_write_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	if (len < 1)
-		return -1;
-	switch (buf[0]) {
-	case '1':
-	case 'y':
-	case 'Y':
-		return adis16400_reset(dev);
-	}
-	return -1;
-}
-
-int adis16400_set_irq(struct device *dev, bool enable)
-{
-	int ret;
-	u16 msc;
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_MSC_CTRL, &msc);
-	if (ret)
-		goto error_ret;
-
-	msc |= ADIS16400_MSC_CTRL_DATA_RDY_POL_HIGH;
-	if (enable)
-		msc |= ADIS16400_MSC_CTRL_DATA_RDY_EN;
-	else
-		msc &= ~ADIS16400_MSC_CTRL_DATA_RDY_EN;
-
-	ret = adis16400_spi_write_reg_16(dev, ADIS16400_MSC_CTRL, msc);
-	if (ret)
-		goto error_ret;
-
-error_ret:
-	return ret;
-}
-
-/* Power down the device */
-static int adis16400_stop_device(struct device *dev)
-{
-	int ret;
-	u16 val = ADIS16400_SLP_CNT_POWER_OFF;
-
-	ret = adis16400_spi_write_reg_16(dev, ADIS16400_SLP_CNT, val);
-	if (ret)
-		dev_err(dev, "problem with turning device off: SLP_CNT");
-
-	return ret;
-}
-
-static int adis16400_self_test(struct device *dev)
-{
-	int ret;
-	ret = adis16400_spi_write_reg_16(dev,
-			ADIS16400_MSC_CTRL,
-			ADIS16400_MSC_CTRL_MEM_TEST);
-	if (ret) {
-		dev_err(dev, "problem starting self test");
-		goto err_ret;
-	}
-
-	adis16400_check_status(dev);
-
-err_ret:
-	return ret;
-}
-
-static int adis16400_check_status(struct device *dev)
-{
-	u16 status;
-	int ret;
-
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_DIAG_STAT, &status);
-
-	if (ret < 0) {
-		dev_err(dev, "Reading status failed\n");
-		goto error_ret;
-	}
-	ret = status;
-	if (status & ADIS16400_DIAG_STAT_ZACCL_FAIL)
-		dev_err(dev, "Z-axis accelerometer self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_YACCL_FAIL)
-		dev_err(dev, "Y-axis accelerometer self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_XACCL_FAIL)
-		dev_err(dev, "X-axis accelerometer self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_XGYRO_FAIL)
-		dev_err(dev, "X-axis gyroscope self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_YGYRO_FAIL)
-		dev_err(dev, "Y-axis gyroscope self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_ZGYRO_FAIL)
-		dev_err(dev, "Z-axis gyroscope self-test failure\n");
-	if (status & ADIS16400_DIAG_STAT_ALARM2)
-		dev_err(dev, "Alarm 2 active\n");
-	if (status & ADIS16400_DIAG_STAT_ALARM1)
-		dev_err(dev, "Alarm 1 active\n");
-	if (status & ADIS16400_DIAG_STAT_FLASH_CHK)
-		dev_err(dev, "Flash checksum error\n");
-	if (status & ADIS16400_DIAG_STAT_SELF_TEST)
-		dev_err(dev, "Self test error\n");
-	if (status & ADIS16400_DIAG_STAT_OVERFLOW)
-		dev_err(dev, "Sensor overrange\n");
-	if (status & ADIS16400_DIAG_STAT_SPI_FAIL)
-		dev_err(dev, "SPI failure\n");
-	if (status & ADIS16400_DIAG_STAT_FLASH_UPT)
-		dev_err(dev, "Flash update failed\n");
-	if (status & ADIS16400_DIAG_STAT_POWER_HIGH)
-		dev_err(dev, "Power supply above 5.25V\n");
-	if (status & ADIS16400_DIAG_STAT_POWER_LOW)
-		dev_err(dev, "Power supply below 4.75V\n");
-
-error_ret:
-	return ret;
-}
-
-static int adis16400_initial_setup(struct adis16400_state *st)
-{
-	int ret;
-	u16 prod_id, smp_prd;
-	struct device *dev = &st->indio_dev->dev;
-
-	/* use low spi speed for init */
-	st->us->max_speed_hz = ADIS16400_SPI_SLOW;
-	st->us->mode = SPI_MODE_3;
-	spi_setup(st->us);
-
-	/* Disable IRQ */
-	ret = adis16400_set_irq(dev, false);
-	if (ret) {
-		dev_err(dev, "disable irq failed");
-		goto err_ret;
-	}
-
-	/* Do self test */
-	ret = adis16400_self_test(dev);
-	if (ret) {
-		dev_err(dev, "self test failure");
-		goto err_ret;
-	}
-
-	/* Read status register to check the result */
-	ret = adis16400_check_status(dev);
-	if (ret) {
-		adis16400_reset(dev);
-		dev_err(dev, "device not playing ball -> reset");
-		msleep(ADIS16400_STARTUP_DELAY);
-		ret = adis16400_check_status(dev);
-		if (ret) {
-			dev_err(dev, "giving up");
-			goto err_ret;
-		}
-	}
-
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_PRODUCT_ID, &prod_id);
-	if (ret)
-		goto err_ret;
-
-	if (prod_id != ADIS16400_PRODUCT_ID_DEFAULT)
-		dev_warn(dev, "unknown product id");
-
-	printk(KERN_INFO DRIVER_NAME ": prod_id 0x%04x at CS%d (irq %d)\n",
-			prod_id, st->us->chip_select, st->us->irq);
-
-	/* use high spi speed if possible */
-	ret = adis16400_spi_read_reg_16(dev, ADIS16400_SMPL_PRD, &smp_prd);
-	if (!ret && (smp_prd & ADIS16400_SMPL_PRD_DIV_MASK) < 0x0A) {
-		st->us->max_speed_hz = ADIS16400_SPI_SLOW;
-		spi_setup(st->us);
-	}
-
-
-err_ret:
-
-	return ret;
-}
-
-#define ADIS16400_DEV_ATTR_CALIBBIAS(_channel, _reg)		\
-	IIO_DEV_ATTR_##_channel##_CALIBBIAS(S_IWUSR | S_IRUGO,	\
-			adis16400_read_12bit_signed,		\
-			adis16400_write_16bit,			\
-			_reg)
-
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_X, ADIS16400_XGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Y, ADIS16400_XGYRO_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(GYRO_Z, ADIS16400_XGYRO_OFF);
-
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_X, ADIS16400_XACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Y, ADIS16400_XACCL_OFF);
-static ADIS16400_DEV_ATTR_CALIBBIAS(ACCEL_Z, ADIS16400_XACCL_OFF);
-
-
-static IIO_DEV_ATTR_IN_NAMED_RAW(supply, adis16400_read_14bit_signed,
-		ADIS16400_SUPPLY_OUT);
-static IIO_CONST_ATTR_IN_NAMED_SCALE(supply, "0.002418 V");
-
-static IIO_DEV_ATTR_GYRO_X(adis16400_read_14bit_signed,
-		ADIS16400_XGYRO_OUT);
-static IIO_DEV_ATTR_GYRO_Y(adis16400_read_14bit_signed,
-		ADIS16400_YGYRO_OUT);
-static IIO_DEV_ATTR_GYRO_Z(adis16400_read_14bit_signed,
-		ADIS16400_ZGYRO_OUT);
-static IIO_CONST_ATTR(gyro_scale, "0.0008726646");
-
-static IIO_DEV_ATTR_ACCEL_X(adis16400_read_14bit_signed,
-		ADIS16400_XACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_Y(adis16400_read_14bit_signed,
-		ADIS16400_YACCL_OUT);
-static IIO_DEV_ATTR_ACCEL_Z(adis16400_read_14bit_signed,
-		ADIS16400_ZACCL_OUT);
-static IIO_CONST_ATTR(accel_scale, "0.0326561445");
-
-static IIO_DEV_ATTR_MAGN_X(adis16400_read_14bit_signed,
-		ADIS16400_XMAGN_OUT);
-static IIO_DEV_ATTR_MAGN_Y(adis16400_read_14bit_signed,
-		ADIS16400_YMAGN_OUT);
-static IIO_DEV_ATTR_MAGN_Z(adis16400_read_14bit_signed,
-		ADIS16400_ZMAGN_OUT);
-static IIO_CONST_ATTR(magn_scale, "0.0005 Gs");
-
-
-static IIO_DEV_ATTR_TEMP_RAW(adis16400_read_12bit_signed);
-static IIO_CONST_ATTR_TEMP_OFFSET("198.16 K");
-static IIO_CONST_ATTR_TEMP_SCALE("0.14 K");
-
-static IIO_DEV_ATTR_IN_RAW(0, adis16400_read_12bit_unsigned,
-		ADIS16400_AUX_ADC);
-static IIO_CONST_ATTR(in0_scale, "0.000806 V");
-
-static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
-		adis16400_read_frequency,
-		adis16400_write_frequency);
-
-static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16400_write_reset, 0);
-
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
-
-static IIO_CONST_ATTR_NAME("adis16400");
-
-static struct attribute *adis16400_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16400_event_attribute_group = {
-	.attrs = adis16400_event_attributes,
-};
-
-static struct attribute *adis16400_attributes[] = {
-	&iio_dev_attr_gyro_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_gyro_y_calibbias.dev_attr.attr,
-	&iio_dev_attr_gyro_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_x_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_y_calibbias.dev_attr.attr,
-	&iio_dev_attr_accel_z_calibbias.dev_attr.attr,
-	&iio_dev_attr_in_supply_raw.dev_attr.attr,
-	&iio_const_attr_in_supply_scale.dev_attr.attr,
-	&iio_dev_attr_gyro_x_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_y_raw.dev_attr.attr,
-	&iio_dev_attr_gyro_z_raw.dev_attr.attr,
-	&iio_const_attr_gyro_scale.dev_attr.attr,
-	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_const_attr_accel_scale.dev_attr.attr,
-	&iio_dev_attr_magn_x_raw.dev_attr.attr,
-	&iio_dev_attr_magn_y_raw.dev_attr.attr,
-	&iio_dev_attr_magn_z_raw.dev_attr.attr,
-	&iio_const_attr_magn_scale.dev_attr.attr,
-	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_const_attr_temp_offset.dev_attr.attr,
-	&iio_const_attr_temp_scale.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_const_attr_in0_scale.dev_attr.attr,
-	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adis16400_attribute_group = {
-	.attrs = adis16400_attributes,
-};
-
-static int __devinit adis16400_probe(struct spi_device *spi)
-{
-	int ret, regdone = 0;
-	struct adis16400_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
-		goto error_ret;
-	}
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, st);
-
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADIS16400_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADIS16400_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
-	st->us = spi;
-	mutex_init(&st->buf_lock);
-	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device();
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
-
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16400_event_attribute_group;
-	st->indio_dev->attrs = &adis16400_attribute_group;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-
-	ret = adis16400_configure_ring(st->indio_dev);
-	if (ret)
-		goto error_free_dev;
-
-	ret = iio_device_register(st->indio_dev);
-	if (ret)
-		goto error_unreg_ring_funcs;
-	regdone = 1;
-
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
-	if (ret) {
-		printk(KERN_ERR "failed to initialize the ring\n");
-		goto error_unreg_ring_funcs;
-	}
-
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0) {
-		ret = iio_register_interrupt_line(spi->irq,
-				st->indio_dev,
-				0,
-				IRQF_TRIGGER_RISING,
-				"adis16400");
-		if (ret)
-			goto error_uninitialize_ring;
-
-		ret = adis16400_probe_trigger(st->indio_dev);
-		if (ret)
-			goto error_unregister_line;
-	}
-
-	/* Get the device into a sane initial state */
-	ret = adis16400_initial_setup(st);
-	if (ret)
-		goto error_remove_trigger;
-	return 0;
-
-error_remove_trigger:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		adis16400_remove_trigger(st->indio_dev);
-error_unregister_line:
-	if (st->indio_dev->modes & INDIO_RING_TRIGGERED)
-		iio_unregister_interrupt_line(st->indio_dev, 0);
-error_uninitialize_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
-error_unreg_ring_funcs:
-	adis16400_unconfigure_ring(st->indio_dev);
-error_free_dev:
-	if (regdone)
-		iio_device_unregister(st->indio_dev);
-	else
-		iio_free_device(st->indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
-error_free_st:
-	kfree(st);
-error_ret:
-	return ret;
-}
-
-/* fixme, confirm ordering in this function */
-static int adis16400_remove(struct spi_device *spi)
-{
-	int ret;
-	struct adis16400_state *st = spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
-
-	ret = adis16400_stop_device(&(indio_dev->dev));
-	if (ret)
-		goto err_ret;
-
-	flush_scheduled_work();
-
-	adis16400_remove_trigger(indio_dev);
-	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		iio_unregister_interrupt_line(indio_dev, 0);
-
-	iio_ring_buffer_unregister(st->indio_dev->ring);
-	adis16400_unconfigure_ring(indio_dev);
-	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
-
-	return 0;
-
-err_ret:
-	return ret;
-}
-
-static struct spi_driver adis16400_driver = {
-	.driver = {
-		.name = "adis16400",
-		.owner = THIS_MODULE,
-	},
-	.probe = adis16400_probe,
-	.remove = __devexit_p(adis16400_remove),
-};
-
-static __init int adis16400_init(void)
-{
-	return spi_register_driver(&adis16400_driver);
-}
-module_init(adis16400_init);
-
-static __exit void adis16400_exit(void)
-{
-	spi_unregister_driver(&adis16400_driver);
-}
-module_exit(adis16400_exit);
-
-MODULE_AUTHOR("Manuel Stahl <manuel.stahl@iis.fraunhofer.de>");
-MODULE_DESCRIPTION("Analog Devices ADIS16400/5 IMU SPI driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
deleted file mode 100644
index de5ef5c..0000000
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ /dev/null
@@ -1,231 +0,0 @@
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/gpio.h>
-#include <linux/workqueue.h>
-#include <linux/mutex.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-
-#include "../iio.h"
-#include "../sysfs.h"
-#include "../ring_sw.h"
-#include "../accel/accel.h"
-#include "../trigger.h"
-#include "adis16400.h"
-
-static IIO_SCAN_EL_C(in_supply, ADIS16400_SCAN_SUPPLY, IIO_SIGNED(14),
-		     ADIS16400_SUPPLY_OUT, NULL);
-
-static IIO_SCAN_EL_C(gyro_x, ADIS16400_SCAN_GYRO_X, IIO_SIGNED(14),
-		     ADIS16400_XGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_y, ADIS16400_SCAN_GYRO_Y, IIO_SIGNED(14),
-		     ADIS16400_YGYRO_OUT, NULL);
-static IIO_SCAN_EL_C(gyro_z, ADIS16400_SCAN_GYRO_Z, IIO_SIGNED(14),
-		     ADIS16400_ZGYRO_OUT, NULL);
-
-static IIO_SCAN_EL_C(accel_x, ADIS16400_SCAN_ACC_X, IIO_SIGNED(14),
-		     ADIS16400_XACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_y, ADIS16400_SCAN_ACC_Y, IIO_SIGNED(14),
-		     ADIS16400_YACCL_OUT, NULL);
-static IIO_SCAN_EL_C(accel_z, ADIS16400_SCAN_ACC_Z, IIO_SIGNED(14),
-		     ADIS16400_ZACCL_OUT, NULL);
-
-static IIO_SCAN_EL_C(magn_x, ADIS16400_SCAN_MAGN_X, IIO_SIGNED(14),
-		     ADIS16400_XMAGN_OUT, NULL);
-static IIO_SCAN_EL_C(magn_y, ADIS16400_SCAN_MAGN_Y, IIO_SIGNED(14),
-		     ADIS16400_YMAGN_OUT, NULL);
-static IIO_SCAN_EL_C(magn_z, ADIS16400_SCAN_MAGN_Z, IIO_SIGNED(14),
-		     ADIS16400_ZMAGN_OUT, NULL);
-
-static IIO_SCAN_EL_C(temp, ADIS16400_SCAN_TEMP, IIO_SIGNED(12),
-		     ADIS16400_TEMP_OUT, NULL);
-static IIO_SCAN_EL_C(in0, ADIS16400_SCAN_ADC_0, IIO_SIGNED(12),
-		     ADIS16400_AUX_ADC, NULL);
-
-static IIO_SCAN_EL_TIMESTAMP(12);
-
-static struct attribute *adis16400_scan_el_attrs[] = {
-	&iio_scan_el_in_supply.dev_attr.attr,
-	&iio_scan_el_gyro_x.dev_attr.attr,
-	&iio_scan_el_gyro_y.dev_attr.attr,
-	&iio_scan_el_gyro_z.dev_attr.attr,
-	&iio_scan_el_accel_x.dev_attr.attr,
-	&iio_scan_el_accel_y.dev_attr.attr,
-	&iio_scan_el_accel_z.dev_attr.attr,
-	&iio_scan_el_magn_x.dev_attr.attr,
-	&iio_scan_el_magn_y.dev_attr.attr,
-	&iio_scan_el_magn_z.dev_attr.attr,
-	&iio_scan_el_temp.dev_attr.attr,
-	&iio_scan_el_in0.dev_attr.attr,
-	&iio_scan_el_timestamp.dev_attr.attr,
-	NULL,
-};
-
-static struct attribute_group adis16400_scan_el_group = {
-	.attrs = adis16400_scan_el_attrs,
-	.name = "scan_elements",
-};
-
-/**
- * adis16400_poll_func_th() top half interrupt handler called by trigger
- * @private_data:	iio_dev
- **/
-static void adis16400_poll_func_th(struct iio_dev *indio_dev, s64 time)
-{
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	st->last_timestamp = time;
-	schedule_work(&st->work_trigger_to_ring);
-	/* Indicate that this interrupt is being handled */
-
-	/* Technically this is trigger related, but without this
-	 * handler running there is currently no way for the interrupt
-	 * to clear.
-	 */
-}
-
-/**
- * adis16400_spi_read_burst() - read all data registers
- * @dev: device associated with child of actual device (iio_dev or iio_trig)
- * @rx: somewhere to pass back the value read (min size is 24 bytes)
- **/
-static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
-{
-	struct spi_message msg;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
-	u32 old_speed_hz = st->us->max_speed_hz;
-	int ret;
-
-	struct spi_transfer xfers[] = {
-		{
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 0,
-		}, {
-			.rx_buf = rx,
-			.bits_per_word = 8,
-			.len = 24,
-			.cs_change = 1,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = ADIS16400_READ_REG(ADIS16400_GLOB_CMD);
-	st->tx[1] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-
-	st->us->max_speed_hz = min(ADIS16400_SPI_BURST, old_speed_hz);
-	spi_setup(st->us);
-
-	ret = spi_sync(st->us, &msg);
-	if (ret)
-		dev_err(&st->us->dev, "problem when burst reading");
-
-	st->us->max_speed_hz = old_speed_hz;
-	spi_setup(st->us);
-	mutex_unlock(&st->buf_lock);
-	return ret;
-}
-
-/* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
- * specific to be rolled into the core.
- */
-static void adis16400_trigger_bh_to_ring(struct work_struct *work_s)
-{
-	struct adis16400_state *st
-		= container_of(work_s, struct adis16400_state,
-			       work_trigger_to_ring);
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
-
-	int i = 0;
-	s16 *data;
-	size_t datasize = ring->access.get_bytes_per_datum(ring);
-
-	data = kmalloc(datasize , GFP_KERNEL);
-	if (data == NULL) {
-		dev_err(&st->us->dev, "memory alloc failed in ring bh");
-		return;
-	}
-
-	if (ring->scan_count)
-		if (adis16400_spi_read_burst(&st->indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++)
-				data[i]	= be16_to_cpup(
-					(__be16 *)&(st->rx[i*2]));
-
-	/* Guaranteed to be aligned with 8 byte boundary */
-	if (ring->scan_timestamp)
-		*((s64 *)(data + ((i + 3)/4)*4)) = st->last_timestamp;
-
-	ring->access.store_to(ring,
-			(u8 *) data,
-			st->last_timestamp);
-
-	iio_trigger_notify_done(st->indio_dev->trig);
-	kfree(data);
-
-	return;
-}
-
-void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
-{
-	kfree(indio_dev->pollfunc);
-	iio_sw_rb_free(indio_dev->ring);
-}
-
-int adis16400_configure_ring(struct iio_dev *indio_dev)
-{
-	int ret = 0;
-	struct adis16400_state *st = indio_dev->dev_data;
-	struct iio_ring_buffer *ring;
-	INIT_WORK(&st->work_trigger_to_ring, adis16400_trigger_bh_to_ring);
-
-	ring = iio_sw_rb_allocate(indio_dev);
-	if (!ring) {
-		ret = -ENOMEM;
-		return ret;
-	}
-	indio_dev->ring = ring;
-	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&ring->access);
-	ring->bpe = 2;
-	ring->scan_el_attrs = &adis16400_scan_el_group;
-	ring->scan_timestamp = true;
-	ring->preenable = &iio_sw_ring_preenable;
-	ring->postenable = &iio_triggered_ring_postenable;
-	ring->predisable = &iio_triggered_ring_predisable;
-	ring->owner = THIS_MODULE;
-
-	/* Set default scan mode */
-	iio_scan_mask_set(ring, iio_scan_el_in_supply.number);
-	iio_scan_mask_set(ring, iio_scan_el_gyro_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_gyro_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_gyro_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_accel_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_magn_x.number);
-	iio_scan_mask_set(ring, iio_scan_el_magn_y.number);
-	iio_scan_mask_set(ring, iio_scan_el_magn_z.number);
-	iio_scan_mask_set(ring, iio_scan_el_temp.number);
-	iio_scan_mask_set(ring, iio_scan_el_in0.number);
-
-	ret = iio_alloc_pollfunc(indio_dev, NULL, &adis16400_poll_func_th);
-	if (ret)
-		goto error_iio_sw_rb_free;
-
-	indio_dev->modes |= INDIO_RING_TRIGGERED;
-	return 0;
-
-error_iio_sw_rb_free:
-	iio_sw_rb_free(indio_dev->ring);
-	return ret;
-}
-- 
1.7.2.2
