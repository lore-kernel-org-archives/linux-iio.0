Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46058 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 06/11] staging:iio:resolver:ad2s120x chan spec conversion
Date: Fri, 30 Sep 2011 11:14:49 +0100
Message-Id: <1317377694-9001-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Straight forward conversion.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s120x.c |   74 +++++++++++++++---------------
 1 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s120x.c b/drivers/staging/iio/resolver/ad2s120x.c
index fdaf0a8..7dadcd0 100644
--- a/drivers/staging/iio/resolver/ad2s120x.c
+++ b/drivers/staging/iio/resolver/ad2s120x.c
@@ -39,62 +39,60 @@ struct ad2s120x_state {
 	u8 rx[2] ____cacheline_aligned;
 };
 
-static ssize_t ad2s120x_show_val(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static int ad2s1200_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
 	int ret = 0;
-	ssize_t len = 0;
-	u16 pos;
 	s16 vel;
-	u8 status;
-	struct ad2s120x_state *st = iio_priv(dev_get_drvdata(dev));
-	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
+	struct ad2s120x_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
-
 	gpio_set_value(st->sample, 0);
 	/* delay (6 * AD2S120X_TSCLK + 20) nano seconds */
 	udelay(1);
 	gpio_set_value(st->sample, 1);
-	gpio_set_value(st->rdvel, iattr->address);
+	gpio_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
 	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret < 0)
-		goto error_ret;
-	status = st->rx[1];
-	if (iattr->address)
-		pos = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-	else {
-		vel = (st->rx[0] & 0x80) ? 0xf000 : 0;
-		vel |= (((s16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+	if (ret < 0) {
+		mutex_unlock(&st->lock);
+		return ret;
+	}
+
+	switch (chan->type) {
+	case IIO_ANGL:
+		*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+		break;
+	case IIO_ANGL_VEL:
+		vel = (((s16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+		vel = (vel << 4) >> 4;
+		*val = vel;
+	default:
+		mutex_unlock(&st->lock);
+		return -EINVAL;
 	}
-	len = sprintf(buf, "%d %c%c%c%c ", iattr->address ? pos : vel,
-				(status & 0x8) ? 'P' : 'V',
-				(status & 0x4) ? 'd' : '_',
-				(status & 0x2) ? 'l' : '_',
-				(status & 0x1) ? '1' : '0');
-error_ret:
 	/* delay (2 * AD2S120X_TSCLK + 20) ns for sample pulse */
 	udelay(1);
 	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
+	return IIO_VAL_INT;
 }
 
-static IIO_DEVICE_ATTR(pos, S_IRUGO, ad2s120x_show_val, NULL, 1);
-static IIO_DEVICE_ATTR(vel, S_IRUGO, ad2s120x_show_val, NULL, 0);
-
-static struct attribute *ad2s120x_attributes[] = {
-	&iio_dev_attr_pos.dev_attr.attr,
-	&iio_dev_attr_vel.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad2s120x_attribute_group = {
-	.attrs = ad2s120x_attributes,
+static const struct iio_chan_spec ad2s1200_channels[] = {
+	{
+		.type = IIO_ANGL,
+		.indexed = 1,
+		.channel = 0,
+	}, {
+		.type = IIO_ANGL_VEL,
+		.indexed = 1,
+		.channel = 0,
+	}
 };
 
 static const struct iio_info ad2s120x_info = {
-	.attrs = &ad2s120x_attribute_group,
+	.read_raw = &ad2s1200_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
@@ -126,6 +124,8 @@ static int __devinit ad2s120x_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s120x_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad2s1200_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
-- 
1.7.3.4

