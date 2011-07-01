Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	ldewangan@nvidia.com,
	shubhrajyoti@ti.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 01/25] staging:iio:accel:kxsd9 cleanup and conversion to iio_chan_spec.
Date: Fri,  1 Jul 2011 11:10:52 +0100
Message-Id: <1309515076-12323-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
References: <1309515076-12323-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Lots of minor bits and pieces.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/kxsd9.c |  268 +++++++++++++++----------------------
 1 files changed, 105 insertions(+), 163 deletions(-)

diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index c8a358a..3f2d047 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -24,8 +24,6 @@
 
 #include "../iio.h"
 #include "../sysfs.h"
-#include "../adc/adc.h"
-#include "accel.h"
 
 #define KXSD9_REG_X		0x00
 #define KXSD9_REG_Y		0x02
@@ -34,10 +32,6 @@
 #define KXSD9_REG_RESET		0x0a
 #define KXSD9_REG_CTRL_C	0x0c
 
-#define KXSD9_FS_8		0x00
-#define KXSD9_FS_6		0x01
-#define KXSD9_FS_4		0x02
-#define KXSD9_FS_2		0x03
 #define KXSD9_FS_MASK		0x03
 
 #define KXSD9_REG_CTRL_B	0x0d
@@ -46,13 +40,8 @@
 #define KXSD9_READ(a) (0x80 | (a))
 #define KXSD9_WRITE(a) (a)
 
-#define KXSD9_SCALE_2G "0.011978"
-#define KXSD9_SCALE_4G "0.023927"
-#define KXSD9_SCALE_6G "0.035934"
-#define KXSD9_SCALE_8G "0.047853"
-
 #define KXSD9_STATE_RX_SIZE 2
-#define KXSD9_STATE_TX_SIZE 4
+#define KXSD9_STATE_TX_SIZE 2
 /**
  * struct kxsd9_state - device related storage
  * @buf_lock:	protect the rx and tx buffers.
@@ -67,170 +56,70 @@ struct kxsd9_state {
 	u8 tx[KXSD9_STATE_TX_SIZE];
 };
 
-/* This may want to move to mili g to allow for non integer ranges */
-static ssize_t kxsd9_read_scale(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	int ret;
-	ssize_t len = 0;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct kxsd9_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.bits_per_word = 8,
-		.len = 2,
-		.cs_change = 1,
-		.tx_buf = st->tx,
-		.rx_buf = st->rx,
-	};
-	struct spi_message msg;
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = KXSD9_READ(KXSD9_REG_CTRL_C);
-	st->tx[1] = 0;
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret)
-		goto error_ret;
-
-	switch (st->rx[1] & KXSD9_FS_MASK) {
-	case KXSD9_FS_8:
-		len += sprintf(buf, "%s\n", KXSD9_SCALE_8G);
-		break;
-	case KXSD9_FS_6:
-		len += sprintf(buf, "%s\n", KXSD9_SCALE_6G);
-		break;
-	case KXSD9_FS_4:
-		len += sprintf(buf, "%s\n", KXSD9_SCALE_4G);
-		break;
-	case KXSD9_FS_2:
-		len += sprintf(buf, "%s\n", KXSD9_SCALE_2G);
-		break;
-	}
+#define KXSD9_SCALE_2G "0.011978"
+#define KXSD9_SCALE_4G "0.023927"
+#define KXSD9_SCALE_6G "0.035934"
+#define KXSD9_SCALE_8G "0.047853"
 
-error_ret:
-	mutex_unlock(&st->buf_lock);
+/* reverse order */
+static const int kxsd9_micro_scales[4] = { 47853, 35934, 23927, 11978 };
 
-	return ret ? ret : len;
-}
-static ssize_t kxsd9_write_scale(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf,
-				 size_t len)
+static int kxsd9_write_scale(struct iio_dev *indio_dev, int micro)
 {
-
-	struct spi_message msg;
-	int ret;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	int ret, i;
 	struct kxsd9_state *st = iio_priv(indio_dev);
-	u8 val;
-	struct spi_transfer xfers[] = {
-		{
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-			.tx_buf = st->tx,
-			.rx_buf = st->rx,
-		}, {
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-			.tx_buf = st->tx,
-		},
-	};
-
-	if (!strncmp(buf, KXSD9_SCALE_8G,
-		     strlen(buf) < strlen(KXSD9_SCALE_8G)
-		     ? strlen(buf) : strlen(KXSD9_SCALE_8G)))
-		val = KXSD9_FS_8;
-	else if (!strncmp(buf, KXSD9_SCALE_6G,
-			  strlen(buf) < strlen(KXSD9_SCALE_6G)
-			  ? strlen(buf) : strlen(KXSD9_SCALE_6G)))
-		val = KXSD9_FS_6;
-	else if (!strncmp(buf, KXSD9_SCALE_4G,
-			  strlen(buf) < strlen(KXSD9_SCALE_4G)
-			  ? strlen(buf) : strlen(KXSD9_SCALE_4G)))
-		val = KXSD9_FS_4;
-	else if (!strncmp(buf, KXSD9_SCALE_2G,
-			  strlen(buf) < strlen(KXSD9_SCALE_2G)
-			  ? strlen(buf) : strlen(KXSD9_SCALE_2G)))
-		val = KXSD9_FS_2;
-	else
+	bool foundit = false;
+
+	for (i = 0; i < 4; i++)
+		if (micro == kxsd9_micro_scales[i]) {
+			foundit = true;
+			break;
+		}
+	if (!foundit)
 		return -EINVAL;
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = KXSD9_READ(KXSD9_REG_CTRL_C);
-	st->tx[1] = 0;
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
 	if (ret)
 		goto error_ret;
 	st->tx[0] = KXSD9_WRITE(KXSD9_REG_CTRL_C);
-	st->tx[1] = (st->rx[1] & ~KXSD9_FS_MASK) | val;
+	st->tx[1] = (ret & ~KXSD9_FS_MASK) | i;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 2);
 error_ret:
 	mutex_unlock(&st->buf_lock);
-	return ret ? ret : len;
+	return ret;
 }
 
-static ssize_t kxsd9_read_accel(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
 {
 	struct spi_message msg;
 	int ret;
-	ssize_t len = 0;
-	u16 val;
-	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfers[] = {
 		{
 			.bits_per_word = 8,
 			.len = 1,
-			.cs_change = 0,
 			.delay_usecs = 200,
 			.tx_buf = st->tx,
 		}, {
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 1,
 			.rx_buf = st->rx,
 		},
 	};
 
 	mutex_lock(&st->buf_lock);
-	st->tx[0] = KXSD9_READ(this_attr->address);
+	st->tx[0] = KXSD9_READ(address);
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
 	ret = spi_sync(st->us, &msg);
 	if (ret)
-		goto error_ret;
-	val = (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
-	len = sprintf(buf, "%d\n", val);
-error_ret:
-	mutex_unlock(&st->buf_lock);
-
-	return ret ? ret : len;
+		return ret;
+	return (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
 }
 
-static IIO_DEV_ATTR_ACCEL_X(kxsd9_read_accel, KXSD9_REG_X);
-static IIO_DEV_ATTR_ACCEL_Y(kxsd9_read_accel, KXSD9_REG_Y);
-static IIO_DEV_ATTR_ACCEL_Z(kxsd9_read_accel, KXSD9_REG_Z);
-static IIO_DEV_ATTR_IN_RAW(0, kxsd9_read_accel, KXSD9_REG_AUX);
-
-static IIO_DEVICE_ATTR(accel_scale,
-		S_IRUGO | S_IWUSR,
-		kxsd9_read_scale,
-		kxsd9_write_scale,
-		0);
-
 static IIO_CONST_ATTR(accel_scale_available,
 		KXSD9_SCALE_2G " "
 		KXSD9_SCALE_4G " "
@@ -238,48 +127,94 @@ static IIO_CONST_ATTR(accel_scale_available,
 		KXSD9_SCALE_8G);
 
 static struct attribute *kxsd9_attributes[] = {
-	&iio_dev_attr_accel_x_raw.dev_attr.attr,
-	&iio_dev_attr_accel_y_raw.dev_attr.attr,
-	&iio_dev_attr_accel_z_raw.dev_attr.attr,
-	&iio_dev_attr_in0_raw.dev_attr.attr,
-	&iio_dev_attr_accel_scale.dev_attr.attr,
 	&iio_const_attr_accel_scale_available.dev_attr.attr,
 	NULL,
 };
 
+static int kxsd9_write_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int val,
+			   int val2,
+			   long mask)
+{
+	int ret = -EINVAL;
+
+	if (mask == (1 << IIO_CHAN_INFO_SCALE_SHARED)) {
+		/* Check no integer component */
+		if (val)
+			return -EINVAL;
+		ret = kxsd9_write_scale(indio_dev, val2);
+	}
+
+	return ret;
+}
+
+static int kxsd9_read_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int *val, int *val2, long mask)
+{
+	int ret = -EINVAL;
+	struct kxsd9_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case 0:
+		ret = kxsd9_read(indio_dev, chan->address);
+		if (ret < 0)
+			goto error_ret;
+		*val = ret;
+		break;
+	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
+		ret = spi_w8r8(st->us, KXSD9_READ(KXSD9_REG_CTRL_C));
+		if (ret)
+			goto error_ret;
+		*val2 = kxsd9_micro_scales[ret & KXSD9_FS_MASK];
+		ret = IIO_VAL_INT_PLUS_MICRO;
+		break;
+	};
+
+error_ret:
+	return ret;
+};
+#define KXSD9_ACCEL_CHAN(axis)						\
+	{								\
+		.type = IIO_ACCEL,					\
+		.modified = 1,						\
+		.channel2 = IIO_MOD_##axis,				\
+		.info_mask = 1 << IIO_CHAN_INFO_SCALE_SHARED,		\
+		.address = KXSD9_REG_##axis,				\
+	}
+
+static struct iio_chan_spec kxsd9_channels[] = {
+	KXSD9_ACCEL_CHAN(X), KXSD9_ACCEL_CHAN(Y), KXSD9_ACCEL_CHAN(Z),
+	{
+		.type = IIO_IN,
+		.indexed = 1,
+		.address = KXSD9_REG_AUX,
+	}
+};
+
 static const struct attribute_group kxsd9_attribute_group = {
 	.attrs = kxsd9_attributes,
 };
 
 static int __devinit kxsd9_power_up(struct kxsd9_state *st)
 {
-	struct spi_transfer xfers[2] = {
-		{
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-			.tx_buf = st->tx,
-		}, {
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-			.tx_buf = st->tx + 2,
-		},
-	};
-	struct spi_message msg;
+	int ret;
+
 	st->tx[0] = 0x0d;
 	st->tx[1] = 0x40;
-	st->tx[2] = 0x0c;
-	st->tx[3] = 0x9b;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
+	ret = spi_write(st->us, st->tx, 2);
+	if (ret)
+		return ret;
 
-	return spi_sync(st->us, &msg);
+	st->tx[0] = 0x0c;
+	st->tx[1] = 0x9b;
+	return spi_write(st->us, st->tx, 2);
 };
 
 static const struct iio_info kxsd9_info = {
+	.read_raw = &kxsd9_read_raw,
+	.write_raw = &kxsd9_write_raw,
 	.attrs = &kxsd9_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -300,7 +235,9 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 
 	st->us = spi;
 	mutex_init(&st->buf_lock);
-
+	indio_dev->channels = kxsd9_channels;
+	indio_dev->num_channels = ARRAY_SIZE(kxsd9_channels);
+	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &kxsd9_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -328,6 +265,10 @@ static int __devexit kxsd9_remove(struct spi_device *spi)
 	return 0;
 }
 
+static const struct spi_device_id kxsd9_id[] = {
+	{"kxsd9", 0}
+};
+
 static struct spi_driver kxsd9_driver = {
 	.driver = {
 		.name = "kxsd9",
@@ -335,6 +276,7 @@ static struct spi_driver kxsd9_driver = {
 	},
 	.probe = kxsd9_probe,
 	.remove = __devexit_p(kxsd9_remove),
+	.id_table = kxsd9_id,
 };
 
 static __init int kxsd9_spi_init(void)
-- 
1.7.3.4
