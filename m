Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49991 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab2A2LGZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2012 06:06:25 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/5] staging:iio:dac:ad5446 unwind use of is_visible for attrs.
Date: Sun, 29 Jan 2012 11:07:02 +0000
Message-Id: <1327835224-20956-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1327835224-20956-1-git-send-email-jic23@kernel.org>
References: <1327835145-20886-1-git-send-email-jic23@kernel.org>
 <1327835224-20956-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Trivial case where no attributes are valid for some parts. Better
handled using two iio_info structures and selecting the right one
at probe time.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 693e748..e439bae 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -149,30 +149,8 @@ static struct attribute *ad5446_attributes[] = {
 	NULL,
 };
 
-static umode_t ad5446_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(indio_dev);
-
-	umode_t mode = attr->mode;
-
-	if (!st->chip_info->store_pwr_down &&
-		(attr == &iio_dev_attr_out_voltage0_powerdown.dev_attr.attr ||
-		attr == &iio_dev_attr_out_voltage_powerdown_mode.
-		 dev_attr.attr ||
-		attr ==
-		&iio_const_attr_out_voltage_powerdown_mode_available.
-		 dev_attr.attr))
-		mode = 0;
-
-	return mode;
-}
-
 static const struct attribute_group ad5446_attribute_group = {
 	.attrs = ad5446_attributes,
-	.is_visible = ad5446_attr_is_visible,
 };
 
 #define AD5446_CHANNEL(bits, storage, shift) { \
@@ -321,6 +299,12 @@ static const struct iio_info ad5446_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_info ad5446_info_no_pwr_down = {
+	.read_raw = ad5446_read_raw,
+	.write_raw = ad5446_write_raw,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad5446_probe(struct spi_device *spi)
 {
 	struct ad5446_state *st;
@@ -353,7 +337,10 @@ static int __devinit ad5446_probe(struct spi_device *spi)
 	/* Estabilish that the iio_dev is a child of the spi device */
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->info = &ad5446_info;
+	if (st->chip_info->store_pwr_down)
+		indio_dev->info = &ad5446_info;
+	else
+		indio_dev->info = &ad5446_info_no_pwr_down;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
-- 
1.7.8.4

