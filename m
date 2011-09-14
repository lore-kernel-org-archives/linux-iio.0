Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:45506 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323Ab1INLxU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Sep 2011 07:53:20 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:adc:ad7606 add channel type specification to range attributes.
Date: Wed, 14 Sep 2011 13:01:24 +0100
Message-Id: <1316001685-13375-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316001685-13375-1-git-send-email-jic23@cam.ac.uk>
References: <1316001685-13375-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cleaner and more consistent naming + makes one abi element we don't need
go away.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606_core.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index bea663d..f22f668 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -140,9 +140,9 @@ static ssize_t ad7606_store_range(struct device *dev,
 	return count;
 }
 
-static IIO_DEVICE_ATTR(range, S_IRUGO | S_IWUSR, \
+static IIO_DEVICE_ATTR(in_voltage_range, S_IRUGO | S_IWUSR, \
 		       ad7606_show_range, ad7606_store_range, 0);
-static IIO_CONST_ATTR(range_available, "5000 10000");
+static IIO_CONST_ATTR(in_voltage_range_available, "5000 10000");
 
 static ssize_t ad7606_show_oversampling_ratio(struct device *dev,
 			struct device_attribute *attr, char *buf)
@@ -198,8 +198,8 @@ static IIO_DEVICE_ATTR(oversampling_ratio, S_IRUGO | S_IWUSR,
 static IIO_CONST_ATTR(oversampling_ratio_available, "0 2 4 8 16 32 64");
 
 static struct attribute *ad7606_attributes[] = {
-	&iio_dev_attr_range.dev_attr.attr,
-	&iio_const_attr_range_available.dev_attr.attr,
+	&iio_dev_attr_in_voltage_range.dev_attr.attr,
+	&iio_const_attr_in_voltage_range_available.dev_attr.attr,
 	&iio_dev_attr_oversampling_ratio.dev_attr.attr,
 	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
 	NULL,
@@ -220,9 +220,10 @@ static mode_t ad7606_attr_is_visible(struct kobject *kobj,
 		&iio_const_attr_oversampling_ratio_available.dev_attr.attr))
 		mode = 0;
 	else if (!st->have_range &&
-		(attr == &iio_dev_attr_range.dev_attr.attr ||
-		attr == &iio_const_attr_range_available.dev_attr.attr))
-			mode = 0;
+		 (attr == &iio_dev_attr_in_voltage_range.dev_attr.attr ||
+		  attr ==
+		  &iio_const_attr_in_voltage_range_available.dev_attr.attr))
+		mode = 0;
 
 	return mode;
 }
-- 
1.7.3.4

