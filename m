Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14880 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098AbcD2LnO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 07:43:14 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 3/3] imu: bmi160: Add avail frequency and scale attributes
Date: Fri, 29 Apr 2016 14:42:35 +0300
Message-Id: <1461930155-13871-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
References: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index b8a290e..97928d5 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -20,6 +20,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
 
 #include "bmi160.h"
 
@@ -466,10 +467,36 @@ static int bmi160_write_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static
+IIO_CONST_ATTR(in_accel_sampling_frequency_available,
+	       "0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600");
+static
+IIO_CONST_ATTR(in_anglvel_sampling_frequency_available,
+	       "25 50 100 200 400 800 1600 3200");
+static
+IIO_CONST_ATTR(in_accel_scale_available,
+	       "0.000598 0.001197 0.002394 0.004788");
+static
+IIO_CONST_ATTR(in_anglvel_scale_available,
+	       "0.001065 0.000532 0.000266 0.000133 0.000066");
+
+static struct attribute *bmi160_attrs[] = {
+	&iio_const_attr_in_accel_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_anglvel_sampling_frequency_available.dev_attr.attr,
+	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group bmi160_attrs_group = {
+	.attrs = bmi160_attrs,
+};
+
 static const struct iio_info bmi160_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = bmi160_read_raw,
 	.write_raw = bmi160_write_raw,
+	.attrs = &bmi160_attrs_group,
 };
 
 static const char *bmi160_match_acpi_device(struct device *dev)
-- 
2.5.0

