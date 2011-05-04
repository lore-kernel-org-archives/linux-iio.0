Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 38/99] staging:iio:imu:adis16350 etc support into adis16400 driver.
Date: Wed,  4 May 2011 12:58:10 +0100
Message-Id: <1304510351-10922-39-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Next patch will remove the current adis16350 driver.
These should have been merged a long time ago, but there we are.

V3: rebase fixup + add missing extend_name for supply on adis16350

V2: Move to single IIO_CHAN macro + use the new extend_name
to make the naming of the temperature sensors contain x, y, z
rather than messing with modifiers.  This a very weird case
and I don't want temperature to use axial modifiers.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/Kconfig             |    8 +-
 drivers/staging/iio/imu/adis16400.h         |   22 +++-
 drivers/staging/iio/imu/adis16400_core.c    |  187 +++++++++++++++++++++++----
 drivers/staging/iio/imu/adis16400_ring.c    |   89 ++++++++++---
 drivers/staging/iio/imu/adis16400_trigger.c |    1 -
 5 files changed, 260 insertions(+), 47 deletions(-)

diff --git a/drivers/staging/iio/imu/Kconfig b/drivers/staging/iio/imu/Kconfig
index 31a6233..dbed7d7 100644
--- a/drivers/staging/iio/imu/Kconfig
+++ b/drivers/staging/iio/imu/Kconfig
@@ -22,10 +22,12 @@ config ADIS16350
 	  high precision tri-axis inertial sensor.
 
 config ADIS16400
-	tristate "Analog Devices ADIS16400/5 IMU SPI driver"
+	tristate "Analog Devices ADIS16400 and similar IMU SPI driver"
 	depends on SPI
 	select IIO_SW_RING if IIO_RING_BUFFER
 	select IIO_TRIGGER if IIO_RING_BUFFER
 	help
-	  Say yes here to build support for Analog Devices adis16400/5 triaxial
-	  inertial sensor with Magnetometer.
+	  Say yes here to build support for Analog Devices adis16350, adis16354,
+	  adis16355, adis16360, adis16362, adis16364, adis16365, adis16400 and
+	  adis16405 triaxial inertial sensors (adis16400 series also have
+	  magnetometers).
diff --git a/drivers/staging/iio/imu/adis16400.h b/drivers/staging/iio/imu/adis16400.h
index 1a7e23e..ec3449b 100644
--- a/drivers/staging/iio/imu/adis16400.h
+++ b/drivers/staging/iio/imu/adis16400.h
@@ -37,6 +37,10 @@
 #define ADIS16400_TEMP_OUT  0x16 /* Temperature output */
 #define ADIS16400_AUX_ADC   0x18 /* Auxiliary ADC measurement */
 
+#define ADIS16350_XTEMP_OUT 0x10 /* X-axis gyroscope temperature measurement */
+#define ADIS16350_YTEMP_OUT 0x12 /* Y-axis gyroscope temperature measurement */
+#define ADIS16350_ZTEMP_OUT 0x14 /* Z-axis gyroscope temperature measurement */
+
 /* Calibration parameters */
 #define ADIS16400_XGYRO_OFF 0x1A /* X-axis gyroscope bias offset factor */
 #define ADIS16400_YGYRO_OFF 0x1C /* Y-axis gyroscope bias offset factor */
@@ -68,7 +72,6 @@
 #define ADIS16400_AUX_DAC   0x4A /* Auxiliary DAC data */
 
 #define ADIS16400_PRODUCT_ID 0x56 /* Product identifier */
-#define ADIS16400_PRODUCT_ID_DEFAULT 0x4015	/* Datasheet says 0x4105, I get 0x4015 */
 
 #define ADIS16400_ERROR_ACTIVE			(1<<14)
 #define ADIS16400_NEW_DATA			(1<<14)
@@ -123,6 +126,18 @@
 #define ADIS16400_SPI_BURST	(u32)(1000 * 1000)
 #define ADIS16400_SPI_FAST	(u32)(2000 * 1000)
 
+#define ADIS16400_HAS_PROD_ID 1
+#define ADIS16400_NO_BURST 2
+struct adis16400_chip_info {
+	const struct iio_chan_spec *channels;
+	const int num_channels;
+	const int product_id;
+	const long flags;
+	unsigned int gyro_scale_micro;
+	unsigned int accel_scale_micro;
+	unsigned long default_scan_mask;
+};
+
 /**
  * struct adis16400_state - device instance specific data
  * @us:			actual spi_device
@@ -139,6 +154,7 @@ struct adis16400_state {
 	u8				*tx;
 	u8				*rx;
 	struct mutex			buf_lock;
+	struct adis16400_chip_info	*variant;
 };
 
 int adis16400_set_irq(struct iio_dev *indio_dev, bool enable);
@@ -156,9 +172,13 @@ int adis16400_set_irq(struct iio_dev *indio_dev, bool enable);
 #define ADIS16400_SCAN_ACC_Y	5
 #define ADIS16400_SCAN_ACC_Z	6
 #define ADIS16400_SCAN_MAGN_X	7
+#define ADIS16350_SCAN_TEMP_X	7
 #define ADIS16400_SCAN_MAGN_Y	8
+#define ADIS16350_SCAN_TEMP_Y	8
 #define ADIS16400_SCAN_MAGN_Z	9
+#define ADIS16350_SCAN_TEMP_Z	9
 #define ADIS16400_SCAN_TEMP	10
+#define ADIS16350_SCAN_ADC_0	10
 #define ADIS16400_SCAN_ADC_0	11
 
 void adis16400_remove_trigger(struct iio_dev *indio_dev);
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 6f43cc9..fad7744 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -38,6 +38,15 @@
 
 #define DRIVER_NAME		"adis16400"
 
+enum adis16400_chip_variant {
+	ADIS16350,
+	ADIS16360,
+	ADIS16362,
+	ADIS16364,
+	ADIS16365,
+	ADIS16400,
+};
+
 static int adis16400_check_status(struct iio_dev *indio_dev);
 
 /* At the moment the spi framework doesn't allow global setting of cs_change.
@@ -383,19 +392,18 @@ static int adis16400_initial_setup(struct adis16400_state *st)
 			goto err_ret;
 		}
 	}
+	if (st->variant->flags & ADIS16400_HAS_PROD_ID) {
+		ret = adis16400_spi_read_reg_16(st->indio_dev,
+						ADIS16400_PRODUCT_ID, &prod_id);
+		if (ret)
+			goto err_ret;
 
-	ret = adis16400_spi_read_reg_16(st->indio_dev,
-					ADIS16400_PRODUCT_ID, &prod_id);
-	if (ret)
-		goto err_ret;
-
-	if ((prod_id & 0xF000) != ADIS16400_PRODUCT_ID_DEFAULT)
-		dev_warn(dev, "unknown product id");
-
-
-	dev_info(dev, ": prod_id 0x%04x at CS%d (irq %d)\n",
-			prod_id, st->us->chip_select, st->us->irq);
+		if ((prod_id & 0xF000) != st->variant->product_id)
+			dev_warn(dev, "incorrect id");
 
+		printk(KERN_INFO DRIVER_NAME ": prod_id 0x%04x at CS%d (irq %d)\n",
+		       prod_id, st->us->chip_select, st->us->irq);
+	}
 	/* use high spi speed if possible */
 	ret = adis16400_spi_read_reg_16(st->indio_dev,
 					ADIS16400_SMPL_PRD, &smp_prd);
@@ -418,7 +426,15 @@ static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, adis16400_write_reset, 0);
 
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("409 546 819 1638");
 
-static IIO_CONST_ATTR_NAME("adis16400");
+static ssize_t adis16400_show_name(struct device *dev,
+				   struct device_attribute *attr,
+				   char *buf)
+{
+	struct adis16400_state *st
+		= iio_dev_get_devdata(dev_get_drvdata(dev));
+	return sprintf(buf, "%s\n", spi_get_device_id(st->us)->name);
+}
+static IIO_DEVICE_ATTR(name, S_IRUGO, adis16400_show_name, NULL, 0);
 
 enum adis16400_chan {
 	in_supply,
@@ -432,10 +448,11 @@ enum adis16400_chan {
 	magn_y,
 	magn_z,
 	temp,
+	temp0, temp1, temp2,
 	in1
 };
 
-static u8 adis16400_addresses[12][2] = {
+static u8 adis16400_addresses[16][2] = {
 	[in_supply] = { ADIS16400_SUPPLY_OUT, 0 },
 	[gyro_x] = { ADIS16400_XGYRO_OUT, ADIS16400_XGYRO_OFF },
 	[gyro_y] = { ADIS16400_YGYRO_OUT, ADIS16400_YGYRO_OFF },
@@ -447,6 +464,9 @@ static u8 adis16400_addresses[12][2] = {
 	[magn_y] = { ADIS16400_YMAGN_OUT, 0 },
 	[magn_z] = { ADIS16400_ZMAGN_OUT, 0 },
 	[temp] = { ADIS16400_TEMP_OUT, 0 },
+	[temp0] = { ADIS16350_XTEMP_OUT },
+	[temp1] = { ADIS16350_YTEMP_OUT },
+	[temp2] = { ADIS16350_ZTEMP_OUT },
 	[in1] = { ADIS16400_AUX_ADC , 0 },
 };
 
@@ -476,6 +496,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			      int *val2,
 			      long mask)
 {
+	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
 	int ret;
 	s16 val16;
 	int shift;
@@ -503,7 +524,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_GYRO:
 			*val = 0;
-			*val2 = 873;
+			*val2 = st->variant->gyro_scale_micro;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_IN:
 			*val = 0;
@@ -514,7 +535,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_ACCEL:
 			*val = 0;
-			*val2 = 32656;
+			*val2 = st->variant->accel_scale_micro;
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_MAGN:
 			*val = 0;
@@ -532,10 +553,9 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
 		ret = adis16400_spi_read_reg_16(indio_dev,
 				adis16400_addresses[chan->address][1],
 				&val16);
-		if (ret) {
-			mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&indio_dev->mlock);
+		if (ret)
 			return ret;
-		}
 		val16 = ((val16 & 0xFFF) << 4) >> 4;
 		*val = val16;
 		return IIO_VAL_INT;
@@ -597,11 +617,57 @@ static struct iio_chan_spec adis16400_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(12)
 };
 
+static struct iio_chan_spec adis16350_channels[] = {
+	IIO_CHAN(IIO_IN, 0, 1, 0, "supply", 0, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16400_SCAN_SUPPLY, IIO_ST('u', 12, 16, 0), 0),
+	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 1, ADIS16400_SCAN_GYRO_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 2, ADIS16400_SCAN_GYRO_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_GYRO, 1, 0, 0, NULL, 0, IIO_MOD_Z,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 3, ADIS16400_SCAN_GYRO_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 4, ADIS16400_SCAN_ACC_X, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, ADIS16400_SCAN_ACC_Y, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z,
+		 (1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SHARED),
+		 0, ADIS16400_SCAN_ACC_Z, IIO_ST('s', 14, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, "x", 0, 0,
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16350_SCAN_TEMP_X, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, "y", 1, 0,
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16350_SCAN_TEMP_Y, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN(IIO_TEMP, 0, 1, 0, "z", 2, 0,
+		 (1 << IIO_CHAN_INFO_OFFSET_SEPARATE) |
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16350_SCAN_TEMP_Z, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN(IIO_IN, 0, 1, 0, NULL, 1, 0,
+		 (1 << IIO_CHAN_INFO_SCALE_SEPARATE),
+		 0, ADIS16350_SCAN_ADC_0, IIO_ST('s', 12, 16, 0), 0),
+	IIO_CHAN_SOFT_TIMESTAMP(11)
+};
+
 static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
-	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_name.dev_attr.attr,
 	NULL
 };
 
@@ -609,6 +675,64 @@ static const struct attribute_group adis16400_attribute_group = {
 	.attrs = adis16400_attributes,
 };
 
+static struct adis16400_chip_info adis16400_chips[] = {
+	[ADIS16350] = {
+		.channels = adis16350_channels,
+		.num_channels = ARRAY_SIZE(adis16350_channels),
+		.gyro_scale_micro = 872664,
+		.accel_scale_micro = 24732,
+		.default_scan_mask = 0x7FF,
+		.flags = ADIS16400_NO_BURST,
+	},
+	[ADIS16360] = {
+		.channels = adis16350_channels,
+		.num_channels = ARRAY_SIZE(adis16350_channels),
+		.flags = ADIS16400_HAS_PROD_ID,
+		.product_id = 0x3FE8,
+		.gyro_scale_micro = 1279,
+		.accel_scale_micro = 24732,
+		.default_scan_mask = 0x7FF,
+	},
+	[ADIS16362] = {
+		.channels = adis16350_channels,
+		.num_channels = ARRAY_SIZE(adis16350_channels),
+		.flags = ADIS16400_HAS_PROD_ID,
+		.product_id = 0x3FEA,
+		.gyro_scale_micro = 1279,
+		.accel_scale_micro = 24732,
+		.default_scan_mask = 0x7FF,
+	},
+	[ADIS16364] = {
+		.channels = adis16350_channels,
+		.num_channels = ARRAY_SIZE(adis16350_channels),
+		.flags = ADIS16400_HAS_PROD_ID,
+		.product_id = 0x3FEC,
+		.gyro_scale_micro = 1279,
+		.accel_scale_micro = 24732,
+		.default_scan_mask = 0x7FF,
+	},
+	[ADIS16365] = {
+		.channels = adis16350_channels,
+		.num_channels = ARRAY_SIZE(adis16350_channels),
+		.flags = ADIS16400_HAS_PROD_ID,
+		.product_id = 0x3FED,
+		.gyro_scale_micro = 1279,
+		.accel_scale_micro = 24732,
+		.default_scan_mask = 0x7FF,
+	},
+	[ADIS16400] = {
+		.channels = adis16400_channels,
+		.num_channels = ARRAY_SIZE(adis16400_channels),
+		.flags = ADIS16400_HAS_PROD_ID,
+		.product_id = 0x4015,
+		.gyro_scale_micro = 873,
+		.accel_scale_micro = 32656,
+		.default_scan_mask = 0xFFF,
+	}
+};
+
+
+
 static int __devinit adis16400_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
@@ -639,11 +763,11 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 		ret = -ENOMEM;
 		goto error_free_tx;
 	}
-
+	st->variant = &adis16400_chips[spi_get_device_id(spi)->driver_data];
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &adis16400_attribute_group;
-	st->indio_dev->channels = adis16400_channels;
-	st->indio_dev->num_channels = ARRAY_SIZE(adis16400_channels);
+	st->indio_dev->channels = st->variant->channels;
+	st->indio_dev->num_channels = st->variant->num_channels;
 	st->indio_dev->read_raw = &adis16400_read_raw;
 	st->indio_dev->write_raw = &adis16400_write_raw;
 	st->indio_dev->dev_data = (void *)(st);
@@ -659,7 +783,9 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 		goto error_unreg_ring_funcs;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
+	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+					  st->variant->channels,
+					  st->variant->num_channels);
 	if (ret) {
 		dev_err(&spi->dev, "failed to initialize the ring\n");
 		goto error_unreg_ring_funcs;
@@ -714,6 +840,7 @@ static int adis16400_remove(struct spi_device *spi)
 	iio_ring_buffer_unregister(st->indio_dev->ring);
 	adis16400_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
+
 	kfree(st->tx);
 	kfree(st->rx);
 	kfree(st);
@@ -724,11 +851,25 @@ err_ret:
 	return ret;
 }
 
+static const struct spi_device_id adis16400_id[] = {
+	{"adis16350", ADIS16350},
+	{"adis16354", ADIS16350},
+	{"adis16355", ADIS16350},
+	{"adis16360", ADIS16360},
+	{"adis16362", ADIS16362},
+	{"adis16364", ADIS16364},
+	{"adis16365", ADIS16365},
+	{"adis16400", ADIS16400},
+	{"adis16405", ADIS16400},
+	{}
+};
+
 static struct spi_driver adis16400_driver = {
 	.driver = {
 		.name = "adis16400",
 		.owner = THIS_MODULE,
 	},
+	.id_table = adis16400_id,
 	.probe = adis16400_probe,
 	.remove = __devexit_p(adis16400_remove),
 };
diff --git a/drivers/staging/iio/imu/adis16400_ring.c b/drivers/staging/iio/imu/adis16400_ring.c
index f5b9bb8..c56c655 100644
--- a/drivers/staging/iio/imu/adis16400_ring.c
+++ b/drivers/staging/iio/imu/adis16400_ring.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
+#include <linux/bitops.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -63,6 +64,56 @@ static int adis16400_spi_read_burst(struct device *dev, u8 *rx)
 	return ret;
 }
 
+static const u16 read_all_tx_array[] = {
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_SUPPLY_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_XGYRO_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_YGYRO_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_ZGYRO_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_XACCL_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_YACCL_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_ZACCL_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16350_XTEMP_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16350_YTEMP_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16350_ZTEMP_OUT)),
+	cpu_to_be16(ADIS16400_READ_REG(ADIS16400_AUX_ADC)),
+};
+
+static int adis16350_spi_read_all(struct device *dev, u8 *rx)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
+
+	struct spi_message msg;
+	int i, j = 0, ret;
+	struct spi_transfer *xfers;
+
+	xfers = kzalloc(sizeof(*xfers)*
+			st->indio_dev->ring->scan_count + 1,
+		GFP_KERNEL);
+	if (xfers == NULL)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(read_all_tx_array); i++)
+		if (st->indio_dev->ring->scan_mask & (1 << i)) {
+			xfers[j].tx_buf = &read_all_tx_array[i];
+			xfers[j].bits_per_word = 16;
+			xfers[j].len = 2;
+			xfers[j + 1].rx_buf = rx + j*2;
+			j++;
+		}
+	xfers[j].bits_per_word = 16;
+	xfers[j].len = 2;
+
+	spi_message_init(&msg);
+	for (j = 0; j < st->indio_dev->ring->scan_count + 1; j++)
+		spi_message_add_tail(&xfers[j], &msg);
+
+	ret = spi_sync(st->us, &msg);
+	kfree(xfers);
+
+	return ret;
+}
+
 /* Whilst this makes a lot of calls to iio_sw_ring functions - it is to device
  * specific to be rolled into the core.
  */
@@ -72,7 +123,7 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->private_data;
 	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	int i = 0, j;
+	int i = 0, j, ret = 0;
 	s16 *data;
 	size_t datasize = ring->access.get_bytes_per_datum(ring);
 	unsigned long mask = ring->scan_mask;
@@ -83,15 +134,25 @@ static irqreturn_t adis16400_trigger_handler(int irq, void *p)
 		return -ENOMEM;
 	}
 
-	if (ring->scan_count)
-		if (adis16400_spi_read_burst(&indio_dev->dev, st->rx) >= 0)
-			for (; i < ring->scan_count; i++) {
+	if (ring->scan_count) {
+		if (st->variant->flags & ADIS16400_NO_BURST) {
+			ret = adis16350_spi_read_all(&indio_dev->dev, st->rx);
+			if (ret < 0)
+				return ret;
+			for (; i < ring->scan_count; i++)
+				data[i]	= *(s16 *)(st->rx + i*2);
+		} else {
+			ret = adis16400_spi_read_burst(&indio_dev->dev, st->rx);
+			if (ret < 0)
+				return ret;
+			for (; i < indio_dev->ring->scan_count; i++) {
 				j = __ffs(mask);
 				mask &= ~(1 << j);
-				data[i]	= be16_to_cpup(
+				data[i] = be16_to_cpup(
 					(__be16 *)&(st->rx[j*2]));
 			}
-
+		}
+	}
 	/* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
 		*((s64 *)(data + ((i + 3)/4)*4)) = pf->timestamp;
@@ -113,6 +174,7 @@ void adis16400_unconfigure_ring(struct iio_dev *indio_dev)
 int adis16400_configure_ring(struct iio_dev *indio_dev)
 {
 	int ret = 0;
+	struct adis16400_state *st = iio_dev_get_devdata(indio_dev);
 	struct iio_ring_buffer *ring;
 
 	ring = iio_sw_rb_allocate(indio_dev);
@@ -129,20 +191,9 @@ int adis16400_configure_ring(struct iio_dev *indio_dev)
 	ring->postenable = &iio_triggered_ring_postenable;
 	ring->predisable = &iio_triggered_ring_predisable;
 	ring->owner = THIS_MODULE;
-
+	ring->scan_mask = st->variant->default_scan_mask;
+	ring->scan_count = hweight_long(st->variant->default_scan_mask);
 	/* Set default scan mode */
-	iio_scan_mask_set(ring, ADIS16400_SCAN_SUPPLY);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_GYRO_X);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_GYRO_Y);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_GYRO_Z);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_ACC_X);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_ACC_Y);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_ACC_Z);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_MAGN_X);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_MAGN_Y);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_MAGN_Z);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_TEMP);
-	iio_scan_mask_set(ring, ADIS16400_SCAN_ADC_0);
 
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
diff --git a/drivers/staging/iio/imu/adis16400_trigger.c b/drivers/staging/iio/imu/adis16400_trigger.c
index b80ae94..d0c4aea 100644
--- a/drivers/staging/iio/imu/adis16400_trigger.c
+++ b/drivers/staging/iio/imu/adis16400_trigger.c
@@ -64,7 +64,6 @@ int adis16400_probe_trigger(struct iio_dev *indio_dev)
 			  st->trig);
 	if (ret)
 		goto error_free_trig;
-
 	st->trig->dev.parent = &st->us->dev;
 	st->trig->owner = THIS_MODULE;
 	st->trig->private_data = st;
-- 
1.7.3.4
