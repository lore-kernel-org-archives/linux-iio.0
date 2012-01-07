Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: pirmin.duss@flytec.ch,
	lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/6] staging:iio:adc:ad7192 unwind use of is_visible for attribute group.
Date: Sat,  7 Jan 2012 10:25:16 +0000
Message-Id: <1325931921-14547-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1325931921-14547-1-git-send-email-jic23@kernel.org>
References: <1325931921-14547-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

It saves a couple of lines of code but reduces simplicity of code.
I generally wish to discourage use of is_visible throughout IIO.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7192.c |   43 ++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index dfeb4ba..881c5e5 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -824,25 +824,20 @@ static struct attribute *ad7192_attributes[] = {
 	NULL
 };
 
-static mode_t ad7192_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad7192_state *st = iio_priv(indio_dev);
-
-	mode_t mode = attr->mode;
-
-	if ((st->devid != ID_AD7195) &&
-		(attr == &iio_dev_attr_ac_excitation_en.dev_attr.attr))
-		mode = 0;
-
-	return mode;
-}
-
 static const struct attribute_group ad7192_attribute_group = {
 	.attrs = ad7192_attributes,
-	.is_visible = ad7192_attr_is_visible,
+};
+
+static struct attribute *ad7195_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_in_v_m_v_scale_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_scale_available.dev_attr.attr,
+	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad7195_attribute_group = {
+	.attrs = ad7195_attributes,
 };
 
 static int ad7192_read_raw(struct iio_dev *indio_dev,
@@ -972,6 +967,15 @@ static const struct iio_info ad7192_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_info ad7195_info = {
+	.read_raw = &ad7192_read_raw,
+	.write_raw = &ad7192_write_raw,
+	.write_raw_get_fmt = &ad7192_write_raw_get_fmt,
+	.attrs = &ad7195_attribute_group,
+	.validate_trigger = ad7192_validate_trigger,
+	.driver_module = THIS_MODULE,
+};
+
 #define AD7192_CHAN_DIFF(_chan, _chan2, _name, _address, _si)		\
 	{ .type = IIO_VOLTAGE,						\
 	  .differential = 1,						\
@@ -1064,7 +1068,10 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	indio_dev->channels = ad7192_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7192_channels);
 	indio_dev->available_scan_masks = st->available_scan_masks;
-	indio_dev->info = &ad7192_info;
+	if (st->devid == ID_AD7195)
+		indio_dev->info = &ad7195_info;
+	else
+		indio_dev->info = &ad7192_info;
 
 	for (i = 0; i < indio_dev->num_channels; i++)
 		st->available_scan_masks[i] = (1 << i) | (1 <<
-- 
1.7.7.4
