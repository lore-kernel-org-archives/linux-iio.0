Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 6/6] staging:iio:imu remove unecessary empty defs for event attributes.
Date: Wed,  5 May 2010 23:25:46 +0100
Message-Id: <1273098346-4184-7-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
References: <1273098346-4184-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/imu/adis16300_core.c |   10 ----------
 drivers/staging/iio/imu/adis16400_core.c |   10 ----------
 2 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16300_core.c b/drivers/staging/iio/imu/adis16300_core.c
index 5a7e5ef..54e3e51 100644
--- a/drivers/staging/iio/imu/adis16300_core.c
+++ b/drivers/staging/iio/imu/adis16300_core.c
@@ -566,14 +566,6 @@ static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
 
 static IIO_CONST_ATTR(name, "adis16300");
 
-static struct attribute *adis16300_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16300_event_attribute_group = {
-	.attrs = adis16300_event_attributes,
-};
-
 static struct attribute *adis16300_attributes[] = {
 	&iio_dev_attr_accel_x_offset.dev_attr.attr,
 	&iio_dev_attr_accel_y_offset.dev_attr.attr,
@@ -637,8 +629,6 @@ static int __devinit adis16300_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16300_event_attribute_group;
 	st->indio_dev->attrs = &adis16300_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index 2c10072..34c0ee5 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -595,14 +595,6 @@ static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("409 546 819 1638");
 
 static IIO_CONST_ATTR(name, "adis16400");
 
-static struct attribute *adis16400_event_attributes[] = {
-	NULL
-};
-
-static struct attribute_group adis16400_event_attribute_group = {
-	.attrs = adis16400_event_attributes,
-};
-
 static struct attribute *adis16400_attributes[] = {
 	&iio_dev_attr_accel_x_offset.dev_attr.attr,
 	&iio_dev_attr_accel_y_offset.dev_attr.attr,
@@ -669,8 +661,6 @@ static int __devinit adis16400_probe(struct spi_device *spi)
 	}
 
 	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->event_attrs = &adis16400_event_attribute_group;
 	st->indio_dev->attrs = &adis16400_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
 	st->indio_dev->driver_module = THIS_MODULE;
-- 
1.7.0.4
