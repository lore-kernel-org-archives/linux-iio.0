Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46076 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 10/11] staging:iio:resolver:ad2s1210 drop raw config register access
Date: Fri, 30 Sep 2011 11:14:53 +0100
Message-Id: <1317377694-9001-11-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This should never have been exposed to userspace

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s1210.c |   44 -------------------------------
 1 files changed, 0 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 697db80..4f248de 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -195,47 +195,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
-
-/* return the OLD DATA since last spi bus write */
-static ssize_t ad2s1210_show_raw(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
-{
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
-	int ret = 0;
-
-	mutex_lock(&st->lock);
-	if (st->old_data) {
-		ret = sprintf(buf, "0x%x\n", st->rx[0]);
-		st->old_data = false;
-	}
-	mutex_unlock(&st->lock);
-
-	return ret;
-}
-
-static ssize_t ad2s1210_store_raw(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf,
-				  size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_get_drvdata(dev));
-	unsigned long udata;
-	unsigned char data;
-	int ret;
-
-	ret = strict_strtoul(buf, 16, &udata);
-	if (ret)
-		return -EINVAL;
-
-	data = udata & 0xff;
-	mutex_lock(&st->lock);
-	ret = ad2s1210_config_write(st, data);
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
 static ssize_t ad2s1210_store_softreset(struct device *dev,
 					struct device_attribute *attr,
 					const char *buf,
@@ -580,8 +539,6 @@ error_ret:
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(raw_io, S_IRUGO | S_IWUSR,
-		       ad2s1210_show_raw, ad2s1210_store_raw, 0);
 static IIO_DEVICE_ATTR(reset, S_IWUSR,
 		       NULL, ad2s1210_store_softreset, 0);
 static IIO_DEVICE_ATTR(fclkin, S_IRUGO | S_IWUSR,
@@ -631,7 +588,6 @@ static struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_raw_io.dev_attr.attr,
 	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_fclkin.dev_attr.attr,
 	&iio_dev_attr_fexcit.dev_attr.attr,
-- 
1.7.3.4

