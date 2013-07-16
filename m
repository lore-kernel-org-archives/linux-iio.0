Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-236.synserver.de ([212.40.185.236]:1488 "EHLO
	smtp-out-236.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567Ab3GPPHY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 11:07:24 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] staging:iio:ad2s1210: Don't expose the chip reset to userspace
Date: Tue, 16 Jul 2013 17:08:00 +0200
Message-Id: <1373987283-32657-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no reason why userspace should want to trigger a manual reset of the
device, so remove this functionality.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/resolver/ad2s1210.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 0d3356d..dcdadbb 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -192,21 +192,6 @@ static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
 	return ad2s1210_config_write(st, 0x0);
 }
 
-static ssize_t ad2s1210_store_softreset(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf,
-					size_t len)
-{
-	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = ad2s1210_soft_reset(st);
-	mutex_unlock(&st->lock);
-
-	return ret < 0 ? ret : len;
-}
-
 static ssize_t ad2s1210_show_fclkin(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
@@ -536,8 +521,6 @@ error_ret:
 	return ret;
 }
 
-static IIO_DEVICE_ATTR(reset, S_IWUSR,
-		       NULL, ad2s1210_store_softreset, 0);
 static IIO_DEVICE_ATTR(fclkin, S_IRUGO | S_IWUSR,
 		       ad2s1210_show_fclkin, ad2s1210_store_fclkin, 0);
 static IIO_DEVICE_ATTR(fexcit, S_IRUGO | S_IWUSR,
@@ -587,7 +570,6 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
 };
 
 static struct attribute *ad2s1210_attributes[] = {
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_fclkin.dev_attr.attr,
 	&iio_dev_attr_fexcit.dev_attr.attr,
 	&iio_dev_attr_control.dev_attr.attr,
-- 
1.8.0

