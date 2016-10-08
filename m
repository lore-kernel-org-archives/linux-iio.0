Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35423 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756850AbcJHQjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:35 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 14/18] staging:iio:accel:sca3000 replace non standard revision attr with dev_info on probe
Date: Sat,  8 Oct 2016 17:39:14 +0100
Message-Id: <20161008163918.18758-15-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There seems little point in being able to query the part revision number
via sysfs.  Hence just put it in the kernel logs during probe incase
anyone ever wants to know.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index fad075398523..dc1d2cf1558a 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -410,26 +410,23 @@ error_ret:
 /**
  * sca3000_show_rev() - sysfs interface to read the chip revision number
  **/
-static ssize_t sca3000_show_rev(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
+static int sca3000_print_rev(struct iio_dev *indio_dev)
 {
-	int len = 0, ret;
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	int ret;
 	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
 	ret = sca3000_read_data_short(st, SCA3000_REG_REVID_ADDR, 1);
 	if (ret < 0)
 		goto error_ret;
-	len += sprintf(buf + len,
-		       "major=%lu, minor=%lu\n",
-		       st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
-		       st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
+	dev_info(&indio_dev->dev,
+		 "sca3000 revision major=%lu, minor=%lu\n",
+		 st->rx[0] & SCA3000_REG_REVID_MAJOR_MASK,
+		 st->rx[0] & SCA3000_REG_REVID_MINOR_MASK);
 error_ret:
 	mutex_unlock(&st->lock);
 
-	return ret ? ret : len;
+	return ret;
 }
 
 static ssize_t
@@ -456,9 +453,6 @@ sca3000_show_available_3db_freqs(struct device *dev,
 static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
 		       S_IRUGO, sca3000_show_available_3db_freqs,
 		       NULL, 0);
-/* More standard attributes */
-
-static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
 
 static const struct iio_event_spec sca3000_event = {
 	.type = IIO_EV_TYPE_MAG,
@@ -920,7 +914,6 @@ static int sca3000_write_event_value(struct iio_dev *indio_dev,
 }
 
 static struct attribute *sca3000_attributes[] = {
-	&iio_dev_attr_revision.dev_attr.attr,
 	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
 	NULL,
@@ -1464,6 +1457,11 @@ static int sca3000_probe(struct spi_device *spi)
 	ret = sca3000_clean_setup(st);
 	if (ret)
 		goto error_free_irq;
+
+	ret = sca3000_print_rev(indio_dev);
+	if (ret)
+		goto error_free_irq;
+
 	return 0;
 
 error_free_irq:
-- 
2.10.0

