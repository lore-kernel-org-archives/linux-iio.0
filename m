Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49994 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752110Ab2A2LGZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2012 06:06:25 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/5] staging:iio:dds:ad9834 unwind use of is_visible for attrs.
Date: Sun, 29 Jan 2012 11:07:01 +0000
Message-Id: <1327835224-20956-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1327835224-20956-1-git-send-email-jic23@kernel.org>
References: <1327835145-20886-1-git-send-email-jic23@kernel.org>
 <1327835224-20956-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Trivial usecase in which just having two different attr
groups covers all options.  Slightly more code, but a simpler
to follow result.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dds/ad9834.c |   53 +++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 5e67104..38a2de0 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -281,29 +281,27 @@ static struct attribute *ad9834_attributes[] = {
 	NULL,
 };
 
-static umode_t ad9834_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_priv(indio_dev);
-
-	umode_t mode = attr->mode;
-
-	if (((st->devid == ID_AD9833) || (st->devid == ID_AD9837)) &&
-		((attr == &iio_dev_attr_dds0_out1_enable.dev_attr.attr) ||
-		(attr == &iio_dev_attr_dds0_out1_wavetype.dev_attr.attr) ||
-		(attr ==
-		&iio_dev_attr_dds0_out1_wavetype_available.dev_attr.attr) ||
-		(attr == &iio_dev_attr_dds0_pincontrol_en.dev_attr.attr)))
-		mode = 0;
-
-	return mode;
-}
+static struct attribute *ad9833_attributes[] = {
+	&iio_dev_attr_dds0_freq0.dev_attr.attr,
+	&iio_dev_attr_dds0_freq1.dev_attr.attr,
+	&iio_const_attr_dds0_freq_scale.dev_attr.attr,
+	&iio_dev_attr_dds0_phase0.dev_attr.attr,
+	&iio_dev_attr_dds0_phase1.dev_attr.attr,
+	&iio_const_attr_dds0_phase_scale.dev_attr.attr,
+	&iio_dev_attr_dds0_freqsymbol.dev_attr.attr,
+	&iio_dev_attr_dds0_phasesymbol.dev_attr.attr,
+	&iio_dev_attr_dds0_out_enable.dev_attr.attr,
+	&iio_dev_attr_dds0_out0_wavetype.dev_attr.attr,
+	&iio_dev_attr_dds0_out0_wavetype_available.dev_attr.attr,
+	NULL,
+};
 
 static const struct attribute_group ad9834_attribute_group = {
 	.attrs = ad9834_attributes,
-	.is_visible = ad9834_attr_is_visible,
+};
+
+static const struct attribute_group ad9833_attribute_group = {
+	.attrs = ad9833_attributes,
 };
 
 static const struct iio_info ad9834_info = {
@@ -311,6 +309,11 @@ static const struct iio_info ad9834_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_info ad9833_info = {
+	.attrs = &ad9833_attribute_group,
+	.driver_module = THIS_MODULE,
+};
+
 static int __devinit ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_platform_data *pdata = spi->dev.platform_data;
@@ -344,7 +347,15 @@ static int __devinit ad9834_probe(struct spi_device *spi)
 	st->reg = reg;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
-	indio_dev->info = &ad9834_info;
+	switch (st->devid) {
+	case ID_AD9833:
+	case ID_AD9837:
+		indio_dev->info = &ad9833_info;
+		break;
+	default:
+		indio_dev->info = &ad9834_info;
+		break;
+	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Setup default messages */
-- 
1.7.8.4

