Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46068 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 09/11] staging:iio:resolver:ad2s1210 minimal chan spec conversion.
Date: Fri, 30 Sep 2011 11:14:52 +0100
Message-Id: <1317377694-9001-10-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just convert the raw reads in this patch.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s1210.c |  114 +++++++++++++++++--------------
 1 files changed, 63 insertions(+), 51 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 9a88563..697db80 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -514,71 +514,70 @@ error_ret:
 	return ret < 0 ? ret : len;
 }
 
-static ssize_t ad2s1210_show_pos(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+static int ad2s1210_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val,
+			     int *val2,
+			     long m)
 {
+	struct ad2s1210_state *st = iio_priv(indio_dev);
+	bool negative;
 	int ret = 0;
-	ssize_t len = 0;
 	u16 pos;
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
-
-	mutex_lock(&st->lock);
-	gpio_set_value(st->pdata->sample, 0);
-	/* delay (6 * tck + 20) nano seconds */
-	udelay(1);
-
-	ad2s1210_set_mode(MOD_POS, st);
-	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret)
-		goto error_ret;
-	pos = be16_to_cpup((u16 *)st->rx);
-	if (st->hysteresis)
-		pos >>= 16 - st->resolution;
-	len = sprintf(buf, "%d\n", pos);
-error_ret:
-	gpio_set_value(st->pdata->sample, 1);
-	/* delay (2 * tck + 20) nano seconds */
-	udelay(1);
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
-static ssize_t ad2s1210_show_vel(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	unsigned short negative;
-	int ret = 0;
-	ssize_t len = 0;
 	s16 vel;
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
 
 	mutex_lock(&st->lock);
 	gpio_set_value(st->pdata->sample, 0);
 	/* delay (6 * tck + 20) nano seconds */
 	udelay(1);
 
-	ad2s1210_set_mode(MOD_VEL, st);
+	switch (chan->type) {
+	case IIO_ANGL:
+		ad2s1210_set_mode(MOD_POS, st);
+		break;
+	case IIO_ANGL_VEL:
+		ad2s1210_set_mode(MOD_VEL, st);
+		break;
+	default:
+	       ret = -EINVAL;
+	       break;
+	}
+	if (ret < 0)
+		goto error_ret;
 	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret)
+	if (ret < 0)
 		goto error_ret;
-	negative = st->rx[0] & 0x80;
-	vel = be16_to_cpup((s16 *)st->rx);
-	vel >>= 16 - st->resolution;
-	if (vel & 0x8000) {
-		negative = (0xffff >> st->resolution) << st->resolution;
-		vel |= negative;
+
+	switch (chan->type) {
+	case IIO_ANGL:
+		pos = be16_to_cpup((u16 *)st->rx);
+		if (st->hysteresis)
+			pos >>= 16 - st->resolution;
+		*val = pos;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_ANGL_VEL:
+		negative = st->rx[0] & 0x80;
+		vel = be16_to_cpup((s16 *)st->rx);
+		vel >>= 16 - st->resolution;
+		if (vel & 0x8000) {
+			negative = (0xffff >> st->resolution) << st->resolution;
+			vel |= negative;
+		}
+		*val = vel;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		mutex_unlock(&st->lock);
+		return -EINVAL;
 	}
-	len = sprintf(buf, "%d\n", vel);
+
 error_ret:
 	gpio_set_value(st->pdata->sample, 1);
 	/* delay (2 * tck + 20) nano seconds */
 	udelay(1);
 	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
+	return ret;
 }
 
 static IIO_DEVICE_ATTR(raw_io, S_IRUGO | S_IWUSR,
@@ -595,8 +594,7 @@ static IIO_DEVICE_ATTR(bits, S_IRUGO | S_IWUSR,
 		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
 static IIO_DEVICE_ATTR(fault, S_IRUGO | S_IWUSR,
 		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
-static IIO_DEVICE_ATTR(pos, S_IRUGO, ad2s1210_show_pos, NULL, 0);
-static IIO_DEVICE_ATTR(vel, S_IRUGO,  ad2s1210_show_vel, NULL, 0);
+
 static IIO_DEVICE_ATTR(los_thrd, S_IRUGO | S_IWUSR,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_LOS_THRD);
@@ -619,6 +617,19 @@ static IIO_DEVICE_ATTR(lot_low_thrd, S_IRUGO | S_IWUSR,
 		       ad2s1210_show_reg, ad2s1210_store_reg,
 		       AD2S1210_REG_LOT_LOW_THRD);
 
+
+static struct iio_chan_spec ad2s1210_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.indexed = 1,
+		.channel = 0,
+	}, {
+		.type = IIO_ANGL_VEL,
+		.indexed = 1,
+		.channel = 0,
+	}
+};
+
 static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_raw_io.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
@@ -627,8 +638,6 @@ static struct attribute *ad2s1210_attributes[] = {
 	&iio_dev_attr_control.dev_attr.attr,
 	&iio_dev_attr_bits.dev_attr.attr,
 	&iio_dev_attr_fault.dev_attr.attr,
-	&iio_dev_attr_pos.dev_attr.attr,
-	&iio_dev_attr_vel.dev_attr.attr,
 	&iio_dev_attr_los_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
 	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
@@ -681,6 +690,7 @@ error_ret:
 }
 
 static const struct iio_info ad2s1210_info = {
+	.read_raw = &ad2s1210_read_raw,
 	.attrs = &ad2s1210_attribute_group,
 	.driver_module = THIS_MODULE,
 };
@@ -760,6 +770,8 @@ static int __devinit ad2s1210_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s1210_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad2s1210_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
 	ret = iio_device_register(indio_dev);
-- 
1.7.3.4

