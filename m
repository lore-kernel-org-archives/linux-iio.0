Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: pirmin.duss@flytec.ch,
	lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/6] staging:iio:dac:ad5446 unwind use of is_visible for attrs.
Date: Sat,  7 Jan 2012 10:25:18 +0000
Message-Id: <1325931921-14547-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1325931921-14547-1-git-send-email-jic23@kernel.org>
References: <1325931921-14547-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Trivial case where no attributes are valid for some parts. Better
handled using two iio_info structures and selecting the right one
at probe time.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/dac/ad5446.c |   33 ++++++++++-----------------------
 1 files changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index bfd88fa..05fccff 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -149,30 +149,8 @@ static struct attribute *ad5446_attributes[] = {
 	NULL,
 };
 
-static mode_t ad5446_attr_is_visible(struct kobject *kobj,
-				     struct attribute *attr, int n)
-{
-	struct device *dev = container_of(kobj, struct device, kobj);
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ad5446_state *st = iio_priv(indio_dev);
-
-	mode_t mode = attr->mode;
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
1.7.7.4
