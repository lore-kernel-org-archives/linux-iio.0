Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: pirmin.duss@flytec.ch,
	lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/6] staging:iio:dds:ad9834 unwind use of is_visible for attrs.
Date: Sat,  7 Jan 2012 10:25:17 +0000
Message-Id: <1325931921-14547-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1325931921-14547-1-git-send-email-jic23@kernel.org>
References: <1325931921-14547-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Trivial usecase in which just having two different attr
groups covers all options.  Slightly more code, but a simpler
to follow result.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dds/ad9834.c |   53 +++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index 59a2813..323718b 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -281,29 +281,27 @@ static struct attribute *ad9834_attributes[] = {
 	NULL,
 };
 
-static mode_t ad9834_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad9834_state *st = iio_priv(indio_dev);
-
-	mode_t mode = attr->mode;
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
1.7.7.4
