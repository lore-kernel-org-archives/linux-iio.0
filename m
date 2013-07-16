Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-236.synserver.de ([212.40.185.236]:1031 "EHLO
	smtp-out-236.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab3GPPHW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Jul 2013 11:07:22 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] staging:iio:adt7316: Don't expose the chip reset to userspace
Date: Tue, 16 Jul 2013 17:08:01 +0200
Message-Id: <1373987283-32657-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1373987283-32657-1-git-send-email-lars@metafoo.de>
References: <1373987283-32657-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no reason why userspace should want to trigger a manual reset of the
device, so remove this functionality.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/addac/adt7316.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 506b5a7..1e13568 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -551,31 +551,6 @@ static IIO_DEVICE_ATTR(enable_smbus_timeout, S_IRUGO | S_IWUSR,
 		adt7316_store_enable_smbus_timeout,
 		0);
 
-
-static ssize_t adt7316_store_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *dev_info = dev_to_iio_dev(dev);
-	struct adt7316_chip_info *chip = iio_priv(dev_info);
-	u8 config2;
-	int ret;
-
-	config2 = chip->config2 | ADT7316_RESET;
-
-	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
-	if (ret)
-		return -EIO;
-
-	return len;
-}
-
-static IIO_DEVICE_ATTR(reset, S_IWUSR,
-		NULL,
-		adt7316_store_reset,
-		0);
-
 static ssize_t adt7316_show_powerdown(struct device *dev,
 		struct device_attribute *attr,
 		char *buf)
@@ -1675,7 +1650,6 @@ static IIO_DEVICE_ATTR(bus_type, S_IRUGO, adt7316_show_bus_type, NULL, 0);
 static struct attribute *adt7316_attributes[] = {
 	&iio_dev_attr_all_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_enabled.dev_attr.attr,
 	&iio_dev_attr_ad_channel.dev_attr.attr,
 	&iio_dev_attr_all_ad_channels.dev_attr.attr,
@@ -1719,7 +1693,6 @@ static struct attribute *adt7516_attributes[] = {
 	&iio_dev_attr_all_modes.dev_attr.attr,
 	&iio_dev_attr_mode.dev_attr.attr,
 	&iio_dev_attr_select_ex_temp.dev_attr.attr,
-	&iio_dev_attr_reset.dev_attr.attr,
 	&iio_dev_attr_enabled.dev_attr.attr,
 	&iio_dev_attr_ad_channel.dev_attr.attr,
 	&iio_dev_attr_all_ad_channels.dev_attr.attr,
-- 
1.8.0

