Return-Path: <tiberiu.a.breana@intel.com>
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v5 2/2] iio: accel: Add triggered buffer support for BMA220
Date: Mon, 16 May 2016 14:58:23 +0300
Message-Id: <1463399903-823-1-git-send-email-tiberiu.a.breana@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
v5 change log:
- addressed Jonathan's comments
- removed rx_buf from data struct
- added available_scan_masks
---
 drivers/iio/accel/bma220_spi.c | 65 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 7343575..1098d10 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -11,9 +11,12 @@
 #include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/spi/spi.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define BMA220_REG_ID				0x00
 #define BMA220_REG_ACCEL_X			0x02
@@ -39,8 +42,22 @@
 	.channel2 = IIO_MOD_##axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 6,						\
+		.storagebits = 8,					\
+		.shift = BMA220_DATA_SHIFT,				\
+		.endianness = IIO_CPU,					\
+	},								\
 }
 
+enum bma220_axis {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
 static IIO_CONST_ATTR(in_accel_scale_available, BMA220_SCALE_AVAILABLE);
 
 static struct attribute *bma220_attributes[] = {
@@ -59,6 +76,7 @@ static const int bma220_scale_table[][4] = {
 struct bma220_data {
 	struct spi_device *spi_device;
 	struct mutex lock;
+	s8 buffer[16]; /* 3x8-bit channels + 5x8 padding + 8x8 timestamp */
 	u8 tx_buf[2] ____cacheline_aligned;
 };
 
@@ -66,6 +84,7 @@ static const struct iio_chan_spec bma220_channels[] = {
 	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
 	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
 	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
@@ -73,6 +92,35 @@ static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
 	return spi_w8r8(spi, reg | BMA220_READ_MASK);
 }
 
+static const unsigned long bma220_accel_scan_masks[] = {
+	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+	0
+};
+
+static irqreturn_t bma220_trigger_handler(int irq, void *p)
+{
+	int ret;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bma220_data *data = iio_priv(indio_dev);
+	struct spi_device *spi = data->spi_device;
+
+	mutex_lock(&data->lock);
+	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
+	ret = spi_write_then_read(spi, data->tx_buf, 1, data->buffer,
+				  ARRAY_SIZE(bma220_channels) - 1);
+	if (ret < 0)
+		goto err;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+					   pf->timestamp);
+err:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static int bma220_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -199,18 +247,30 @@ static int bma220_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = bma220_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
+	indio_dev->available_scan_masks = bma220_accel_scan_masks;
 
 	ret = bma220_init(data->spi_device);
 	if (ret < 0)
 		return ret;
 
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+					 bma220_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
+		goto err_suspend;
+	}
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&spi->dev, "iio_device_register failed\n");
-		return bma220_deinit(spi);
+		iio_triggered_buffer_cleanup(indio_dev);
+		goto err_suspend;
 	}
 
-	return ret;
+	return 0;
+
+err_suspend:
+	return bma220_deinit(spi);
 }
 
 static int bma220_remove(struct spi_device *spi)
@@ -218,6 +278,7 @@ static int bma220_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 
 	return bma220_deinit(spi);
 }
-- 
1.9.1
