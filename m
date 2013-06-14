Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1072 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751299Ab3FNP6Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Jun 2013 11:58:25 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/7] staging:iio:ad7291: Remove userspace reset
Date: Fri, 14 Jun 2013 17:58:23 +0200
Message-Id: <1371225508-32190-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1371225508-32190-1-git-send-email-lars@metafoo.de>
References: <1371225508-32190-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no reason why userspace should want to trigger a manual reset of the
device, so remove this functionality.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7291.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index a3a3a2f..782e100 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -127,29 +127,6 @@ static int ad7291_i2c_write(struct ad7291_chip_info *chip, u8 reg, u16 data)
 	return i2c_smbus_write_word_data(chip->client, reg, swab16(data));
 }
 
-static ssize_t ad7291_store_reset(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf,
-		size_t len)
-{
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct ad7291_chip_info *chip = iio_priv(indio_dev);
-
-	return ad7291_i2c_write(chip, AD7291_COMMAND,
-				chip->command | AD7291_RESET);
-}
-
-static IIO_DEVICE_ATTR(reset, S_IWUSR, NULL, ad7291_store_reset, 0);
-
-static struct attribute *ad7291_attributes[] = {
-	&iio_dev_attr_reset.dev_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group ad7291_attribute_group = {
-	.attrs = ad7291_attributes,
-};
-
 static irqreturn_t ad7291_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -569,7 +546,6 @@ static struct attribute_group ad7291_event_attribute_group = {
 };
 
 static const struct iio_info ad7291_info = {
-	.attrs = &ad7291_attribute_group,
 	.read_raw = &ad7291_read_raw,
 	.read_event_config = &ad7291_read_event_config,
 	.write_event_config = &ad7291_write_event_config,
-- 
1.8.0

