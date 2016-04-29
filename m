Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:41401 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753022AbcD2NcP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 09:32:15 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v3 2/2] iio: accel: Add triggered buffer support for BMA220
Date: Fri, 29 Apr 2016 16:32:55 +0300
Message-Id: <1461936775-16419-3-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1461936775-16419-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1461936775-16419-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/accel/bma220_spi.c | 66 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 5df5594..cc305aa 100644
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
@@ -58,12 +69,16 @@ static const int bma220_scale_table[][4] = {
 
 struct bma220_data {
 	struct spi_device *spi_device;
+	struct mutex lock;
+	s8 buffer[16]; /* 3x8-bit channels + 5x8 padding + 8x8 timestamp */
+
 };
 
 static const struct iio_chan_spec bma220_channels[] = {
 	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
 	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
 	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
@@ -71,6 +86,40 @@ static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
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
+	u8 tx_buf = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
+	u8 rx_buf[3];
+
+	/* Do a bulk read, then pick out what we need. */
+	mutex_lock(&data->lock);
+	ret = spi_write_then_read(spi, &tx_buf, sizeof(tx_buf),
+					rx_buf, sizeof(rx_buf));
+	if (ret < 0)
+		goto err;
+
+	i = 0;
+	for_each_set_bit(bit, indio_dev->active_scan_mask,
+			      indio_dev->masklength) {
+		data->buffer[i] = rx_buf[bit];
+		i++;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+					   pf->timestamp);
+err:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static int bma220_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val, int *val2, long mask)
@@ -173,6 +222,7 @@ static int bma220_probe(struct spi_device *spi)
 	data = iio_priv(indio_dev);
 	data->spi_device = spi;
 	spi_set_drvdata(spi, indio_dev);
+	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &bma220_info;
@@ -185,11 +235,22 @@ static int bma220_probe(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+					 bma220_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&data->spi_device->dev,
+			"iio triggered buffer setup failed\n");
+		return ret;
+	}
+
 	ret = iio_device_register(indio_dev);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&spi->dev, "iio_device_register failed\n");
+		iio_triggered_buffer_cleanup(indio_dev);
+		return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
 static int bma220_remove(struct spi_device *spi)
@@ -198,6 +259,7 @@ static int bma220_remove(struct spi_device *spi)
 	struct bma220_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 
 	return bma220_read_reg(data->spi_device, BMA220_REG_SUSPEND);
 }
-- 
1.9.1

