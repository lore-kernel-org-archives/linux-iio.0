Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19964 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbcEEPsO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 5 May 2016 11:48:14 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v4 2/2] iio: accel: Add triggered buffer support for BMA220
Date: Thu,  5 May 2016 18:48:56 +0300
Message-Id: <1462463336-16108-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1462463336-16108-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1462463336-16108-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/accel/bma220_spi.c | 64 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 7343575..6c0bbd8 100644
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
@@ -39,6 +42,14 @@
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
 
 static IIO_CONST_ATTR(in_accel_scale_available, BMA220_SCALE_AVAILABLE);
@@ -59,13 +70,16 @@ static const int bma220_scale_table[][4] = {
 struct bma220_data {
 	struct spi_device *spi_device;
 	struct mutex lock;
+	s8 buffer[16]; /* 3x8-bit channels + 5x8 padding + 8x8 timestamp */
 	u8 tx_buf[2] ____cacheline_aligned;
+	u8 rx_buf[3];
 };
 
 static const struct iio_chan_spec bma220_channels[] = {
 	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
 	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
 	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
@@ -73,6 +87,40 @@ static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
 	return spi_w8r8(spi, reg | BMA220_READ_MASK);
 }
 
+static irqreturn_t bma220_trigger_handler(int irq, void *p)
+{
+	int i;
+	int ret;
+	int bit;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bma220_data *data = iio_priv(indio_dev);
+	struct spi_device *spi = data->spi_device;
+
+	/* Do a bulk read, then pick out what we need. */
+	mutex_lock(&data->lock);
+	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
+	ret = spi_write_then_read(spi, data->tx_buf, 1,
+				  data->rx_buf, sizeof(data->rx_buf));
+	if (ret < 0)
+		goto err;
+
+	i = 0;
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			      indio_dev->masklength) {
+		data->buffer[i] = data->rx_buf[bit];
+		i++;
+	}
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
@@ -204,13 +252,24 @@ static int bma220_probe(struct spi_device *spi)
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
@@ -218,6 +277,7 @@ static int bma220_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 
 	return bma220_deinit(spi);
 }
-- 
1.9.1

