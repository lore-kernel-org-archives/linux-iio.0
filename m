Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46051 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/11] stagiong:iio:resolver:ad2s90 chan spec conversion
Date: Fri, 30 Sep 2011 11:14:46 +0100
Message-Id: <1317377694-9001-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Trivial conversion.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s90.c |   41 ++++++++++++++------------------
 1 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 4b936d6..8b3d34d 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -25,45 +25,38 @@ struct ad2s90_state {
 	u8 rx[2] ____cacheline_aligned;
 };
 
-static ssize_t ad2s90_show_angular(struct device *dev,
-			struct device_attribute *attr, char *buf)
+static int ad2s90_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
 {
 	int ret;
-	ssize_t len = 0;
-	u16 val;
-	struct ad2s90_state *st = iio_priv(dev_get_drvdata(dev));
+	struct ad2s90_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
 	ret = spi_read(st->sdev, st->rx, 2);
 	if (ret)
 		goto error_ret;
-	val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-	len = sprintf(buf, "%d\n", val);
+	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+
 error_ret:
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : len;
+	return IIO_VAL_INT;
 }
 
-#define IIO_DEV_ATTR_SIMPLE_RESOLVER(_show) \
-	IIO_DEVICE_ATTR(angular, S_IRUGO, _show, NULL, 0)
-
-static IIO_DEV_ATTR_SIMPLE_RESOLVER(ad2s90_show_angular);
-
-static struct attribute *ad2s90_attributes[] = {
-	&iio_dev_attr_angular.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad2s90_attribute_group = {
-	.attrs = ad2s90_attributes,
-};
-
 static const struct iio_info ad2s90_info = {
-	.attrs = &ad2s90_attribute_group,
+	.read_raw = &ad2s90_read_raw,
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_chan_spec ad2s90_chan = {
+	.type = IIO_ANGL,
+	.indexed = 1,
+	.channel = 0,
+};
+
 static int __devinit ad2s90_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -83,6 +76,8 @@ static int __devinit ad2s90_probe(struct spi_device *spi)
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &ad2s90_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = &ad2s90_chan;
+	indio_dev->num_channels = 1;
 	indio_dev->name = spi_get_device_id(spi)->name;
 
 	ret = iio_device_register(indio_dev);
-- 
1.7.3.4

