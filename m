Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41228 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934637AbaGPSdH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:07 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 12/13] iio:bma180: Implement _available sysfs attribute dynamically
Date: Wed, 16 Jul 2014 20:32:55 +0200
Message-Id: <1405535576-26482-13-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

makes it easier to add more chip variants and removes redundancy:
scales and frequencies are now stated just once

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 54 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 6e940b0..9fbc81f 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -83,12 +83,6 @@ struct bma180_part_info {
 #define BMA180_DEF_BW		20
 #define BMA180_DEF_SCALE	2452
 
-/* Available values for sysfs */
-#define BMA180_FLP_FREQ_AVAILABLE \
-	"10 20 40 75 150 300"
-#define BMA180_SCALE_AVAILABLE \
-	"0.001275 0.001863 0.002452 0.003727 0.004903 0.009709 0.019417"
-
 struct bma180_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
@@ -347,13 +341,51 @@ err:
 	dev_err(&data->client->dev, "failed to disable the chip\n");
 }
 
-static IIO_CONST_ATTR(in_accel_filter_low_pass_3db_frequency_available,
-		BMA180_FLP_FREQ_AVAILABLE);
-static IIO_CONST_ATTR(in_accel_scale_available, BMA180_SCALE_AVAILABLE);
+static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned n,
+				 bool micros)
+{
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (!vals[i])
+			continue;
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+			micros ? "0.%06d " : "%d ", vals[i]);
+	}
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t bma180_show_filter_freq_avail(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct bma180_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	return bma180_show_avail(buf, data->part_info->bw_table,
+		data->part_info->num_bw, false);
+}
+
+static ssize_t bma180_show_scale_avail(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct bma180_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	return bma180_show_avail(buf, data->part_info->scale_table,
+		data->part_info->num_scales, true);
+}
+
+static IIO_DEVICE_ATTR(in_accel_filter_low_pass_3db_frequency_available,
+	S_IRUGO, bma180_show_filter_freq_avail, NULL, 0);
+
+static IIO_DEVICE_ATTR(in_accel_scale_available,
+	S_IRUGO, bma180_show_scale_avail, NULL, 0);
 
 static struct attribute *bma180_attributes[] = {
-	&iio_const_attr_in_accel_filter_low_pass_3db_frequency_available.dev_attr.attr,
-	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_filter_low_pass_3db_frequency_available.
+		dev_attr.attr,
+	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
 	NULL,
 };
 
-- 
1.9.1

